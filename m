Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4094A4012
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358170AbiAaKYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:24:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358122AbiAaKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:23:56 -0500
Date:   Mon, 31 Jan 2022 11:23:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643624633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KP118xyiOlCfNk6Yd6qwpbFDC5oBogtckl9rVGfc3U4=;
        b=1qqMupU1R69pNXQ/TeFSoXrMek18fQYm3CcWo22+BNV0gvpzOnj0/2zBU81yHvGmd3CzPI
        Z0b5+It4pK6zgzj3Q5tQUzYR0puoqFdctdXjTXc9+QiMOISO6bUOoDEdz5YNYiYy9vMKob
        ZY8i4ifLPQGJEewcDzITyVmvKtV4her+Tv1KXbIZE9v5YXL5iMZyblZ697BBQic/wzT3+O
        XLlZZH0iJROtnuCTOEfahzwp3XQ4JoAGg+oaw2W53qzikqJjbV0GCzZkx/1nR6EKxbva73
        nMAZ5WBgFM02EFqx8/M5NwfcEMPtYCsCRuRvaUDdf0GdSxiRuhzYMGAbJUJrUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643624633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KP118xyiOlCfNk6Yd6qwpbFDC5oBogtckl9rVGfc3U4=;
        b=E/2C2AXQkKgwmIl3KTMx+DqHKQS7paMznJWUUCeCefUq64ONtb2twfK0tt02MTsp7fnzjz
        ca7gtMjUE+FLQCCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <clark.williams@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.org>,
        linux-rt-users@vger.kernel.org, williams@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH PREEMPT_RT 4.19 STABLE] rt:  PREEMPT_RT safety net for
 backported patches
Message-ID: <Yfe4uHYEC+syPy/J@linutronix.de>
References: <20220130221944.7992CC340E4@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220130221944.7992CC340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-30 15:46:27 [-0600], Clark Williams wrote:
> While doing some 4.19-rt cleanup work, I stumbled across the fact that parts of
> two backported patches were dependent on CONFIG_PREEMPT_RT, rather than
> the CONFIG_PREEMPT_RT_FULL used in 4.19 and earlier RT series.  The commits
> in the linux-stable-rt v4.19-rt branch are:
> 
> dad4c6a33bf4e mm: slub: Don't resize the location tracking cache on PREEMPT_RT
> e626b6f873f2c net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT
> 
> Discussing this at the Stable RT maintainers meeting, Steven Rostedt suggested that
> we automagically select CONFIG_PREEMPT_RT if CONFIG_PREEMPT_RT_FULL is on, giving
> us a safety net for any subsequently backported patches. Here's my first cut at
> that patch.
> 
> I suspect we'll need a similar patch for stable RT kernels < 4.19.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
>  kernel/Kconfig.preempt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 306567f72a3e..951f58cbd652 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -6,6 +6,10 @@ config PREEMPT_RT_BASE
>  	bool
>  	select PREEMPT
>  
> +config PREEMPT_RT
> +       bool
> +       default false

default is false.

> +
>  config HAVE_PREEMPT_LAZY
>  	bool
>  

Sebastian
