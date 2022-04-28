Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C0513239
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbiD1LS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbiD1LSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:18:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657922B21;
        Thu, 28 Apr 2022 04:15:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq17so8874102ejb.4;
        Thu, 28 Apr 2022 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+MfYH2YQ+litd9nC4WLDji5G/nTM7/Ix1hsN4aQQiE=;
        b=jHDaRN+NjsQ+9ro4gz2Wvs/dDGIlEWHb+T9Y5mQ8AObnsBA5Pd0FlIoc/BIu2k8+bj
         /SqLjEdJ0MZBiONiCGTKXiTaa5DqMmVe7Sph+iCnEyB20tu2Qw6eNSS3+zCc+D/axZsL
         rjBBnKxSScWm3WwnPeg65OWtkedtlAZ8F1Kex53HXfIm2H88bMNA1Tn5HoEUlNUA65/6
         NcxY+80Ezi1ctMi6XpRx/YS4rDtLM5kc8ZJhKrBI5XW/VL4O84FMUxs6FkQzkLKcsAx7
         c5nTCPQ77/aJ3432dxYq66k7k7wrGE7gYwARTs4fAry2AD/KtPpSrv/UQkd6gSBBGF8O
         ttjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+MfYH2YQ+litd9nC4WLDji5G/nTM7/Ix1hsN4aQQiE=;
        b=r42hFB3eOSmxHIsU/7K8rGnoGjuxObSrenqqk5jy4+alPC5xQN9oRibODWWwufTk/7
         GExkrIOxv5FGdWjIsosgpkGrfS659ilkvdOc2r5yjp8M3klF+zYtgB84ednpDhLlXPlI
         FamT77OfqDeQ0TyRiBTNQZaoUXPMvI3JnnPJa/8T64shgOOkRrQSLYME63+lNNtOhoDI
         XUSlNuvv8PdNPsgof9DQtEutwakisuyk7K1GeAeHQwcbWh8rGe+Jv0lhtE2g5/sbfH0w
         omJB/mNp6DJpHNSST9iwdLz6yY2tc1PALA1Asa8mGw3K5yzRDAeYY7CpwQWCgI/Xy/DY
         hoLg==
X-Gm-Message-State: AOAM532T6g3AYP6f0zuPiwbWi9eonOf1NQZEBpG/qWMhdQgMJSmtMuAD
        Qn3AupRx1cG5NDWLt5rFuf+FvaGBmCgRLg==
X-Google-Smtp-Source: ABdhPJzAYtvVXrl9CAWvbv76jT6c8d/n2DovgQHySmatr7l5Dm4yG1AqCIsF6qg23AwQhhKxNa+28Q==
X-Received: by 2002:a17:906:6a22:b0:6f3:e768:7de0 with SMTP id qw34-20020a1709066a2200b006f3e7687de0mr1469172ejc.480.1651144507953;
        Thu, 28 Apr 2022 04:15:07 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id kk14-20020a170907766e00b006f3a6a528c8sm4898179ejc.146.2022.04.28.04.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:15:07 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x
Date:   Thu, 28 Apr 2022 13:15:06 +0200
Message-ID: <2087500.ItEYzMA54p@archbook>
In-Reply-To: <20220425133502.405512-1-michael.riesch@wolfvision.net>
References: <20220425133502.405512-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 25. April 2022 15:35:00 CEST Michael Riesch wrote:
> This USB 3.0 controller is capable of OTG/DRD operation. Enable it in the
> device tree.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 55e6dcb948cc..f611aaf2d238 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -266,7 +266,7 @@ usb_host0_xhci: usb@fcc00000 {
>  			 <&cru ACLK_USB3OTG0>;
>  		clock-names = "ref_clk", "suspend_clk",
>  			      "bus_clk";
> -		dr_mode = "host";
> +		dr_mode = "otg";
>  		phy_type = "utmi_wide";
>  		power-domains = <&power RK3568_PD_PIPE>;
>  		resets = <&cru SRST_USB3OTG0>;
> 

Hi Michael,

according to official specs[1], only the RK3568 is capable of using the
USB 3.0 controller in OTG mode. For the RK3566, OTG is USB 2.0, if I
understand this correctly.

So I think this should be an override in rk3568.dtsi.

Regards,
Nicolas Frattaroli

[1]: Compare page 17 of the RK3568 datasheet to page 16 of the RK3566
     datasheet


