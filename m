Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B228582790
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiG0NXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiG0NW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:22:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4862D1FB;
        Wed, 27 Jul 2022 06:22:57 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 27C74835;
        Wed, 27 Jul 2022 15:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1658928174;
        bh=eotjNVMAx8QGW06uc3w0MIvKkRtcfjCQLq3gxWF/uIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q+e5gl73+JqpP0dYQ4eSjNqjCNe4M4TG2Sjx+O2xlDudTYz/i3tKWrWLtynEldDgO
         Nwmzb60YTLItlupERg3e/OWkyQwRdzR6t4IoGoK4uI22nQijb75Fof+RwTIL873C7/
         vlfPQQ8tLDGP1OtT+jfY2n9LJ2C5yvIEYQQF1rVs=
Message-ID: <83df99ee-1304-121f-97e6-85ca416aef1f@ideasonboard.com>
Date:   Wed, 27 Jul 2022 16:22:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 8/8] drm/tidss: Enable Dual and Duplicate Modes for OLDI
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-9-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220719080845.22122-9-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/07/2022 11:08, Aradhya Bhatia wrote:
> The AM625 DSS peripheral supports 2 OLDI TXes which can work to enable 2
> duplicated displays of smaller resolutions or enable a single Dual-Link
> display with a higher resolution (1920x1200).
> 
> Configure the necessary register to enable the different modes.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 44 +++++++++++++++++++++++++++--
>   1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 0b9689453ee8..28cb61259471 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -1021,8 +1021,8 @@ static void dispc_enable_oldi(struct dispc_device *dispc, u32 hw_videoport,
>   	int count = 0;
>   
>   	/*
> -	 * For the moment DUALMODESYNC, MASTERSLAVE, MODE, and SRC
> -	 * bits of DISPC_VP_DSS_OLDI_CFG are set statically to 0.
> +	 * For the moment MASTERSLAVE, and SRC bits of DISPC_VP_DSS_OLDI_CFG are
> +	 * set statically to 0.
>   	 */
>   
>   	if (fmt->data_width == 24)
> @@ -1039,7 +1039,45 @@ static void dispc_enable_oldi(struct dispc_device *dispc, u32 hw_videoport,
>   
>   	oldi_cfg |= BIT(0); /* ENABLE */
>   
> -	dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +	/*
> +	 * As per all the current implementations of DSS, the OLDI TXes are present only on
> +	 * hw_videoport = 0 (OLDI TX 0). However, the config register for 2nd OLDI TX (OLDI TX 1)
> +	 * is present in the address space of hw_videoport = 1. Hence, using "hw_videoport + 1" to
> +	 * configure OLDI TX 1.
> +	 */
> +
> +	switch (dispc->oldi_mode) {
> +	case OLDI_MODE_OFF:
> +		oldi_cfg &= ~BIT(0); /* DISABLE */
> +		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		break;
> +
> +	case OLDI_SINGLE_LINK_SINGLE_MODE_0:
> +		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		break;
> +
> +	case OLDI_SINGLE_LINK_SINGLE_MODE_1:
> +		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		break;
> +
> +	case OLDI_SINGLE_LINK_DUPLICATE_MODE:
> +		oldi_cfg |= BIT(5); /* DUPLICATE MODE */
> +		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		break;
> +
> +	case OLDI_DUAL_LINK:
> +		oldi_cfg |= BIT(11); /* DUALMODESYNC */
> +		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
> +		break;
> +
> +	default:
> +		dev_warn(dispc->dev, "%s: Incorrect oldi mode. Returning.\n",
> +			 __func__);
> +		return;
> +	}
>   
>   	while (!(oldi_reset_bit & dispc_read(dispc, DSS_SYSSTATUS)) &&
>   	       count < 10000)

This feels a bit hacky:

- The function is dispc_enable_oldi, but the above code also disables 
oldi. We have code in dispc_vp_unprepare() which disables OLDI at the 
moment.

- The function takes hw_videoport as a parameter, and is designed to 
work on that videoport. The above operates on two videoports. Isn't the 
function also called for hw_videoport +1, which would result in reg 
writes to hw_videoport + 2?

- No matching code in dispc_vp_unprepare

Obviously the duplicate mode (I presume that's "cloning") and the dual 
link complicate things here, and I have to say I haven't worked with 
such setups. But I think somehow this should be restructured so that 
common configuration (common to the OLDIs) is done somewhere else.

I would guess that there are other drivers that support cloning and dual 
mode. Did you have a look how they handle things?

  Tomi
