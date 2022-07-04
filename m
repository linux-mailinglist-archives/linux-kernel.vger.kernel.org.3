Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA456569B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiGDNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiGDNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:10:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9146435;
        Mon,  4 Jul 2022 06:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb9s/4l8b3P1aEqFKw/b9ahwQ3AU5iBPLY5jbL++oFd/WNrQs9TX27ex8NZfxJm/F8SCEOdsAGTu1QoQnv12Lcrz7Di/ke+R9bTj6ArvbG9UN5al0xhpg195Cf8q/mQKT2mr7cLQnyEu8jZ3/wqCtmh4p+Ky/WHjqxqcAktP7V9gka3ErjPO/EZIAYkA/NMWb2vRK0159QxNttnjzC2j2xnoMV3OATYPwOStntXB6tO5N2vVG/GBL8/WdcoRPRZW9ZmJWQqvfoCyW2dV4O7vW4fiNT85LKnwpCciouxeWDxe4w9s2uRqSja0CuSuZN6sz01Y7UUl/dSwK5aTBRJY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIjwyr4p6plx/ePwAA3QkFqKwegu3ItIDHS+RlLuLHE=;
 b=eRbRpoK4152D7KPzpITnN7tICxqDPZap4hEW80QdeLABqEGGU7WRY+KRpvx3VFQVLkYbDqD0FCft8Idxnv9CKjLkUX3t6g4VXsiqkg8fYUXc90M9XzeKZ8m7++2vFJ0t2/YKHa/+J/Vo4W0pZfIkM4EshtAg5LYn5WnLZrjqIIlD8+NSE/e6+3hWAbMVrisyvYlbvfVcit6A8mqRbK+7X6P49duZXUYzUvGJtq3UH8f3HjZzANTNFoNkPa2yatSRwz3wsvU2iXR0DyVZHzY84IwW37BN+EdOw2sJr+p637IEH+N1Qv2I5B/tRZF9dyFGAEepksAgh3sIhsqdEhx+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIjwyr4p6plx/ePwAA3QkFqKwegu3ItIDHS+RlLuLHE=;
 b=VVywZVRx/2hhdJvXRTuwP01NeOcvH5BCPUjtHOOQwuFnANonn/yL3psV9zSOMyV4H8ieFDFmqZ4w3Y7GbN+T1OIAdVV1tM3upnbzUS+hZ3kRZUvVe8WmITGa/+iW0l1DLvZ0PKWoGSbS2HJBM/pc/So9A3u8SW07HoTlSfJQ28A=
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:10:01 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::73) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 13:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 13:10:01 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 08:09:57 -0500
Message-ID: <06cd1d42-0c9e-a1b7-4219-d30cc202694a@amd.com>
Date:   Mon, 4 Jul 2022 15:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] spi: dt-bindings: cadence: add missing 'required'
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
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220704130618.199231-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121ef2ee-e35d-4a06-f6aa-08da5dbe80cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1dLVzJSZ0IzNWdTVklWeHVwcmhlYUVwb1oxdjNFZXdFWVBwY016ai96TVVm?=
 =?utf-8?B?ajVucWVsbFQ4WTdFMUk2M09RWmFTYzVvdlphYy94VDlrdGhXakc0U205bUpo?=
 =?utf-8?B?bmpoL2ZjeStzU212dFcwVko5SHlmYUh2Sm4vYXdKMXN5T2J2YzBVa2h1Uk4v?=
 =?utf-8?B?ZmVGNFIzOUNsNWpyYS94N0dubTc1a3V1cjU1WjRWUjVwSmVyK2JxWUEvNzVp?=
 =?utf-8?B?TzhlYWJGZmxpbTZIWm9OYWF4SGhKb2o4VnRaRm5XRllQcjN5VlpGMHg1WW91?=
 =?utf-8?B?Vi9JSk0rajNBQ2h2ZXhiRkw1VFpYeFIzVTNQd0xwUUFMdHcvd2s2RUp0WW9q?=
 =?utf-8?B?dmFzbTU1bXZLeFNJQkcxN2IyV3lZMEEvVVJhUVV3YjZ2V2RVc0V2UzE1aTM2?=
 =?utf-8?B?TlkvTXBmTEFTU09PcDg1TEMvdTBrODhwN1RXVi9DaFh5Q1JzQUdiZERkQzlw?=
 =?utf-8?B?L3Q5bTM5RHg4TCtNSkN3andRcFpjbSs2YUtoalRLaWtPTVZsTHdaZ1daSXhz?=
 =?utf-8?B?WjFkQzNIMnBhM1dYaUNMTC9VZG5nRDRpZHN4NzZTdmwxY3FzQnAxbis2UzlF?=
 =?utf-8?B?TFJpUWdJWVBsRERxRlVvenlsZS9HRG4xOGRpbVEzYUJLNkNraW5uQjZjZkQ3?=
 =?utf-8?B?bHNlQjlpS3p3NGJqaDBqOGkyQjIrYVcwQ1ovcGNLMXNoSEQzbjg5VHdUSmUz?=
 =?utf-8?B?L0J4SW8zb1Vmcjk4ZVczeXF6V2pmZk9RdlpBNnFsWTA1R2MrYkp4ckFSdkZx?=
 =?utf-8?B?RmhzRWRSOVcvZUZzL1JtQkQrenE0eURseGVaalY4ajdtUkRjVDA3M3NMcXRn?=
 =?utf-8?B?SGdyMmZ5ZC9rTzhuL3ZDQnp2dDMzRjAwc3dPRXg4Vk40eDNjVHdZV01uMWpY?=
 =?utf-8?B?d0Q5ZldJSzRDUERNUWd2blRBWUtyVUpXWFBMQmw2V2FjVFZ1MUhENWZHZ1E0?=
 =?utf-8?B?UXNKTExSVWFrRGZMTEZuR0xEWnFobDZYYUg4aGMzZ3VRd3NUTkNzb0h0YzR1?=
 =?utf-8?B?bHh0bjhDeElMd05NZVUwVUI1QmtoYTdBa0tRRTBWNFNIUXZqUVY4OWpFbXBX?=
 =?utf-8?B?cTJsc3ppWjB5U2RMbWVJTWpFNVQ1MUxCMCsxa2RQTmtBTHIzTGg3WGRuU3Vx?=
 =?utf-8?B?Y2VRdVc3OUlGVUZwaXlZU3dCQ0tuQkhyZzNJSkM3S1p1NXFkTHpqWTNacUtK?=
 =?utf-8?B?YXJ0cm1LZ293YjZKWWovdzN4TEljL3A0bi92WThiQktCRXFDVVJZVFFpeThN?=
 =?utf-8?B?a2tXajU4VUFBNWlGbVYyUUpHdVRNdUd4bHNSOTZKdFF0THE0dDBVc0t4aElM?=
 =?utf-8?Q?oy8msvLsjel0k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(16526019)(186003)(47076005)(426003)(40480700001)(336012)(31686004)(110136005)(70206006)(70586007)(8676002)(36756003)(2616005)(26005)(83380400001)(53546011)(478600001)(86362001)(40460700003)(31696002)(36860700001)(82310400005)(34020700004)(41300700001)(2906002)(16576012)(316002)(44832011)(4744005)(921005)(356005)(82740400003)(81166007)(8936002)(5660300002)(83996005)(2101003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:10:01.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121ef2ee-e35d-4a06-f6aa-08da5dbe80cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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
> 
> 
> During the conversion the bindings lost list of required properties.
> 
> Fixes: aa7968682a2b ("spi: convert Cadence SPI bindings to YAML")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/spi/spi-cadence.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> index 9787be21318e..82d0ca5c00f3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> @@ -49,6 +49,13 @@ properties:
>       enum: [ 0, 1 ]
>       default: 0
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
