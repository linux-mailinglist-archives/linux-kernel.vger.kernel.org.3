Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F564ED515
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiCaIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiCaIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:00:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C01402B;
        Thu, 31 Mar 2022 00:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LolAmc/H5JW8WmmvFbetK5WjFGNzERsXvfeFFm+EhhHPpTiydKXa0O0SehPdBQICurQe35ceZro6NKBzP9dQv2ynMujJxc1ozvLVsCtd0dkfxL4aHPsUlz98mCAi9voooT8V4vHN7G6Qe4j6lnCTG0m4UVPqCLuDiyY8h8TaZ7IhrygulmmTAyAowQB0InKSJ0dmjUjaCYX/v/AR6a8tQmLhIc1oEDKbC0PQ45MR/5bUBH9N7SbX4mwBZbIt5GpuHKGHoJiCyN0ojjqFW6ySh7b4VU/uXMqlDeK+YK7cwad9J+O7PLoQWzsuVVVqMIK9ipw1v+6uh4oG8tbV/rfnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+026ONd9VEBhKGbI2RtjtU9J8DfdB27nUZS56jqlsk=;
 b=YrVRMeOc42EwXPAXLSBm0ywsMvWlQBbl1x+WeVsqgbV7j2erwxjBqJsUdONvJKj1Yy2+NzfddjJCxO31413IGq1xl81ipN1x5PxeNO9lqkCrQzm7dbKCFnn2kxh2MNmissq9S2uc9L27FbvBRPgnA2YL3YVqyC9922E5UdYqZxbJrxFhCwVJ9memDMFlkdzCZosI6S4zbYw1OlrT/lk0WK8VBvm9xPJz+YAS4zYAaXanIcUwM0uQO7tzOxHHSs6NqO30ECLd3LXPm6yvZCnw00byEf2H7Ff41+FheI09TcS6cqIkTOttvjwHK9R7vmsaPJRVFR8+zdNfTNGYff1+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+026ONd9VEBhKGbI2RtjtU9J8DfdB27nUZS56jqlsk=;
 b=TaT6mFpDIOwjlIFixLAuYunQSAUwqfqcpi+DH7tuQHsLA9g3je/y60Y6KSJ9rUlkpeX24GRFdPKSJm3R+MinG1MoiAlTC1h7eHlHh/FCmiJLzKxQ0tW2X86mRJDf3mJNlHJ3OLAsW6gLTh1271fDcBUb+PJ2mgRCTpUtwSwF67XkOh9FXtERWWywuWfzVUiOPA70CJeSZ3Yf2pCnsRwPX/mlUNGVAp+PDch0Vftn6uzhl3h9UrYlcY8qPc3sax0cCPpZR/DhTtfm/Iafpk4dvAHV7ZwG1Wezqji//95IDS482W/T6u+fyqCyOc/hWJgjard25MNLOJzB8NK5x4vK0g==
Received: from BN6PR18CA0001.namprd18.prod.outlook.com (2603:10b6:404:121::11)
 by MN2PR12MB4550.namprd12.prod.outlook.com (2603:10b6:208:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.17; Thu, 31 Mar
 2022 07:58:27 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::ec) by BN6PR18CA0001.outlook.office365.com
 (2603:10b6:404:121::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.22 via Frontend
 Transport; Thu, 31 Mar 2022 07:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 07:58:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 31 Mar
 2022 07:58:26 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 00:58:22 -0700
Message-ID: <512f17bd-b252-462e-ec2f-32983d92356d@nvidia.com>
Date:   Thu, 31 Mar 2022 13:28:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v2 2/4] dt-bindings: arm: tegra: Add bindins for
 nvidia,tegra-ccplex-cluster
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        "Sumit Gupta" <sumitg@nvidia.com>
References: <20220330143819.27476-1-sumitg@nvidia.com>
 <20220330143819.27476-3-sumitg@nvidia.com>
 <cfc6a2ac-1489-e221-f262-aab0ad5b701c@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <cfc6a2ac-1489-e221-f262-aab0ad5b701c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9233e860-5293-425a-4e50-08da12ec3d54
