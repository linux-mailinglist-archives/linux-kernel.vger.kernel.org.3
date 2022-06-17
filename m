Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2D55002C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378444AbiFQWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358121AbiFQWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:48:12 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69745275C1;
        Fri, 17 Jun 2022 15:48:11 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id m16so2367942ilf.6;
        Fri, 17 Jun 2022 15:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWqgJ+BNBlicstTxKNm6zsmC+wdLqiLODgZbKAeFkuM=;
        b=QSgLDXjSUXB/Z+fD21M1Ym0qzAQ4VWN0JqEdp0yS9IoHuEusYolvuuK5coXYfRTJYt
         cAHV/2fej7ZDmg331gYj+hskjFCVRSGjvjQsIdnURUFv7+P4HRBEizU70S/Xjvzqkxlk
         iohm35jo5O98hGVyyoNgV2tF4IlAdJPTAKMPVUbpRbwy1n+dIsK6cUEIWwHIX+ENC9Fg
         Y4JYq6QaHmu8MZUaanPe3tRv2KgJbUEZPr5w40xXp3otDiHjZ+jOO/xD1ysOif7MjxpP
         l0nnAl0brI1eyXCGcUHzfj1IFAFgv6GM1TX1N48xG8jEkN3J1bWHZnwmlG9cfqjBLPJY
         2QfQ==
X-Gm-Message-State: AJIora/Rz0b/9lZb1KrMezmsBmDYLBIrPjkYTkWmE26+6gxhBkw4MxTL
        PmocnmLprihknA3w1jdGfRFZ+c+BDg==
X-Google-Smtp-Source: AGRyM1tF1TFgKSd3rEFaD6pBxylnAQ7yDR97H315fy0ANiBFFFLxcOCCc9qGBhQwWAv/RErvaCyrxA==
X-Received: by 2002:a05:6e02:1be5:b0:2d3:ea49:fe47 with SMTP id y5-20020a056e021be500b002d3ea49fe47mr6908114ilv.289.1655506090157;
        Fri, 17 Jun 2022 15:48:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g9-20020a02cd09000000b0033192b7fd35sm2775207jaq.128.2022.06.17.15.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:48:09 -0700 (PDT)
Received: (nullmailer pid 2580984 invoked by uid 1000);
        Fri, 17 Jun 2022 22:48:08 -0000
Date:   Fri, 17 Jun 2022 16:48:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com, sivadur@xilinx.com
Subject: Re: [PATCH 2/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc
 error after resume bug
Message-ID: <20220617224808.GA2576564-robh@kernel.org>
References: <20220613124703.4493-1-piyush.mehta@xilinx.com>
 <20220613124703.4493-3-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613124703.4493-3-piyush.mehta@xilinx.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 06:17:03PM +0530, Piyush Mehta wrote:
> When configured in HOST mode, after issuing U3/L2 exit controller fails
> to send proper CRC checksum in CRC5 field. Because of this behavior
> Transaction Error is generated, resulting in reset and re-enumeration of
> usb device attached. Enabling chicken bit 10 of GUCTL1 will correct this
> problem.
> 
> When this bit is set to '1', the UTMI/ULPI opmode will be changed to
> "normal" along with HS terminations after EOR. This option is to support
> certain legacy UTMI/ULPI PHYs.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  drivers/usb/dwc3/core.c | 16 ++++++++++++++++
>  drivers/usb/dwc3/core.h |  6 ++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index e027c0420dc3..8afc025390d2 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1140,6 +1140,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
>  	}
>  
> +	/*
> +	 * When configured in HOST mode, after issuing U3/L2 exit controller
> +	 * fails to send proper CRC checksum in CRC5 feild. Because of this
> +	 * behaviour Transaction Error is generated, resulting in reset and
> +	 * re-enumeration of usb device attached. Enabling bit 10 of GUCTL1
> +	 * will correct this problem. This option is to support certain
> +	 * legacy ULPI PHYs.
> +	 */
> +	if (dwc->enable_guctl1_resume_quirk) {

What's the downside to just always doing this?

> +		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
> +		reg |= DWC3_GUCTL1_RESUME_QUIRK;
> +		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
> +	}
> +
>  	if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
>  		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
>  
> @@ -1483,6 +1497,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  				"snps,dis-del-phy-power-chg-quirk");
>  	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
>  				"snps,dis-tx-ipgap-linecheck-quirk");
> +	dwc->enable_guctl1_resume_quirk = device_property_read_bool(dev,
> +				"snps,enable_guctl1_resume_quirk");
>  	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
>  				"snps,parkmode-disable-ss-quirk");
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 81c486b3941c..e386209f0e1b 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -397,6 +397,9 @@
>  #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
>  #define DWC3_GUCTL_REFCLKPER_SEL		22
>  
> +/* Global User Control Register 1 */
> +#define DWC3_GUCTL1_RESUME_QUIRK		BIT(10)
> +
>  /* Global User Control Register 2 */
>  #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
>  
> @@ -1093,6 +1096,8 @@ struct dwc3_scratchpad_array {
>   *			change quirk.
>   * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
>   *			check during HS transmit.
> + * @enable_guctl1_resume_quirk: Set if we enable quirk for fixing improper crc
> + *			generation after resume from suspend.
>   * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
>   *			instances in park mode.
>   * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
> @@ -1308,6 +1313,7 @@ struct dwc3 {
>  	unsigned		dis_u2_freeclk_exists_quirk:1;
>  	unsigned		dis_del_phy_power_chg_quirk:1;
>  	unsigned		dis_tx_ipgap_linecheck_quirk:1;
> +	unsigned		enable_guctl1_resume_quirk:1;
>  	unsigned		parkmode_disable_ss_quirk:1;
>  
>  	unsigned		tx_de_emphasis_quirk:1;
> -- 
> 2.17.1
> 
> 
