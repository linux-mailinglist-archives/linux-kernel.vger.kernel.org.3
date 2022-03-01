Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A874A4C8D85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiCAOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiCAOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:18:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83012671;
        Tue,  1 Mar 2022 06:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB7D61549;
        Tue,  1 Mar 2022 14:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA2BC340F9;
        Tue,  1 Mar 2022 14:17:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FxuRFGkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646144249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wi3i96/wmqMIwx3wn7eIDg7ic4mvqpHlhPzqx/cxrvg=;
        b=FxuRFGkEk6bsiaMmwLO+GSj9BMSQzNGo3JLCFOX6lFbKZ2Xi+0R5zshySjhYq30vBbZogE
        KZGsFCX3JMrkaBvJvjVj9lyAL6c9TZCotqgv7FSUZo7lKmmz39cnosYJC1YjOt4dwdFUDH
        d5gwbmKbElhGAJYDcRwBSXi0Sfqovp8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f2e36451 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 14:17:29 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id f5so3653447ybg.9;
        Tue, 01 Mar 2022 06:17:29 -0800 (PST)
X-Gm-Message-State: AOAM531sXDsWLQRv5ZcMLyQoI3zk4hyKaRmXNA39kEw5ZTVkwgIrH4KE
        SanbJnrvJBDYo4Jg+9ccPNYm9vIbfe4ifuwwDuw=
X-Google-Smtp-Source: ABdhPJy+JE8PV2WW9wy7wujk4BA2IH2XCT1livVxX2BSwxc+6BFGyr7tWjee+U7ChBP6OKDVPnXxw23xb6xo+dT1IF8=
X-Received: by 2002:a25:b905:0:b0:61e:23e4:949f with SMTP id
 x5-20020a25b905000000b0061e23e4949fmr24865932ybj.373.1646144246594; Tue, 01
 Mar 2022 06:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
 <20210610134459.28541-2-tianjia.zhang@linux.alibaba.com> <Yh32tEhUgGeSXf/A@zx2c4.com>
 <52be961d-a00d-785d-8fb1-15b1a17bd74e@linux.alibaba.com> <CAHmME9pvbeGhWD+0N4_nOh-pkWmt7=Q9PDW40QjK8NHiJi7D2w@mail.gmail.com>
In-Reply-To: <CAHmME9pvbeGhWD+0N4_nOh-pkWmt7=Q9PDW40QjK8NHiJi7D2w@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Mar 2022 15:17:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9qBzVzBfAYZdTUNM0qW3JtQow4Fcf+hyrOVJQWte_jV2Q@mail.gmail.com>
Message-ID: <CAHmME9qBzVzBfAYZdTUNM0qW3JtQow4Fcf+hyrOVJQWte_jV2Q@mail.gmail.com>
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

On Tue, Mar 1, 2022 at 2:22 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> You additional export symbols of those SIMD implementations in
> arch/crypto/, which is not correct either, since nothing in the tree
> uses those symbols. Please remove those EXPORT_SYMBOL directives as
> well. Those functions can be static, and do not need to be declared in
> the .h file.

Actually, this part isn't quite so, because you share the avx
implementation in the avx2 implementation. However,

> Yes, and those accelerated implementations are part of the crypto API,
> and are not used by anything except the crypto API. Hence this should
> be in crypto/, just like everything else that is /only/ used for the
> cryto API. lib/crypto/ is for in-kernel users of crypto via normal
> code paths. sm4.c does not belong in lib/crypto/ and should be moved.

This still holds.

Jason
