Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E634D767C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiCMPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiCMPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:42:51 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6653E7F7F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kJFamGwV2YRmFkmhsHMWP/npEW6up1Bh8aSbdipR2KM=; b=TXw9kTM9jjmrLVG+ehXN3lcHHO
        polElEV5vRKGA/Hkfx2uV99KporRPhjrCZtuAdc11vlGgRF2+FsXTSDiPydSkVimVs8J3mj/k3iUn
        WzbRT/qhfSy4ThBb9SsAnGOMpNVk3DVQB9FV19GsjtmfikPhKYWyx5dPp4IH3oziWqZoHYjZIV5oZ
        VQ8whA2RIuFVtU71Y0NxOrVbu4s6sBaaC5+GKmmww6ODYxfx436zz1BaqMKBOBMp0FrP7aNgakAii
        6GMHYiBSoh7GSf1pLQAQNgmjHkjHLg7VhG34jviD0WGs68QTJdjUdwgLKnvpO+u8N55oc0pvDkGY6
        k/osOCjg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58449 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1nTQLk-0005wG-Te; Sun, 13 Mar 2022 16:41:40 +0100
Message-ID: <569b42fb-5d85-645a-2947-77216c44696a@tronnes.org>
Date:   Sun, 13 Mar 2022 16:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/repaper: combine allocs in repaper_spi_transfer()
To:     trix@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220313141008.1503638-1-trix@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220313141008.1503638-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 13.03.2022 15.10, skrev trix@redhat.com:
> From: Tom Rix <trix@redhat.com>
> 
> repaper_spi_transfer() allocates a single byte
> for the spi header and then another buffer for
> the payload.  Combine the allocs into a single
> buffer with offsets.  To simplify the offsets
> put the header after the payload.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/tiny/repaper.c | 40 ++++++++++------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index 37b6bb90e46e1..22a6732f35a01 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -100,50 +100,34 @@ static inline struct repaper_epd *drm_to_epd(struct drm_device *drm)
>  static int repaper_spi_transfer(struct spi_device *spi, u8 header,
>  				const void *tx, void *rx, size_t len)
>  {
> -	void *txbuf = NULL, *rxbuf = NULL;
>  	struct spi_transfer tr[2] = {};
> -	u8 *headerbuf;
> +	u8 *buf;
>  	int ret;
>  
> -	headerbuf = kmalloc(1, GFP_KERNEL);
> -	if (!headerbuf)
> +	buf = kmalloc(1 + len, GFP_KERNEL);
> +	if (!buf)
>  		return -ENOMEM;
>  
> -	headerbuf[0] = header;
> -	tr[0].tx_buf = headerbuf;
> +	buf[len] = header;
> +	tr[0].tx_buf = &buf[len];

I don't think this will work since the buffer is used directly for DMA
on some platforms[1] so the buffers need to be at the correct alignment
for that to work. For this reason I think it's better to leave this
as-is since we know the kmalloc buffers will always be useable for DMA
and the code is also easy to read and understand instead of calculating
offsets.

[1] tinydrm/mipi-dbi: Use dma-safe buffers for all SPI transfers
(a89bfc5d9a07)

Noralf.

>  	tr[0].len = 1;
>  
> -	/* Stack allocated tx? */
> -	if (tx && len <= 32) {
> -		txbuf = kmemdup(tx, len, GFP_KERNEL);
> -		if (!txbuf) {
> -			ret = -ENOMEM;
> -			goto out_free;
> -		}
> +	if (tx) {
> +		memcpy(buf, tx, len);
> +		tr[1].tx_buf = buf;
>  	}
>  
> -	if (rx) {
> -		rxbuf = kmalloc(len, GFP_KERNEL);
> -		if (!rxbuf) {
> -			ret = -ENOMEM;
> -			goto out_free;
> -		}
> -	}
> +	if (rx)
> +		tr[1].rx_buf = buf;
>  
> -	tr[1].tx_buf = txbuf ? txbuf : tx;
> -	tr[1].rx_buf = rxbuf;
>  	tr[1].len = len;
>  
>  	ndelay(80);
>  	ret = spi_sync_transfer(spi, tr, 2);
>  	if (rx && !ret)
> -		memcpy(rx, rxbuf, len);
> -
> -out_free:
> -	kfree(headerbuf);
> -	kfree(txbuf);
> -	kfree(rxbuf);
> +		memcpy(rx, buf, len);
>  
> +	kfree(buf);
>  	return ret;
>  }
>  
