Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268F655FE71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiF2LYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiF2LYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:24:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FBE2529B;
        Wed, 29 Jun 2022 04:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZTeHI0I6StVz6g4SiY/fzUiDRENo/py8gN8aEn7KJmn/2ro1/RBpQQqi8irhapo+fVf8pfyQchap+vbzYsUCItNCzhsShENYGQAJCw5dmEoxNgCb2Kg3CMSdgLfXLluCMMFAZtX9FTf1IK4+R5dMcD8RNICly1/A0G9IQIsQ5kjdSiJfzOI+/pCuGmox5fH+ZvNYZhscbtJ9O5tV2CoywGQjIsGHjap/bDCIRSSNwSoEjEHcrqL54wjrvzhnGeK1YsZRvOKB1ivGzNqQgD1ldJ+VoQVgyy7s/uGDmbKydFNrXbnFAebAUF+OsqCy8EnwnGitEHTBSQ2J/uGtg8cVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=889PvbqatPYaOX+Cjne81hfGyd2sfbtZJnFdcJOpiRg=;
 b=HeCbawQqA92/E8XK+reBVfcsBQ/eP8bAtd03q488j6zHzJU61yk+gqiZw2d5i3tUge1zWRSdPm8tMmspEVyxTaNglXA92qfGwN5cMP6beyK17QRpebmeFkIFzxnwinA49gdKYj/TYzEGsueo8t8sVv9RydumlHNCu/SLnjgR4OcMJmeUFuu/2Z1EL9gFfT2+3IIir1gcIVHHtevH/Bdaa0GtjJ2bh/Nj15i69zImJFcx46Q8HsnRAWp3RRnUWjhdGnMZTlhxZvxLQ3IPgXbzUNZL25m8b1pmDppiGTzlNlpXAl7A4tnL3mF/ICtLnX8wIU4PyLeIh7D69zmz09FpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=889PvbqatPYaOX+Cjne81hfGyd2sfbtZJnFdcJOpiRg=;
 b=L21cD/vm10OJLIsv8iohRWeP/09OXmlpAXuI8TpfDnOD9At+MGhgtvYHgcjfIX0sSJMyuERr/c6aUy2xjnFNCq5IFxEOszrcLEF7XzDXPofq5Ip15a5Pqt4Gk2nglM+D9aKBmIJgppRJnuN2nJaBezjJ7Kd8bWXu/WcueHTUZ7E=
