Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9973B53E246
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiFFIWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiFFIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:22:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F6CC4;
        Mon,  6 Jun 2022 01:22:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so8431891wra.1;
        Mon, 06 Jun 2022 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oKiwtYWwJ/ZAYTG8vdYuhRqG3yc8krk/ZBTNC2MOyng=;
        b=gM8wZ/Jx8lrC6fmxR/XpEfarEEJJz9uExyTwyh9muHTRApq5hOGMFrj88oPbNqF3iC
         60paYjYKRrLSiyckRcOsuxrsTRE/wNkcWlUsZMqRH3zEvh9i0dxMTSGLoDRTKavBADLH
         ZXw6OCXI8UmfWx78iS5dFmwHY5CKXWlAT3c4H3aEwasPFnsnspzUqibg/fiKHAbG3HaL
         /3o2rDM+OjpPOvSYFeU2irp+ETdvmomGGpJHXjbqTU+Fmcr+kM3jemaA8xMuVHho49lw
         Vupf/aoNKgVD1uzHD+OZXJ7X9kCdzafFKp9oK4Dh1iBSgvpimNCfkYHvt5roDcq6Fqqq
         6vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oKiwtYWwJ/ZAYTG8vdYuhRqG3yc8krk/ZBTNC2MOyng=;
        b=Wpu/xj91CEkJHTnT8eMQRi+BopLdzcHlAV7zgVrdhIpQKlQoyADvGOCAjj9HPztS6S
         NdHvNwF1mt8Kch8goLU4q8FQM8vP3m38tq+a4Ofd0Aq1GKCUFOBA9NXumD0CYLI94d8U
         J6UY7idqhLhewxlvBg9UQeOjAgvzr0b5o/FJAqDYouVJ2WZJdKEW6lz7GGupky+QUkKn
         KcTNkrT4nI6OCtAts3nCOlcTHjruGZ5Nbef78YWG6fE4dy/1o3H4zlgB3k9bd5RJAQS1
         YIgYyKxItCOpNrhhMZJ4sxkBsEaDSSK2omqYQfhY713G60RCree4ulkuiTChQVynIsBY
         RdIg==
X-Gm-Message-State: AOAM533ZfJw8txhk3XXxTELXgfJ5GSFMrl1J8Z5DBdHa8uSPoicZn0Bv
        UPPQtDK7Jpk1bXHO13G79tc=
X-Google-Smtp-Source: ABdhPJz7JciclJBrOqf8JtfMLxlNu71DjfTpAykx1io2ek9vepBw+TG/Dtn+BMR5meU5xE3utuCgKg==
X-Received: by 2002:adf:eb11:0:b0:213:19dd:e1aa with SMTP id s17-20020adfeb11000000b0021319dde1aamr19393403wrn.324.1654503767336;
        Mon, 06 Jun 2022 01:22:47 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id j22-20020a5d4536000000b0021108003596sm14062329wra.10.2022.06.06.01.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 01:22:46 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:22:41 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Message-ID: <Yp25UVBCNHzeiQOn@Red>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com>
 <YpcYLiJfC6tgP2Nj@Red>
 <HK0PR06MB320263939B2E388481DE2A0A80DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR06MB320263939B2E388481DE2A0A80DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Jun 01, 2022 at 08:38:51AM +0000, Neal Liu a écrit :
> > Le Wed, Jun 01, 2022 at 01:42:00PM +0800, Neal Liu a écrit :
> > > Hash and Crypto Engine (HACE) is designed to accelerate the throughput
> > > of hash data digest, encryption, and decryption.
> > >
> > > Basically, HACE can be divided into two independently engines
> > > - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> > > engine driver for hash accelerator.
> > >
> > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > 
> > Hello
> > 
> > Did you test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y (you should
> > said it in cover letter).
> > There are several easy style fixes to do (please run checkpatch --strict) Did you
> > test your driver with both little and big endian mode ?
> > 
> 
> Yes, I also test it with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y. I'll describe it in cover letter as you suggested.
> And the style problem would be fixed, thanks for your suggestion.
> 
> How to test it with both little and big endian mode? It would be appreciated if you give me some clue.
> 

