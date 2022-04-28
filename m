Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6EB512B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbiD1G1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbiD1G10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:27:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706887486C;
        Wed, 27 Apr 2022 23:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTd5aqNDDLFK2DEt2YifAEQV7U5kuUaV2G+jBgNO8dFtFTDrBWk+sljVwrZ7RgiovKWhJ36a8Ghtz/sNtP/KiFxyToLuygZsBXrdo+6+SIlouIWlN5TtPNFx5LkG2cubGPKlG7wXJPVp+lrzaaS0sl6FEwvO8p2P4H9H4jv0OZwMEsFLttR6uwhqrRbnYTv3j0MEfJKQUJ31X7MvYKr/+QcdBUrvkrI2yvUvtM540kAmeYCoB0HK2lYSciPL7zGlUJTHADS2Ad6iUQwIIGp1WOpgWEQxvdUMsg7Clj5s2OWiuIp36jiXDuxva/kf8XIZGd7MLk++0Y9FO3HZh02nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoEGhvqA/i+0LdD/ysJU00w3j6d8iv0AhWTl8HSAiSs=;
 b=c58eDNEnqEs2DEH8I4i/3TAhxCesJQxe3/FeDmze+iWVR9gvj7PqKGRTj5goZdSfn+twR7FLyaHgRwdsQM5eIVNGrMaNN82EcV9urWzAthfNInqk2//zi6gbQxTNiuAQdzsQ0QJ3guvBGlr4X2cL/q3MP5COvGqzulynOOVMMuhRFodoIaN/oWt3Q0udZdOhS8JLBQibUHlI8axYRla8+43g/uLPddyFdfbGor/O0px3NuofQ2D0dcRMSPwl5NgCNW1cLcVpYSBUEfQ4y5IW/L4i+7695LFrKgUSaSqGdncuEn1xt96An6LfEN/V4b2MwGpq8AcBHMPjYT3VhM64Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoEGhvqA/i+0LdD/ysJU00w3j6d8iv0AhWTl8HSAiSs=;
 b=qPlySODjpJGjWWwJHCpCMQzppkc8hh2wzzcEnG6DVaOd5CW9J+8i1TXu4N5F3FE7G7byEAAO74i1TH83A5WbelX3QwNQN71Gu84oY8PPOnQngpVMK1RJawNjfSk4QT/NBR+PF9uQJeeX7dqqLhkHiFwqhamfaIoFyO3RyosrakM=
Received: from SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11)
 by SN6PR02MB4350.namprd02.prod.outlook.com (2603:10b6:805:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 06:24:07 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::bf) by SA0PR11CA0186.outlook.office365.com
 (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 28 Apr 2022 06:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 06:24:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 27 Apr 2022 23:24:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 27 Apr 2022 23:24:06 -0700
Envelope-to: krzysztof.kozlowski@linaro.org,
 lee.jones@linaro.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 alim.akhtar@samsung.com,
 dinguyen@kernel.org,
 liviu.dudau@arm.com,
 sudeep.holla@arm.com,
 lorenzo.pieralisi@arm.com,
 rjui@broadcom.com,
 sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com,
 s.nawrocki@samsung.com,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [10.254.241.50] (port=50846)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1njxZO-0005e1-6K; Wed, 27 Apr 2022 23:24:06 -0700
Message-ID: <4c06af4b-e29d-48c7-c1aa-1347c359027c@xilinx.com>
Date:   Thu, 28 Apr 2022 08:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 01/10] ARM: dts: zynq-7000: use proper
 'dma-channels/requests' properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh@kernel.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <20220427155840.596535-2-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220427155840.596535-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0843fd82-8c07-4d5f-ac6f-08da28dfb30b
X-MS-TrafficTypeDiagnostic: SN6PR02MB4350:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB4350B93CF22DBBD6DDB35CD3C6FD9@SN6PR02MB4350.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UcjJ8eo0uUAEK/J9eCgfQiRPo2gIb1GMadP3ac2u3cqv5DTnooRXV3CRrQzp/14e9INg+V9EH6N1h2RqWgQZdoWgS+AIu4dHukOI8NimAVYyXv9TSt/3GQDCTHV1S3hJck/YWGU2PWwWRhWGOVscKkiQ929NNMjhkuMdqvtwTlEt+QoDeB/EtzLvXqc96j+3VE9elqSHah/ZbWxBpqb57C6hgTo1KRBmpS8U5rj2FA4cfd9X2TXtbvRcvL5ovRKJJMgfDjqtK3Pln6CB4vZZQrjSSN9hfNTobUVRCzx/rmAJ+a3LVzzhTXmtdih/gW3BCBaD9/4vHNWlwNr876s4IFQWyMFw0FZRxsxQMh3QfGbwWTzZXs6sc2/w38Tueh6zk8W79Vm1pE85tv2CzA2BXD0VG4TuyFi8EQQq3AQIt9jGMr88guNpn0vKUQXyFVbBUnd0KcxHxrm/7QxP7I8+1pQaOMzuyZcku7cc1C50i3rhH1MC11rnltGcrQ7kRXkOXa1MkrDkx460TJuI+AZVFzkqkDT/Uq+l4uPURCZSzzGNw102yU7oyi5+wIHyEUFwjZ9QzN5HuxTJzzF6VcfTxNT3kEWTxo89vmWh0VdYKk9vjhW45x+ojVQN1gBKkH34zmf4hRWGFJcoDpCvpkygAiOVz/limG8rEXhGZuxX9I2nNPzyAHRgmKvYipqXyaH7nENEEMbEdMJQg0pbXVBgr5ziAi91qYDWAKFPa8/e2HPYxTh8NjocaB1Vzi248VL0WWgZmaEuRk3ha4NkyFPNNiAi45fmXRo8YzrlIHGrCo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(426003)(316002)(186003)(82310400005)(83380400001)(47076005)(26005)(40460700003)(2616005)(110136005)(31696002)(9786002)(4744005)(44832011)(5660300002)(36756003)(508600001)(7416002)(8936002)(36860700001)(53546011)(921005)(356005)(2906002)(8676002)(31686004)(6666004)(4326008)(7636003)(70206006)(70586007)(50156003)(2101003)(83996005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:24:07.2270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0843fd82-8c07-4d5f-ac6f-08da28dfb30b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4350
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/22 17:58, Krzysztof Kozlowski wrote:
> pl330 DMA controller bindings documented 'dma-channels' and
> 'dma-requests' properties (without leading hash sign), so fix the DTS to
> match the bindings.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 47c2a4b14c06..40c60a2b6d2c 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -343,8 +343,8 @@ dmac_s: dmac@f8003000 {
>   			             <0 40 4>, <0 41 4>,
>   			             <0 42 4>, <0 43 4>;
>   			#dma-cells = <1>;
> -			#dma-channels = <8>;
> -			#dma-requests = <4>;
> +			dma-channels = <8>;
> +			dma-requests = <4>;
>   			clocks = <&clkc 27>;
>   			clock-names = "apb_pclk";
>   		};

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
