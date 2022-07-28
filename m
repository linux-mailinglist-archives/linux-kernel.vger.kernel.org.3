Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1492C583CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiG1LEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiG1LEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:04:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0066AF6;
        Thu, 28 Jul 2022 04:03:59 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E366D56D;
        Thu, 28 Jul 2022 13:03:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659006236;
        bh=4C5fixSDw1OhkJhVXTYHM7W8UHnH5gRoIf+wUO4yo1U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ipevg5r0GyMQWYZN+8cuQD6AIp3Kxw50cwc+B9UIstrn+rQ9xW5SnJUj9aqgwnlz+
         UDgJQqJgHV/zJVdi1uS7ctRp/DTJI5TUQA01mGVxp9lFT4fwnoYDxj7dDQwG/q4Xmd
         ayXE5EVemDF3A/aszMN6BDSKV0pMIplBq+Su46VQ=
Message-ID: <f2909af1-be23-009b-ba71-34206f099473@ideasonboard.com>
Date:   Thu, 28 Jul 2022 14:03:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/8] drm/tidss: Add support for Dual Link LVDS Bus Format
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-5-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220719080845.22122-5-a-bhatia1@ti.com>
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

On 19/07/2022 11:08, Aradhya Bhatia wrote:
> The 2 OLDI TXes in the AM625 SoC can be synced together to output a 2K
> resolution video.
> 
> Add support in the driver for the discovery of such a dual mode
> connection on the OLDI video port, using the values of "ti,oldi-mode"
> property.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 39 +++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index add725fa682b..fb1fdecfc83a 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -853,25 +853,36 @@ void dispc_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
>   	}
>   }
>   
> -enum dispc_oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
> +enum dispc_oldi_mode_reg_val {
> +	SPWG_18		= 0,
> +	JEIDA_24	= 1,
> +	SPWG_24		= 2,
> +	DL_SPWG_18	= 4,
> +	DL_JEIDA_24	= 5,
> +	DL_SPWG_24	= 6,
> +};
>   
>   struct dispc_bus_format {
>   	u32 bus_fmt;
>   	u32 data_width;
>   	bool is_oldi_fmt;
> +	bool is_dual_link;
>   	enum dispc_oldi_mode_reg_val oldi_mode_reg_val;
>   };
>   
>   static const struct dispc_bus_format dispc_bus_formats[] = {
> -	{ MEDIA_BUS_FMT_RGB444_1X12,		12, false, 0 },
> -	{ MEDIA_BUS_FMT_RGB565_1X16,		16, false, 0 },
> -	{ MEDIA_BUS_FMT_RGB666_1X18,		18, false, 0 },
> -	{ MEDIA_BUS_FMT_RGB888_1X24,		24, false, 0 },
> -	{ MEDIA_BUS_FMT_RGB101010_1X30,		30, false, 0 },
> -	{ MEDIA_BUS_FMT_RGB121212_1X36,		36, false, 0 },
> -	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, SPWG_18 },
> -	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, SPWG_24 },
> -	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, JEIDA_24 },
> +	{ MEDIA_BUS_FMT_RGB444_1X12,		12, false, false, 0 },
> +	{ MEDIA_BUS_FMT_RGB565_1X16,		16, false, false, 0 },
> +	{ MEDIA_BUS_FMT_RGB666_1X18,		18, false, false, 0 },
> +	{ MEDIA_BUS_FMT_RGB888_1X24,		24, false, false, 0 },
> +	{ MEDIA_BUS_FMT_RGB101010_1X30,		30, false, false, 0 },
> +	{ MEDIA_BUS_FMT_RGB121212_1X36,		36, false, false, 0 },
> +	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, false, SPWG_18 },
> +	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, false, SPWG_24 },
> +	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, false, JEIDA_24 },
> +	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, true, DL_SPWG_18 },
> +	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, true, DL_SPWG_24 },
> +	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, true, DL_JEIDA_24 },
>   };

So the dual link sends two pixels per clock, right? Are there panel or 
bridge drivers that support this? My initial thought was that it should 
be a new bus format.

  Tomi
