Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661264A88CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352335AbiBCQmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352328AbiBCQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:42:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97708C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:42:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so3503509pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FuRCLnfxwlvb1J+RwHflUcAxOrvFYgmF6o4xsZNYvRE=;
        b=P327Uxc0PHCdy0eIrGyhkt4gw8sFyN/ZgXuKAjNfKClxOr7jCwjevkV3J1f5HluXJ2
         AB2jtUhGsjC2ZbFmTLB4IoeYdqcDct5oKmjDI4wN0q7CEXSuthnrYySAAvf49eOwIAx4
         uVFbLfV2w7qkUgDWyyAr0Wez1CBoxm71LYhsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuRCLnfxwlvb1J+RwHflUcAxOrvFYgmF6o4xsZNYvRE=;
        b=rYGcVYxBezoA3qdykPA52/MmyLSfSMkirv0in9+81GxQImLAMMVPMWUaBeB09UEfpQ
         YDBFb2exBtJllB7XPcM5fQcIArvdDqEY6t2hxVsBcy/3sPaFhVtVYsuBZK5N4LhXkdP6
         W3uDZJCZ2CMI+ssYYYj91Tx+Fyc4Qsft37qyf6DK2LwiKKNVL/zDHs7i42apcXumYjwc
         PTb1ZmJQ3hKP6Od7xBti9FpEanmCONiVcfLtFcF4lHGYaeygbsC0s1AaTzcLbliaLoIc
         8FJoCBkcOy0oFE7W56/M8VSc2ui1P/U8jszM69H0gHQXFZvuYF8NNTWxk1lM/OVy5oKK
         vV/g==
X-Gm-Message-State: AOAM530PknOtdqq0Tc18usI9eQtlo9CKEkDe/gc8/iX7Sqf8YIXAt24U
        LNtfyg8lmqYZV3O2th6SzF+0mw==
X-Google-Smtp-Source: ABdhPJzVt446Nl24jLwqlYCF/L3YcUft8htmLOPs4wfow+9wqeN2hCr0oj1J/tM6R/ticZPsIpv2Rw==
X-Received: by 2002:a17:90a:f89:: with SMTP id 9mr14611265pjz.138.1643906548155;
        Thu, 03 Feb 2022 08:42:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm30393877pfl.126.2022.02.03.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:42:27 -0800 (PST)
Date:   Thu, 3 Feb 2022 08:42:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] m68k: cmpxchg: Dereference matching size
Message-ID: <202202030841.E00D20362@keescook>
References: <20220202225327.1544295-1-keescook@chromium.org>
 <CAMuHMdVRrD+2zKoHxAaQdDuiK5JFDanbv0SJ91OdWfx+eyekPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVRrD+2zKoHxAaQdDuiK5JFDanbv0SJ91OdWfx+eyekPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:13:30AM +0100, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Wed, Feb 2, 2022 at 11:53 PM Kees Cook <keescook@chromium.org> wrote:
> > Similar to the recent arm64 fix[1], avoid overly wide casts in the cmpxchg
> > implementation. Avoid this warning under -Warray-bounds with GCC 11:
> >
> > net/sched/cls_tcindex.c: In function 'tcindex_set_parms':
> > ./arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct tcf_result[1]' [-Warray-bounds]
> >    64 |                 __asm__ __volatile__
> >       |                 ^~~~~~~
> > net/sched/cls_tcindex.c:338:27: note: while referencing 'cr'
> >   338 |         struct tcf_result cr = {};
> >       |                           ^~
> >
> > No binary output differences are seen from this change.
> >
> > [1] commit 3364c6ce23c6 ("arm64: atomics: lse: Dereference matching size")
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for your patch!
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Do you want me to queue this in the m68k for-v5.18 branch, or do
> you want to take it yourself, together with commit a8712a32665f9b1a
> ("Makefile: Enable -Warray-bounds") in linux-next that triggers this?
> In case of the latter:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Given how -next is being ordered, it's probably best to go via my tree.
Thanks for the review!

-Kees

> 
> Please let me know. Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Kees Cook
