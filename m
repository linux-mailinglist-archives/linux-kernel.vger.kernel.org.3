Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D55656A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiGDNKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiGDNKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:10:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C352181;
        Mon,  4 Jul 2022 06:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcFV12uELP+bR1fXBbPAbfq0JB/5etoCSfd2BtFzI0sZiL6NpN4Jf5TB2n25YyihbVHS/4+7g2eI4odu8uk5nzuigBOJVaD3q1Tep3WzDYLm1F+OOhsHGxOSIqnWbXIDEJd7QqeYgv/3H/a64hOW0JN3i2pmoq2nxCmuF5eUZHGcx6bAI3+iq3aPr81b39WOySOYyV0zotU4zlPKZBeOHqeqaNq7FaS/4YjHQB7xse5zIyhmEayf72AExHFOWZhRqowOGuAqMQG8YyZrKk66mFqAVgN/1egUVZ/kAZ8dqTfzH0dO00iecjTsU7PKBVUbmHBWQxKLnMHYkOCSel4N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqPf5RixL9ZJKC5Si7RAxmkuIymCtyDc2/3vgawWUNM=;
 b=I9u3YdICNkLAJkabWSezKNaT7UYKc2DCD4Mh7VC59ySKQ2JTWjBscve6Wi1epQM30ztTkc9+nE9SPUFvvIV0XQPRhyMYZClovJWY27J84UjW7CJfpo9fwIUNy63McQxp2WGg0YPdX6mVJFMyoUFGUCuazuS7MpC6lC+OX7QuiCe9dxswyMj+s1Zh6Nrhx7MzRzrLBGxGN7nvF6d/sbVhh9ixctCav4ZTHUFQipr4SC9h0Tcz2dUsO6s1ssyO4w6FS6SG7tVX5qVE5ySZx9cQYXtfS3TaSaJNo1KlecN5Nn7YCBd07XhL43715YPoYdrjkqSet8BAO706798Ku50mBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqPf5RixL9ZJKC5Si7RAxmkuIymCtyDc2/3vgawWUNM=;
 b=ZnlIS5IbmUJvAfZ9vEZ9FBIytlsl7Ed4UCzq5o2mIuSgANupYdKgvD/G2ymV6l3mzHwluJSzvGTUcBf6ipA/CfOZckYawMxgGaBbhuZkiNF18mS/PASvio8BO0fo/mho873x6inWS+9ivRAfdtAE9YhP6Lu2ee9iexSDf61R3Wc=
