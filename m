Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC654E26F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347613AbiCUMz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiCUMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:55:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7704CD70;
        Mon, 21 Mar 2022 05:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNXYUsYxwcdJozVJsrL6jvcTLliWmrmdGxdD2blW/juhp/qcNQdj88oOaNv4y7wQba0G61v32ruOwpn86LgJy26LQEOXo/x45B+tQJ/kPTpxxGLPu7NeBeHedgWn9tNkvZQAXbNkx5zqWVBWQ3272PtTBZtSLSWfl9Okxnpg2CTnzuwLuqmhGVoqQjoGNfzkg83+HuEzXEdPMFFCtLEXJbznaYVyWorNRCZodSqujh561Pr9tzKfJFDdYx2jNGx/1/jKt5v+lBz0KU/Wgcc9F2tsFOl374KylhvGJ6OJknWFhFSN6hhoOU2PrL0Ca52/JUdhc3TvECtAhXq0MalJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27tk8hMv5OqgP3OjLFaMwdoT1Msw3jdS+gyMcAYdVX0=;
 b=BPwCqdZ9T48A44RCDhlRL51RTTPaKFWwbNbIMWBYAzsXNEojRQJsT6pAnjAoOKwLs7pr+nufO60wAWed+MEEG5ngJdaRvcsav1uMMRfTutiBrPAcOYKvSGZwCiDF/szIFsODTAd/Fk0Ni5WTkvjAIn/u8LejE2QX4TPo6Ud30LApibRVrvKXW2DSFLb8ewIa+NyE8y4wQ1n5raActMYWjnH31tCYv0DxSUAyyHGQwxPSZa11iR19sTP3Lyl4N5e7iE/hjepEGdhSvDvjE4clXFALpfJeMX4Fm6h05wpN59KNMtK3BCPoAKK41dlQYb7zRg1mamZ/6bQYXpzXowPxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27tk8hMv5OqgP3OjLFaMwdoT1Msw3jdS+gyMcAYdVX0=;
 b=WeZoOKk08S8rlzmZuf5JPBCKKcNTvxYxs6duYaOzqxVUcaUI2neabX2Z6fsBLTmyGRCCaRIl3pCX0ZwJr9QrUiPD2hkY9hVgCNLlxPZE4J4qNsyOmgggi/hlegQi1Yay66wyccJugv3iesyy46cHFdMoQnLPw70LtjOFgGY4pu45hjQxKRuPLPiqZiERx+bwkp7F4CiRw5sTCA26kHOxEo0ERwx9/58dimqD6+zMuTETCR2qAes7SvJi0AZAHOEhXebfRJAo0ZKs60RlCcnfOwFaZSFEwiwUzhSPtwmjTU9COoZ8qHuKhZYjy9cK+C3qC5gtbA4j+TDsCsixAnxKEQ==
