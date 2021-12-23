Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4147E061
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347197AbhLWIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:24:48 -0500
Received: from mail-bn1nam07on2066.outbound.protection.outlook.com ([40.107.212.66]:55886
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347177AbhLWIYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:24:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT+ZbL70epCEROxPr1tIXtnR9AOuRZ41OY+r0b9nKhDCJVe1bEESY7SWCcbnz6yQl5WRkR8laboJbXOaJgR2B0iKsJJdgcRveLVPwzOmHrLct2PiYFSJhwcQkHybQXSiQVA2hCXXJY6fmTGVgE3cNJAVrfnOZr89yr0Bf644t1vWLDHf/46BYC3QGxS27NBvpXtFafR3+LRYaZ5a3R9BrrwuK8VAZWkzVUVF8kyJoerS8/E01tW4ryl1UaKAyAfd2Ck9thfYHYQRs+fbih2zmIJ4w+yM9+kalGU/+fO5fhRtdKSVU5sAF44ZC1TsViSi5XKr3a+bc6hv2NKa849zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0TDanaccpyvjKJQS8+A//ZhJzcD+t8BYBl9HZGmMTw=;
 b=OnI68dLt0mubpckznre9QPOHb/wPq1dAt/AE430QuWE8pPOw328MC0MPfdLf4xJEgZMQCszDHUvyZnL3gGD3KpEw/vomC0xxxEUnpZTnZmKK0mj3bEcUKKPsCqOQ0qvbKXXtU/mKzhOUtpOJrMpBfOmfjROr30Q/BIPCFs3xIQfRX34g2VX/zB7dr9XMD6qnsA8TEkT2TxlwoHHEXpUnEBDtvnLPiFChdt4TmQm+KWwE7/IVqbuiWkpluMaDIfg+UxF4T1uhafMbDlfIUEcnhhUukbVbuBBqIab2UfUjox+VcZ3cIcWDVTxDJSAQN1wI+pN5sLUqOgjs4fphCY3X1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0TDanaccpyvjKJQS8+A//ZhJzcD+t8BYBl9HZGmMTw=;
 b=ivhx/2kCLPjp22xF9gxY7c5BIh4EqVwpLbZ23pIJG3z3wR6EbJ8WOa4qQgile0sGTH4azTpbfQDE5x90P4S760RDs3pS6Z0Y3dcxxqPvBibuHbtMJT2wquKPYyoVxMRwHkwjdERzZJp2+PL5KHud92Pi19dg/jOBGQDF+HO+7eiEJ3NTZjM3aSYgMnOi6r7SChxKTjohfJKiDuWPgaT5cKwlKwlYS+c4KJMjW2GKcGnCwkc+Ne+w5Ht+dT25NR08plqCsugsaxHFyB9RhrWTxq7ZzqmpV246gt4b5JE9KkNuGxkUmr1H25jH62j0hijZ5bUJ15CJqdU7PwwA0vA56w==
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by MWHPR12MB1517.namprd12.prod.outlook.com (2603:10b6:301:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Thu, 23 Dec
 2021 08:24:22 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::1f) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14 via Frontend
 Transport; Thu, 23 Dec 2021 08:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4823.18 via Frontend Transport; Thu, 23 Dec 2021 08:24:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Dec
 2021 08:24:21 +0000
Received: from [10.41.21.79] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 23 Dec 2021
 00:24:17 -0800
Subject: Re: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
To:     Rob Herring <robh@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kbuild-all@lists.01.org>,
        <bbasu@nvidia.com>, <vsethi@nvidia.com>, <jsequeira@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
 <20211221125117.6545-4-sumitg@nvidia.com>
 <YcNv7xm19sFTlfjW@robh.at.kernel.org>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <226fd57c-2631-ec7a-fc48-d6547d557681@nvidia.com>
Date:   Thu, 23 Dec 2021 13:54:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcNv7xm19sFTlfjW@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e957458c-6d0f-42a3-ef34-08d9c5ed9f99
X-MS-TrafficTypeDiagnostic: MWHPR12MB1517:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15178C1BA367A6A257B38EAAB97E9@MWHPR12MB1517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFhkdHJyK0RoMGNZbWJmMzlzcEF3KzFVYjFwdE5Zck9PZ05YQk9lRTVvUlRu?=
 =?utf-8?B?bUZFc0d6L0EvWDZXbGtmd08zcDd0NTFraFRvM2tKclJ0Z0VuMW9STlkwSGcr?=
 =?utf-8?B?c1ArSDd3bkpEUHoyL2ZGRFpaWXNqNnRDdFRYM28ycFBoa01OaWpTakg0RHRS?=
 =?utf-8?B?aFFSbm5SUGZ4dng5ZFVHenQ1SGFIOEVCclBWaUNyaE85NllrUE0rcVRZUksr?=
 =?utf-8?B?cC95RTRLWkxHQ0toamZpOEU1SThMVnQxMitHU3ByWnJmb25PVDArVDMwanpt?=
 =?utf-8?B?OHFFNVdHNmJOeXJBMlVTelpmV0FiRnBXUzAwOTRzR29iQzFUbVVBMzF5YXlJ?=
 =?utf-8?B?d3JlUGg5T1VHRWM3TzFHY1JMNi9DM3FYVTFhRUFiaDFCR0dlSy9HcHhURXF5?=
 =?utf-8?B?Nm1SalE3aEU5TG15NUhVY3pOLzJCaER2ZVIxa0tGenJhckU1VW9zSU9YZVhj?=
 =?utf-8?B?MVBOZmRQSCtDV09BckNrblJJM2NFQWcwUm51Y2F4Smhmb1BKU3V3VE1nZXBv?=
 =?utf-8?B?Y1FNcmhuTzM4UndTdHpNRkJtb2plOFJyVGpGRHZTUXRWbGgxR2NxUFliRFBR?=
 =?utf-8?B?YlhYUWI3MHp3aXZ0eEt2K0pSdzAxY3dHZUxjRWdKcFZiOHc4UWw1ZExiTHdE?=
 =?utf-8?B?eGtlUU54bDhoVjRLTXhaNG9STWIxRmlqd2paT0kvZ2FPMVF6cmt2TVp2TUdm?=
 =?utf-8?B?QzNpNkZPVVBJcVU1MGFUK3J5ZXZvditBRklaWmlCOVluajNrcG5KTFpNQVRj?=
 =?utf-8?B?Qkp4V21QTWxub3ZkVzRoQVJJSnpTbExVZTlHdFNJYlVQS3dPd1drSjZScFBQ?=
 =?utf-8?B?QUY3cnZyTzJ4YS9CUW1HYTJuczJpYWI0Z20xQ1d5dmhxNG5Eako2dWNQVitP?=
 =?utf-8?B?cTdmSDJKZjBCeFowMWExMkdPazdscnl1d01TSnEvUUY4RXB1MHV4MFFiS0pK?=
 =?utf-8?B?Wk9Sb0ZraHA1TkJXd2hiTGxLT1ZoYjM1aWs1UmxBNlpoNm5XMVVQU3E4VmlX?=
 =?utf-8?B?YmEvRncyOGpWd3hjOTFGZEhlWDZEeGcyWFBlZDBVcmJKTW1DcUZOVyt0RDhM?=
 =?utf-8?B?U0s5RkJOUkVjSGF2TzZpbVhIV1A2dEdJVTQyaXNOREI2MnBGYzJsc2NMVXJ3?=
 =?utf-8?B?ZkZqSm9VY25UWmFEb3V4MWRYUHJoZ1F4cElVTlJURUdDZFdFVDhIUDNkNUVh?=
 =?utf-8?B?VEk2ckdqczBZaUZlYXlqOERPbGdhS29uTzZKSzMvUU9xRmx1MDZUSTJXZVBL?=
 =?utf-8?B?NnBJUWNLSVVyY1o2dkxTbG5zd3pBSGdlWHRFNUx1YW4xbjc1UT09?=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(86362001)(70586007)(40460700001)(31686004)(508600001)(70206006)(82310400004)(26005)(16526019)(8936002)(107886003)(31696002)(6666004)(4326008)(186003)(6916009)(36756003)(8676002)(47076005)(336012)(36860700001)(2906002)(316002)(426003)(81166007)(2616005)(5660300002)(16576012)(356005)(54906003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 08:24:22.3503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e957458c-6d0f-42a3-ef34-08d9c5ed9f99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1517
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Tue, Dec 21, 2021 at 06:21:11PM +0530, Sumit Gupta wrote:
>> Add device-tree binding documentation to represent the axi2apb bridges
>> used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for APB
>> slaves are reported as slave error because APB bas single bit to report
>> error. So, CBB driver needs to further check error status registers of
>> all the axi2apb bridges to find error type.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>   .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>> new file mode 100644
>> index 000000000000..788a13f8aa93
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: NVIDIA Tegra194 AXI2APB bridge
>> +
>> +maintainers:
>> +  - Sumit Gupta <sumitg@nvidia.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^axi2apb@([0-9a-f]+)$"
>> +
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-axi2apb
>> +
>> +  reg:
>> +    maxItems: 6
>> +    description: Physical base address and length of registers for all bridges
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    axi2apb: axi2apb@2390000 {
> 
> As axi2apb appears to be a bus, then all the child nodes (APB devices)
> should be under this node.

axi2apb is a bridge which coverts an AXI to APB interface and not a bus.
CBB stretches to the various partitions using different bridges like 
axi2apb, axip2p etc connected either as single or in chain.
The bridge reports if error and that gets logged in NOC's error logger.
For APB slaves, all errors are logged as slave errors as there is a 
single error bit. So, we need to read the error status register of the 
bridges to further triage the reason of the error.

> 
> Is NVidia still putting all the devices at the root level rather than
> under a bus node which is preferred?
All the cbb noc nodes in T194 and fabric nodes in T234 are under "bus@0" 
node.

> 
>> +      compatible = "nvidia,tegra194-axi2apb";
>> +      reg = <0x02390000 0x1000>,
>> +            <0x023a0000 0x1000>,
>> +            <0x023b0000 0x1000>,
>> +            <0x023c0000 0x1000>,
>> +            <0x023d0000 0x1000>,
>> +            <0x023e0000 0x1000>;
>> +    };
>> --
>> 2.17.1
>>
>>
