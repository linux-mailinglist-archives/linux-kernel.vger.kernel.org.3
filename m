Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE024DC260
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiCQJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCQJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:14:39 -0400
X-Greylist: delayed 171289 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 02:13:23 PDT
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01883ECDA9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:13:22 -0700 (PDT)
Received: from [192.168.1.100] (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AAA133F707;
        Thu, 17 Mar 2022 10:13:20 +0100 (CET)
Message-ID: <636d90ea-327f-f61f-8d88-074c351aea2e@somainline.org>
Date:   Thu, 17 Mar 2022 10:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH,v2] drm/panel: Fix return value check in nt35950_probe()
Content-Language: en-US
To:     Lu Wei <luwei32@huawei.com>, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
References: <20220317083707.237039-1-luwei32@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
In-Reply-To: <20220317083707.237039-1-luwei32@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/22 09:37, Lu Wei ha scritto:
> In function nt35950_probe(), mipi_dsi_device_register_full() is called
> to create a MIPI DSI device. If it fails, a pointer encoded with an error
> will be returned, so use IS_ERR() to check the return value. Besides, use
> PTR_ERR to return the actual errno.
> 
> Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
> Signed-off-by: Lu Wei <luwei32@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Thanks!

> ---
>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> index 288c7fa83ecc..d252e5e56228 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -579,9 +579,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>   		}
>   
>   		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
> -		if (!nt->dsi[1]) {
> +		if (IS_ERR(nt->dsi[1])) {
>   			dev_err(dev, "Cannot get secondary DSI node\n");
> -			return -ENODEV;
> +			return PTR_ERR(nt->dsi[1]);
>   		}
>   		num_dsis++;
>   	}

