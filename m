Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344334C0342
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiBVUrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiBVUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:47:01 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B9E8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:46:34 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98B04FF807;
        Tue, 22 Feb 2022 20:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645562792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+URZgxj9nzytd/RWgKSb1xmxxLoF8F2uzNEWDYieyE=;
        b=gio0QLnASurQ4A/a73tVkPgJfzoAlaWqc6Djwbs1yQ7uhkJRDq/NrTjENaLA5wG1C0FH8x
        pbgrOjJyw06rddJwn+1mOyJ/hQWsVe3lKvKgrP0Hcnlz+/CTyI7SjDcfORZUZZtsg2AQF0
        yjtc3o40jZBQICxa5xgKLwpvPFdDGIB9Sncv4DVDQKVdidwuezxPf8TBfYkJM28qr1nv/3
        u+61JxLlDYDaU7u9x+AAPNgu0FKr9BZcnIfgpk27A8bgJwKw7osaOvo+vz6fDsufyQ+zOM
        23y+rDrZ7JdEQ0TrU4Xa7F9KX3UmIHUTrF8b9IstKPb/NKmM/B8rWXMxXQUKbw==
Date:   Tue, 22 Feb 2022 21:46:30 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hari Prasath <Hari.PrasathGE@microchip.com>
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH] 1/3] ARM: dts: at91: sama7g5: Restrict ns_sram
Message-ID: <YhVLpnQ5fKs5x1Hq@piout.net>
References: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 17:09:22+0530, Hari Prasath wrote:
> Limit the size of SRAM available for the rest of kernel via genalloc API's to
> 13k. The rest of the SRAM is used by CAN controllers and hence this restriction.
> 

Certainly not, if the can controller need the SRAM, they have to
allocate it properly.

> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
> ---
>  arch/arm/boot/dts/sama7g5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index eddcfbf4d223..6c7012f74b10 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -65,7 +65,7 @@
>  		compatible = "mmio-sram";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		reg = <0x100000 0x20000>;
> +		reg = <0x100000 0x3400>;
>  		ranges;
>  	};
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
