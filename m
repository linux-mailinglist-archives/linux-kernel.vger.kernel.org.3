Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC124D7971
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiCNCr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiCNCr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25A3205B;
        Sun, 13 Mar 2022 19:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6865560F79;
        Mon, 14 Mar 2022 02:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9806AC340E8;
        Mon, 14 Mar 2022 02:46:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QfZxhQW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647225974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDz5hx9lxCk7D09c3ISkgI6zkqAGOex3FBZ8f7v5Mb0=;
        b=QfZxhQW3Yyv6bW3EiEZx4jJkhs6iPPn9CvXZfa9Tq6tBgX8jXAMPVjRbAZLmYiNCzTA4xF
        VFgAKnShQVEoogMFV0OM0o1ADYqKSJSKhKpq06OVEtoiEaYCIqPD1DHXxCBKmH+vXgw/Np
        7l9kdqsro4cMFLZkfjvsoLpORBID9ww=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 894763f8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Mar 2022 02:46:13 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id x200so28065431ybe.6;
        Sun, 13 Mar 2022 19:46:13 -0700 (PDT)
X-Gm-Message-State: AOAM531KMaecuTScpibobFyr160JCzz1OixB4v2mkEZs33LqK1Bo24c8
        NQxqlN/OWmwDRV2W73k0QfoodC7kCQVdZKdTOlk=
X-Google-Smtp-Source: ABdhPJz5mcXnyF9zfanEzRVubdzS2dClTcwgr2TwDVhFJjM1oMDlJD7dQIQnPoDLl4BLm1skvRdGC6yfK58oKXv5js4=
X-Received: by 2002:a5b:6cf:0:b0:61e:1371:3cda with SMTP id
 r15-20020a5b06cf000000b0061e13713cdamr16907258ybq.235.1647225971412; Sun, 13
 Mar 2022 19:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
 <20210610134459.28541-2-tianjia.zhang@linux.alibaba.com> <Yh32tEhUgGeSXf/A@zx2c4.com>
 <Yh65NU6TwcvW/VZV@gondor.apana.org.au> <CAHmME9qL4gHwJZcYGRmJ8sxcjkpGFjWDH2gxu15FXzgCUDLifw@mail.gmail.com>
 <Yh/uW6z7aOyG0Jl8@gmail.com> <CAHmME9rUUGAM+MP802=dSe0HMLnGAq4Yne-NHfJxyGaKMcdSxg@mail.gmail.com>
 <d8e6305a-b535-5952-aa2a-275ca18c1bd9@linux.alibaba.com> <CAHmME9r5CiU9kB=h4QJGeQ5HtkznCaZeTV3e1pBDv1UjrS1AsQ@mail.gmail.com>
 <Yi6sMd51viEl3de6@gondor.apana.org.au>
In-Reply-To: <Yi6sMd51viEl3de6@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Mar 2022 20:46:00 -0600
X-Gmail-Original-Message-ID: <CAHmME9q7Cn6LfEXJuy26UyyG4KtW1ufzRBXLVpFQ6HK1at34jw@mail.gmail.com>
Message-ID: <CAHmME9q7Cn6LfEXJuy26UyyG4KtW1ufzRBXLVpFQ6HK1at34jw@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: sm4 - create SM4 library based on sm4 generic code
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        X86 ML <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Sun, Mar 13, 2022 at 8:45 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sun, Mar 13, 2022 at 08:40:00PM -0600, Jason A. Donenfeld wrote:
> > Hi Herbert,
> >
> > Are you willing to consider the views of Eric and me? Or is this a
> > hard nack from you?
>
> Please present your patch to move the code with the reasoning
> for the move and then I can consider it.

Okay, no problem, will do.

Jason
