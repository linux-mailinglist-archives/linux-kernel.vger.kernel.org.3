Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EB14E5303
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbiCWNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244260AbiCWNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:24:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3F57D002
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w4so2084249wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nFhPQ/2TAffPjbDjiI/2I0v37r+CcQs5C7D/sWxAMI8=;
        b=quPIS4rlbqNNwzlG7UsIcANuXUutqUX2+fS2vwwVrkSb8FadLyZ9PZuzt3n4FECs6b
         JD3NheA8m53Arv3IJp2+FRXgb8apclZMBwVLZzL1u949YS0k93kjWRoPRC7j6cfksk60
         qxWnya1GQ0o6FnD0kdxsnW3YSZ6iUb00BQ9WyMilezQ5n3ltGCDn+C8jl6rMTHz5Oakz
         /607HtEh8xP6zzvxbUd5PSpNYWuV9/bc8PQYBMTN/o3/amywjFJkjwFPiEjWUSPZsUf+
         UUicmWGMkDbN/NfGnIkjbJTQNk7WhHnpkDNNvhtM2OQ7+b+7vY0duYDYvrj3Vwl6M31g
         2puA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nFhPQ/2TAffPjbDjiI/2I0v37r+CcQs5C7D/sWxAMI8=;
        b=FfBCOh3jVoFrmQ/tcQ1VF8cQT2M31iWKoRSQ2cQa5Nc5TVNBJhWYUDuPcSdNQO9FTM
         CtAfn3z8p5uf8bILL6bROkVIgQu9TUP80qe3r4+Q1U9Dc6igv/lUNv4NQp6oDFhs5Olc
         vA0FzQCTgdNt3ErycWhCZ76KyMhBGYMiVYESS30FGKOIjtXunduo9qV4z+jRQ8JAHrWl
         SALWwoP2nbzRYSN8dWDw1poxHWthShq0OJ0XzDrKFcx1wp3hYHkBV6hYL4bUOhIs5pR9
         bR9ueCpYWNVvgr5457XyF5xFRzBw1oxv75CRJmN+iew4C1eFc2v7KHjq7BnltQ8H+WES
         ks5A==
X-Gm-Message-State: AOAM5308iiRivWUiI5HMCKovKv7JP62hIFpr46PsPMcnUjLNLlCBNwM+
        7ZVPHZ/8tn8Kbb4JWZH0ViL8Ew==
X-Google-Smtp-Source: ABdhPJzktCyQ+4ZXtq4E5zEr/KHSW2QBwhlwN+M/BloZ0THBfCmhcKR2IkHX5we1S2uX5VNg/THYAA==
X-Received: by 2002:a05:6000:1b86:b0:1f0:d6f:1424 with SMTP id r6-20020a0560001b8600b001f00d6f1424mr26954876wru.174.1648041764214;
        Wed, 23 Mar 2022 06:22:44 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm2806353wmq.41.2022.03.23.06.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:22:43 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:22:41 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 18/26] arm64: dts: rockchip: rk3399: add crypto node
Message-ID: <YjsfIbLQRvoxkana@Red>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
 <20220321200739.3572792-19-clabbe@baylibre.com>
 <70422777-a3f9-b2f1-5faa-94d24fe200ac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70422777-a3f9-b2f1-5faa-94d24fe200ac@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 22, 2022 at 12:00:06PM +0000, Robin Murphy a écrit :
> On 2022-03-21 20:07, Corentin Labbe wrote:
> > The rk3399 has a crypto IP handled by the rk3288 crypto driver so adds a
> > node for it.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index 88f26d89eea1..ca2c658371a5 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -573,6 +573,18 @@ saradc: saradc@ff100000 {
> >   		status = "disabled";
> >   	};
> >   
> > +	crypto0: crypto@ff8b0000 {
> > +		compatible = "rockchip,rk3399-crypto";
> > +		reg = <0x0 0xff8b0000 0x0 0x4000>,
> > +		      <0x0 0xff8b8000 0x0 0x4000>;
> > +		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
> > +		clocks = <&cru SCLK_CRYPTO0>, <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>,
> > +			 <&cru SCLK_CRYPTO1>, <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>;
> > +		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>,
> > +			 <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
> > +	};
> 
> What's going on here? If these are simply two instances of the same IP 
> block as the evidence suggests, why are they crammed into a single DT 
> node rather than simply being described as two separate instances? I was 
> rather wondering what all the confusing mess in patch #16 was about, 
> until I got here.
> 
> If there's something in the crypto API that means the driver can't 
> simply naively register itself multiple times, there should be any 
> number of ways for the probe routine to keep track of whether it's 
> already registered something and associate any subsequent devices with 
> the first one internally if need be. Linux implementation details should 
> not leak out as non-standard DT weirdness.
> 
> I know the Rockchip IOMMU driver does this, but in that case the two 
> IOMMU instances are closely coupled and sharing work such that they 
> effectively need to be programmed identically at all times, so it was a 
> bit more justifiable. I don't know the full story here, but it certainly 
> looks like rk_get_engine_number() is just a means to schedule work on 
> any available unit independently, so looks like it wouldn't take much to 
> select between distinct devices at that point, and actually end up a lot 
> simpler and cleaner overall.

Yes rk3399 has 2 instances of the same IP (Exception: crypto1 does not have RSA).

The problem is that only one drivername (like rk-md5) could exists.
If crypto0 and crypto1 register with different drivername (rk-md5-0/rk-md5-1), only one will be used anyway.
So I merged them into only one instance.
I think this way will be easier, but you are right, this is not pretty.

I found another way with 2 nodes:
You could preview it at https://github.com/montjoie/linux/tree/cryptorockchipv4
Basicly the crypto0 is a normal instance, and crypto1 "registers" itself against crypto0.
So if crypto0 know another instance exists it will load balance requests.

Regards
