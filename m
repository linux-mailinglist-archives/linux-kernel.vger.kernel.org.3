Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97246B66C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhLGIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:54:24 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29096 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhLGIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:54:22 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J7Ypn0Nywz1DDBs;
        Tue,  7 Dec 2021 16:48:01 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Tue, 7
 Dec 2021 16:50:50 +0800
Message-ID: <61AF2069.5030607@hisilicon.com>
Date:   Tue, 7 Dec 2021 16:50:49 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] arm64: dts: HiSilicon: Add support for HiKey 970
 USB3 PHY
References: <cover.1637063775.git.mchehab+huawei@kernel.org> <97d470290e81ac40023bdcc7e2d796796421b737.1637063775.git.mchehab+huawei@kernel.org>
In-Reply-To: <97d470290e81ac40023bdcc7e2d796796421b737.1637063775.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/11/16 19:59, Mauro Carvalho Chehab wrote:
> Add the USB3 bindings for Kirin 970 phy and HiKey 970 board.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1637063775.git.mchehab+huawei@kernel.org/
> 
>  .../boot/dts/hisilicon/hi3670-hikey970.dts    | 83 +++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 56 +++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> index 7c32f5fd5cc5..60594db07041 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> @@ -430,3 +430,86 @@ &uart6 {
>  	label = "LS-UART1";
>  	status = "okay";
>  };
> +
> +&usb_phy {
> +	phy-supply = <&ldo17>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	rt1711h: rt1711h@4e {
> +		compatible = "richtek,rt1711h";
> +		reg = <0x4e>;
> +		status = "okay";
> +		interrupt-parent = <&gpio27>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_cfg_func>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> +				PDO_VAR(5000, 5000, 1000)>;
> +			op-sink-microwatt = <10000000>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@1 {
> +					reg = <1>;
> +					usb_con_ss: endpoint {
> +						remote-endpoint = <&dwc3_ss>;
> +					};
> +				};
> +			};
> +		};
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rt1711h_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&hikey_usb_ep1>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	/* USB HUB is on this bus at address 0x44 */
> +	status = "okay";
> +};
> +
> +&dwc3 { /* USB */
> +	dr_mode = "otg";
> +	maximum-speed = "super-speed";
> +	phy_type = "utmi";
> +	snps,dis-del-phy-power-chg-quirk;
> +	snps,dis_u2_susphy_quirk;
> +	snps,dis_u3_susphy_quirk;
> +	snps,tx_de_emphasis_quirk;
> +	snps,tx_de_emphasis = <1>;
> +	snps,dis-split-quirk;
> +	snps,gctl-reset-quirk;
> +	usb-role-switch;
> +	role-switch-default-mode = "host";
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		dwc3_role_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&hikey_usb_ep0>;
> +		};
> +
> +		dwc3_ss: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usb_con_ss>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 225dccbcb064..b47654b50139 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -8,6 +8,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/hi3670-clock.h>
> +#include <dt-bindings/usb/pd.h>
>  
>  / {
>  	compatible = "hisilicon,hi3670";
> @@ -892,5 +893,60 @@ i2c4: i2c@fdf0d000 {
>  			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
>  			status = "disabled";
>  		};
> +
> +		usb3_otg_bc: usb3_otg_bc@ff200000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0xff200000 0x0 0x1000>;
> +
> +			usb_phy: usbphy {
> +				compatible = "hisilicon,hi3670-usb-phy";
> +				#phy-cells = <0>;
> +				hisilicon,pericrg-syscon = <&crg_ctrl>;
> +				hisilicon,pctrl-syscon = <&pctrl>;
> +				hisilicon,sctrl-syscon = <&sctrl>;
> +				hisilicon,eye-diagram-param = <0xFDFEE4>;
> +				hisilicon,tx-vboost-lvl = <0x5>;
> +			};
> +		};
> +
> +		usb31_misc_rst: usb31_misc_rst_controller {
> +			compatible = "hisilicon,hi3660-reset";
> +			#reset-cells = <2>;
> +			hisi,rst-syscon = <&usb3_otg_bc>;
> +		};
> +
> +		usb3: hisi_dwc3 {
> +			compatible = "hisilicon,hi3670-dwc3";

Could you please also add a binding document for the "hi3670-dwc3"?
The driver part has added the compatible string as you pointed out before.
Thanks!

Best Regards,
Wei

