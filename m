Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603CC4A79C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbiBBUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbiBBUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:53:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA7C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:53:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c3so301620pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ETnKDeiOpwbtdI5wfgwyS9AlH6EKFDBz28cAyBq176w=;
        b=Z8n6/iQ6Ng/iumDQGn5Zu/vWC5/7pLHgLzDZnJkpoNCssZHWsOx9eC6Sb1V2fJCNzQ
         6/0govRNCPerrev9lxboz2wl/wAoCyKRc90QsEnQWwXUMfCVwjCe3hu60jurrl1OatSt
         3NHG35dR73JSUUn6+43aaOaaymCDSFhkt6Gks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ETnKDeiOpwbtdI5wfgwyS9AlH6EKFDBz28cAyBq176w=;
        b=pWmLI5I7a/b1T3avPeprKymzZ4YTBZRL7cXu5bPP1M1eU0RnX0GnMqSXdCTwqvMGpH
         TImYbiWMPe5Pduq5RhEmwqs3yFROrgdQpT95RozzFGdD7woW4otwL2/VwHnsHW+YOub2
         CBI+5KAj3FLZbfiqOR/XwRYL4TS0oSOcRT5lezddjJ0Isrm8OmjIg9yBHtuvdCw4ir49
         9946qMZrX26/Ao+i6Wo0wMOYam0bNV4I38W/V+pRpkXvQGBjKzRriUx2bGJVKEXtVOdu
         M5yfsMtw8QiT0/7SO8GMC+0VD6JJgqji4bxhgpEesLfYaJiDOoMy2Y7EnG2RjJwiO23d
         B60g==
X-Gm-Message-State: AOAM533/szxBMJpCchNoPRr4tBFFA6EtAMRyuMyZZfRdUUXl/yHo7dm+
        cr2OP4Iz8YhZg6TnAR1sQUvRaPtdzsvhlQ==
X-Google-Smtp-Source: ABdhPJysBLPSxyD4Zj/4RBqUVky3ecL5kEsRiYnlSK96emSeDBQdAUZPYWpHfccyeJDtLUzp7z6b/Q==
X-Received: by 2002:a17:90b:1912:: with SMTP id mp18mr10098907pjb.152.1643835204425;
        Wed, 02 Feb 2022 12:53:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p22sm24518460pfw.139.2022.02.02.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:53:24 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:53:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] include: drop pointless __compiler_offsetof indirection
Message-ID: <202202021253.B62C357@keescook>
References: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 11:21:47AM +0100, Rasmus Villemoes wrote:
> (1) compiler_types.h is unconditionally included via an -include
> flag (see scripts/Makefile.lib), and it defines __compiler_offsetof
> unconditionally. So testing for definedness of __compiler_offsetof is
> mostly pointless.
> 
> (2) Every relevant compiler provides __builtin_offsetof (even sparse
> has had that for 14 years), and if for whatever reason one would end
> up picking up the poor man's fallback definition (C file compiler with
> completely custom CFLAGS?), newer clang versions won't treat the
> result as an Integer Constant Expression, so if used in place where
> such is required (static initializer or static_assert), one would
> get errors like
> 
> t.c:11:16: error: static_assert expression is not an integral constant expression
> t.c:11:16: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
> t.c:4:33: note: expanded from macro 'offsetof'
> #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
> 
> So just define offsetof unconditionally and directly in terms of
> __builtin_offsetof.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Yes please. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
