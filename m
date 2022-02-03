Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEC4A841B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiBCMwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:52:24 -0500
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:10304
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350641AbiBCMwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:52:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1ACmpM4vvNFV1HBJXXOPzTPB4ycvrs3vaApSV5XC+LWI2R3vd8/+2umBCR/NGn/V0xfadGQp7EAYcVCKpUbrGV/IARmxTljVF1sl19VPxAnm7k8wutOqHN4uJB40AhRqsyDbPNmruF5lAfGngxUjS4y1b5a6wLodW7i0em9y3aCgHGbDUJeT9Bt6QHalDiCH6Vb/5wNufHbJuc5LsMeDve2dWKM7UwBLoz+6/jeNmjslvQugmeWDLLMk4fraUY+MCRITKHEldBHIL++aLM+DtnLAV7VQmlkKEwvlgeb9lCRf7nWiZoQwPYsx6ydbHpp+FQbg+k+0NP9YmELemj+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dEp55POGUB0SgbmBuHArd2zaMGuxhI11aLePlwF/tU=;
 b=U5WxhniTORKvxAUcTtf8OKO57U/5KMiFqW4aG8GF4waZrrq99PmXvjoc58tJk11XzGxf8Hqvo2qtlz6c/CBQz5MifqlFcizQO5YAb59tTnyHgbdx/cA1bX1I1J/GcwCaxtC4oArPwjQ7jvjH89Q+bLnfy0s84lxg2TFUhTxRVIAXhK/LWJ0qlW1m+hBHxxvJJLGp9RHrXSJAKejITU6j1dMJd8gixrllky/aOlnCnw5SmJGHQ/cqRVUOaI6WzaeMFT/zzaFIR9XQ/WW4UEFbLLF3VWwP6nzvznRdNfWMWU2cBuK1EWmFR6q7leC8RX6ND+5cqRJaGJMT/rULfLfq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dEp55POGUB0SgbmBuHArd2zaMGuxhI11aLePlwF/tU=;
 b=TiGmmilLV6XGXSAhc2jbsD+nLC653pb8iGXXOK8UtojWMGMSddL2mgrY35X7cTwV9r/al5G8BOOHnqHnkydNrG+sevBLkeudaXxlZQAVYi2KFgMlXmZugU77Kno6zU592ulSdDZigWZ5zeXHtD0OwFHYH6p7arIvrA8W0uRCSffq8Q4uOHQaeyNHXBe04LUm0CSlYsjgQYkrOUSxwdxAp0ieyX6lcQqCiHy/gTFb1zZFh9b5xzqssq2qoOQcWleEF5UAuKHdwyHPSZLUq13RGJDjmGabRvVm33juRfJITR68CYmZr32fZxMl9XD5+7H0WzoWu/my+FSm8VluT8NaoQ==
Received: from FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::21)
 by DBAPR10MB4044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 12:52:18 +0000
