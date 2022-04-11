Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3E4FB641
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbiDKIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiDKIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:44:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F7E3EAAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:42:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r13so21865280wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8C/eYgaWADBmXGolQTtkrHTLecaGjlBMq7BNuIlcZ8Q=;
        b=xeJcy/KGJE8E9dTJtbqIY8xwk3sT+9zWBdf3lwNQ3wiHwbo4fFi8C+BojzWUb7Nts5
         YPHs4k4QJ+0sAnvMgpBPi22mDZOONbSIFtlnjK/F59s/8G5mPCd2VtQv5dvyliQPsxYp
         KmY7lSTcYSkZjPO7nyfaPW2MGED205fey3U79yIsgipqxg9s588DuLwxZoS624dnuMgM
         MHMyVZLpuUay/uFgMoPsgbusEwXdLTEqSSHSIgL/tziKq/jixkyvnP9IpacQh9Y4GqEV
         Rm3sXKIwUpMR9FpWp1I6M9UhCnaMeQFSP4Q/dXQ3qck3BCxgik8RLUyCr26oF7Q4kt7N
         JBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8C/eYgaWADBmXGolQTtkrHTLecaGjlBMq7BNuIlcZ8Q=;
        b=57gFGfWoBGytTwiExddkDUdOWPGtbo78NM/LamZ6ykO84kqaxGZG5aeqhNwR+Cd6cB
         +r/tYB3c6MYE3fDv7K/xU+DfdZI8x/U3xTUMEfQEwfm9ivx2wb7ldnCy51+Ru2Ih11G6
         fkytX1vfxtNJVbtB7dHayVnhWPRsnyBOkPJuEgRmhqPg1kxUV6wgkOKMMP+OUKu0WiaW
         9ja8ZUcBW3VBFW1wHuYRsboSARqdWOmDHLhMrHzQP4E2WIZGFLHFZ/2uCWzNO/8xhFDy
         AT9ilYiSlq3CA4ts1tpa8htSHFo0X364x4sz90oq77tImLnKTVaQl8QhvhE+XcZcq93c
         Lenw==
X-Gm-Message-State: AOAM530D0KwBjTguHgzeE+uKxzwFJZDj8P6POTNWLPaf/yt1F0KTlBhh
        rKzdWalOL/eimDYB5BlDV4/fAw==
X-Google-Smtp-Source: ABdhPJwj2GX5sxFvKfF2plvDXxPFsbnq+9QtCMe/UP3BTx6ywnM8X9ZtvNekIgx0mHUmfcedMxPk8Q==
X-Received: by 2002:a5d:5406:0:b0:205:a2c2:3530 with SMTP id g6-20020a5d5406000000b00205a2c23530mr23927622wrv.587.1649666549614;
        Mon, 11 Apr 2022 01:42:29 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id c4-20020a056000184400b00207a55f712asm3337327wri.37.2022.04.11.01.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:42:29 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:42:26 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     John Keeping <john@metanate.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 06/33] crypto: rockchip: add fallback for cipher
Message-ID: <YlPp8rkH7B742TZM@Red>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-7-clabbe@baylibre.com>
 <YkrV1z5GPVXc+d/X@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkrV1z5GPVXc+d/X@donbot>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 04, 2022 at 12:26:15PM +0100, John Keeping a écrit :
> On Fri, Apr 01, 2022 at 08:17:37PM +0000, Corentin Labbe wrote:
> > The hardware does not handle 0 size length request, let's add a
> > fallback.
> > Furthermore fallback will be used for all unaligned case the hardware
> > cannot handle.
> > 
> > Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> > diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> > index bbd0bf52bf07..c6b601086c04 100644
> > --- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> > +++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> > @@ -13,6 +13,71 @@
> >  
> >  #define RK_CRYPTO_DEC			BIT(0)
> >  
> > +static int rk_cipher_need_fallback(struct skcipher_request *req)
> > +{
> > +	struct scatterlist *sgs, *sgd;
> > +	unsigned int todo, len;
> > +	unsigned int bs = crypto_skcipher_blocksize(tfm);
> > +
> > +	if (!req->cryptlen)
> > +		return true;
> > +
> > +	len = req->cryptlen;
> > +	sgs = req->src;
> > +	while (sgs) {
> > +		if (!IS_ALIGNED(sgs->offset, sizeof(u32))) {
> > +			return true;
> > +		}
> > +		todo = min(len, sgs->length);
> > +		if (todo % bs) {
> > +			return true;
> > +		}
> > +		len -= todo;
> > +		sgs = sg_next(sgs);
> > +	}
> > +	len = req->cryptlen;
> > +	sgd = req->dst;
> > +	while (sgd) {
> > +		if (!IS_ALIGNED(sgd->offset, sizeof(u32))) {
> > +			return true;
> > +		}
> > +		todo = min(len, sgd->length);
> > +		if (todo % bs) {
> > +			return true;
> > +		}
> > +		len -= todo;
> > +		sgd = sg_next(sgd);
> > +	}
> > +	sgs = req->src;
> > +	sgd = req->dst;
> > +	while (sgs && sgd) {
> > +		if (sgs->length != sgd->length)
> 
> This check still seems to be triggering the fallback when it is not
> needed.
> 
> I've done some testing with fscrypt and the series is working great, but
> the stats show the fallback triggering more than I'd expect.  With some
> extra logging here I see output like:
> 
> 	sgs->length=32 sgd->length=255 req->cryptlen=16
> 
> In this case sgs and sgd are both the first (and only) entries in the
> list.  Should this take account of req->cryptlen as well?
> 
> In fact, can't this whole function be folded into one loop over src and
> dst at the same time, since all the checks must be the same?  Something
> like this (untested):
> 
> 	while (sgs && sgd) {
> 		if (!IS_ALIGNED(sgs->offset, sizeof(u32)) ||
> 		    !IS_ALIGNED(sgd->offset, sizeof(u32)))
> 			return true;
> 
> 		todo = min(len, sgs->length);
> 		if (todo % bs)
> 			return true;
> 
> 		if (sgd->length < todo)
> 			return true;
> 
> 		len -= todo;
> 		sgs = sg_next(sgs);
> 		sgd = sg_next(sgd);
> 	}
> 
> 	if (len)
> 		return true;
> 

Thanks, for this hint, I will use it.

Regards
