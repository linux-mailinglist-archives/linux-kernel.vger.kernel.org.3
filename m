Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C9F56BB86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiGHOOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbiGHOOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:14:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C4E18E13;
        Fri,  8 Jul 2022 07:14:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id os14so7705410ejb.4;
        Fri, 08 Jul 2022 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0XOec91623/KuMv+Ej/7gZUuHsCJ62v6usunFr5b6A=;
        b=f6IhZTBULbQ7llaZot4o9crrDH/bVkSBG4cnMtEpeURfPACgFjn6vJq/r5K9ktnt1p
         LERVggmRob4jL/GCkTX2w7v74r1KkY3FTdHWj4yihWbrOZUOANV5aUCghGUOwU0dnxko
         /PZTw+0EqCC4O3OgTunDclurFhOm+fOeM7DwyLzfawWZNxV75iEId53Bz12llAwF3zZA
         CxlP1Y+szHux5dgocUVRRMZVsnAep+OILxAx64nCQmbv+MyobgioKifPwL4r/ZjZE8Ln
         pQduBNe9DY1hriNkcdpRfW0SVuCcc5CUW3dFFnTn/mtPcA5nKFiMo8hNefUcad7CmpbW
         7uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0XOec91623/KuMv+Ej/7gZUuHsCJ62v6usunFr5b6A=;
        b=2bWVjD2wcED/t2bvI5RGppREQfkPw4wTAXMUCnW6e6uKbn6zzHGRCfYX+To6B0C1S6
         YGpBR6DJm0bY1LyiWYAOHeyKQhAABYymNo3ZThriLX5FVmC3eE37KOhemlsukErUvEsx
         m+sWUibOqGpY1aJ1yY1cvsENyKaI5V+Y5igUu1LUph13AFiUIRFyrH+U0iNVi0KKXHiF
         S45LL6AFqS9TNYpUIhQiLlMUCKAIKoBgeJ4o2Vr/E0nH4au2YSKzvA1I2XymCvHYKRph
         lEbztsK18olCmJxRTmkvbC5Ac34VXu7YOAanT7V0zDaQWLBzOQmoYkXw7Eimj9EQucew
         oSkQ==
X-Gm-Message-State: AJIora84G1DHCGO4O8hZ6eG2JSY+njMaVQetFkngqFhV9jw2jQxOSt1/
        gkYf7aeINhrLLkdrk3Wkd4ZBHLPOwNBTmA==
X-Google-Smtp-Source: AGRyM1v6rPWBPZilFN90Jv15KQMt+j6kMHP6jk8djEs05COCTktH+9O11oNXRuqjRUVfaq+6AN/t3g==
X-Received: by 2002:a17:907:3dac:b0:722:e6ab:8d9 with SMTP id he44-20020a1709073dac00b00722e6ab08d9mr4190126ejc.20.1657289674494;
        Fri, 08 Jul 2022 07:14:34 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906a08200b006fed93bf71fsm20603401ejy.18.2022.07.08.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:14:34 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Michal Suchanek <msuchanek@suse.de>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@aosc.xyz>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sunxi: dts: Fix SPI NOR campatible on Orange Pi Zero
Date:   Fri, 08 Jul 2022 16:13:11 +0200
Message-ID: <10106175.nUPlyArG6x@jernej-laptop>
In-Reply-To: <0c575068-abd7-c69a-e59c-3140f8cb7813@sholland.org>
References: <20220707174801.36e010da@donnerap.cambridge.arm.com> <20220707170721.20225-1-msuchanek@suse.de> <0c575068-abd7-c69a-e59c-3140f8cb7813@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

sorry, but I was a bit too quick with giving r-b line. See comments below.

Dne petek, 08. julij 2022 ob 09:36:26 CEST je Samuel Holland napisal(a):
> Hi Michal,
> 
> The subject prefix should start with "ARM: dts:" (e.g. "ARM: dts: sunxi:").
> Generally it is a good idea to look at the log of the file and follow the
> pattern you see there.
> 
> On 7/7/22 12:07 PM, Michal Suchanek wrote:
> > Without "jedec,spi-nor" compatible the flash memory cannot be probed by
> > u-boot. The macronix part is what is shipped on the boards that come
> > with a flash chip.

Please reword this a bit. DT isn't user specific, so U-Boot should not be 
mentioned. But you can write about compatible being wrong. According to DT 
bindings, it should be manufacturer specific compatible, followed by 
"jedec,spi-nor".

Once both issues are addressed, you can keep my r-b tag and include fixes tag 
posted by Sameul.

Best regards,
Jernej

> 
> Fixes: 45857ae95478 ("ARM: dts: orange-pi-zero: add node for SPI NOR")
> 
> Regards,
> Samuel
> 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > 
> >  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts index
> > f19ed981da9d..3706216ffb40 100644
> > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > @@ -169,7 +169,7 @@ &spi0 {
> > 
> >  	flash@0 {
> >  	
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> > 
> > -		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
> > +		compatible = "mxicy,mx25l1606e", "jedec,spi-nor";
> > 
> >  		reg = <0>;
> >  		spi-max-frequency = <40000000>;
> >  	
> >  	};




