Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D74D7968
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiCNCld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiCNCl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758E205E1;
        Sun, 13 Mar 2022 19:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB0260F71;
        Mon, 14 Mar 2022 02:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2ACC340F5;
        Mon, 14 Mar 2022 02:40:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e/iIu45z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647225615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxWsH5pTBRggZeOYLAsTkx6ggFTj7oXpuk7EgEQjyt8=;
        b=e/iIu45zpWTS2VodkwVy6GA8wAo3mI/atjtRMNodO8jBaOOvxUQ59wmvpFY7dKeeWcY0MR
        lzJtxwPeEl3Ve59mO8mAP6KHp9fWHYLAqyRoSuFV4eP3mg3vWQl0v/VQiegz4M434JMYA5
        0b3YH89y1jD7dVDmDXsgJTquAWVoWew=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c57d92b0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Mar 2022 02:40:14 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id e186so28040094ybc.7;
        Sun, 13 Mar 2022 19:40:13 -0700 (PDT)
X-Gm-Message-State: AOAM533qT78gRDa/hoS7UwwAr8D+/GnYcva+76JghQBICQzRmD5Zt94G
        D0btGw9CXY9NstGkZ4NNwvqHQCGjgi+bTX6qiFM=
X-Google-Smtp-Source: ABdhPJwIJoxwe8xzsbvNQZF8DmEyLN3lM7Ew7K6wEdhhGq9IcTHgIUUCLA6lC3JT3Q5QN/S2zaPVLRTmqBkuCRTKM3w=
X-Received: by 2002:a25:2312:0:b0:629:60d6:7507 with SMTP id
 j18-20020a252312000000b0062960d67507mr15832101ybj.267.1647225611795; Sun, 13
 Mar 2022 19:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
 <20210610134459.28541-2-tianjia.zhang@linux.alibaba.com> <Yh32tEhUgGeSXf/A@zx2c4.com>
 <Yh65NU6TwcvW/VZV@gondor.apana.org.au> <CAHmME9qL4gHwJZcYGRmJ8sxcjkpGFjWDH2gxu15FXzgCUDLifw@mail.gmail.com>
 <Yh/uW6z7aOyG0Jl8@gmail.com> <CAHmME9rUUGAM+MP802=dSe0HMLnGAq4Yne-NHfJxyGaKMcdSxg@mail.gmail.com>
 <d8e6305a-b535-5952-aa2a-275ca18c1bd9@linux.alibaba.com>
In-Reply-To: <d8e6305a-b535-5952-aa2a-275ca18c1bd9@linux.alibaba.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Mar 2022 20:40:00 -0600
X-Gmail-Original-Message-ID: <CAHmME9r5CiU9kB=h4QJGeQ5HtkznCaZeTV3e1pBDv1UjrS1AsQ@mail.gmail.com>
Message-ID: <CAHmME9r5CiU9kB=h4QJGeQ5HtkznCaZeTV3e1pBDv1UjrS1AsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: sm4 - create SM4 library based on sm4 generic code
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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

Are you willing to consider the views of Eric and me? Or is this a
hard nack from you?

Thanks,
Jason
