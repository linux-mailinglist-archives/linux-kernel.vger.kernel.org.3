Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90AF55FE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiF2LaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiF2L3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:29:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE873EA9A;
        Wed, 29 Jun 2022 04:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHcG5f7ncf6dO9ZLmOlceN8UW5wf+DFDfHDIm2XaM+pkCusaULgZLfkGhw3C3idUdu+BMkRL0+kwnoiW9G+/mPtfv32lRywUW86ZBos7WwYd5x6uJ3xXj28h4+cPW/K1mz7cTaMBBcV8Sa9M5kVRSkRjFGEA5FCBspTwOgzWdVq3xWNLYWRpDduo52rJq6uYdTWfthqCyx062Qwb2qwlZD3fhlokopEH9m1Q1DI/2+rOB/i4SDxWlB1UU5043P5btvRBAyG3OEksJPUC60SNjQPUIUPXcsSCY4DhJRwWATbdu81Ng6RGJhlCapK9QJo7Av3LnA+ywI+8jHgJh3g7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvowT1nkISA8FeUAsBCVG5rbTr96MJp5e/PD1zhDr/k=;
 b=ER6gjmWs2YUmxelOaN9idP0RtXOQ1VfwO42SGUYqeUEIxr/vSujxCc6bf+0yCZXuLvzRxDrsBUihDHzznNU3uEnV5Q/Lz0BJw9eEHI4tZygPF0Tds/sblTjgIDXaZB5OhFV4khDPifBI8f+8SNUOY5W4t7pJaL7hbFBwsdhCtrBbiATs8w21BLldOJzaEvsGsayed1gNBlEZc/vhG+N0w+T+2jOe4T7EAaSoF/peJKhjp01fSCrfYdQv1bW41prD7IvirLewEVQCpqdLqgr0hYyUB419XFxc6OE34Uj3kfoR+UrkMc5OcGns3bZwxQybJy9WnqebPJeOYyx/0kXbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvowT1nkISA8FeUAsBCVG5rbTr96MJp5e/PD1zhDr/k=;
 b=LSjY2GSQirjcgCgKGFxpPqL8frt0PGXEeFZAhObv2KokPkP7RyJIz9S6uBZSoGNs09doyVZsAyCH0arT5crnAG5arhH8W1f427lTtHKumFq9Cn79W8wwbpiNu6WoclJ81WITRUUJyoEQeKZz2MBKCgEGTP4ustBoGTVR5cWCm7s=
