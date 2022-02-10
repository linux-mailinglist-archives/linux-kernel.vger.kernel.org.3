Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0012C4B0A88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiBJK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:27:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiBJK1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:27:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C9D12C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:27:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D96DED1;
        Thu, 10 Feb 2022 02:27:54 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 157DA3F718;
        Thu, 10 Feb 2022 02:27:51 -0800 (PST)
Date:   Thu, 10 Feb 2022 10:27:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 5/7] sched/preempt: add PREEMPT_DYNAMIC using static
 keys
Message-ID: <YgTn7pnZ/hxmHBha@FVFF77S0Q05N>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-6-mark.rutland@arm.com>
 <20220209174801.GA547263@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209174801.GA547263@lothringen>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 06:48:01PM +0100, Frederic Weisbecker wrote:
> On Wed, Feb 09, 2022 at 03:35:33PM +0000, Mark Rutland wrote:
> > +config HAVE_PREEMPT_DYNAMIC_KEY
> > +	bool
> > +	depends on JUMP_LABEL
> 
> This should probably be:
> 
>      depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
>      select JUMP_LABEL
> 
> Otherwise you may run into trouble if CONFIG_JUMP_LABEL is initially n.

I'll make that:

 config HAVE_PREEMPT_DYNAMIC_KEY
        bool
        depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
        ...

... and 

 config PREEMPT_DYNAMIC
        bool "Preemption behaviour defined on boot"
        depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
        select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
        ...

So that we don't force JUMP_LABEL on even when people aren't using it.

Thanks,
Mark.
