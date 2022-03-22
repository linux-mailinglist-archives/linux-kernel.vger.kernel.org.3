Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A314E3E16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiCVMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiCVMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:08:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75883019;
        Tue, 22 Mar 2022 05:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg0GZ8nVMKAXfcr61Ca17CGfwAPDmVe0jlX9g3apMERQp9TDY4INFs4x+pc9PyDQ7D9c3iCiA1+7IqavDxz+TkJW8H+9HPFAvUEO4QF/AUFbI7TxugTw9MLdq/6B26IilM1SPiaR6c3bzrPtJZX5xYtzq7c1phdUv1Tcl1HUNVQaCRymwkWfSSzjEnCAYib0c7lr1waKz0wQ17aLiSL5Fq8SCwXlUCg5Ir4mnLaeExrHylh98MXnwN6AaPVEfPebh2kn1SibFdFAYgMyq6DMAxkpucAEZnvkXenI1LGvUJZOWsYDGdKKtrbtcEtHq0VBEvBeCv6YAiPaKv76W2Q5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhzVdp7E8myfiPE6dttt5qQF6Yo1x0+0Wv60Gj+utNY=;
 b=OAayw5/COxBS2Ns/H2BSqkVdpCgu3KkGNHr8M9zlx7ojOLh65/UlwNTLcFj7/V8XTXyQ1xgsvJMlfEUXcm+dYOrAvLamA0cE/YL27OAdavdDjdW/EnoyIg7BzNDuWfZ0GoiORBevz4UExGn18cf6CzPrNUkuumvb122UNWiABED/MLAf+en8i9CNu494JnAQOuUmQAEjW+/nYADrbIyUEclVebmqRo8HVdQjBch/iK7i0I+pR/cT5uZiEL0dL0lh0g4XC+kvBQIXmUYg1PJpJUhZ3NxAbdaUBwL2xtMqYuqmXdoYwEEtUdN3bmaZpUz3R9PpP5s+jS8dfolM9FpdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhzVdp7E8myfiPE6dttt5qQF6Yo1x0+0Wv60Gj+utNY=;
 b=NNlStCaq/tWAAE5FzWWWNkNgD9i8k7dD6w3XfbIYnG5qd5X1Denfhmyvf/FfteWx+xDSLxF5zsxYjyA1Yc7zYQ8J6Ukzk4o0znkut/4qKRc1UmPw+uBruSlH3K866vxchq+zn1fdZ3NOajOCDtbcx66b/jqY4fEucEBcTCL7n+oUM4J+6VmCWKvcMnm4K3IWjAV0Xorz+xaHB7yeZQ3TKk7jRbOdA/gaVfiUWRTQzLQCVw8Iy6zMSIHpucdJOs8ZcDIg2KlrhDzP73MeqY7DzHLOzCXD4TyTSH7eYLkA/p6hxqCN/xJSSKI7+K1fKIK1lSj5sOr87knetbNJaDvwcQ==
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 12:06:31 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::d0) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Tue, 22 Mar 2022 12:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 12:06:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 22 Mar
 2022 12:06:10 +0000
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 22 Mar
 2022 05:06:06 -0700
