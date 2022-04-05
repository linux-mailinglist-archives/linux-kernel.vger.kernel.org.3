Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1908A4F3232
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbiDEJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbiDEIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE42641C;
        Tue,  5 Apr 2022 01:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEWMmfspaT/SAPF1l3Pb1Z7HlvGgF3UA6+HM9u/lYB4KNqNPYVycaOwHJlDRzu3TG/1mSG3EKtBfSgi4gbV3cm2aA7mEMu1xFkUN5kV4m/9cT8wbucs9SfkIYtAYA0qJTS0aIKNNrqll7JQn9PsEtaGM+bVReJEFPnyZH01nfAi99dTr9Fb4dLq3pWKdyUDLxwffphCm09XwK02F4eSE53NpaPgNrZi76NRRJ+lKnfs/L4OkirKYkznxFeCp4SQb8QI0er40dwG7F0YNaBqi//UiIqPohBeYQ5WJa+UWdSuusz8CbwnPx3QffWdmD9WtFQyqOfU5VH/AC2riSRnjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zod3BV10YHUk/5mSinApGGyP1wTOVPTEWVtjzC4BRNE=;
 b=NedKtFH8BNnDPQS8y2baqo2+h2ZmYOP2zRcd6e5UlpO71fCwfR/MJR4rAN61iGLnxS8d+SPL6NVOb+xVUCkhTLV252lPqCdvyqNdVWAOSopZfEg6lLa1Lf2diqSYox4kIvQ9HNLLHSA5dn2WbIxre+JqbvKF3fp3nsU+5KFqRjy09dtrufSi4g+aHjzn+6Adr9Z9xiIhVBjWKky3zIdmbit/nUl81/vOSxnxj2Fbwk0cPppQNXXCLC1TuLHXRj9uWy6d6kIHNF7F6HSpTh6Pd+H/iSHOxU/yEgF1QsqqQYU7AasB6RUL+Dxr45bwN/6EkbjBjYQd+8rLh65DhGCOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zod3BV10YHUk/5mSinApGGyP1wTOVPTEWVtjzC4BRNE=;
 b=JmfNV1eb5pMhhQdghMy6SHLJW3br0GFFMDhBZqO3ZUYXiORpPY9zzJ7Nq+eCFJknEbydiF45SHYk4gf1XywGT0PcsGBwzLVAACi4J/+UgRKhT9R/e9O8qSOE3Rb/Hq83YXdGO0cayXBXZ3n5GULoCSx6m+sIHQ/2YACif6SXGWapXPPIZBoESuSeqzuL31Q7W23UhiZJp0dORgncmxzUBq10T9hQTCEIsGILfRYUyCYgFOm7BL3Dvn+LQpLm4vC0jnO0y9CusJcH9eVmq3cXUsYoR2OR3LTCNU0anDpNAX8niSMfIyWr3X/jewUgOSh9RIdE8W9D/1PcYG3f1gTFNg==
Received: from BN6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:405:75::25)
 by BN8PR12MB3426.namprd12.prod.outlook.com (2603:10b6:408:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 08:16:51 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::81) by BN6PR17CA0036.outlook.office365.com
 (2603:10b6:405:75::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 08:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 08:16:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 5 Apr
 2022 08:16:50 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 01:16:46 -0700
Message-ID: <9c20f916-4de9-33cf-960b-cd3bedf96ca8@nvidia.com>
Date:   Tue, 5 Apr 2022 13:46:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v3 1/4] dt-bindings: Document Tegra CCPLEX Cluster
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ksitaraman@nvidia.com>, <bbasu@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <sanjayc@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <robh+dt@kernel.org>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <krzk+dt@kernel.org>, Sumit Gupta <sumitg@nvidia.com>
References: <20220404121713.22461-1-sumitg@nvidia.com>
 <20220404121713.22461-2-sumitg@nvidia.com>
 <1649088538.036927.1436947.nullmailer@robh.at.kernel.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <1649088538.036927.1436947.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 091dd518-3a5f-4da9-8763-08da16dca366
X-MS-TrafficTypeDiagnostic: BN8PR12MB3426:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB342646C0DF8C99A3C855588EB9E49@BN8PR12MB3426.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsWnEccd7+S7Ws2FpisJqbrDwDbZjVExhvjK/tKo+YnMPc5akTkWEJX0yGTvmZsvWmXvEqdafPHk0JENQbubbGBL8uW6Hb5XgjtK1IeavmYpgGZ+EYWB0zzqL0jVfOZLgA+cS057xoxElFD6VtZBKXlRe0ENEyZNNlRAKW0+aEuXAp13GUymtghYx2LW6t2R9t0dOLvNu46zs1C2+owXVbhA9Bn0TwufsK4bs/EQXVagbdx+kXcxTTjlsH1Wl5cNR8x1BdKVWOL83yZ01RJnqYHWM+XSpSxC4GaxVwCvfk0idEnWTTfJFgzvUE9U37XIgUl+GTYe7VQZh9LkPoxUOAXiTUGSPFzGpLTaOrdElGoM9F11avMzu1YbYPIeONpNkiN8S8VdB27UD86vRDoRISSH3D3Xv1OFNXESYiCu4nqYoApDP1qrTJtfG3M8ZiKLXbBdJ/S93LPdGcIjNqoni3Zz1QiikOCbc87dsbWe09sGMBMNXuCWnhvcO+RYsa3q9N1/h9r4373XDtduNyHqp80iaUUs21EETwOwwIs43nFLhW6ouUbmuj+hQ8B1fIT7RtuPCPInN+/iuNoxA3Mq2iqKMc7DSWBKN6i/HHs9CwbWzNBtqwnzBelJKeCkLw9fU1PbjaEy5vIVIu63MQYHuFUg/pX8yss8WEPfTUAP6gV2oFex2YXDNMycvXibp1l/kJduboB5mFRuklR2L7hW23TmZrTb8A6CbcnHJGmFkBD6T/A8pjXvtW5W7WQq0B/k3INtLL2v4PkYuI2I17z2xfJBjS80TwhahRrhRN36Td5znPh0RvhmaSQULe5mFTiE
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(16576012)(70206006)(966005)(316002)(8936002)(16526019)(26005)(186003)(2906002)(426003)(336012)(31686004)(107886003)(508600001)(2616005)(83380400001)(6916009)(54906003)(36756003)(70586007)(31696002)(40460700003)(53546011)(86362001)(82310400005)(36860700001)(5660300002)(47076005)(81166007)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 08:16:51.4805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 091dd518-3a5f-4da9-8763-08da16dca366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3426
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/22 21:38, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 04 Apr 2022 17:47:10 +0530, Sumit Gupta wrote:
>> The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
>> registers that initiate CPU frequency/voltage transitions.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.example.dt.yaml: example-0: ccplex@e000000:reg:0: [0, 234881024, 0, 393215] is too long
>          From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> 
will do the below change to fix this in v4.

      ccplex@e000000 {
        compatible = "nvidia,tegra234-ccplex-cluster";
-      reg = <0x0 0x0e000000 0x0 0x5ffff>;
+      reg = <0x0e000000 0x5ffff>;


> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
