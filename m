Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49B583BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiG1KF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiG1KFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:05:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3862CDEE1;
        Thu, 28 Jul 2022 03:05:33 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5B7116D4;
        Thu, 28 Jul 2022 12:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659002731;
        bh=hy09P7RDOAzNVp6jFuC+hh2uVzq3PfPWCI074OwJV9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vSVPEiCikFIts17ipxPcLb8xBz3GdW/ISCuSKbuVf4MbcMMky8Bkd7huQyioWsF8G
         iVBHAuPkoV+FdyL3+g4d+QDl9C5BPxXhiOvA3eiYagautvq8BTr0UxwnEOIZunEIXr
         YWpmHZkcGkcSMkL5IKpBSnMeDTjgxHXb/zM3b/Zo=
Message-ID: <03c77b33-271c-5cb3-fe00-cda7ff21102b@ideasonboard.com>
Date:   Thu, 28 Jul 2022 13:05:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/8] drm/tidss: Fix clock request value for OLDI
 videoports
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jyri.sarha@iki.fi>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-8-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220719080845.22122-8-a-bhatia1@ti.com>
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
> The OLDI TX(es) require a serial clock which is 7 times the pixel clock
> of the display panel. When the OLDI is enabled in DSS, the pixel clock
> input of the corresponding videoport gets a divided-by 7 value of the
> requested clock.
> 
> For the am625-dss, the requested clock needs to be 7 times the value.
> 
> Update the clock frequency by requesting 7 times the value.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index c4a5f808648f..0b9689453ee8 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -1326,6 +1326,16 @@ int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
>   	int r;
>   	unsigned long new_rate;
>   
> +	/*
> +	 * For AM625 OLDI video ports, the requested pixel clock needs to take into account the
> +	 * serial clock required for the serialization of DPI signals into LVDS signals. The
> +	 * incoming pixel clock on the OLDI video port gets divided by 7 whenever OLDI enable bit
> +	 * gets set.
> +	 */
> +	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI &&
> +	    dispc->feat->subrev == DISPC_AM625)
> +		rate *= 7;
> +
>   	r = clk_set_rate(dispc->vp_clk[hw_videoport], rate);
>   	if (r) {
>   		dev_err(dispc->dev, "vp%d: failed to set clk rate to %lu\n",

The AM625 TRM seems to be missing the "DSS integration" section, even if 
it's referred to in three places in the TRM. Supposedly that has details 
about the clocking.

Shouldn't the source clock be 3.5x when dual-link mode is used?

While I don't know the details, this doesn't feel correct. We're 
supposed to be setting the VP pixel clock here, and the serial clock 
would be derived from that as it's done on AM65x. Is the DT clock tree 
wrong for AM625?

  Tomi
