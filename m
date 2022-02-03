Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A174A9085
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355723AbiBCWNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiBCWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:13:47 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A50C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:13:46 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z7so5955181ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xJKejqFUEH0gH02bsrJyrmiS9uC9eYI5/u6Jxv0S8E=;
        b=H24z7FjJDol5wBZEbnN2Imdyd1onGd0cFpHlfJZfyL+uWUtNi2aoFXif9gUr+4s3Xv
         uBmskidnVWURLL+YtWHTjHZ9PJG9hKcRd7yQhsPw58FBd4qf0Q4eTR/0/1f4tOtdnCu1
         fDPqQqRoSiBLnGmelyqJmyFNGGvecWyqTLD4PXP1wAafPBiLwFGWOmNe+uuU6wMO8cfJ
         MRPioqayInupF70/CODAACEA0JvTFoJTv+OByl6ZVBfaxCQpBYUO/HI2TkIH1YBncuQK
         Lzw6UWJ7iq3T2kAX32oz66qtHCL6s7tKSB94chdxTr8WF7WpolWrLPftMc0su3IMkMdb
         /jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xJKejqFUEH0gH02bsrJyrmiS9uC9eYI5/u6Jxv0S8E=;
        b=cTXRCQOLd4PIgL+klOEJpc/2bk8GtKOAXGaaU6SFaWQ45pdzOCBcWzhPYqt5vFeHC6
         D0sNNOoaQo0SUTRuzzjpc0ab2QYwj0JAbG6l+i4pgUT6boF6STJMTFc6UhN1MY0CcbkS
         xghHsefpRen2431+vhEPqLpfI1dI0H5kzbPXgoBtcG7DzTzM9qUq+EEuWhDkwACBjnzU
         BXK8HwofLmLUG+nbzrp4pZSRdc/r+RgEVNLfmRsOWXl8wjmnsQkqm3IvrAetnPurx3bG
         dAhzgnFn1HOOdoBeTJ6idvmDIakR3bsKDUMTatggqcwUDf7+wZVRR4JDOcgr9vpTM/jb
         c4aQ==
X-Gm-Message-State: AOAM531cbCvUSvLI8FMDdj70KrrQSZl83wYdVkBVbS0Gpc0Wb+Xv2CRc
        4kTMftSfKmwmroDKNYBXwVFqrl7Snti7B862Ee4N7w==
X-Google-Smtp-Source: ABdhPJwukk4FfgGCE9DXGX12jyqxMhXq20QnpHOQ5CsAHRtiMZ0ck8ImUh9oBxHNeO9V4ehDak2Z2QOHbbWezu5b8SI=
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr27111lja.339.1643926424857;
 Thu, 03 Feb 2022 14:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org> <20220202003033.704951-5-keescook@chromium.org>
In-Reply-To: <20220202003033.704951-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 14:13:33 -0800
Message-ID: <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index c45159dbdaa1..5482536d3197 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,7 +2,9 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>
> -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> +#include <linux/const.h>
> +
> +#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline)) __overloadable

Sorry, I just noticed this line (already) uses a mix of open coding
__attribute__ and not. Would you mind also please changing the open
coded gnu_inline to simply __gnu_inline to make the entire line
consistent?
-- 
Thanks,
~Nick Desaulniers
