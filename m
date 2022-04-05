Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238F84F2D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351071AbiDEKBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiDEIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:24:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0483313CEA;
        Tue,  5 Apr 2022 01:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho9exRHlVQKzA1rb5Y8Kb4GOagmdgEqQC0s6SPE/9aD06yGyz6j5PJArZyuIyCP17E2Wg/oVrJ/QzvAVOgsYD39DTc08YomHtHCQb9zLZKJIA/7/kDJuH00puGmHIkolHvT7cl51XZdwva9Y2qP/NMsC/eHLbgQKcycEZws0FWg2//pIxAzoa/vZTkhN2ZOlHhBT/CrY4r6bFj9nGI2GPRmM8dqCM6yauwi+5x3Ebw9bsEbB71AiOqPRJgp4sqqkshx4K/ddG3fNfgPJSfRNbRrcz6L8HAHhvTIbzFV//J1LM2olCaITWxQF/yVjWxXi1MBbxLAqvsCc5/t5DE3H5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtauuBICGxu9K0J9J3IAwNMoPLi7PuLdXF5AmOZ1cso=;
 b=acTKn8T9pKY9jRFh9WmYQjR+j62odjSA/N16cyLxIQ9lASSQH+q6CuADfEI2beFtZ4sQJ0zh9tdrj9TtzPrzCjwtXFzIuEMPl87yvlqDAB/Wb9CBt2OdCT7BEm+b4+m66KwDyUjZdVXbrHsik1kCffxIi656J4oHnw+a+aC9tIp3iVQe2zAWBUmqXDFrb94jK5D7k+8h7Ou1thMeyeYiUhBoRnwjb6SqFaqSOkGwPuwCpUDlSCYS/Tn5/Mk8N6NzKaJFMCPwITDgFnydKDuSQOvBs3shR1/VBsKjF/iItcLKPx7dMc3zfqmW96AuXX2p8eZB8nPz2rEp9LfmYt5VjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtauuBICGxu9K0J9J3IAwNMoPLi7PuLdXF5AmOZ1cso=;
 b=Epl1JLwXZwXAu0smiKYasRuhp/l8nXq5VY6EKmBi5O2y2IyMvn0xBd8l5kRbfUe7Yru32A7Yj/Ju5sHDONxu0EJzBtPI10WZedfdvWb7XK3mYIeI9DIo0tvUHHOHWLQ1KqAfhpPa9+FYzKe0tM5ihOGH/PRlay1k1BXoA7qw1HiEugf3NNCEI1ACwEJrFls1Ld2xpzJH/MY1EFKk3sH/g9ZDfuk1pqSIzxQE9d/lKLwGxJ1rRRmsbY8A6OxRpQ6xNFVQ4szi8ootFlm6z7Z6A5AYVWuZY8g1izyhc0ttB06LS9x/1nMUMWgtAQppwc1q32sFps1TD13frqBKT3l7xw==
Received: from BN9PR03CA0331.namprd03.prod.outlook.com (2603:10b6:408:f6::6)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 08:20:29 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::a3) by BN9PR03CA0331.outlook.office365.com
 (2603:10b6:408:f6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 08:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 08:20:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 08:20:27 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 01:20:24 -0700
Message-ID: <b140dc82-a841-3fe2-b9c5-086cc445069b@nvidia.com>
Date:   Tue, 5 Apr 2022 13:50:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v3 1/4] dt-bindings: Document Tegra CCPLEX Cluster
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <krzk+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20220404121713.22461-1-sumitg@nvidia.com>
 <20220404121713.22461-2-sumitg@nvidia.com>
 <Yksa8cvCvB2Zn7tn@robh.at.kernel.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <Yksa8cvCvB2Zn7tn@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4593aba8-96ae-4636-b9b1-08da16dd2540
