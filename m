Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240A94B8270
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiBPIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:00:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPIAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:00:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16812F158
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:00:12 -0800 (PST)
Date:   Wed, 16 Feb 2022 09:00:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644998411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3wE8zC2jYkj5x3k+oWAafJ5133fm1wlh+aJZav8UAA=;
        b=jaXSSzyje7OAjBr0pNyS0kC9631YB1d0r1xiJeJPjaji5U2NKpyppIrJV5amnFvQkcYG9Q
        8d0SSRbXsJAOSdUb89yBAfAS4FfeX5DSV/GCIQKXw2q6KKwkyRoq8lOlfMMew4LXLA+OCO
        Cp2N/xN6XosIIIT78a+yaNDYInxTNZ/9JiJ/uJC+n30MVenmAMOt6mQgywm7LKqwjG7Qh0
        2YjthQae5zOy9x/vGdYHMP/akgtArO8bY4pyPDFkJ5QURwqR9oUcSVhIhCHe6vE0BSlguK
        WI5xR4MGgO1OKhrm+rKXMoOw5dLg5JWT2D09F2WC4s1ozE6QDTPKpFfpySqCMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644998411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3wE8zC2jYkj5x3k+oWAafJ5133fm1wlh+aJZav8UAA=;
        b=cx7+VPwBYMo2YklIKj2fj9LIDfDAb3Ai+sBh0/4P+3PYdLJawOMwiPIaYrG+cdU1BBB3iR
        JJd8W0dzCP+bV5AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] mm/page_alloc: Mark pagesets as __maybe_unused
Message-ID: <YgyvCTiIWAFKq6G4@linutronix.de>
References: <20220215184322.440969-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215184322.440969-1-nathan@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-15 11:43:22 [-0700], Nathan Chancellor wrote:
> Commit 9983a9d577db ("locking/local_lock: Make the empty local_lock_*()
> function a macro.") in the -tip tree converted the local_lock_*()
> functions into macros, which causes a warning with clang with
> CONFIG_PREEMPT_RT=n + CONFIG_DEBUG_LOCK_ALLOC=n:
> 
>   mm/page_alloc.c:131:40: error: variable 'pagesets' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>   static DEFINE_PER_CPU(struct pagesets, pagesets) = {
>                                          ^
>   1 error generated.
> 
> Prior to that change, clang was not able to tell that pagesets was
> unused in this configuration because it does not perform cross function
> analysis in the frontend. After that change, it sees that the macros
> just do a typecheck on the lock member of pagesets, which is evaluated
> at compile time (so the variable is technically "used"), meaning the
> variable is not needed in the final assembly, as the warning states.
> 
> Mark the variable as __maybe_unused to make it clear to clang that this
> is expected in this configuration so there is no more warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1593
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7ff1efc84205..406f5d0c610f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -128,7 +128,7 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  struct pagesets {
>  	local_lock_t lock;
>  };
> -static DEFINE_PER_CPU(struct pagesets, pagesets) = {
> +static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {

No, I need to think of something else then for the local_lock thing.  I
haven't seen it with gcc. There is probably more than just this one.

>  	.lock = INIT_LOCAL_LOCK(lock),
>  };

Sebastian
