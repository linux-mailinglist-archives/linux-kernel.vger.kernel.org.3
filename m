Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B578530EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiEWLek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbiEWLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:34:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0D0750005
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:34:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66AFA11FB;
        Mon, 23 May 2022 04:34:20 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 405B23F73D;
        Mon, 23 May 2022 04:34:18 -0700 (PDT)
Date:   Mon, 23 May 2022 12:34:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 2/2] arm64: stacktrace: use non-atomic __set_bit
Message-ID: <YotxNzMfMdqw0uY2@FVFF77S0Q05N>
References: <697e015e22ea78b021c2546f390ad5d773f3af86.1653177005.git.andreyknvl@google.com>
 <a584e95f613d59c7ff45686c2805deb63bd61442.1653177005.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a584e95f613d59c7ff45686c2805deb63bd61442.1653177005.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 01:50:59AM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Use the non-atomic version of set_bit() in arch/arm64/kernel/stacktrace.c,
> as there is no concurrent accesses to frame->prev_type.
> 
> This speeds up stack trace collection and improves the boot time of
> Generic KASAN by 2-5%.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 33e96ae4b15f..03593d451b0a 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -103,7 +103,7 @@ static int notrace unwind_frame(struct task_struct *tsk,
>  		if (fp <= frame->prev_fp)
>  			return -EINVAL;
>  	} else {
> -		set_bit(frame->prev_type, frame->stacks_done);
> +		__set_bit(frame->prev_type, frame->stacks_done);
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 