X-MS-TrafficTypeDiagnostic: BY5PR12MB5509:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB550957D834A982F1F8ECEC8CB9E49@BY5PR12MB5509.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjMA9wjfos30GE9KcPPE2madqH512bm3Ajj3GF8mYhDmpU6Dl5wPjfgjUSU4LFr+s42WXWJ4KrJzuG7EU5uKEgn3+v/si2stlAIQPk1VLcht1kERS+0LNjclg8HjIZvF2xqVdSrp/6JxAGg8rYoCzkqlP0q5oiDGRmWyPJMWj71a6w/9yjGoVIuv0YLDe1fpQEnmu3knLEHCL4XZarJ/vkKyFKHS8o9C0YC+MpiC+0Jz+1i81Wwo8AGZTn4k2Ypn58Pzf78znoNQFF1ntNzvIdfzVgo05q20nsjGVNA7/2fcT/GC7fG7C5CnckG5olO5SKmumlFc6t2H6aiuLDUICFOhRwFcxqQAqMLctmvObO9wkF+/UrYKjKVaBc3Ms3wlzniRQbfWa/9SWRmHIbH2mfKhy0cCjYXoe+Nr5fsDFiie1E+MWndJ6PgCz4rLH5u0LV5+Z5W232Tu1GPB4A1+URzRTZQuca4xxRcB64OIdbXXgDwxIq7jNjO/Q/tmm5n7PLoleh22xxQancuEkCVHnLkCKmXKoJ8oOo1CC74Dzw7bxlNRGNrOW0/rcyssmIs550LuBxoBP9pPf1Wg8WziqToqDl+FWuqQwRYDWobMP2mHC5lzWqXoMxo0wYnO83ZW5LoHKvOY7hytgoXmeRQ3TFbdCKO0av0/tQY/1vqfKATt+WsllAisuTfsM+bXhVxMPNYfuXiTBm24g1FeY1LXj1qWHtg6IzyFz+sk2Ht2ui0auT/8fGZrXvKtx5N06RLmtOAb86yEuAMbdmeIDpMG6G1b5L/0RGUOAg0q9div2cKVDu+I3e+7QvSrZT++xQPFdobmvoDfczyw8ed9uPF52P2ZzxyqdmFg/bilWU3h/vpiCvYNC14U+adydhXHn7Wj
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(6666004)(53546011)(4326008)(508600001)(70206006)(36756003)(47076005)(8936002)(54906003)(316002)(31686004)(5660300002)(70586007)(8676002)(45080400002)(16576012)(186003)(40460700003)(31696002)(82310400005)(16526019)(26005)(2906002)(107886003)(86362001)(36860700001)(2616005)(426003)(336012)(356005)(81166007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 08:20:29.3210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4593aba8-96ae-4636-b9b1-08da16dd2540
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/22 21:51, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Apr 04, 2022 at 05:47:10PM +0530, Sumit Gupta wrote:
>> The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
>> registers that initiate CPU frequency/voltage transitions.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
> 
> Changes from v2? None perhaps because you ignored my comments there.
Sorry, i missed that mail. Will do the fix in v4.

> 
>>   .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
>> new file mode 100644
>> index 000000000000..d89457e0bd7d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Farm%2Ftegra%2Fnvidia%2Ctegra-ccplex-cluster.yaml%23&amp;data=04%7C01%7Csumitg%40nvidia.com%7Cb16581be5d9b4c2e302a08da16571fa0%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846861298835916%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=NnMO3XdVzZjEDcYd5k8uPY1o%2BuJwNiWuZoAoJTaoako%3D&amp;reserved=0"
>> +$schema: "https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=04%7C01%7Csumitg%40nvidia.com%7Cb16581be5d9b4c2e302a08da16571fa0%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846861298835916%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=xEIMU8P4LOYDwTFyuaeClH0%2F7Na%2F7w29Fm6VBxxNRQQ%3D&amp;reserved=0"
>> +
>> +title: NVIDIA Tegra CPU COMPLEX CLUSTER area device tree bindings
>> +
>> +maintainers:
>> +  - Sumit Gupta <sumitg@nvidia.com>
>> +  - Mikko Perttunen <mperttunen@nvidia.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +
>> +description: |+
>> +  The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
>> +  registers that initiate CPU frequency/voltage transitions.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "ccplex@([0-9a-f]+)$"
>> +
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra186-ccplex-cluster
>> +      - nvidia,tegra234-ccplex-cluster
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  nvidia,bpmp:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description: |
>> +      Specifies the BPMP node that needs to be queried to get
>> +      operating point data for all CPUs.
>> +
>> +additionalProperties: true
> 
> Additionally, true is only allowed for incomplete, common bindings which
> this is not.
> 
Ok, will remove "additionalProperties: true" in v4.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - nvidia,bpmp
>> +  - status
>> +
>> +examples:
>> +  - |
>> +    ccplex@e000000 {
>> +      compatible = "nvidia,tegra234-ccplex-cluster";
>> +      reg = <0x0 0x0e000000 0x0 0x5ffff>;
>> +      nvidia,bpmp = <&bpmp>;
>> +      status = "okay";
>> +    };
>> --
>> 2.17.1
>>
>>
