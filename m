Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA04ABE5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356031AbiBGMDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391100AbiBGL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:58:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F9C03542F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:57:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F626B811D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCA6C004E1;
        Mon,  7 Feb 2022 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644235031;
        bh=1gjzPxzY6TrtkD/E/QoBv0Pnu4h98uNL6Xtp/W2eAWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2r0Qy0d1WxcFIB9DEbkeirAjqXCRmYv72myWdUQv+Sl6L6cOuQ96/CqWHBCl726P
         5N+5dA+Kj7lVCVQW5eK3Q3zSRj3watMYybj4UAVv7bDfOuDjZKCoP9ltw1jBElZCSl
         CqABD0U62RXhE6JrkJIkZzSj11k8yx00F+hdPy/RtMvg1MGqQJUIY9j6GlTTXs3RSj
         4i5/Hwz7tKZGyXl3RBlr6VnGnnFCSm+muQDfmGLL5IZr1ZWFKMDZUFS8eTCYNAZ89q
         DOYGSx+BWlq24iahh5TJ0DR5HdE0sxdTJ/kopFIWHI6N4l4t0PXjQb8z06SDJC670U
         rfXPuGm5csCiQ==
Date:   Mon, 7 Feb 2022 12:57:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v2 5/7] sched/preempt: add PREEMPT_DYNAMIC using static
 keys
Message-ID: <20220207115708.GA514319@lothringen>
References: <20220204150557.434610-1-mark.rutland@arm.com>
 <20220204150557.434610-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204150557.434610-6-mark.rutland@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:05:55PM +0000, Mark Rutland wrote:
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index dfd84c59b144..141952f4fee8 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -456,13 +456,19 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
>   */
>  void raw_irqentry_exit_cond_resched(void);
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> +#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
>  #define irqentry_exit_cond_resched_dynamic_disabled	NULL
>  DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
>  #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
> -#else
> -#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
> +#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);

If CONFIG_PREEMPT && CONFIG_PREEMPT_DYNAMIC and no "preempt=" parameter is
passed, nothing is overriden on boot. So you need to either have cond_resched
and might_resched initially disabled (STATIC_KEY_FALSE?) or call
sched_dynamic_update() from preempt_dynamic_init() also when CONFIG_PREEMPT=y.

Thanks.
