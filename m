Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D198D554BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356882AbiFVNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355133AbiFVNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:47:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD652AE11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:47:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so6716309ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QZHrrIBVW3T6cCzOrquv5g3s3bcHIbuUCuv4UP/4ic=;
        b=FmNIAbKhrN0tr6L1fI9HtdVfR7DjgkD7iykGsVbbqVbYqmGPYkuYj88aNATFf7XmjN
         Nk65pyBmSuDZEEGv2RAHOm/IqWDB0Fp0VdstYlyMr6ivizNYuBuT5BlBI0kL5DDBrK1P
         HeY63qQi5LEvLajcHynt3VDm2pUUK7Ml7VBG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QZHrrIBVW3T6cCzOrquv5g3s3bcHIbuUCuv4UP/4ic=;
        b=6GoEfiNSXMfvmAidg1tsXBBAO7GvHLIWMDtuFIA1ZOzTlqPDWZYrKm4LsRt5ZVihaZ
         U+ZEmCBOPgkYlslsur18GXHBXWEdSAApKz4t3UFOnRP+MQwd62BWWVQeAcAgpDeYsGqI
         MRns6RHVTc1Z69nsXJl9x0r47w2hT8ro6yPeWUAnYNSbu1tmEMeTGc0rcCOx73zTRXqZ
         hT73Kux5NP1H/BqqC8JyvhRDVrN+t0n/NpHGH5wnrTxqtizbK6ysFLdlm50zUN4ut+79
         NFwB30USNq70U+PCCn3lp4TQCA0MlBo/siVS3LoV7OH+VzlC1djFF8CZoW1l92Uxpv2v
         FlZA==
X-Gm-Message-State: AJIora/bEUPgLIJBycjL9BxKwZBgpvamHI1l8UB0Vs8BFcDndeHh1kJ7
        apxHw0liurmikqVSBTXE6QV60HvBR3lC0nCT
X-Google-Smtp-Source: AGRyM1uPrbNHbCJ1aAVJ10WR1Fgoy97eBi4zzF+4gTkdG4tGLD+RiwhP8QgZ/+FBgy7VBoHudUZ0Kg==
X-Received: by 2002:a17:906:265b:b0:722:e88b:1b31 with SMTP id i27-20020a170906265b00b00722e88b1b31mr1082128ejc.350.1655905660341;
        Wed, 22 Jun 2022 06:47:40 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id q12-20020a5085cc000000b0042ab87ea713sm15122986edh.22.2022.06.22.06.47.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 06:47:39 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso8966663wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:47:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr4093835wmq.8.1655905658386; Wed, 22 Jun
 2022 06:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian>
In-Reply-To: <YrLtpixBqWDmZT/V@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jun 2022 08:47:22 -0500
X-Gmail-Original-Message-ID: <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
Message-ID: <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 5:23 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> I have recently (since yesterday) started building the mainline kernel
> with clang-14 and I am seeing a build failure with allmodconfig.

Yeah, the clang build has never been allmodconfig-clean, although I
think it's starting to get pretty close.

I build the kernel I actually _use_ with clang, and make sure it's
clean in sane configurations, but my full allmodconfig build I do with
gcc.

Partly because of that "the clang build hasn't quite gotten there yet"
and partly because last I tried it was even slower to build (not a big
issue for my default config, but does matter for the allmodconfig
build, even on my beefy home machine)

I would love for people to start doing allmodconfig builds with clang
too, but it would require some initial work to fix it... Hint, hint.

And in the case of this warning attribute case, the clang error messages are

 (a) verbose

 (b) useless

because they point to where the warning attribute is (I know where it
is), but don't point to where it's actually triggering (ie where it
was actually inlined and called from).

The gcc equivalent of that warning actually says exactly where the
problem is. The clang one is useless, which is probably part of why
people aren't fixing them, because even if they would want to, they
just give up.

Nick, Nathan, any chance of getting better error messages out of
clang? In some cases, they are very good, so it's not like clang does
bad error messages by default. But in this case, the error message
really is *entirely* useless.

             Linus
