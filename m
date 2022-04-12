Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC35F4FE3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356523AbiDLO1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356506AbiDLO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:27:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2FE19034
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:25:05 -0700 (PDT)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53F24486;
        Tue, 12 Apr 2022 16:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649773502;
        bh=TD/bZV0n+8gOuaITuXISCNvKDTaVocldAK+mP8GfBLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qWqtmbG+qDmmBC5ucGcMjlZotm5YfmGMe11bdqgwIAxkUhErnX5V1SOMFJ22CqFaN
         oybAlLuQC0/8TaltkrMd7+POolRP0MdihrnqljtTSoChK5/8v4nh6n4qKVu5R17Stq
         AwZSOW0KWK4kgTn0lwILUtQF6vdaIuB45sV8TBPI=
Message-ID: <86a07099-1074-e8d1-6d0e-1ce68414b627@ideasonboard.com>
Date:   Tue, 12 Apr 2022 17:24:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/tidss: Soft Reset DISPC on startup
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, linux-kernel@vger.kernel.org,
        jyri.sarha@iki.fi, tomba@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     nm@ti.com, a-bhatia1@ti.com, r-ravikumar@ti.com, nikhil.nd@ti.com,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
        laurent.pinchart@ideasonboard.com
References: <20220314113739.18000-1-devarsht@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220314113739.18000-1-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/03/2022 13:37, Devarsh Thakkar wrote:
> Soft reset the display subsystem controller on startup and wait for
> the reset to complete. This helps the scenario where display was
> already in use by some other core before the linux was booted.

The reason the omapdrm doesn't do a reset is that the PM features on 
some of the DSS registers were set and controlled outside dss driver, so 
the dss driver could not do a reset just like that. That design was 
carried to the tidss driver, although I'm not sure if the reason is 
valid on AM6 and J7 platforms.

If that reasoning is not valid, this patch is ok and:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 60b92df615aa..dae47853b728 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2650,6 +2650,20 @@ static void dispc_init_errata(struct dispc_device *dispc)
>   	}
>   }
>   
> +static void dispc_softreset(struct dispc_device *dispc)
> +{
> +	u32 val;
> +	int ret = 0;
> +
> +	/* Soft reset */
> +	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, 1, 1);
> +	/* Wait for reset to complete */
> +	ret = readl_poll_timeout(dispc->base_common + DSS_SYSSTATUS,
> +				 val, val & 1, 100, 5000);
> +	if (ret)
> +		dev_warn(dispc->dev, "failed to reset dispc\n");
> +}
> +
>   int dispc_init(struct tidss_device *tidss)
>   {
>   	struct device *dev = tidss->dev;
> @@ -2709,6 +2723,10 @@ int dispc_init(struct tidss_device *tidss)
>   			return r;
>   	}
>   
> +	/* K2G display controller does not support soft reset */
> +	if (feat->subrev != DISPC_K2G)
> +		dispc_softreset(dispc);
> +
>   	for (i = 0; i < dispc->feat->num_vps; i++) {
>   		u32 gamma_size = dispc->feat->vp_feat.color.gamma_size;
>   		u32 *gamma_table;

