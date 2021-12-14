Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22721474080
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhLNKfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:35:16 -0500
Received: from mail-bn1nam07on2041.outbound.protection.outlook.com ([40.107.212.41]:14566
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231219AbhLNKfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:35:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFaZuYQGYJQAGA87jLIHoDsUBQIvwc+DC0toARK+p/22vc1yHIUk1T28jXpXTDEpmPYqvE3vOh0tA3tnLIP541axzYXNL82QqvcB/3KDkQvU7WTdnZDQnUd9RL3A/Ngsp6b676eQFuQlGuO3mWuQ3gsQQjDptjO7ulA9Gf7R/X0VZ2t+HfwnOj1R3SWJaKWqg0zLIB79SFrlN2lZhsq+uTPVKuF63+3keIcNpbyvvQLUw7CimRohnSuEv9Zvao1p4JKvacFRSzAXvGb5AEcGpfevn+PZd1CVtq+g/vGXDvMHoArjdnK7H+tLmJZ4sr6sE0Bwz5LsYMcDwFxW6vwbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnToDJSteqmII8z3t8Pv6uLYSWccMykYO8WdNpom+jU=;
 b=VcB9CiGwlvu3+iC2YY5N8vT6zM0dgu3tn/RFmB9okIrTiopxc6zZl0b7Irh7C86+Xn3kRIuYWlNiMRd3f3QKeJenHBQ2/ixLHSnVNRDUGtvZBJTwBFOOUL5PiNBtQwEQ7IOrbpQSJP95ZBTSaniZQvGGgwAVtDJxOkJBItCAMuB+dkG2HyhUFabRpyL2daOqSwZ5nHiWBz7Sy/1zaWccFmLfxAxFHOPAFUzDpG8mm9UL/+s1t8w4ZGPxtFIjUS8DiwTN0PPEQqE71Bj3HCfxcpz24gBXsj6U4fuzmy0VnG5GaZFdU70H0mCjBWfhzB8m8hixsEdzWJBJXqen67cfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ixit.cz smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnToDJSteqmII8z3t8Pv6uLYSWccMykYO8WdNpom+jU=;
 b=VFjc7eB57GNrnuW7MOiNLpWH7E7pbSpm9Bb6QRqm1Hea3pfx0ZjaD/TWptHHyhHKCO+csiwZsNbaC4CD8tRRhx2Ae6QI99QfRrcE/+/95AZFHGY22BJ/OMhTrA1N7GkeIbkEnSDNrsXckO4EocfgFwta18PqsSlcruwQa9Jj5ZM=
Received: from DM3PR12CA0075.namprd12.prod.outlook.com (2603:10b6:0:57::19) by
 SN4PR0201MB3566.namprd02.prod.outlook.com (2603:10b6:803:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 10:35:10 +0000
Received: from DM3NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::a7) by DM3PR12CA0075.outlook.office365.com
 (2603:10b6:0:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 10:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT047.mail.protection.outlook.com (10.13.4.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Tue, 14 Dec 2021 10:35:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Dec 2021 02:35:06 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 14 Dec 2021 02:35:06 -0800
Envelope-to: david@ixit.cz,
 robh+dt@kernel.org,
 ~okias/devicetree@lists.sr.ht,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=39948)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mx59G-000DxD-AN; Tue, 14 Dec 2021 02:35:06 -0800
Message-ID: <7e4eb48c-8b03-e3d3-3ed7-1bca5a42aea3@xilinx.com>
Date:   Tue, 14 Dec 2021 11:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] arm64: xilinx: dts: drop legacy property
 #stream-id-cells
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <~okias/devicetree@lists.sr.ht>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211208184846.101166-1-david@ixit.cz>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211208184846.101166-1-david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c611f9f-5d1f-44ee-60aa-08d9beed67b1
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3566:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3566CB8CC91E15D519F9CBFCC6759@SN4PR0201MB3566.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZwOnfoJpUuIKuNGZz9dZ7geWM/eddU7MRgtegGhjXWEnSCY5MjKctg6LbY4aUV07jLwuM34QMDoEBEaNJaNq8Fvme8ghfZcPlna2cVyHEP7kKux4SbdzCnoaMvQJDlzmt61rs3yWwukfA5ihVkGO6kEZZarADfehpM9nYLdRvFkvUJ4vTA0ZSvywXcQe4YfTTCa8DwZzSg8gBJwV6ybJqBF6aKuiaNc30FRloOAaCJ4MENtbru4vb25ghiSIZi41GsZBuio8Ui4hrEsg7gMLFsOU6hvmdvURc3iRCg68seLXud/oxHzMEGJq4xFPBfzMcZHfWVyM68zDc5vkLRRW6gr4WFu7hE03Lwh/bE6J36DsaCg2g7If4KMfziZ/3AKAOsenDhkGP5PkvaV/agPlbw53Lk5b+i7TDDpzb16U+u1aA5x0kp91QGxWAMs2anACUSTWcrNhaRLYoKX2acW/iJOGCsQ62LTd14INumXli7JHohPNUERzUyJukla/XU99xa2e2OfOVsEjPu5T3AchZxdxjp9zRcN0PLlQ+Q5BXOBGG5uHYGuM/IRPb23Qjv+9GZgzatQ/EE+cYiVyhySpnoT56sfX+6yVoQc4S+giXfgxt90q2MdOBZqAQ+8hPz66E0pCyjtAPineuTCah1+YD58+TYi9mIrfzwBbP6NxsCsluqLdJlnChwQGrBNY7PGoeWtpnQkIj4/xBUQFUVjFggTRaduZZWjnuFFaQvstdvtjndmiHKA/Rlze7BQ2t2FfCRJTVirXClVmxt8XXoe/g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36860700001)(31696002)(2616005)(186003)(26005)(36756003)(9786002)(70586007)(70206006)(31686004)(7636003)(47076005)(44832011)(316002)(6666004)(8936002)(53546011)(2906002)(82310400004)(4326008)(83380400001)(426003)(336012)(54906003)(5660300002)(110136005)(8676002)(508600001)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 10:35:10.4902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c611f9f-5d1f-44ee-60aa-08d9beed67b1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3566
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/21 19:48, David Heidelberg wrote:
> Property #stream-id-cells is legacy leftover and isn't currently
> documented nor used.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>   - split qcom and xilinx
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 28 --------------------------
>   1 file changed, 28 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 74e66443e4ce..493719f71fb5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -262,7 +262,6 @@ fpd_dma_chan1: dma@fd500000 {
>   			interrupts = <0 124 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14e8>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -275,7 +274,6 @@ fpd_dma_chan2: dma@fd510000 {
>   			interrupts = <0 125 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14e9>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -288,7 +286,6 @@ fpd_dma_chan3: dma@fd520000 {
>   			interrupts = <0 126 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14ea>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -301,7 +298,6 @@ fpd_dma_chan4: dma@fd530000 {
>   			interrupts = <0 127 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14eb>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -314,7 +310,6 @@ fpd_dma_chan5: dma@fd540000 {
>   			interrupts = <0 128 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14ec>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -327,7 +322,6 @@ fpd_dma_chan6: dma@fd550000 {
>   			interrupts = <0 129 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14ed>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -340,7 +334,6 @@ fpd_dma_chan7: dma@fd560000 {
>   			interrupts = <0 130 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14ee>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -353,7 +346,6 @@ fpd_dma_chan8: dma@fd570000 {
>   			interrupts = <0 131 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <128>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x14ef>;
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
> @@ -383,7 +375,6 @@ lpd_dma_chan1: dma@ffa80000 {
>   			interrupts = <0 77 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x868>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -396,7 +387,6 @@ lpd_dma_chan2: dma@ffa90000 {
>   			interrupts = <0 78 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x869>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -409,7 +399,6 @@ lpd_dma_chan3: dma@ffaa0000 {
>   			interrupts = <0 79 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x86a>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -422,7 +411,6 @@ lpd_dma_chan4: dma@ffab0000 {
>   			interrupts = <0 80 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x86b>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -435,7 +423,6 @@ lpd_dma_chan5: dma@ffac0000 {
>   			interrupts = <0 81 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x86c>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -448,7 +435,6 @@ lpd_dma_chan6: dma@ffad0000 {
>   			interrupts = <0 82 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x86d>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -461,7 +447,6 @@ lpd_dma_chan7: dma@ffae0000 {
>   			interrupts = <0 83 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x86e>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -474,7 +459,6 @@ lpd_dma_chan8: dma@ffaf0000 {
>   			interrupts = <0 84 4>;
>   			clock-names = "clk_main", "clk_apb";
>   			xlnx,bus-width = <64>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x86f>;
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
> @@ -495,7 +479,6 @@ nand0: nand-controller@ff100000 {
>   			interrupts = <0 14 4>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x872>;
>   			power-domains = <&zynqmp_firmware PD_NAND>;
>   		};
> @@ -509,7 +492,6 @@ gem0: ethernet@ff0b0000 {
>   			clock-names = "pclk", "hclk", "tx_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x874>;
>   			power-domains = <&zynqmp_firmware PD_ETH_0>;
>   		};
> @@ -523,7 +505,6 @@ gem1: ethernet@ff0c0000 {
>   			clock-names = "pclk", "hclk", "tx_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x875>;
>   			power-domains = <&zynqmp_firmware PD_ETH_1>;
>   		};
> @@ -537,7 +518,6 @@ gem2: ethernet@ff0d0000 {
>   			clock-names = "pclk", "hclk", "tx_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x876>;
>   			power-domains = <&zynqmp_firmware PD_ETH_2>;
>   		};
> @@ -551,7 +531,6 @@ gem3: ethernet@ff0e0000 {
>   			clock-names = "pclk", "hclk", "tx_clk";
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x877>;
>   			power-domains = <&zynqmp_firmware PD_ETH_3>;
>   		};
> @@ -621,7 +600,6 @@ pcie: pcie@fd0e0000 {
>   					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
>   					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
>   					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x4d0>;
>   			power-domains = <&zynqmp_firmware PD_PCIE>;
>   			pcie_intc: legacy-interrupt-controller {
> @@ -642,7 +620,6 @@ qspi: spi@ff0f0000 {
>   			      <0x0 0xc0000000 0x0 0x8000000>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x873>;
>   			power-domains = <&zynqmp_firmware PD_QSPI>;
>   		};
> @@ -674,7 +651,6 @@ sata: ahci@fd0c0000 {
>   			interrupts = <0 133 4>;
>   			power-domains = <&zynqmp_firmware PD_SATA>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
> -			#stream-id-cells = <4>;
>   			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
>   				 <&smmu 0x4c2>, <&smmu 0x4c3>;
>   		};
> @@ -686,7 +662,6 @@ sdhci0: mmc@ff160000 {
>   			interrupts = <0 48 4>;
>   			reg = <0x0 0xff160000 0x0 0x1000>;
>   			clock-names = "clk_xin", "clk_ahb";
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x870>;
>   			#clock-cells = <1>;
>   			clock-output-names = "clk_out_sd0", "clk_in_sd0";
> @@ -700,7 +675,6 @@ sdhci1: mmc@ff170000 {
>   			interrupts = <0 49 4>;
>   			reg = <0x0 0xff170000 0x0 0x1000>;
>   			clock-names = "clk_xin", "clk_ahb";
> -			#stream-id-cells = <1>;
>   			iommus = <&smmu 0x871>;
>   			#clock-cells = <1>;
>   			clock-output-names = "clk_out_sd1", "clk_in_sd1";
> @@ -825,7 +799,6 @@ dwc3_0: usb@fe200000 {
>   				interrupt-parent = <&gic>;
>   				interrupt-names = "dwc_usb3", "otg";
>   				interrupts = <0 65 4>, <0 69 4>;
> -				#stream-id-cells = <1>;
>   				iommus = <&smmu 0x860>;
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				/* dma-coherent; */
> @@ -852,7 +825,6 @@ dwc3_1: usb@fe300000 {
>   				interrupt-parent = <&gic>;
>   				interrupt-names = "dwc_usb3", "otg";
>   				interrupts = <0 70 4>, <0 74 4>;
> -				#stream-id-cells = <1>;
>   				iommus = <&smmu 0x861>;
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				/* dma-coherent; */

Applied.
M
