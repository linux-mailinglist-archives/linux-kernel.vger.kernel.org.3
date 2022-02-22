Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598C14C033B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiBVUjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBVUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:39:10 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1041F96
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:38:43 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id i5so15946348oih.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwSJOm72enzvSwn5fw2V4YLB10CbBfcudem7m2XE/IA=;
        b=m0D+eDfHYGEca0kD7CvrIAlkU4h0Aa8prF8+7q6lENdAX9AWiX2Fw15TWzOcVd/Rvo
         Aux9cN2VQ+1eJ3L0ZODSI2UsVNzXV1bkYOaqnzR5mFnYkduRZWvvTTRHoYkH8m8pDe2/
         LSHmPzC4wvwLAL72AdnzV1CKROT83e1SCXVSI9fDiC9NPv68+L7tbhLt67F2Ko28JeX0
         ZnMuT8jIY5wErkjGdnCe/lr2Lf4G9xYkAxEjO4AdRXrLvYfxXujIxlt1sggjriENqj14
         mzgGVQwEAiWlyKtoCfwH0O0cCAqFTR/rRCHi7WCdEPPwfy9I67iWb602ShPAf3TjHHBu
         wZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwSJOm72enzvSwn5fw2V4YLB10CbBfcudem7m2XE/IA=;
        b=TwYWxr613scVagyt7m/kAkLrV/0ubjyswNaM9gge9UG5SuPHN69GWONpbWwvlPHFuM
         pEyrHspDYjAcSwyC9CqpfsHHymQC7LeyFll4Pf3OaCet/g0gOAZNdeT8qm1mKinSyD6K
         Whum1YwnR4h9BPUsRdPDRRk0fRpM/guqa3cyxxpy3bCgicDcpzffkDRVy+AyvwhTsstF
         2cHu3y61L0nJAvr0WF5kWM4nRJJ4Lab9b6iXBIqaPLFl+fxtFDfpiQZ2feBue0hFZ8SV
         Iu4bFwQ+La9+M7qHKRimxUa+N5JdlNF8k+pcgo5LAK0hBVPqn7ne+KW9h4WAoSxCT++z
         +wog==
X-Gm-Message-State: AOAM530J+1+VBer2aHGX3lk50yrXF9+B01UvHo+UgnnR1b/g0OVeVVSP
        rv224HWcWOpw9O5pDb9/ZI1cqg==
X-Google-Smtp-Source: ABdhPJwgvHVqdHtcvzeXV27U5qMSVDq5IhInVn7Kh4O8+gXrXN1zcMZvgi142CXfexOkJ6+fxzxrig==
X-Received: by 2002:aca:44c6:0:b0:2d4:f519:e7c4 with SMTP id r189-20020aca44c6000000b002d4f519e7c4mr2912829oia.282.1645562322695;
        Tue, 22 Feb 2022 12:38:42 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j8sm7904869otu.40.2022.02.22.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:38:42 -0800 (PST)
Date:   Tue, 22 Feb 2022 12:40:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Rahul T R <r-ravikumar@ti.com>, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, krzk@kernel.org,
        geert+renesas@glider.be, marcel.ziswiler@toradex.com,
        biju.das.jz@bp.renesas.com, vkoul@kernel.org,
        enric.balletbo@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] arm64: defconfig: Enable configs for DisplayPort on J721e
Message-ID: <YhVKSpMOKWzZy9a2@ripper>
References: <20220222180703.30401-1-r-ravikumar@ti.com>
 <20220222193930.sbc5xlsofhg3amgk@overrun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222193930.sbc5xlsofhg3amgk@overrun>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Feb 11:39 PST 2022, Nishanth Menon wrote:

> On 23:37-20220222, Rahul T R wrote:
> > Enable DRM and PHY configs required for supporting
> > DisplayPort on J721e
> > 
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> >  arch/arm64/configs/defconfig | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 9f23d7ec1232..b0cb894a392e 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -702,6 +702,9 @@ CONFIG_DRM_EXYNOS_DSI=y
> >  CONFIG_DRM_EXYNOS_HDMI=y
> >  CONFIG_DRM_EXYNOS_MIC=y
> >  CONFIG_DRM_ROCKCHIP=m
> > +CONFIG_DRM_TIDSS=m
> > +CONFIG_DRM_DISPLAY_CONNECTOR=m
> > +CONFIG_DRM_CDNS_MHDP8546=m
> 
> Please use savedefconfig to place the changes in the correct location
> 

Just to clarify the request, use "make savedefconfig" to generate a
defconfig, then based on that put _only_ the relevant changes in the
commit.

> Also indicate changes if any in vmlinux in commit message.
> 

Nishanth, what are you asking for here? Just a mentioning if this has
any impact to vmlinux (or is isolated to the modules selected), or are
you asking for anything specific?

Regards,
Bjorn

> A bootlog indicating functionality in diffstat is also additional good
> thing to do.
> 
> >  CONFIG_ROCKCHIP_ANALOGIX_DP=y
> >  CONFIG_ROCKCHIP_CDN_DP=y
> >  CONFIG_ROCKCHIP_DW_HDMI=y
> > @@ -1175,6 +1178,8 @@ CONFIG_PHY_SAMSUNG_UFS=y
> >  CONFIG_PHY_UNIPHIER_USB2=y
> >  CONFIG_PHY_UNIPHIER_USB3=y
> >  CONFIG_PHY_TEGRA_XUSB=y
> > +CONFIG_PHY_J721E_WIZ=m
> > +CONFIG_PHY_CADENCE_TORRENT=m
> >  CONFIG_ARM_SMMU_V3_PMU=m
> >  CONFIG_FSL_IMX8_DDR_PMU=m
> >  CONFIG_QCOM_L2_PMU=y
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
