Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDD50352A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiDPIYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiDPIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:24:29 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC014186D6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zo2kez9Tmm6A4y3mcmFjr5uk6/P/xlgMUWSYGBYBkEE=; b=RBsoPUaTWVZ/aw+h4s2eUIX4Di
        +6ArJacLiSudfTSWv7rJbxmw5NeEW7DyPbS7Lb4EBz/5SYhteQXabFxq2ejFmOkznXP9w4bbwfBHO
        OxXa03Ko3lXRAdpNVVnUX38KEprpAdQNco5ogEeyjh/6oK/0ChmK/AbF0fFLtPwA8ZBLX1+hp4PN2
        kmpaEw9sbTRafDx8TEndmzG33tjmdFBMqGcMf1U9sRY+7ak3eIUuL8de2g2agmpovEYeXR8owsybZ
        /Xva4hxa0Msxq9QusegW9GMjj5DPwHRRYekgHF3Qpebo0vmYZHJOkLgxYXFdTgDHKVLOUxtrIjmjb
        m/NBE2Ag==;
Received: from [2a01:799:961:d200:9146:d5a0:be36:3d08] (port=62077)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1nfdgp-0005St-Tm; Sat, 16 Apr 2022 10:21:55 +0200
Message-ID: <e62b4d4f-ab99-9e8d-51b6-2fda0432e923@tronnes.org>
Date:   Sat, 16 Apr 2022 10:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/mipi-dbi: Fix max_chunk calculation in spi_transfer
To:     Yunhao Tian <t123yh.xyz@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220308015611.3007395-1-t123yh.xyz@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220308015611.3007395-1-t123yh.xyz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 08.03.2022 02.56, skrev Yunhao Tian:
> In __spi_validate, there's a validation that no partial transfers
> are accepted (xfer->len % w_size must be zero). When
> max_chunk is not a multiple of bpw (e.g.max_chunk = 65535,
> bpw = 16), the transfer will be rejected.
> 
> This patch clamps max_chunk to the word size, preventing

I think align is a better word here than clamp.

> the transfer from being rejected.
> 
> Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dbi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
> index 71b646c4131f..440dc9fec6cc 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -1182,6 +1182,15 @@ int mipi_dbi_spi_transfer(struct spi_device *spi, u32 speed_hz,
>  	struct spi_message m;
>  	size_t chunk;
>  	int ret;
> +	int w_size;
> +
> +	if (bpw <= 8)
> +		w_size = 1;
> +	else if (bpw <= 16)
> +		w_size = 2;
> +	else
> +		w_size = 4;
> +	max_chunk -= (max_chunk % w_size);

mipi_dbi_spi_transfer() is only called with bpw= 8 or 16, so I think
this can be simplified to: max_chunk = ALIGN_DOWN(max_chunk, 2);
We might shorten the max transfer by one byte when bpw=8, but that
doesn't matter. A short comment explaining why we need this would be nice.

Please add a fixes tag so the patch is backported to the stable kernels:

Fixes: d23d4d4dac01 ("drm/tinydrm: Move tinydrm_spi_transfer()")

Noralf.

>  
>  	spi_message_init_with_transfers(&m, &tr, 1);
>  