Received: from BN8PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:94::45)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Mon, 21 Mar 2022 12:54:30 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::c9) by BN8PR03CA0032.outlook.office365.com
 (2603:10b6:408:94::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Mon, 21 Mar 2022 12:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Mon, 21 Mar 2022 12:54:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 21 Mar
 2022 12:54:29 +0000
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 21 Mar
 2022 05:54:24 -0700
Message-ID: <748d87c6-3f91-8bc0-ce8f-0a64278b4122@nvidia.com>
Date:   Mon, 21 Mar 2022 18:24:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v1 2/3] arm64: tegra: add node for tegra234 cpufreq
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        "Sumit Gupta" <sumitg@nvidia.com>
References: <20220316135831.900-1-sumitg@nvidia.com>
 <20220316135831.900-3-sumitg@nvidia.com>
 <30bb04fe-4fed-04bc-6f99-158ac09d6bb8@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <30bb04fe-4fed-04bc-6f99-158ac09d6bb8@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f89de91c-dfed-4c40-ae72-08da0b39f03c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5723:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5723BDAAD9C1A792143D7D90B9169@DM4PR12MB5723.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raBEaZ2XTXtKTp1rZG3Gpfb0KRAbyEsYKHQcoLPbgzC6ROaOKHLebEZ7nbUMisIV5HdT3zgE7TtWEg+SISBuImTDOVUJoJu/5iYTaBKgFjPOluMind9FoUB5XWpwk8s6x+/oq3D1zjnXMOy7uJ5VwZ2quKKJqGF8uPHr4Fp8cI7WmF0NOEbOAdS26WQfffPOwyIYPTZ40qJbGcqrF93znwRYNYCjviN3AMK2Y8Q6psfQqxeVwWcq8xr9jNoHm0v17XHbNYGyOfOn3iP5CAdZ99HXbGJfVh2AUYiM9fr00TxdjVdfkB89IxhVdmCEomt9fKfhwTxISyzA+jjRB0YyiiaPVAv07ouLq7/Kb2sgAZDTS43E2cmlKnIXiawiZ0/wAIvu/r0uUxCW4FHyBxnABkrIeMZkifh1o+zpPGL0mCjnWtn5hT9ght5c6smRbMaQ2kvyHEP53Shij6/Ujg1CIgCtJGwCkupU95K3Lgw0Es7plxQsLx3E/nhOulF/Px6EDp2A+v5h5SNZQxZ5WkdBm8pWNmEUFK2FZ/VW+Q/xkqg0qOQ7q3WFQW/+lGADbeHsPYowQtYXizQ65bQeKVR2LghwvYeToKtsvWoIYi6XtMvwLBy4u++GAoP5+qRHT+tMa+SiUKzlA+y2iZICVtHIiDCCBbasmZ5aJaHGC6zocAlMiBq4E1QI7GRgwCu+Ky5Fa408c9avPeKG8RDcb4sHSXODismC3mY8s57MhFHzHEv/LjBiivkG7+EBchb8kuYiZLTv0vwNRrMlVcCrCCw+Yqq9Fk+xiIFxlkF+E0/+8ZTSakvff4LuwZ03pu56rAOAbPuaAPeSTLPsoZVaLU5GeA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(6666004)(316002)(16576012)(36860700001)(36756003)(426003)(4326008)(83380400001)(336012)(86362001)(70206006)(70586007)(8676002)(186003)(16526019)(26005)(2616005)(82310400004)(31696002)(107886003)(2906002)(356005)(921005)(81166007)(966005)(40460700003)(31686004)(508600001)(54906003)(110136005)(8936002)(5660300002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:54:29.6177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89de91c-dfed-4c40-ae72-08da0b39f03c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> Adding cclpex node to represent Tegra234 cpufreq.
>> Tegra234 uses some of the CRAB (Control Register Access Bus)
>> registers for cpu frequency requests. These registers are
>> memory mapped to CCPLEX_MMCRAB_ARM region. In this node, mapping
>> the range of MMCRAB registers required only for cpu frequency info.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi 
>> b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> index aaace605bdaa..610207f3f967 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> @@ -1258,6 +1258,13 @@
>>           };
>>       };
>> +    ccplex@e000000 {
>> +        compatible = "nvidia,tegra234-ccplex-cluster";
>> +        reg = <0x0 0x0e000000 0x0 0x5ffff>;
>> +        nvidia,bpmp = <&bpmp>;
>> +        status = "okay";
>> +    };
>> +
>>       sram@40000000 {
>>           compatible = "nvidia,tegra234-sysram", "mmio-sram";
>>           reg = <0x0 0x40000000 0x0 0x80000>;
> 
> 
> We need to add this compatible string to a DT binding doc somewhere.
It seems the binding doc was previously posted in [1] for T186 SoC.
Same will be applicable for T234 SoC also. Only compatible string need 
to be added.
Should I sent a separate patch after converting it to yaml format and 
add compatible string (or) send as part of v2.

[1] https://lkml.org/lkml/2017/4/3/324

> 
> Cheers
> Jon
> 