Hello

Sorry for the delayed answer.

You should try compiling and booting with CONFIG_CPU_BIG_ENDIAN=y

> > Also please see my comment below.
> > 
> > [...]
> > > +/* Initialization Vectors for SHA-family */ static const u32
> > > +sha1_iv[8] = {
> > > +	0x01234567UL, 0x89abcdefUL, 0xfedcba98UL, 0x76543210UL,
> > > +	0xf0e1d2c3UL, 0, 0, 0
> > > +};
> > > +
> > > +static const u32 sha224_iv[8] = {
> > > +	0xd89e05c1UL, 0x07d57c36UL, 0x17dd7030UL, 0x39590ef7UL,
> > > +	0x310bc0ffUL, 0x11155868UL, 0xa78ff964UL, 0xa44ffabeUL };
> > > +
> > > +static const u32 sha256_iv[8] = {
> > > +	0x67e6096aUL, 0x85ae67bbUL, 0x72f36e3cUL, 0x3af54fa5UL,
> > > +	0x7f520e51UL, 0x8c68059bUL, 0xabd9831fUL, 0x19cde05bUL };
> > > +
> > > +static const u32 sha384_iv[16] = {
> > > +	0x5d9dbbcbUL, 0xd89e05c1UL, 0x2a299a62UL, 0x07d57c36UL,
> > > +	0x5a015991UL, 0x17dd7030UL, 0xd8ec2f15UL, 0x39590ef7UL,
> > > +	0x67263367UL, 0x310bc0ffUL, 0x874ab48eUL, 0x11155868UL,
> > > +	0x0d2e0cdbUL, 0xa78ff964UL, 0x1d48b547UL, 0xa44ffabeUL };
> > > +
> > > +static const u32 sha512_iv[16] = {
> > > +	0x67e6096aUL, 0x08c9bcf3UL, 0x85ae67bbUL, 0x3ba7ca84UL,
> > > +	0x72f36e3cUL, 0x2bf894feUL, 0x3af54fa5UL, 0xf1361d5fUL,
> > > +	0x7f520e51UL, 0xd182e6adUL, 0x8c68059bUL, 0x1f6c3e2bUL,
> > > +	0xabd9831fUL, 0x6bbd41fbUL, 0x19cde05bUL, 0x79217e13UL };
> > > +
> > > +static const u32 sha512_224_iv[16] = {
> > > +	0xC8373D8CUL, 0xA24D5419UL, 0x6699E173UL, 0xD6D4DC89UL,
> > > +	0xAEB7FA1DUL, 0x829CFF32UL, 0x14D59D67UL, 0xCF9F2F58UL,
> > > +	0x692B6D0FUL, 0xA84DD47BUL, 0x736FE377UL, 0x4289C404UL,
> > > +	0xA8859D3FUL, 0xC8361D6AUL, 0xADE61211UL, 0xA192D691UL };
> > > +
> > > +static const u32 sha512_256_iv[16] = {
> > > +	0x94213122UL, 0x2CF72BFCUL, 0xA35F559FUL, 0xC2644CC8UL,
> > > +	0x6BB89323UL, 0x51B1536FUL, 0x19773896UL, 0xBDEA4059UL,
> > > +	0xE23E2896UL, 0xE3FF8EA8UL, 0x251E5EBEUL, 0x92398653UL,
> > > +	0xFC99012BUL, 0xAAB8852CUL, 0xDC2DB70EUL, 0xA22CC581UL };
> > 
> > Thoses IV already exists as define in linux headers (SHA1_H0 for example) But I
> > am puzzled on why you invert them.
> > 
> 
> This is Aspeed hardware limitation.

The limitation is that hardware does not know theses IV ?
Having them inverted seems to proof that you have some endianness issue.

> > 
> > Why didnt you use the crypto_engine API instead of rewriting it.
> 
> Any common crypto_engine API can be used? I did not find any, Maybe I miss something.
> It would be appreciated if you give me some clue.
> 

Please check crypto/crypto_engine.c.
You could take crypto/omap and allwinner/sun8i-ce as example of usage.

Regards