Message-ID: <bf4eccf5-6db5-c837-a29d-b75ab1ded607@nvidia.com>
Date:   Tue, 22 Mar 2022 17:36:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v1 3/3] cpufreq: tegra194: Add support for Tegra234
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20220316135831.900-1-sumitg@nvidia.com>
 <20220316135831.900-4-sumitg@nvidia.com>
 <20220322055012.oewlqykxb4dlkhbr@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20220322055012.oewlqykxb4dlkhbr@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc30a1b4-1762-4368-3dd1-08da0bfc66c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2794:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27943BC18FC7A6EE8B18BE78B9179@DM6PR12MB2794.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etFmBjlqc/3MXL7XBCRaby2/jyDEx0hAV+FldPeqtw9Sbq3789RdgJrR6K461MulyiqTQIEcINUc+Ovr0xF73XQW2uywY+U+Xh/QAHp8AVb4QSbrwBip49nPeaDhaz/Q6ZQSmFSgVktVgHbJHaK6cT7tnJcQZwRhBcr6M892aZsGHvkXROZXhiKYzJ1ueRfzPD7h7DUlC/PB1yBrqpqCuRiErpsjUWmgS71aWyjpZZ6AkyHXsBkXYg2kehLe7J0EOuYkXIJApuvKe2dRarXWKIM5OQYtfmk4pPYz3aDHnzwKhpbPT75VVuHfcQ8DwVrsW9q1PYCfnMP2hWq+shB0aXEcMMA1YpnyLEW7AcCWAWSmeorC6mwNK/rc1kmqzcG+gLjeu8o9zuZP8M/hZ/czMoaR274P7wAjgwoOTXLJPt03uvZTuO6Kzym9UqyDfng1BH1afW/QLi4xtscRXTxvUHSdkgkl0poc/P8/sbFlLF/Zj3mbhU97L+GYyRNe5bm1IX8W7GXkYS/m2B128Vyn/Wt42LaSBfV06PfViIU1OX0aHLmf+cU1KQgACUa1TCcUPZomBxhw1csrjy0fC6JY4mxdFP9wXUWTH+qlELPcDqfOvG6g4o/S8nDl/J5X97HlN3hYvWWa93FpO1y8yn1YyRg94jd1tJLuBOHfszEAJTg0IVZaxxMnBl6uKJhzPUT0hYNBYIdW8w6ggjMU+OHcpeuY9NYaUVann/EV1gUzKcrGxHmTZR9wiji2B4N3Uj8M
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(2906002)(86362001)(508600001)(47076005)(8936002)(5660300002)(31686004)(336012)(70206006)(186003)(316002)(26005)(16526019)(2616005)(426003)(4326008)(36756003)(107886003)(54906003)(16576012)(6916009)(82310400004)(31696002)(53546011)(40460700003)(8676002)(81166007)(356005)(70586007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 12:06:30.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc30a1b4-1762-4368-3dd1-08da0bfc66c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/22 11:20, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 16-03-22, 19:28, Sumit Gupta wrote:
>> @@ -442,6 +538,13 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
>>        if (!data->tables)
>>                return -ENOMEM;
>>
>> +     if (of_device_is_compatible(pdev->dev.of_node, "nvidia,tegra234-ccplex-cluster")) {
> 
> Since you have soc specific data, that should be used here to know if you need
> to map registers or not. You shouldn't use device-compatible here again.
SoC data struct has 'actmon_cntr_base' field which will be populated for 
SoC's using MMIO. Will use this to check before doing ioremap and add 
the change in v2.

struct tegra_cpufreq_soc {
         struct tegra_cpufreq_ops *ops;
         int maxcpus_per_cluster;
         phys_addr_t actmon_cntr_base;
};

if (soc->actmon_cntr_base) {
  /* mmio registers are used for frequency request and re-construction */
         data->regs = devm_platform_ioremap_resource(pdev, 0);
         if (IS_ERR(data->regs))
                 return PTR_ERR(data->regs);
}

> 
>> +             /* mmio registers are used for frequency request and re-construction */
>> +             data->regs = devm_platform_ioremap_resource(pdev, 0);
>> +             if (IS_ERR(data->regs))
>> +                     return PTR_ERR(data->regs);
>> +     }
>> +
>>        platform_set_drvdata(pdev, data);
>>
>>        bpmp = tegra_bpmp_get(&pdev->dev);
>> @@ -486,6 +589,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
>>
>>   static const struct of_device_id tegra194_cpufreq_of_match[] = {
>>        { .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
>> +     { .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
>>        { /* sentinel */ }
>>   };
>>
>> --
>> 2.17.1
> 
> --
> viresh
