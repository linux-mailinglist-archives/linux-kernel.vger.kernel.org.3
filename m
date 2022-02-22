Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C494C00DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiBVSC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiBVSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:02:24 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08082E094
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:01:57 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id l20-20020a0568302b1400b005af8c95bbe4so314791otv.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SdxXBssqIsA1l+C6PXrlMorWOAj9zYyZXBKmUKMGGC8=;
        b=SeLZhPFd5FksIREpIbjxg8L6cWMzA7jyGFZvXFmarSW6JT2CTchwa88hMEEegG0g5J
         sEW9T5K1xDqNe35ep+WkFnGIoyYK9JRUkmbehMKUmXqwoGxe5RV2CXqke77ey4RWVyeJ
         7gx4hkcqB7snXXVsFY+KEmoJxlA3DiSa3MYgmW30PwOLzM7V4Due72mSc3aLyDy85Llq
         JRFQLPf6vlyG2/L23ui3GG7IcZTqHYNYD1f+MJTK5pbOv1TGJ2Cfqux4LxbwiwgdW81s
         rDJWqiJJk5M5Wy52Vi5uwOy4yFtV/SnnUQxNsVhy3OW85Z0Y24e+qRRRrT6dPzvHUzk/
         PZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SdxXBssqIsA1l+C6PXrlMorWOAj9zYyZXBKmUKMGGC8=;
        b=XF2leHY6NFOyJNNQKONzhwAJZQR/kzkchFs0WcB/dWHqrnDz/bQPs8YcecvuPkf0KQ
         ObHVt6RmCEyoISR8iR9IJe5nCzRQh+0XPEH5FyefmM/mDSSRgvJgJ098KpaRGoWTk6wi
         42S9QvRcPT05VwCaNMbYEf6B+Lv0Qh/WtHZI2FhI5XUYR5SnOnuWVjpJgIMHw81b1vZl
         2GyvV3dYkHpyHxmuJFnzVbxwjMz+IgCexE79RPA8mV6syNn6gDMHX8td25aNru8diWEG
         9lgK+lFy+wBFmioVjoHTVVXBfVjlAPuEII3JG/0pPeZiiL8jRYKqRxL7P8hwZZzJZVnT
         zViQ==
X-Gm-Message-State: AOAM532QEl150TCRHxCLsMsYYWbD3TA7811QZw+2Fj9AIl14JQun05xY
        nJOFdKiWNtRsK3AFLynakic4pQ==
X-Google-Smtp-Source: ABdhPJxWEHC+Mm9/uZ3OOHosJbLQd2o6I9x0B1SYOT+wH5/0geWhywMJzUO7D5r90LvBSBOGtL/1qw==
X-Received: by 2002:a05:6830:44f:b0:5ac:fdb6:28d7 with SMTP id d15-20020a056830044f00b005acfdb628d7mr8649483otc.182.1645552917118;
        Tue, 22 Feb 2022 10:01:57 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 8sm6335790ota.60.2022.02.22.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:01:56 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:03:57 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 04/15] dt-bindings: ufs: drop unused/old ufs-qcom PHY
 bindings
Message-ID: <YhUljWBHi6vbMth4@ripper>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-5-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Feb 06:58 PST 2022, Krzysztof Kozlowski wrote:

> The Qualcomm UFS PHY bindings are documented in
> bindings/phy/qcom,qmp-phy.yaml and the compatibles from separate file
> bindings/ufs/ufs-qcom.txt are not used at all.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  .../devicetree/bindings/ufs/ufs-qcom.txt      | 63 -------------------
>  1 file changed, 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> deleted file mode 100644
> index fd59f93e9556..000000000000
> --- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -* Qualcomm Technologies Inc Universal Flash Storage (UFS) PHY
> -
> -UFSPHY nodes are defined to describe on-chip UFS PHY hardware macro.
> -Each UFS PHY node should have its own node.
> -
> -To bind UFS PHY with UFS host controller, the controller node should
> -contain a phandle reference to UFS PHY node.
> -
> -Required properties:
> -- compatible        : compatible list, contains one of the following -
> -			"qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
> -			"qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
> -			"qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
> -			 present on MSM8996 chipset.
> -- reg               : should contain PHY register address space (mandatory),
> -- reg-names         : indicates various resources passed to driver (via reg proptery) by name.
> -                      Required "reg-names" is "phy_mem".
> -- #phy-cells        : This property shall be set to 0
> -- vdda-phy-supply   : phandle to main PHY supply for analog domain
> -- vdda-pll-supply   : phandle to PHY PLL and Power-Gen block power supply
> -- clocks	    : List of phandle and clock specifier pairs
> -- clock-names       : List of clock input name strings sorted in the same
> -		      order as the clocks property. "ref_clk_src", "ref_clk",
> -		      "tx_iface_clk" & "rx_iface_clk" are mandatory but
> -		      "ref_clk_parent" is optional
> -
> -Optional properties:
> -- vdda-phy-max-microamp : specifies max. load that can be drawn from phy supply
> -- vdda-pll-max-microamp : specifies max. load that can be drawn from pll supply
> -- vddp-ref-clk-supply   : phandle to UFS device ref_clk pad power supply
> -- vddp-ref-clk-max-microamp : specifies max. load that can be drawn from this supply
> -- resets : specifies the PHY reset in the UFS controller
> -
> -Example:
> -
> -	ufsphy1: ufsphy@fc597000 {
> -		compatible = "qcom,ufs-phy-qmp-20nm";
> -		reg = <0xfc597000 0x800>;
> -		reg-names = "phy_mem";
> -		#phy-cells = <0>;
> -		vdda-phy-supply = <&pma8084_l4>;
> -		vdda-pll-supply = <&pma8084_l12>;
> -		vdda-phy-max-microamp = <50000>;
> -		vdda-pll-max-microamp = <1000>;
> -		clock-names = "ref_clk_src",
> -			"ref_clk_parent",
> -			"ref_clk",
> -			"tx_iface_clk",
> -			"rx_iface_clk";
> -		clocks = <&clock_rpm clk_ln_bb_clk>,
> -			<&clock_gcc clk_pcie_1_phy_ldo >,
> -			<&clock_gcc clk_ufs_phy_ldo>,
> -			<&clock_gcc clk_gcc_ufs_tx_cfg_clk>,
> -			<&clock_gcc clk_gcc_ufs_rx_cfg_clk>;
> -		resets = <&ufshc 0>;
> -	};
> -
> -	ufshc: ufshc@fc598000 {
> -		#reset-cells = <1>;
> -		...
> -		phys = <&ufsphy1>;
> -		phy-names = "ufsphy";
> -	};
> -- 
> 2.32.0
> 
