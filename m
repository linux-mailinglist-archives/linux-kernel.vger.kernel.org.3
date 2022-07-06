Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4995695DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiGFXbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiGFXbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:31:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B882BB3A;
        Wed,  6 Jul 2022 16:31:10 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266NV2dZ078471;
        Wed, 6 Jul 2022 18:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657150262;
        bh=HChBSuYPg3XFNgNE1J30KqlRi/A+/hWfCMaoAkl4RfU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=h+uZY2QW/XzH3Q8NdLWy+wDrxHPE4xricNibyCYSHoYn2n0iA6VYt2jaNA/Kr+skP
         eYxVseb2xUl43feEDoiYqvjyIAH80gOx9CnnLYyrBmka0jO6T/MYR+wAKs0Taxz8Fr
         OPZpiOvd+egnON/KCxWETYtK4d/PkEtOYwJ+R/DM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266NV2nk044320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 18:31:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 18:31:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 18:31:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266NV1lE010474;
        Wed, 6 Jul 2022 18:31:01 -0500
Date:   Wed, 6 Jul 2022 18:31:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: k3-am625-sk: Add audio output
 support
Message-ID: <20220706233101.zrrzeaa62fgvd5g4@huddling>
References: <20220620102750.32718-1-j-luthra@ti.com>
 <20220620102750.32718-4-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220620102750.32718-4-j-luthra@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:57-20220620, Jai Luthra wrote:
> Add nodes for audio codec and sound card, enable the audio serializer
> (McASP1) under use and update pinmux. Disable all other McASP nodes.
> 
> Audio input is currently not working properly, so the RX port on McASP1
> is disabled for now, until the issue is debugged.
> 
> The serializer is shared between HDMI and codec. By default codec is
> used for output, but it can be toggled to HDMI using a FET switch
> connected to the MCASP1_FET_SEL (J24) header on the board.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
[...]
> +	main_mcasp1_pins_default: main-mcasp1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACLKX */
> +			AM62X_IOPAD(0x0098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
> +			AM62X_IOPAD(0x008c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
> +			AM62X_IOPAD(0x0084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
> +		>;
> +	};
>  };
>  
>  &wkup_uart0 {
> @@ -352,6 +401,18 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
>  	};
> +
> +	tlv320aic3106: audio-codec@1b {
> +		#sound-dai-cells = <0>;
> +		compatible = "ti,tlv320aic3106";

I cant pick up a patch with compatibles that are'nt converted to yaml.

Please convert to yaml in master and then post.

> +		reg = <0x1b>;
> +
> +		/* Regulators */
> +		AVDD-supply = <&vcc_3v3_sys>;
> +		IOVDD-supply = <&vcc_3v3_sys>;
> +		DRVDD-supply = <&vcc_3v3_sys>;
> +		DVDD-supply = <&vcc_1v8>;
> +	};
>  };
>  
>  &main_i2c2 {
> @@ -412,6 +473,34 @@
>  	};
>  };
>  
> +&mcasp0 {
> +	status = "disabled";
> +};
> +
> +&mcasp1 {
> +	status = "okay";

we don't need to set okay on a node that is ok by default.

> +	#sound-dai-cells = <0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcasp1_pins_default>;
> +
> +	op-mode = <0>;          /* MCASP_IIS_MODE */
> +	tdm-slots = <2>;
> +
> +	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> +	       1 0 0 0
> +	       0 0 0 0
> +	       0 0 0 0
> +	       0 0 0 0
> +	>;
> +	tx-num-evt = <32>;
> +	rx-num-evt = <32>;
> +};
> +
> +&mcasp2 {
> +	status = "disabled";
> +};
> +
>  &mailbox0_cluster0 {
>  	mbox_m4_0: mbox-m4-0 {
>  		ti,mbox-rx = <0 0 0>;
> 
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
