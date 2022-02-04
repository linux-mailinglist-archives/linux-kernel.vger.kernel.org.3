Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2144A919C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356230AbiBDA2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiBDA2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:28:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C7C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:28:02 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so4643706pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vhgypBVUxatDQA2t/PEFyJq1Dz/oV4D6TAQvVZv0u8=;
        b=W0bGQxU2pU33Ei4vTMwb4LxDzrWE0EXjvMUkCBocmmMUvkaM2UsgQk5t3PALzqMv7A
         lwPd32y7m9eeQCbpVad3GG1/067X3mSlbKgu/pUqoqJwnR6nFSBetJG6JYl6+G+RMZX1
         qQ5u/9a9tlXqQzT9hGubw9MgAX/XtNzYaS4xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vhgypBVUxatDQA2t/PEFyJq1Dz/oV4D6TAQvVZv0u8=;
        b=XJy74JaRCkkcjeDhjtqmoS/vJHcB+qhN6YQoCeEB115pgY+5x/5on/iaj9ezSr0xwY
         Tit3fHvC4+dCjQNPmwqYSUe/tTx4XCavYDOLx1o+bWCMcaL/4YorTBFchKGrFYPO8dNc
         JIOCj3wvJKodIFTgE7e9yD1Vwgt0RRx/KkJZ1sjZpCQdAB+Vl2n5pL75/LQXnF4cwrKG
         97imxCr2Lc0hyoJG46CB7YU/nhUmbf2eE6EZamsR9/a1UZZwExXeo3yjFCPXPjAQYGux
         nwj6GjYGz6KZTv3ecnuHSxPwK/Pgd1Ls0Rr/nvIowRLmcFgj3/nBeRatwAOiCopXoncu
         K31w==
X-Gm-Message-State: AOAM533vJi1g11ErAtNnml5fBmV8JaWx1j5GYVhVlU5YyVspLdlkp4Tn
        pbArvhGvgerrMKMpQzw17A7twg==
X-Google-Smtp-Source: ABdhPJzclz2hHFHcinwuT36MxYy5C66IRul1bzvGhtdzdI25zojLs1J2oEC8VA4G/XwZL8ZwyaFSNQ==
X-Received: by 2002:a17:903:183:: with SMTP id z3mr380439plg.127.1643934482295;
        Thu, 03 Feb 2022 16:28:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm162686pfu.194.2022.02.03.16.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:28:01 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:28:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
Message-ID: <202202031627.0EEB393@keescook>
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-5-keescook@chromium.org>
 <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:13:33PM -0800, Nick Desaulniers wrote:
> On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index c45159dbdaa1..5482536d3197 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -2,7 +2,9 @@
> >  #ifndef _LINUX_FORTIFY_STRING_H_
> >  #define _LINUX_FORTIFY_STRING_H_
> >
> > -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> > +#include <linux/const.h>
> > +
> > +#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline)) __overloadable
> 
> Sorry, I just noticed this line (already) uses a mix of open coding
> __attribute__ and not. Would you mind also please changing the open
> coded gnu_inline to simply __gnu_inline to make the entire line
> consistent?

Ah yeah, thanks. Fixed.

-- 
Kees Cook
