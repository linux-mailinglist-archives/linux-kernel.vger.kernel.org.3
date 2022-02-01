Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6274B4A53CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiBAAJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBAAJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:09:44 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E34C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:09:44 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q186so30064186oih.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pPpIi5w9W/mHGl9gvj7pAydSd9Upe0NYLYSjf6SNmGI=;
        b=yOCpgFpAmJBPY+ah6VrkXhKzLEm1/ycMzK2Okai47RXkQDeBdVZse8DqJ7tHoj2f9P
         7+p6hf7zI+mL/rWg+t7j2wPhYbXaZpBeXlMpUL1H9o3WJxsve9uzAQNmoYjZ+XlguiRi
         LiQVx6DYfD6VXkfFqrQQRztqB9n/OhvG/0lA0aFdZzscGg50nj6RYYxYmKm1TVI2WSkw
         FlbJ+NOaO+6g06pQ7CSjhtznTvwTW1BYW12/fefFmcFhPb6/Pt3wqj+QkgQ/jUpLZzPG
         763QAM+VbJ0mZsyNz9ZyTJL6n0sTWObqhIvKdjGba2XPcHm/9GJPsCLq9/YPHdA7jl9S
         T5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pPpIi5w9W/mHGl9gvj7pAydSd9Upe0NYLYSjf6SNmGI=;
        b=QxjxyNM4fcc59IByiXTgecjvCHWGsI+8feyCxl882FiDXXvtz/BMJ8paGzQybGShOc
         pxUxjheBzvb92NtLOG/gxVMes0iNr16AuevuzSzHKG17h4+/pDzKNxlxGKq6E4fFDkOn
         dVNhVjqpXEor8ppvi2iJjHSMyRWuOrNFU1osCEGJt0YsFvh84KlkSb1uf4zRoiKUYO7d
         Adw51Ys/f+x3TSxKIgQ383e71oFkB+S9/+IHUX0INz6pnfQ89kPpteEybNgNls3QgkmI
         oZZagd0h50i0lMP0XbKbPh/YaLyaoqmG181gIviW1vUcRYo/U4Ok9T/7Ej2OAvNG8/CR
         qMfA==
X-Gm-Message-State: AOAM533pGvNp1E1iG+XmSTOSuA6C+QVCrUHNNnbvYpame6h2qO2Yx0qq
        Un4pPX8gAQcRC9GPoY4vz576qw==
X-Google-Smtp-Source: ABdhPJzWXq0v30SY2G1ZDmV6zl2mHlBTYpH44vyYkuwf8i2o47oSV5DE6SKMq469Uw1k23FhtpyMZg==
X-Received: by 2002:a05:6808:f0d:: with SMTP id m13mr9140694oiw.141.1643674184137;
        Mon, 31 Jan 2022 16:09:44 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id h9sm6642619otk.42.2022.01.31.16.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:09:43 -0800 (PST)
Date:   Mon, 31 Jan 2022 18:09:41 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, sboyd@kernel.org,
        tdas@codeaurora.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH 3/8] clk: qcom: gcc: Add PCIe, EMAC and UFS GDSCs for
 SM8150
Message-ID: <Yfh6RSTegg2n5xuy@builder.lan>
References: <20220126221725.710167-1-bhupesh.sharma@linaro.org>
 <20220126221725.710167-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126221725.710167-4-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 Jan 16:17 CST 2022, Bhupesh Sharma wrote:

> This adds the PCIe, EMAC and UFS GDSC structures for
> SM8150. The GDSC will allow the respective system to be
> brought out of reset.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sm8150.c               | 74 +++++++++++++++++----
>  include/dt-bindings/clock/qcom,gcc-sm8150.h |  9 ++-
>  2 files changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> index 245794485719..ada755ad55f7 100644
> --- a/drivers/clk/qcom/gcc-sm8150.c
> +++ b/drivers/clk/qcom/gcc-sm8150.c
> @@ -3448,22 +3448,67 @@ static struct clk_branch gcc_video_xo_clk = {
>  	},
>  };
>  
> +static struct gdsc emac_gdsc = {
> +	.gdscr = 0x6004,
> +	.pd = {
> +		.name = "emac_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc pcie_0_gdsc = {
> +	.gdscr = 0x6b004,
> +	.pd = {
> +		.name = "pcie_0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc pcie_1_gdsc = {
> +	.gdscr = 0x8d004,
> +	.pd = {
> +		.name = "pcie_1_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc ufs_card_gdsc = {
> +	.gdscr = 0x75004,
> +	.pd = {
> +		.name = "ufs_card_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc ufs_phy_gdsc = {
> +	.gdscr = 0x77004,
> +	.pd = {
> +		.name = "ufs_phy_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +
>  static struct gdsc usb30_prim_gdsc = {
> -		.gdscr = 0xf004,
> -		.pd = {
> -			.name = "usb30_prim_gdsc",
> -		},
> -		.pwrsts = PWRSTS_OFF_ON,
> -		.flags = POLL_CFG_GDSCR,
> +	.gdscr = 0xf004,
> +	.pd = {
> +		.name = "usb30_prim_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
>  };
>  
>  static struct gdsc usb30_sec_gdsc = {
> -		.gdscr = 0x10004,
> -		.pd = {
> -			.name = "usb30_sec_gdsc",
> -		},
> -		.pwrsts = PWRSTS_OFF_ON,
> -		.flags = POLL_CFG_GDSCR,
> +	.gdscr = 0x10004,
> +	.pd = {
> +		.name = "usb30_sec_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
>  };
>  
>  static struct clk_regmap *gcc_sm8150_clocks[] = {
> @@ -3714,6 +3759,11 @@ static const struct qcom_reset_map gcc_sm8150_resets[] = {
>  };
>  
>  static struct gdsc *gcc_sm8150_gdscs[] = {
> +	[EMAC_GDSC] = &emac_gdsc,
> +	[PCIE_0_GDSC] = &pcie_0_gdsc,
> +	[PCIE_1_GDSC] = &pcie_1_gdsc,
> +	[UFS_CARD_GDSC] = &ufs_card_gdsc,
> +	[UFS_PHY_GDSC] = &ufs_phy_gdsc,
>  	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
>  	[USB30_SEC_GDSC] = &usb30_sec_gdsc,
>  };
> diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> index 3e1a91876610..35d80ae411a0 100644
> --- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
> +++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> @@ -241,7 +241,12 @@
>  #define GCC_USB_PHY_CFG_AHB2PHY_BCR				28
>  
>  /* GCC GDSCRs */
> -#define USB30_PRIM_GDSC                     4
> -#define USB30_SEC_GDSC						5

These constants goes into .dtb files as numbers (4 and 5), changing them
will cause annoying-to-debug bugs in the transition while people still
are testing a new kernel with last weeks dtb.

So please add the new constants without affecting these numbers.

Rest looks good.

Regards,
Bjorn

> +#define EMAC_GDSC						0
> +#define PCIE_0_GDSC						1
> +#define	PCIE_1_GDSC						2
> +#define UFS_CARD_GDSC						3
> +#define UFS_PHY_GDSC						4
> +#define USB30_PRIM_GDSC						5
> +#define USB30_SEC_GDSC						6
>  
>  #endif
> -- 
> 2.34.1
> 