Received: from DS7PR03CA0200.namprd03.prod.outlook.com (2603:10b6:5:3b6::25)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:10:07 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b7) by DS7PR03CA0200.outlook.office365.com
 (2603:10b6:5:3b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 13:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 13:10:07 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 08:10:03 -0500
Message-ID: <4e2d44a5-0242-b714-09e1-af6edfc6e5ee@amd.com>
Date:   Mon, 4 Jul 2022 15:10:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] spi: dt-bindings: zynqmp-qspi: add missing 'required'
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220704130618.199231-1-krzysztof.kozlowski@linaro.org>
 <20220704130618.199231-2-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220704130618.199231-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2953f62-8d9a-45cf-9ad1-08da5dbe845b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnNEUWJYeGIzdmpvSGVMWHcxMzB1VGVudUo4N3NYbXU5YzMrNHYwaitDUCtn?=
 =?utf-8?B?ZHFXcDlyUGRPc05BUldQKzI1WmpMdFpSd2cvWnNaTGd6R1J5VVZ0dHNzaFJN?=
 =?utf-8?B?d0l3YzRDTy8rTEluQldPKytuYUtXcVRYMnQxZFVMQXNoZnkxSHl0STFvUWRH?=
 =?utf-8?B?UWs3djlobXB1aEhLUXlxSmYyd0lHcFVySTB2aytpaHUxUXJsK2RRMm03aFdM?=
 =?utf-8?B?cEdSNFRNTjRFTTRsb3JHaEVlQlJOanI2WCsvdTlFTS96RjlCYXF4dEpaWTFo?=
 =?utf-8?B?Z09Tc2w4c2VvSGYyTW51Z2w1VmI5MzVMK3hqeFlFUXZiVG1rT0dFSmZtaDRP?=
 =?utf-8?B?WFNWN3ozdnMxaDVrdlI5b1BSRFpkR0tSRno0RlVYNTZNYUlibHh5dXlnNWNW?=
 =?utf-8?B?YTNBNlVEUnRRMEVDNURGU2s0VXVkODdkMDFqZDJRVXRVaXVaWTczS2RycWo5?=
 =?utf-8?B?eURZVnJCVktUSHhtQ2VSUU9jeFoyc2tyeXloc01iSk1sQnVpUHErcFJQZUky?=
 =?utf-8?B?V2tISFB2WCtLY2R0NVJjQU1KYVhlNlFWUzhqU0pIMXhFZ1krOWs5a0F2MzRC?=
 =?utf-8?B?VTlEaktOc1U3SEVOVUpvamdOTThWQlJZdVJhU3MxWXh5cm8vWDdCSnlBQTRu?=
 =?utf-8?B?V1ltd2Z2ZS9tZHVRS3hzemxWb3VWTitDMnpGTTM0TysyVEFQL3I0NitBTko2?=
 =?utf-8?B?YkZBUHFJanhFOVFaL3E2c09XdFFYRVFubStwS2poODJQU1Bqc3BncmJzeXRU?=
 =?utf-8?B?bEZIY1AxeFpaUXdKK0pQU2pTdzl6cFNoQWRFa21iT1pIaTJ2MmN1Mk1xcklQ?=
 =?utf-8?B?S3VjVzNpeXdBSUU2MkZVbXNOeVg0b09hNlBYeTNrbDRmalJTTXJnMzc3WGky?=
 =?utf-8?B?eTJ1UDVZTXRaRGE2Qy9VNGRNeVZDaFRLRnJKQThFT3FwQlI5eEw0M1JXdmRP?=
 =?utf-8?B?WEV2MzRkbjRPYUh6OThYWlM3azU2SHJCWWpwMkZxUmNXOXVSRFMydXdnWVVq?=
 =?utf-8?B?REYyb0sxNmdpOHRTT2lCWXFFSlR4dDFtY2toSmk4dnlrdDdXR3p4TDZzQ0Qy?=
 =?utf-8?B?eGsyb0lRd1NnUFNTN0x1REVkQVQzN2IzZUIwY1VHQjRGL1l5U01ud1FhTWU3?=
 =?utf-8?B?bmsxQmE0U0t5eDRzNFpCVFJGanlIcjcxZ1l2MXlrSU5IbGcrTzRYVXZHMjVp?=
 =?utf-8?B?NE1jb0twT2kzTUdKczlkdnNMeXBVa2JLRVdSaUNBTG0vSGVtVzc3TUJoMHE3?=
 =?utf-8?B?Ky93RDh6aHRwM3dRZUxveWpLaTFhM21GQ2dCckRRTXdsa2Uyck9CaFlxSTBM?=
 =?utf-8?Q?tVPzN6FvmOQWM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(34020700004)(82310400005)(16526019)(336012)(426003)(186003)(47076005)(83380400001)(40460700003)(36860700001)(81166007)(921005)(82740400003)(356005)(40480700001)(41300700001)(36756003)(2906002)(70586007)(70206006)(16576012)(316002)(110136005)(478600001)(44832011)(2616005)(8676002)(26005)(53546011)(5660300002)(8936002)(86362001)(31696002)(31686004)(83996005)(2101003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:10:07.1018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2953f62-8d9a-45cf-9ad1-08da5dbe845b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/22 15:06, Krzysztof Kozlowski wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> During the conversion the bindings lost list of required properties.
> 
> Fixes: c58db2abb19f ("spi: convert Xilinx Zynq UltraScale+ MPSoC GQSPI bindings to YAML")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index ea72c8001256..fafde1c06be6 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> @@ -30,6 +30,13 @@ properties:
>     clocks:
>       maxItems: 2
> 
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
>   unevaluatedProperties: false
> 
>   examples:
> --
> 2.34.1
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
