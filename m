Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D74C2428
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiBXGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiBXGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:43:45 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65C192F25
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:43:16 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 27so954513pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2qG7ZKq2LLWcE9zTz7YvTPglUi3xbVY2wEf6KvxxJ8=;
        b=WA4MOhJmYzzPc7ehM4B4Ly35+5OunOQ5WwzYoeDhWwfBxgwAJKi97bI3GpMydQ4Y71
         fvutOpNi0dXCT6E0dzUy2Ll8YyAfhG5l5r+85MBF93pbS8JG9iajJ2AzFnQzLhKpef4w
         ZjhwET9dBfwja8qz9sCjFkTLnCwWJt8G56WM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2qG7ZKq2LLWcE9zTz7YvTPglUi3xbVY2wEf6KvxxJ8=;
        b=ebTloubGZvjcs1s0QY1wthnNXsfDw/yfI1L9x5TPaPLhQTZKbxDhyxw5PH94Dgbifv
         Nd8R9kzFIn7S/rg6YBiRgSNerqrfErzOoWMSMCjSbOrevD/OKXw/MAZ3gE9Cs39JmpxQ
         4PfaMrV1tr/uupn8KekF+BPwRpxoO48bQHndqn6lH61LRlgOoUoFyd/tRiD9IEahnFkH
         4cdbV6rrNT4Wnjh4Wex65rStuAuBR80s4H8S7U1ZmEPJ2miq6p49B3PxxPSDPivmsoLz
         DihMzi7Ys+p40sq2JoI9rzR5PWHBUYmKZIiGhGh1YfaMrYqWBV7L9CaJ5yhk6amUsX2r
         7BqA==
X-Gm-Message-State: AOAM531D4bTsxcHOVfQjqbcvXo5xidAi1LcYYqzXQynYjdKkwZ9UrJ9y
        4HmyYwvvbjo7FxRgPSnUzc2/u8Q8bANVHw==
X-Google-Smtp-Source: ABdhPJyOHD+pCoqYXDMeb5HUndZCLOinHUyw1Y69stmNhu8tnwxXMVGmJohGfoX845ZLZwIxPKDDUQ==
X-Received: by 2002:a63:9d44:0:b0:374:a18a:17fa with SMTP id i65-20020a639d44000000b00374a18a17famr1198415pgd.293.1645684996377;
        Wed, 23 Feb 2022 22:43:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm1873667pfj.44.2022.02.23.22.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:43:16 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:43:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, Marc Zyngier <maz@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xtensa: Implement "current_stack_pointer"
Message-ID: <202202232239.FF2343D42@keescook>
References: <20220224060503.1856302-1-keescook@chromium.org>
 <CAMo8BfJFJE-n3=AF+pb9_6oF3gzxX7a+7aBrASHjjNX5byqDqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJFJE-n3=AF+pb9_6oF3gzxX7a+7aBrASHjjNX5byqDqw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:22:59PM -0800, Max Filippov wrote:
> On Wed, Feb 23, 2022 at 10:05 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > To follow the existing per-arch conventions replace open-coded uses
> > of asm "sp" as "current_stack_pointer". This will let it be used in
> > non-arch places (like HARDENED_USERCOPY).
> >
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: linux-xtensa@linux-xtensa.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/xtensa/Kconfig                  | 1 +
> >  arch/xtensa/include/asm/current.h    | 2 ++
> >  arch/xtensa/include/asm/stacktrace.h | 2 +-
> >  arch/xtensa/kernel/irq.c             | 3 +--
> >  4 files changed, 5 insertions(+), 3 deletions(-)
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Thanks! And apologies, my cross-compiler tricked me into thinking this
patch compiled without problems. It did, however. I've change the patch
slightly to deal with the needed casts:

diff --git a/arch/xtensa/include/asm/stacktrace.h b/arch/xtensa/include/asm/stacktrace.h
index fe06e8ed162b..a85e785a6288 100644
--- a/arch/xtensa/include/asm/stacktrace.h
+++ b/arch/xtensa/include/asm/stacktrace.h
@@ -19,14 +19,14 @@ struct stackframe {
 
 static __always_inline unsigned long *stack_pointer(struct task_struct *task)
 {
-	unsigned long *sp;
+	unsigned long sp;
 
 	if (!task || task == current)
-		__asm__ __volatile__ ("mov %0, a1\n" : "=a"(sp));
+		sp = current_stack_pointer;
 	else
-		sp = (unsigned long *)task->thread.sp;
+		sp = task->thread.sp;
 
-	return sp;
+	return (unsigned long *)sp;
 }
 
 void walk_stackframe(unsigned long *sp,

Shall I send a v2, or just carry this fix in my tree?

Sorry for the glitch!

-Kees

-- 
Kees Cook
