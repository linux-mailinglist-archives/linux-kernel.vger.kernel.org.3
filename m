Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E694A907B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355696AbiBCWME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiBCWMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:12:01 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABAC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:12:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q22so5934898ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvLgSYVGM2996ioEI15ojDQMy+E3HZDVmRKeEYykM40=;
        b=d+00TCXqREwctnhJC2Vz3mHrLurwPMNF8rFaK2ZoUN9UE7RX2igGNvTuW8fgOLewhw
         OOgkfYYCVz4oDaNHM7Ixgb6VHD9qnBfO13Wl3Wq5NapplduLQjYFtBNk1fmjfCBWq00j
         r0vW0gVU8HhLUMGSTdHdrw0WuaBYpz/ZIwSXX7XZ04wGfllcNcJXtLPQYA6/nEWvHccZ
         B0v9/KUCpixTg0BQmk66EiQpUjLMNiscv7khu0X/VkvagSLHNUW1YP6kkSsgKVJORwhW
         F97K+SZup9eAr0XfOrLzhg1tayDXjlpdwrqOic13Od4CADVoDAU/zrEGPWHc0pEmq4wR
         B6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvLgSYVGM2996ioEI15ojDQMy+E3HZDVmRKeEYykM40=;
        b=AbrgyqVEgtMUDLLf3XX43efPd5/tW4EYyHs1R78tg8Xi/vlEUZcIHTGx624Y2dilKX
         PhgQl+2FBQ8/iTwIqxVXuOMlnDc54FexYxhWthR7JykvKgg2gFyslK7Dh1EJ3u41qYZH
         LdZ825odRd9ai9cTeHSMR2vtUd2ejKNxTU6YUsmpOQsT2EWkmyCh0E9WFV4RpwTnJItJ
         Dz1QnBunIhvbaLaTs9/job9NAluL+RywAymBiHEMZpXQG7cKRHlyNk5ruHuKHMgN/aUE
         aZVgNvC5OyKzhhvw1AFtVofJlcHLFppxVRkAYHB+i/CP9fJMXULdOYSI6Gvekd+UMOIp
         atzg==
X-Gm-Message-State: AOAM530t0b2ETFplrxJyaStiDOvYexnfG9JX/mGFmk53MQg7ep+xUv4x
        17KS9nF0eMizZnFAPCdpdwfonzVfghvDTMizM/tZjA==
X-Google-Smtp-Source: ABdhPJx4xwSIhl1CWKMd+BeSstYj6x7/c4rQegMzqm29e91gX4A7J7U22wJThBU+MEd0EovNCPT+zJO+7qLu7pGf59A=
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr34894ljc.526.1643926319521;
 Thu, 03 Feb 2022 14:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-3-keescook@chromium.org> <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
 <202202031301.437D8FD3@keescook>
In-Reply-To: <202202031301.437D8FD3@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 14:11:48 -0800
Message-ID: <CAKwvOdm-_uGYrm=2LTGSR7yhGK08NniGdkhLj_sM-QD-xdKVtA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 1:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 03, 2022 at 12:26:15PM -0800, Nick Desaulniers wrote:
> > On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > must be marked as being overloadable (i.e. different prototypes).
> > > This allows the __pass_object_size versions to take precedence.
> >
> > Is this because of the `const` additions to the function signatures?
>
> That might be an issue, but the *real* issue is the implicit mutation of
> the function into an inline with _additional_ arguments. i.e.
>
> char *strcpy(char * POS p, const char * POS q)
>
> is really
>
> char *strcpy(char * const p, const char * const q, size_t __size_of_p, size_t __size_of_q)
>
> (i.e. what I was doing with macros, but all internally and still an
> extern inline)

What do you mean "is really"? 4/4 doesn't change the number of
parameters in strcpy explicitly in the definition AFAICT.
-- 
Thanks,
~Nick Desaulniers
