Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E94C8C89
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiCANXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCANXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:23:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E294C43ADE;
        Tue,  1 Mar 2022 05:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DC1661492;
        Tue,  1 Mar 2022 13:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BDEC340F6;
        Tue,  1 Mar 2022 13:22:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aaeWUnOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646140949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcFwbBQlk4N6dLDr7ol2zSn4srWBhKw+bhj4t3mx+tA=;
        b=aaeWUnOw/oQFplXWOGiUohaTfWucM0p6Si2ZZ1xR0E6jOtsgD6CyEzvRLckGZRUyLQNnfd
        daWMKitMQ7cGczdu2LmNfCopzlPSSCLXbk1+jPXmFqL+h4HI8WGzaYfQzUC+u0W+E9G3rW
        ayhPEv813xg5wOp0ZomPSSqLvaoOnq8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8841f98a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 13:22:29 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d6d0cb5da4so144041727b3.10;
        Tue, 01 Mar 2022 05:22:27 -0800 (PST)
X-Gm-Message-State: AOAM531zNM101Se3n+RjIRAXPG+BZsrgzacwPMB2rdEKBC9D5cTOo7Zg
        ppX1VNZGtK6ZA30zzUZ/DX02w2LlXRn+1TCJ7Mw=
X-Google-Smtp-Source: ABdhPJzk8mJx2bMABmMdRjdp1LtAWDtzZ1zD/XcRpopsk81uJHBKHBuk+dQythWCj5JJ+Bm5Wl+PrkaQXagnMVJ9yOc=
X-Received: by 2002:a81:7d04:0:b0:2d0:d0e2:126f with SMTP id
 y4-20020a817d04000000b002d0d0e2126fmr24512255ywc.485.1646140946219; Tue, 01
 Mar 2022 05:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
 <20210610134459.28541-2-tianjia.zhang@linux.alibaba.com> <Yh32tEhUgGeSXf/A@zx2c4.com>
 <52be961d-a00d-785d-8fb1-15b1a17bd74e@linux.alibaba.com>
In-Reply-To: <52be961d-a00d-785d-8fb1-15b1a17bd74e@linux.alibaba.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Mar 2022 14:22:14 +0100
X-Gmail-Original-Message-ID: <CAHmME9pvbeGhWD+0N4_nOh-pkWmt7=Q9PDW40QjK8NHiJi7D2w@mail.gmail.com>
Message-ID: <CAHmME9pvbeGhWD+0N4_nOh-pkWmt7=Q9PDW40QjK8NHiJi7D2w@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: sm4 - create SM4 library based on sm4 generic code
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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

Hi Tianjia,

On Tue, Mar 1, 2022 at 12:50 PM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> Hi Jason,
>
> On 3/1/22 6:34 PM, Jason A. Donenfeld wrote:
> >>   lib/crypto/Kconfig   |   3 +
> >>   lib/crypto/Makefile  |   3 +
> >>   lib/crypto/sm4.c     | 184 +++++++++++++++++++++++++++++++++++++++++++
> >
> > If this is only used by the crypto API, it does not belong in
> > lib/crypto. I understand you want fallback generic code for the SIMD
> > implementation, but we've generally done that in crypto/ when the use
> > case is only the crypto API. Can you move this to the right place?
>
> This is not only used by the crypto API, but also used for SIMD
> acceleration under the x86 and arm architectures, mainly for processing
> the remaining blocks after SIMD acceleration. In general, the
> performance of SIMD processing a single block is not as good as that of
> general software implementations.

Yes, and those accelerated implementations are part of the crypto API,
and are not used by anything except the crypto API. Hence this should
be in crypto/, just like everything else that is /only/ used for the
cryto API. lib/crypto/ is for in-kernel users of crypto via normal
code paths. sm4.c does not belong in lib/crypto/ and should be moved.

You additional export symbols of those SIMD implementations in
arch/crypto/, which is not correct either, since nothing in the tree
uses those symbols. Please remove those EXPORT_SYMBOL directives as
well. Those functions can be static, and do not need to be declared in
the .h file.

Thanks,
Jason
