Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E94B1239
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiBJP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:59:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbiBJP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:59:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A30E87
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:59:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C8361CC8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D98C340EE;
        Thu, 10 Feb 2022 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644508772;
        bh=dIgio40C1V0AUEVczldmp/PFz0TwGbd4uOrumI1TjKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6srJBqUF2/+KCo/h3Ta6qgvtRrsGezTiaT6oiKgyQGPmShZwnJw7oUVcDAhcxrir
         6QHI3ua4NPlJ0SXsj4khnhcRW0ZKFl2lSOQ5qe/CI6ynJrkNteWkQy9b1xX6MTGeVM
         4M0/Or6M1G1c3ZIl4UoKrhxzX2VNB/hO6VE6aSIIdm5BOCpLheaJhpVdKtoYCYsxBl
         6spqOuH/JUcbnu7mHMpNut+NYroWnwFpRRhF5lz/NqhJII87ELV0CqSD3E0+R0G5C6
         h/T2AI6m4WBFRa1IB1j24wZeSwm+qfFvjz18w7HMcu5ue+lcyjyRMdquI9ngsha2h3
         AC8plMVkcvZSw==
Date:   Thu, 10 Feb 2022 16:59:29 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 5/7] sched/preempt: add PREEMPT_DYNAMIC using static
 keys
Message-ID: <20220210155929.GB567552@lothringen>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-6-mark.rutland@arm.com>
 <20220209174801.GA547263@lothringen>
 <YgTn7pnZ/hxmHBha@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgTn7pnZ/hxmHBha@FVFF77S0Q05N>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:27:39AM +0000, Mark Rutland wrote:
> On Wed, Feb 09, 2022 at 06:48:01PM +0100, Frederic Weisbecker wrote:
> > On Wed, Feb 09, 2022 at 03:35:33PM +0000, Mark Rutland wrote:
> > > +config HAVE_PREEMPT_DYNAMIC_KEY
> > > +	bool
> > > +	depends on JUMP_LABEL
> > 
> > This should probably be:
> > 
> >      depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
> >      select JUMP_LABEL
> > 
> > Otherwise you may run into trouble if CONFIG_JUMP_LABEL is initially n.
> 
> I'll make that:
> 
>  config HAVE_PREEMPT_DYNAMIC_KEY
>         bool
>         depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
>         ...
> 
> ... and 
> 
>  config PREEMPT_DYNAMIC
>         bool "Preemption behaviour defined on boot"
>         depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
>         select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
>         ...
> 
> So that we don't force JUMP_LABEL on even when people aren't using it.

Much better!

Thanks!