Received: from DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) by
 BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 11:24:05 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::6c) by DM6PR07CA0041.outlook.office365.com
 (2603:10b6:5:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 11:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 11:24:05 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 06:23:59 -0500
Message-ID: <6f5a1b1e-b484-3a15-00be-2c1ddc09468e@amd.com>
Date:   Wed, 29 Jun 2022 13:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <git@amd.com>, <git@xilinx.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
 <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 296897b9-bafb-4159-547b-08da59c1e057
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2tCbFF1WUl3WHhQa29ldVlESUpCNmR3YStnNDBOUjJEd05UMk91SG1qZjFC?=
 =?utf-8?B?ODVLTFIyMXhCTUJqZ0o4VFVVUGczNmhQZ0JxRzhUQm1BS1JpNEVEdmdLWHAv?=
 =?utf-8?B?djR3SWxRblNiekxoVS93V0t5T0ZwV2VYNXJxTnNBT2tyU29KSThEbFliWDNJ?=
 =?utf-8?B?SzhYc2xjT1MzeWxhTVVhTkJuMUJyeGpLU1p6RmRjSDBYVlYrY0lEMzBsN1lp?=
 =?utf-8?B?ZDRrN2ZQbVhaYjM2RWk3SjhDTnZ2Q3d2dTlPOGFvZktub1hnbmk3ekpaSDBU?=
 =?utf-8?B?eWJYY1oyeWtGdjFFNXV2Zm02RFVEOTNmSEQ3ang3L0tJQktFTW94MDE0Ni8r?=
 =?utf-8?B?MDFOV1RMbUNKcVBnTG42VktRRXlvQXJpWnZld1ZVdnhLcjNDeWp1MUl3OXMv?=
 =?utf-8?B?eHVFM2ZsTzF6T2VHWnJsWm5EMU00R2FQZEEwRzhwT3ZoMGpMLzNPanc1NVJV?=
 =?utf-8?B?TTVhczZlK1JFaDJVdGVLODZGQUpaT202MjFMbitvbnllZ0IvMk4xQi9KcmZ6?=
 =?utf-8?B?UVR5bmJ6MVIwUStvNlZMU2NmZjdQYlpsRGlXSE9LVm9pTVpHMkR2clFYdERl?=
 =?utf-8?B?eC9WZ2duNHpJN3djUi9RVmJFQ3lGRmk5NGJZMWRqNGp5cGU2UWpaL3U2ZUJQ?=
 =?utf-8?B?M0pnUGFqaXlXY2sxeEZkZ3lqZ1UzOVlkMlZ6TDdMZk53VEdEemFlZXhXS2dN?=
 =?utf-8?B?dXIrWWtBelVKQWdSUlNyY3ZiSGVySFhnN1FydWNpcm9ESGRjNTc4SFdDb21Z?=
 =?utf-8?B?Vnh4QjVEL3BlRk1GdnRvbUxsZ3J2NjNuMG9GV1EweCtjYzBPWTdTSERDUkw5?=
 =?utf-8?B?OWpQbUp3MElOWFd6Ung5dXR0Um9uc2M3dEZZZTd2WlZ5aUdETGhRTHYyK01Q?=
 =?utf-8?B?TFJYbXVxTDIrRkMyTUlSbUNSeDYzNHdiWU1MTVkzY0lJcVpWbVBCNTYzalh4?=
 =?utf-8?B?cFVlaW1oUkl3Q3A2bG5IWnZFU3RheHFVVUswYXJ0M2Y0dXRMMFdTU0NyaVlY?=
 =?utf-8?B?a2NZd2FjOEpXK1VTb2s4WTJRWXlDMWtYY05meDNWWnMwWlRFeEgzZERZbzF3?=
 =?utf-8?B?eno2Z2Q2eEhvT1J1ZE11VVY4b3pLOTc0c3ZOTWozdEdoY29zZlRRaXYvZ1ov?=
 =?utf-8?B?cDdZUVh6UzdVaFBHZE9mdHZZc0VvZmVhZEN5eno0K1ZkMDhmWVArVTBobnND?=
 =?utf-8?B?VSszNElpSE5hZy9Ec1VXS0lLbm5MWlFBeUNhT0VJRlBFSWFKcExnSkpvcWdh?=
 =?utf-8?B?VHhqRkJsNWt0bklGTFpmRGs5WnpiZjgrK2ZLbXVsZmVlcWZ1Zz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(478600001)(8936002)(921005)(5660300002)(2616005)(356005)(36860700001)(82740400003)(107886003)(81166007)(966005)(40480700001)(53546011)(26005)(31696002)(86362001)(83380400001)(40460700003)(44832011)(82310400005)(2906002)(36756003)(41300700001)(31686004)(47076005)(70586007)(54906003)(110136005)(186003)(70206006)(316002)(426003)(16526019)(336012)(4326008)(8676002)(16576012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 11:24:05.1851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296897b9-bafb-4159-547b-08da59c1e057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/22 12:07, Krzysztof Kozlowski wrote:
> On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:
>> This commit adds documentation for Triple Modular Redundancy(TMR) Manager
>> IP. The Triple Modular Redundancy(TMR) Manager is responsible for handling
>> the TMR subsystem state, including fault detection and error recovery
>> provides soft error detection, correction and recovery features.
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>> ---
>>   .../bindings/misc/xlnx,tmr-manager.yaml       | 48 +++++++++++++++++++
> 
> This is not a misc device. Find appropriate subsystem for it. It's not
> EDAC, right?

We were thinking where to put it but it is not EDAC driver.
If you have better suggestion for subsystem please let us know.

> 
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>> new file mode 100644
>> index 000000000000..f6cb4d235981
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/xlnx,tmr-manager.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx TMR Microblaze Device Tree Bindings
> 
> s/Device Tree Bindings//
> 
>> +
>> +maintainers:
>> +  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>> +
>> +description: |
>> +  The Triple Modular Redundancy(TMR) Manager is responsible for handling the
>> +  TMR subsystem state, including fault detection and error recovery. The core
>> +  is triplicated in each of the sub-blocks in the TMR subsystem, and provides
>> +  majority voting of its internal state.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,tmr-manager-1.0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  xlnx,magic1:
>> +    minimum: 0
>> +    maximum: 255
>> +    description:
>> +      Magic number 1, When writing to the control register the first write data
>> +      byte (bits 7:0) must match this value in order to have any effect on the
>> +      nominal recovery function.
> 
> Register values are usually not in the scope of bindings. We describe
> here hardware, not programming model, although in case of soft cores
> maybe it's a bit different.

you need to setup this value for every instance in design tools and it is 
directly present in HW. It means this value is really describing HW.

Thanks,
Michal

