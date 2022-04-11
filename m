Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE2A4FB65E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbiDKIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbiDKIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:53:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC83EABE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:51:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g18so5672994wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IXFXkZ/zIPR/vpj7KNO5NDwB6CMm+azUma0NGH5YVgU=;
        b=DU1x7RrLRqhM32z2qCQqJ8a/bsJ1Es12ZQaw54KzV/aumf31lk1TLA1cpv4cZI8Ml0
         I+PBZQ513P+Kl+A/cS98JJNei9ccl78hSmxjsg7XW11/rh3t9Ybra6WILnO2jHnWVw03
         d99k42th8WeHxcw1YDHY+O1+QzALwhvy3AH1pZW142gprxVanbAPJMWDcfOlCMCwxITt
         0bDMQgwZrIbdNbhNstZ0ncbZD4ArqB/X32ZlX0JK3qVtYtPbKZ7UwF7Z7vjQOIhIkgsF
         hcglTWYerpYvHtIhiNnQjyVGp4qBPBlKNsdrpzUAw6LdVPJPh8vkURTvWG+uDP3P+36m
         kpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IXFXkZ/zIPR/vpj7KNO5NDwB6CMm+azUma0NGH5YVgU=;
        b=6mNDhCUiwslPEUIxEdtQLWR8ubesNxmifaaaDuQZQ1vvMVqZJ19ZQeBLa2GP3u/k+5
         TnyezIcpB71gbHr/OElKLZ3jgD0v7ILFk3qjaGRw/4rWtcH69tM1WjXwFP1wwnG96emt
         i4SSI5IRb37+pA8FV/IKJHGQidi6YaiwaatzrLOQ6VLkzUdUVM8PNThCBra+g9IYQK6v
         arxKhI08aMSRXLSE9e7uihxMIGzgVD42UG7FWXGAXecS98Ye7HAcIJZ1jSTelsZ+/OPq
         aiCbzksyJ9SqnfPcdg52jZi8z/MwfyplG9Hz8sECwDYKoiIL5yB0bhk8Xpx92mnbeSKz
         zfqA==
X-Gm-Message-State: AOAM533mLXgU1+NYYP2cB8jTwibxRCgBhuOET8ej2dn7WjZW17tw6rjj
        iCMKh8SE0Ui4XLV3RJS/LzlG85Q7+Keu/Q==
X-Google-Smtp-Source: ABdhPJwBIvnDClmMj7lyqH8WolBn46vICihfyKzrStW5W+VTLqQQ9byyWSgWtWbeDhcHuG4qEqGRgQ==
X-Received: by 2002:a05:6000:15cb:b0:207:97e4:e445 with SMTP id y11-20020a05600015cb00b0020797e4e445mr11520814wry.672.1649667100481;
        Mon, 11 Apr 2022 01:51:40 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm30881650wrd.31.2022.04.11.01.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:51:39 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:51:38 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     John Keeping <john@metanate.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 08/33] crypto: rockchip: better handle cipher key
Message-ID: <YlPsGvmoloOBw8Sa@Red>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-9-clabbe@baylibre.com>
 <YkrW/+DX5vN8W5cF@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkrW/+DX5vN8W5cF@donbot>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 04, 2022 at 12:31:11PM +0100, John Keeping a écrit :
> On Fri, Apr 01, 2022 at 08:17:39PM +0000, Corentin Labbe wrote:
> > The key should not be set in hardware too much in advance, this will
> > fail it 2 TFM with different keys generate alternative requests.
> > The key should be stored and used just before doing cipher operations.
> > 
> > Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/crypto/rockchip/rk3288_crypto.h          |  1 +
> >  drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 10 +++++++---
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
> > index 8b1e15d8ddc6..826508e4a0c3 100644
> > --- a/drivers/crypto/rockchip/rk3288_crypto.h
> > +++ b/drivers/crypto/rockchip/rk3288_crypto.h
> > @@ -245,6 +245,7 @@ struct rk_ahash_rctx {
> >  struct rk_cipher_ctx {
> >  	struct rk_crypto_info		*dev;
> >  	unsigned int			keylen;
> > +	u32 key[AES_MAX_KEY_SIZE / 4];
> 
> Should this be u8?  It's only ever memcpy'd so the fact the registers
> are 32-bit is irrelevant.
> 
> (Also a very minor nit: this should probably be aligned in the same was
> as the above two variables.)

Yes, it could be u8 and I will fix the alignement.

Regards
