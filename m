Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC04A8F57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355089AbiBCUrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356627AbiBCUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43156C061749
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:45:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so4122482pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ax+zgGQyyKWqqmUNa+Gr/NFN1a356webih9nQCbtRlA=;
        b=lq4mnyUfUnu0BzR6Wiz2LqRbI6UXI+AlM29AzDRsgBJJEGxcudKiSVmcZVkBdH1V5R
         H9ihEHFWxShy/iMqODNdF03wxTXBQYKV/ZiBFz64MRdzRlBLWokuqPF3y8/2M49e7xEO
         8cpdAI1hx+7n5zGDn6/weEZdRv67FbbRqt0zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ax+zgGQyyKWqqmUNa+Gr/NFN1a356webih9nQCbtRlA=;
        b=wPHl+nnEnJfUusqyhqEnmSIKKaDzUoi8bHi1eRnfhrfleAAb4Rqmw4Xt1ofqMAi3d2
         vfBvg2tdq47pGIXbCmCZFMHwEthTJlR+jR6Guu+ZpgJ0TDXv0BpX45oMe0MEQtWj9Lq0
         k+oUdVYKHEI2ZEgEBzmcbTOvceYSlzcrODRLS/xQf3UFA9FIHrzLtb0ck0dJRt6oifIH
         Bi2bZjOxxKJ2MjVGxLk07cN5candAMIKau8rN1S2P9ZTWOXPb1HpPzHeGXdK4ZzNR6nq
         mxc3sZmZiTPdu37dGIEuj6oTbXkuquNkixTXsvcH2yJX57PWYuCOSGhrWkt4qwdC1Psn
         FbVw==
X-Gm-Message-State: AOAM5333HaFNaDWUhtPbSjNOuvxgcrtSY14TJOaORhCUtuSzzTdLCEwv
        1+QLIldareA8+hkPWqdSAKkX+A==
X-Google-Smtp-Source: ABdhPJzyIjueAdPLPELPYzMN0XC6MvF7sAwGHIqciSmxWkbnOpbPZS4x4gmcwTPLeXlwCj4QQRQGWA==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr37649101plk.137.1643921137797;
        Thu, 03 Feb 2022 12:45:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10sm30543226pfu.93.2022.02.03.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:45:37 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:45:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202031242.45A7F5704@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
 <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
 <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
 <202202030911.4914709E@keescook>
 <CAMuHMdUBKofPP-6EofE3B7d6k0zv0nPJ7e4pjsznPF==ApJ6qg@mail.gmail.com>
 <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnJ3w2Jb9tBZ+JnEfviquj2WktemCd833f=_P66a0qVag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:50:34AM -0800, Nick Desaulniers wrote:
> The kernel does not link against a libc; but it does provide many
> symbols that libc would provide, with the same or similar enough
> semantics that I would strongly recommend we _don't_ use
> -ffreestanding in order to get such libcall optimizations (there are a
> lot; see https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Utils/SimplifyLibCalls.cpp
> for some examples) and simply use -fno-builtin-* when necessary, or
> fix the kernel implementations individually.

Right, we really don't want -ffreestanding. Rather, we want to not link
against libgcc. This is mostly true already, though some of the smaller
architectures still do:

$ git grep print-libgcc
arch/arc/Makefile:LIBGCC        = $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
arch/csky/Makefile:     $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
arch/h8300/boot/compressed/Makefile:LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name 2>/dev/null)
arch/nios2/Makefile:LIBGCC         := $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
arch/openrisc/Makefile:LIBGCC           := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
arch/parisc/Makefile:LIBGCC             := $(shell $(CC) -print-libgcc-file-name)
arch/xtensa/Makefile:LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
arch/xtensa/boot/boot-redboot/Makefile:LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)

-- 
Kees Cook
