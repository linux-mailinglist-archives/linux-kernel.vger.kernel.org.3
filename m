Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68318575736
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiGNVtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiGNVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:48:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD4132EC1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:48:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bp15so5775488ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1iX27wFeV0T/X/fBHF2BNfaWRJqrDGUQT8DlTbAlDg=;
        b=FWC7HCmyZVead3f2O3DASZjsf1DvWU3lo55I8StLcNFNInBWNn7wtRAGdMMZc7vrOy
         4gtk6E+oaR9L65XjWqwLxsWfinSbNh3ow9dXD48q+t8QtaY3AmdJvPCbjHSn25eVEFJh
         CND1MbO0rSFNpPNls/b2Mfc4joBGdSTOm5a5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1iX27wFeV0T/X/fBHF2BNfaWRJqrDGUQT8DlTbAlDg=;
        b=cUEMDu2vwkoz5g/K6lQrKYuMiSDr1oHrIICT0YzpAsdRIDPuRFBYqSqiHEg9+ta/Ik
         UJTcml2I2cxN87NIMuGUPeRcEGFYHSprjNaBgjrQwmH9USlR2cCzdm6mgBAKd6kIBWrx
         6gXGDYsrG+xMj58kGrliiMIDsGDAWVNVsI/JcnGnYLDDKTfDoaO6zw14DCcezD9ftBGl
         x+d7li+VQjHXLbI4ATisNDDHdisC+GwIXl3OSzsHKQbrZhJ2BdmJFHctsVDf/b/IJ1Qj
         AlpcexxySk9TfzHbfs9F/6TTqdkO1p/tay3OX/sPg/fod8TBIVoGXuty1s9c6z4HwJUV
         SVzg==
X-Gm-Message-State: AJIora91DSLhDi3hzRIVSdxnEADQZWr1+dg8+mBAavscS3Yp+AQcJKpU
        8eI8HOqJKV0I9bwZgkYSUDQ/FEW5E/i1aUjeZhg=
X-Google-Smtp-Source: AGRyM1s4r4YS/LKMLhElojNh8B7dSrgTiIw5ct0k07PIgqabkyzyTFqExhGKJO5SUEhVShE3pHTH0Q==
X-Received: by 2002:a17:907:a055:b0:72b:16dd:d485 with SMTP id gz21-20020a170907a05500b0072b16ddd485mr10643567ejc.435.1657835334855;
        Thu, 14 Jul 2022 14:48:54 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906119800b0072b8fbc9be1sm1157793eja.187.2022.07.14.14.48.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 14:48:54 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id r10so4302566wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:48:53 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr10262406wrh.193.1657835333499; Thu, 14
 Jul 2022 14:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220714205646.4023495-1-ndesaulniers@google.com>
 <CAHk-=whnndsMXO=32vFn9-Osw4r8-NvROV1rtsbxjw9Uvj1WPA@mail.gmail.com> <CAKwvOd=PB9Kpbnf3y0e5u6LrZ=Lv2Ex8O7y=VY63D67Jf2eyHQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=PB9Kpbnf3y0e5u6LrZ=Lv2Ex8O7y=VY63D67Jf2eyHQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 14:48:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whs05rO37wjdTOgppP-N+mYy70Q2ctBrp6vMoUP=OtcVA@mail.gmail.com>
Message-ID: <CAHk-=whs05rO37wjdTOgppP-N+mYy70Q2ctBrp6vMoUP=OtcVA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:38 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> int do_div (int dividend, int divisor) {
>   return dividend / divisor;
> }
>
> has UB should divisor ever be zero, not much different from:

So?

What about the million other '/' in the kernel?

Adding one check to 'do_div()' is just stupid. It's like using a
bottle-cap as an umbrella.

Nick, that's the whole _point_ of having compiler support for things
like this - automation. Because doing them manually one at a time is
just completely broken and stupid.

                Linus