Received: from DM6PR11CA0072.namprd11.prod.outlook.com (2603:10b6:5:14c::49)
 by MN2PR12MB3821.namprd12.prod.outlook.com (2603:10b6:208:16f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 11:29:44 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::df) by DM6PR11CA0072.outlook.office365.com
 (2603:10b6:5:14c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Wed, 29 Jun 2022 11:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 11:29:39 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 06:29:34 -0500
Message-ID: <92e215f2-afb3-1d43-dd21-9206176b4263@amd.com>
Date:   Wed, 29 Jun 2022 13:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
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
 <20220628054338.1631516-4-appana.durga.rao@xilinx.com>
 <1ba34d2b-113f-360e-bdd1-ab440bc456df@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <1ba34d2b-113f-360e-bdd1-ab440bc456df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04e427b-0a5e-477e-6d0c-08da59c2a77f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3821:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFNRbUFseEFJYUMrMG84eFJJTUExSGR6RUtwT3FHa1ZRbkxPRU9JaUFHZEJR?=
 =?utf-8?B?eWRWWDFwOEpEK2FVdFcrcFVwV3FKR1RiTWphM0wxQkE4bEhsaWdDR25PcnJJ?=
 =?utf-8?B?Nk4yNEhyMm5UTzRWOHRvN2dkMWU2Ym9FZy91QjNiVjJtWkpwZkF2NlVrVXlW?=
 =?utf-8?B?bXhRS2loUGtLQ0RQRk0wN0ZidmlzMDBYYW80bTk2RXhEM3ZpenIya2NsNHZ1?=
 =?utf-8?B?dmx1MGFyODF5SVYrOVhDMnpjR2crem8yZDg2RC8wZ213K0FHclJYd1U1ODF1?=
 =?utf-8?B?MTJSMXY2QVIzUVd5emFTN2JFNTZnNFFwVTZuYUNjWitrSFBzaHZHSWtGVFk4?=
 =?utf-8?B?NTZvZU1ZYXl4UTJhS0YwRTRJTUVQM3VjeUN5Rk45VVFuTVRwWlhNZDhqVVF3?=
 =?utf-8?B?QmhxVVJwOW9ubDFGRWllTS9Ka0hwY2ZiR1JhaFAveFZGc0pwelRrMHMwUnlD?=
 =?utf-8?B?NVJqQjVkV3pxS1pQWHR4RHBFUzhtN0Z0d1lxbnQ5VkdyMzhHc2hXcDJHT2FV?=
 =?utf-8?B?SHVabFJZaVlISXdDbndWV0k2RExVeStWcVBJdXduN2R0MEVXQ0cwUjdTaEJQ?=
 =?utf-8?B?S0JrRGttRDVEblo2N1UvR1JVT25XMVByb1pvdFlpUEdZeFl0Qm5aV0YrNEJM?=
 =?utf-8?B?dVFIZ2Nxb2REVTJVNHIwYVZ0b2hkb1FNYlI3VDBIbjk5REw5MVZGMS9tcy9N?=
 =?utf-8?B?dlh1SXZ2TVUxOXVjekxwd2lXRGlGVzdkZGZKQ2lLV2ZRUURYNzFYRk1rQ04z?=
 =?utf-8?B?c0NpZW5UdXdSR09zOEVhbUpnaDJScFBmQWVwNXI2VWpCYTk0aUJncDZVRVY1?=
 =?utf-8?B?ZENkaGRSZmYrLzErUGVmYlNKV0N2TnVPWlRpMWFCVnFFaUFCZGZWQVFrT1lq?=
 =?utf-8?B?a2tnRVF3S25kSHVZUVVXTm1yM2NIbkxNbGQwMWcrbmhvUTErMGxwVEVCSTF1?=
 =?utf-8?B?UWhTNE1Oc05xRnZ5MkZBaGJKbkliVUVyL2w4S2U3czhBd1hESXk1OVJFdmpY?=
 =?utf-8?B?WWhFanN5UlBCWkN5QTlvRWlKa3hNNVNoVnl2ekFCL0cxekRRQlprQ29OS0Yr?=
 =?utf-8?B?ZGdad3p5aGorZVR3d3psZFdkRVB0WmVFSHMrajZkT21XTmgvSnhadFcxemFn?=
 =?utf-8?B?TWhuS3l3NGhDb1Ixc1hYQ2RPM3FNcTZkWERIWXlheXlzSU9WTEFiL2J1UCtr?=
 =?utf-8?B?MUZzYmxRdERnTjU3RW5xeHhlQ3hVVWZObXFHYUdZTUpFMXplYUg1YWdwVVlB?=
 =?utf-8?B?MEhEaFhpalh5cE05K2xlQTB1WTIyb2gyNTVLK0N4Z3NveVVnZz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(40470700004)(31686004)(5660300002)(36860700001)(316002)(40460700003)(8936002)(86362001)(6666004)(83380400001)(40480700001)(921005)(2906002)(82310400005)(44832011)(36756003)(31696002)(41300700001)(966005)(8676002)(81166007)(336012)(426003)(70586007)(2616005)(70206006)(107886003)(47076005)(356005)(82740400003)(4326008)(53546011)(478600001)(26005)(16576012)(54906003)(16526019)(186003)(110136005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 11:29:39.4082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04e427b-0a5e-477e-6d0c-08da59c2a77f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/22 12:08, Krzysztof Kozlowski wrote:
> On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:
>> This commit adds documentation for Triple Modular Redundancy (TMR)
> 
> No "This commit"
> 
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
>> Inject IP.
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>> ---
>>   .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
>> new file mode 100644
>> index 000000000000..4daf9539000b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/xlnx,tmr-inject.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx TMR Inject Device Tree Bindings
> 
> Same comments.
> 
>> +
>> +maintainers:
>> +  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>> +
>> +description: |
>> +  The Triple Modular Redundancy(TMR) Inject core provides functional fault
>> +  injection by changing selected MicroBlaze instructions, which provides the
>> +  possibility to verify that the TMR subsystem error detection and fault
>> +  recovery logic is working properly.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,tmr-inject-1.0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  xlnx,magic:
>> +    minimum: 0
>> +    maximum: 255
>> +    description: |
>> +      Magic number used when injecting faults. The fault inject write data least
>> +      significant byte (bits 7:0) must match this number to have any effect.
> 
> And why exactly register value is a property of DT?
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - xlnx,magic
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    tmr-inject@44a30000 {
> 
> fault-inject?

no problem with it but I think it would be good to extend 2.2.2 chapter in 
devicetree specification with these generic names.

Thanks,
Michal
