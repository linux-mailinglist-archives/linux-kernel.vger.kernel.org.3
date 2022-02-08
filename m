Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C724AE171
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385501AbiBHSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385498AbiBHStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:49:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 835D2C0612BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:49:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2701FB;
        Tue,  8 Feb 2022 10:49:13 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53D813F73B;
        Tue,  8 Feb 2022 10:49:12 -0800 (PST)
Date:   Tue, 8 Feb 2022 18:49:07 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [peterz-queue:sched/core 32/32]
 arch/arm64/include/asm/preempt.h:85:1: error: type defaults to 'int' in
 declaration of 'DECLARE_STATIC_KEY_TRUE'
Message-ID: <YgK7I2bMJQA8IPmt@FVFF77S0Q05N>
References: <202202081918.RDLHzFHh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202081918.RDLHzFHh-lkp@intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 07:08:33PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   ac7695a93a578befdcf4900a90860bf19e057e1b
> commit: ac7695a93a578befdcf4900a90860bf19e057e1b [32/32] arm64: support PREEMPT_DYNAMIC

> >> arch/arm64/include/asm/preempt.h:85:1: warning: data definition has no type or storage class
>       85 | DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>          | ^~~~~~~~~~~~~~~~~~~~~~~

This is because I forgot to include <linux/jump_label.h>, so GCC has no idea
what `DECLARE_STATIC_KEY_TRUE` means.

I'll go add that where needed and check that doesn't introduce a circular
dependency.

Thanks,
Mark.