Received: from VE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:4b:cafe::f4) by FR3P281CA0059.outlook.office365.com
 (2603:10a6:d10:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5 via Frontend
 Transport; Thu, 3 Feb 2022 12:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT004.mail.protection.outlook.com (10.152.2.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 12:52:17 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 13:52:17 +0100
Received: from [167.87.72.47] (167.87.72.47) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 13:52:16 +0100
Message-ID: <61bec34c-0861-f042-09bd-d30fd0cafb8f@siemens.com>
Date:   Thu, 3 Feb 2022 13:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65*: remove
 #address-cells/#size-cells from flash nodes
Content-Language: en-US
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
 <6e245e545a2927d2bd4bbc7df9197e6669ccce93.1641900122.git.matthias.schiffer@ew.tq-group.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6e245e545a2927d2bd4bbc7df9197e6669ccce93.1641900122.git.matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.47]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce748b6e-cd97-4a22-09b2-08d9e71402a6
X-MS-TrafficTypeDiagnostic: DBAPR10MB4044:EE_
X-Microsoft-Antispam-PRVS: <DBAPR10MB40449208A1EDCB98FA498E9A95289@DBAPR10MB4044.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wst0Wexb5u7g226fJii+s7/Sa9AwJMEOiQELWOUUcaBeYv2K3R/h6LoscSsslUdYD35ILO0wgyII4my/DpOIvhoMoNGNz3zKONb+5mxv0GYnJeRgGg2tihbos3sr40n04sWUINDAPLdae41Vti0aBFJyiQS+LM8KnoOzy7dvwNF4H3IVDF06NtZwDhFmWe05rzGSoN5BIC2CKb/bXIqM4MUzhw6PQ6OtLc565cUuxCaNi1hehKF/hlcfvVrjqQrexIljlFSZI47H1xsNVfnGpttI4RxinTfuhPR8RoKm5847KCrfuiLoEFIqYMKlDcfZqQNZ8g4H0op6mYrCs2gDbRWi0AKJAB8d9vZyqrPxv5K7AJXrpVdNeHI/vfyGD82rKi6fQPW5rHIdPmAKPOTaoDOgkVc8xDYlH4CC26bGe4AttLe7NBXcPdVWpbQd1cB9uQqUyWSs+ssouOsnk/bco3qf+Dh5NK/g8vKJd3O5531kOuB4ph4eHnZJDrPc3tkG9lFhvjrz92aL6J5gPkEZZDxvJErBrh6u4zUTFtpIpmspcDfFxYZv72o86kkHPpHe6Cqohc0o+fc/l44H6lwfM580XExbaLaOR1QggHHOQIT/uX0ixNNZQxff1jFd6mqqAZxj9OwD7HrPAVy1cBNs2JKfSAozj2IGjyV0AV6k4gYPCb6JS1MlVA3RL1qHepw/e+3XDXnBloufLmrjXY7XT4sM2Qj/J7l7MMiNBcb/JPZIUeM/opGefFgyJ1eh14gM
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(5660300002)(186003)(83380400001)(26005)(356005)(336012)(7596003)(47076005)(31686004)(82960400001)(36756003)(44832011)(7636003)(2906002)(53546011)(70586007)(86362001)(8936002)(8676002)(82310400004)(956004)(31696002)(6706004)(110136005)(54906003)(40460700003)(70206006)(2616005)(508600001)(316002)(4326008)(16576012)(36860700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 12:52:17.8965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce748b6e-cd97-4a22-09b2-08d9e71402a6
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.22 12:25, Matthias Schiffer wrote:
> Specifying partitions directly in the flash node is deprecated, a
> fixed-partitions node should be used instead. Therefore, it doesn't make
> sense to have these properties in the flash nodes.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 --
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 8 ++------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 873c123c611e..7eca697e1ca1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -623,8 +623,6 @@ flash@0 {
>  		cdns,tchsh-ns = <60>;
>  		cdns,tslch-ns = <60>;
>  		cdns,read-delay = <2>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 821ee7f2eff0..9c06da9d6d8f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -340,14 +340,12 @@ &main_spi0 {
>  	ti,pindir-d0-out-d1-in;
>  	status = "okay";
>  
> -	flash@0{
> +	flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0x0>;
>  		spi-tx-bus-width = <1>;
>  		spi-rx-bus-width = <1>;
>  		spi-max-frequency = <48000000>;
> -		#address-cells = <1>;
> -		#size-cells= <1>;
>  	};
>  };
>  
> @@ -442,7 +440,7 @@ &ospi0 {
>  	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>  	status = "okay";
>  
> -	flash@0{
> +	flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0x0>;
>  		spi-tx-bus-width = <8>;
> @@ -453,8 +451,6 @@ flash@0{
>  		cdns,tchsh-ns = <60>;
>  		cdns,tslch-ns = <60>;
>  		cdns,read-delay = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  	};
>  };
>  

For the iot2050 bits:

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

-- 
Siemens AG, Technology
Competence Center Embedded Linux
