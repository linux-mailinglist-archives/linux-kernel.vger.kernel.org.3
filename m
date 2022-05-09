Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05951F90F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiEIJe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiEIJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:01:10 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 01:57:14 PDT
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDEF17DDDE;
        Mon,  9 May 2022 01:57:14 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9F2F34000C;
        Mon,  9 May 2022 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652086633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z7lD/6wsz8WyTLCbps6p5giktcyRpazC8nij2b2o9yo=;
        b=OCNX88WspEU309CH3Fm+RMeKlDIyqWboRqPY7vo5JCIC2q768FxaxodBNi/k6nvUuxT7p0
        NtICauOBb89G1k1v9KLIRGVdRoAMugfNm4rEEiKXU7FnPkdN4KawVDIrUmT7a4GmQR9S6i
        GCTjULZ28vRLvMUBILaP5yGZGHCyH+8eid5uMYwCIBD29p7CuudRHNvDzxbvoyVv3qUA2P
        xnpTyANMwofxDkxrspD2wbIimpbf5MO6CkX3EKzz0zg5bRsz4sWNKzdhqHKOYKuTVwZG9Y
        1DcmcYJOhEOQH32G6bNSpaqXTjpUJ+f55efaUEKigt6ibv+K/nggLc/BYN3/XQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v3 1/3] arm64: dts: marvell: espressobin-ultra: fix
 SPI-NOR config
In-Reply-To: <20210928170919.691845-1-robert.marko@sartura.hr>
References: <20210928170919.691845-1-robert.marko@sartura.hr>
Date:   Mon, 09 May 2022 10:57:06 +0200
Message-ID: <87k0avrsm5.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> SPI config for the SPI-NOR is incorrect and completely breaking
> reading/writing to the onboard SPI-NOR.
>
> SPI-NOR is connected in the single(x1) IO mode and not in the quad
> (x4) mode.
> Also, there is no need to override the max frequency from the DTSI
> as the mx25u3235f that is used supports 104Mhz.
>
> Fixes: 3404fe15a60f ("arm64: dts: marvell: add DT for ESPRESSObin-Ultra")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied on mvebu/dt64

Thanks,

Gregory


> ---
> Changes in v3:
> * Add Fixes tag
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index c5eb3604dd5b..610ff6f385c7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -71,10 +71,6 @@ &sdhci1 {
>  
>  &spi0 {
>  	flash@0 {
> -		spi-max-frequency = <108000000>;
> -		spi-rx-bus-width = <4>;
> -		spi-tx-bus-width = <4>;
> -
>  		partitions {
>  			compatible = "fixed-partitions";
>  			#address-cells = <1>;
> -- 
> 2.31.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