X-MS-TrafficTypeDiagnostic: MN2PR12MB4550:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4550FF60B0A6FCB7B759C6D6B9E19@MN2PR12MB4550.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwdRFLjGiON47d3LHdQYQLD6pnMCQh1cfSaDMC+nPVNUNCsmfqnodL1Pvv+ld4Sps5KDBA0dKrxwVnX1k20PbvRlmM3VUyRi5zp4X+P9C9o3Qrl/w5/HbizgHdILbiqhI/d9hEWi4KV6FndxP9MGpyYizZ7/8LDwKTMbZJLLtKmC2sOOcopv8X69nBn2S5debZodtLbRhl1RfHJmPJL8/xVCAnwMsJGKbKkzIeUhIaqbwzerbEpfV0NcqFHiBkDI1z3nvvpH7UQoKYmB7qKBS68eLIThyC70MJUpiVp5DMYNbb2SmSQ6+H7YT4LQFtIlYAbsRLambH4P+gDK/qSjv3dWoeNKMy5kStkPvoJMMAPnWXqUrlRKNv3yKajwXj4PR5ryFkiXPHo9Wr6h1rI1k+jjb0VzE2iVrbO4ExBrGlyhMA1Dqyr/GbbRyJA1lUXxMZ+Augh7NMupD4afyCcYozfUPJ07iPrIegqgULlbawss2RpuHsWrIh55X/yuSUv16wi8CrZrjoX3rJ7CKtAIbktugt/DoZvoUQVfwuOWTR/vj55SmdPH86P2iZ9HaW2KsH77hCz6oK6lUPgGitLye3Q9gWJjMtRMLfnCqEq7lTXx/vE/wO4OZVxqNoA2jXLof40fB4N1ITEv38On+sQcwxc5xVPlunnDgXntPdWJw0NXaS24cavxg8jinHX+c5xNHDtCls2hCon+MM21yBCNPf1CElyXQPeixOMf11S9upEZ/dHoN2hokMBOQcT4c+mDtLvOwYcp8xFIEVvzbPh3F8i89aAjXRnZlJc/L9TWiafD7j3/YyKvLKpmalEgCw1r+z6EXI+i5+OhhV15knW5N3xhGl8G85TdrCzecnIEHcXgbWBvP503JFIXs4XUHDmB9IqVZTHThAT7HPP1z8CoVA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(921005)(45080400002)(508600001)(2616005)(81166007)(26005)(426003)(336012)(186003)(40460700003)(31686004)(2906002)(8936002)(47076005)(16526019)(356005)(107886003)(36860700001)(53546011)(316002)(70586007)(31696002)(36756003)(86362001)(4326008)(16576012)(110136005)(5660300002)(70206006)(54906003)(83380400001)(82310400004)(8676002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 07:58:27.5144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9233e860-5293-425a-4e50-08da12ec3d54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4550
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/22 12:30, Jon Hunter wrote:
> Please update the subject to be something like ...
> 
> "dt-bindings: Document Tegra CCPLEX Cluster"
Ok. will do the change and send v3.

> 
> On 30/03/2022 15:38, Sumit Gupta wrote:
>> The Tegra CCPLEX_CLUSTER area contains memory-mapped
> 
> Here you have CCPLEX_CLUSTER and ...
> 
>> registers that initiate CPU frequency/voltage transitions.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml 
>>
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml 
>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml 
>>
>> new file mode 100644
>> index 000000000000..74afa06f695e
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml 
>>
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: 
>> "https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Farm%2Ftegra%2Fnvidia%2Ctegra-ccplex-cluster.yaml%23&amp;data=04%7C01%7Csumitg%40nvidia.com%7C15234587dd2e46ad722108da12e42b88%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637843068437808995%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=tDheliQYxde7WJ5hqLYUz7dsq4tsUnFe3gHlaTRa7i4%3D&amp;reserved=0" 
>>
>> +$schema: 
>> "https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Csumitg%40nvidia.com%7C15234587dd2e46ad722108da12e42b88%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637843068437808995%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=%2BWDvqJkJKdG0z85Bfn%2F3AMejwHVvi02cVLarmKbZ0iE%3D&amp;reserved=0" 
>>
>> +
>> +title: NVIDIA Tegra CPU_CLUSTER area device tree bindings
> 
> ... here we have "CPU_CLUSTER" and ...
> 
>> +
>> +maintainers:
>> +  - Sumit Gupta <sumitg@nvidia.com>
>> +  - Mikko Perttunen <mperttunen@nvidia.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +
>> +description: |+
>> +  The Tegra CCPLEX_CLUSTER area contains memory-mapped
> 
> .. then we have CCPLEX_CLUSTER again. Let's have a consistent name such 
> as 'CPU COMPLEX CLUSTER' (admittedly a mouthful but that is what is 
> means). I don't think we need the '_' in the name.
Sure. will update all places to 'CPU COMPLEX CLUSTER' in v3.

> 
>> +  registers that initiate CPU frequency/voltage transitions.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "ccplex@([0-9a-f]+)$"
>> +
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra186-ccplex-cluster
>> +      - nvidia,tegra234-ccplex-cluster
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  nvidia,bpmp:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description: |
>> +      Specifies the bpmp node that needs to be queried to get
> 
> s/bpmp/BPMP
> 
>> +      operating point data for all CPUs.
>> +
>> +additionalProperties: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - nvidia,bpmp
>> +  - status
>> +
>> +examples:
>> +  - |
>> +    ccplex@e000000 {
>> +      compatible = "nvidia,tegra234-ccplex-cluster";
>> +      reg = <0x0 0x0e000000 0x0 0x5ffff>;
>> +      nvidia,bpmp = <&bpmp>;
>> +      status = "okay";
>> +    };
> 
