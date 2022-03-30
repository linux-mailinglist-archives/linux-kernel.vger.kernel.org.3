Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE364EBD32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiC3JGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiC3JGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:06:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3298193B5F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:04:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6475223A;
        Wed, 30 Mar 2022 02:04:57 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.23.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F4773F66F;
        Wed, 30 Mar 2022 02:04:55 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:04:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] entry: fix compile error in
 dynamic_irqentry_exit_cond_resched()
Message-ID: <YkQdMDlIt1iHWS3U@FVFF77S0Q05N>
References: <20220330084328.1805665-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330084328.1805665-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:43:28AM +0200, Sven Schnelle wrote:
> kernel/entry/common.c: In function ‘dynamic_irqentry_exit_cond_resched’:
> kernel/entry/common.c:409:14: error: implicit declaration of function ‘static_key_unlikely’; did you mean ‘static_key_enable’? [-Werror=implicit-function-declaration]
>   409 |         if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
>       |              ^~~~~~~~~~~~~~~~~~~
>       |              static_key_enable
> 
> static_key_unlikely() should be static_branch_unlikely().
> 
> Fixes: 99cf983cc8bca ("sched/preempt: Add PREEMPT_DYNAMIC using static keys")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Sorry about this. FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

For context for others, this'll only show up on architectures which both use
the generic entry code and select CONFIG_HAVE_PREEMPT_DYNAMIC_KEY. Today, only
arm64 selects CONFIG_HAVE_PREEMPT_DYNAMIC_KEY, and it doesn't use the generic
entry code.

Sven, I assume you're looking at wiring this up on s390 or parisc?

Thanks,
Mark.

> ---
>  kernel/entry/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index ef8d94a98b7e..371ee8914af1 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -406,7 +406,7 @@ DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
>  DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>  void dynamic_irqentry_exit_cond_resched(void)
>  {
> -	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> +	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
>  		return;
>  	raw_irqentry_exit_cond_resched();
>  }
> -- 
> 2.32.0
> 
