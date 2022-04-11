Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2F4FB3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiDKGV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiDKGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:21:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7003CFFE;
        Sun, 10 Apr 2022 23:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB4VWktLeL0snqG+Qd3yIZDyrIPmpibjJterje8Qig26WoSWvrwP7btUJYpU20HdKrvCzUywc7ovvK29dU0RjJ4406HkhSPF5BSFZdbuRNzwYnb6UupYelN8EsDFK0IXsbYWEXmjD17pRlNDO0KzbyEr64I7Gu7gZ/vP5s0wbvw/KM0UBVyAZpIqYQ5lFQeel92DiDBeJmrl9mEIdWVZmFfqGnSQsYc3Vp2xd4GQIu0UdtgBdjgfyGwsO3Km7UUKX2MEOKPl356rjQiMLoUQUzpNIPoi27pNnYgAmNElrqYUEzzQXj/DymLGxU3S8vW+RyJnjxMljHEsRGpV9GDq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gebWwcrS7tPQNlULcQ966jK1Oji3DPdodzatXLurdew=;
 b=nVQodPi+wLv0ikQ+Qb2MKi7DTuJofpYKSr5AUgrzB37tQamsJSUZFOWutO30I8poS5VhyhBHgG6HizZmyu8aOZC/48XqN0oUNn/exSKiPeF6M4CasBLStlacwvFitkXvSpum3E0pCspUZImshtpCnkqQhlIcjWwvhR438W/umdrgZeIRf3P61MjM/S6gdCSTzxvI+LCELp2LrZjceWymvWlJL5oMVD7UgcXoJcJLfdRChaAtK79GzElisf6EXyDnZ7izxXeeGKp3SBSQQsO2DNAMu9Y90Qs8ssQNxrytJMCdj97q7mCyRGUWuvpOCJfhLDc5rUAc2N1Mt/6p9g8EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gebWwcrS7tPQNlULcQ966jK1Oji3DPdodzatXLurdew=;
 b=H3GyjAIyDcgLDfxPvtUC2RjpoT89kpl91BUD7wzzBvEU66Kz1NiENY0pG5v9MV/U//5+8186bFfrGYrkxrUd2WhTxXOxDQk7yIWnI7KVediTaGgMVRF7tg23A9akAOcFRE6YuUARWwuh0nCVWKZvPvqRBhIXBgZga+YC4UmEVegXCrdB1OnW8sAOv/w3p/MKUJ9SXHdq9UFLaSEwqlWGfePjZyX33h5DK7laSeX8Y0pfLf5eZO5yKX+2VXFMpnqzCwjsXMtkp9rD3f2ychEQZ75bw9f8A2beet+tbPnLNY/ciKCD4eVzyfe7Dmp6wiB469jiDo4usgPcJynjvsl8RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 06:19:07 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 06:19:07 +0000
Message-ID: <343749e8-871e-9eb7-dbdf-572ed5a83e73@nvidia.com>
Date:   Mon, 11 Apr 2022 11:48:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
 <3b9cab7e-9ebb-7903-4ae6-2ec6adbc72a6@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <3b9cab7e-9ebb-7903-4ae6-2ec6adbc72a6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::23) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9a4528-1f22-45b0-7cba-08da1b832f0b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51646AFC3D984DF5F8699FC1CAEA9@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+TRVDAy20zyr35IsVb3Tvb74+6JC2QsnO4/KZ1C4AfLfbvJXx6eSrcx+MRd401flSUCFpH/Z+9E+ErnH4n+wfXBGR7ultXUf/14iJ9Yp+irFKZTWh/QvgV/677uGnNyVnFCj/DBK1h6HqeaItRaM8yS6KEKIOccu5dwPxHXkPMMGYjRVcYdpr4rxZgxvXVCFjI9HZZMMR3xlYJb64b9dM8IjFZIJOSPIPGq14kZGSkycNyuDKVHcYfpC7379DfaPyrAG4y2Qie7A9erfgF5h1TebIU1vqdm1DQAo4qAA0f4MmWl4Qpc9qViRrNbIk1t6560Sk6xEZjNFs6cY0pkludUbjx0qtm8oOJNQ9hQAplcvO6ByI+7TLd0SGp+nFm6yqb3oVLRQ9JNk5VanIOs+diTCKGEz54wlYGDf0V53lBxeccAGVuUKRRwKR4xXq9MBMoYv0cQYlJPsQoA6PWU+c09TaxA9I4LFlAU2vlJpNkBDinVDctd0ydYJy7pdkFk0nIdYDcI3Tt0iHD/wrRcR5Du0zE8FL+7hYN2AnVqlw25TkPZfAVBhjqiVHETf5RxH17FMicTuz+oPcDqUYS7ywetfrErcepl/POjMPHr/gGRpjleb7yexWkPZt2rwTwJ61SVU01N1n/ET46q544c4FktjSKzzHREN1HAlYGInSw4OpZ0/c/vC3ctUqVbheGXcAE9AWm5Y6/iQp9KMVbQ4EWEsiJb6cq0VYh/dcMhWc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(66556008)(66946007)(8676002)(66476007)(4326008)(86362001)(38100700002)(31696002)(8936002)(5660300002)(2906002)(83380400001)(6512007)(6506007)(6666004)(53546011)(107886003)(55236004)(2616005)(316002)(6486002)(31686004)(508600001)(36756003)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2lsMkpFeEo0L3lVWFNjdFVPMWg1OW5yUlI1TitSWFYzSithZGo5VUdobVlw?=
 =?utf-8?B?em5TZTc5a3pzSUtrR2NGVGdJOUMrWlNTSzlKMVpaOVBBN1NCTXk4K1lyTjZU?=
 =?utf-8?B?L3M4OGVmbzF5c3N1NW5Wczd0aVlYaDNCSEdpSnBzQXlMWFdKZkk5SHFGck9V?=
 =?utf-8?B?UllFRVF4MnUrQVduTDBJQnlTcE5UQkFWbWU5V2IwWnBSYXlJU1RJdlIwcDNX?=
 =?utf-8?B?R0w2Q1NqRkxSTmxkbmNEUVdtcEJRT3F3TjBXcm9qcERXSXFOekx1M3BEN3Fl?=
 =?utf-8?B?K3hNMVJrU2s2d3VmSGZGc1R0UTFzMUhoU2RxYjBQenRKTWIxc2tzNC9oNTdY?=
 =?utf-8?B?bXZzUTdROWtrRTRBK1ZKcE94c1dHdmsxVGhrMVp5aDZybGNYZlhHd0dhRkFR?=
 =?utf-8?B?eTgwWkszT0JtVERkSEpnNHVselpTeGVDWTBqTElDdnE3cUZTN3NkWnhhQitM?=
 =?utf-8?B?WitMZk5aOHl3L1JsdVRWTytxQUQzRDArSXlXcXNaMVY3MnEvc0FUMGx3bEZD?=
 =?utf-8?B?c3ZNaHVxZ0VQK2IwVmh1UHc1QXRpTGxsYUQyYVdMbEtiNWNOblROUFVON2xw?=
 =?utf-8?B?aXdPa3VFNnljRE4reXJtaUhBYTlWd1dlbDgyVThOT1NEV3pXZU5XR2VHOEhH?=
 =?utf-8?B?emdRbnBLdklZaE5rWDVxTTJDMjRzNGIrM2VtUXg0QWNQeTZyQVkxV0V5MDFz?=
 =?utf-8?B?VXhXRXFydlR1YWhoNE82SUc1bTZrOUNkSE1mWFM5Sm9xUU1aU3Fkb2dmRTNt?=
 =?utf-8?B?Ky9oYnpzcGo3WG90QWozSG4yd1BGSUs1ZW52anAwOXZPMEt5MWVxbjc4TWZL?=
 =?utf-8?B?SUFtQWthQ2MwQVRUWkF5V0EzSnd0L0k1NkVhOWljbjJseFRFRy9sY0EvTDQ5?=
 =?utf-8?B?N0h3WEdTZExJZWpWVVdBd2J5eE5wMnllS3JCTmpvakdlQStCa2Fqd1BrQnZV?=
 =?utf-8?B?TzhjRllCTEdJUHlqUnpMZHVVZFQ4RWx4MnE4eE1aUWQ3SXlpT0Jzay81ZmdQ?=
 =?utf-8?B?djVvREZoY1Z3QTM4ZjNzTjBVaFdqdkJhQW5tcU9qa2ExMXZGT2lzanlxY0o0?=
 =?utf-8?B?STJoVXBtZjVIL3E4MkZGemViV1oyc2ptcFVyM0dvYnUzenBqWWliQnRYcC9H?=
 =?utf-8?B?NnhrM0VrOTFkbFgyY1pueEkrM2JZZWJkcm44ajJlV3JoK2hQaW9KdTdKV3Yr?=
 =?utf-8?B?ZkRYbUowOGNuMkJqbnNsNUFDbnpsK2N1MDQ0SlhQVkZrQ0FoVXZ1eEV5U3JP?=
 =?utf-8?B?VTI1cnVUQ0NoclNoYi9YMzlRUU9DQTFZb29sc1JmTGplSUJvajdJTXFlYlpa?=
 =?utf-8?B?V2xDVjNIYjFDTGt1d2Z6bHEvemp4QTBWTHZrTkxKcXhDdDgvamJmMExaNGtK?=
 =?utf-8?B?YkcrUEdxNXl5clk0RVBTTSt4Q0hQMDZpbUVhOU1kZWJKcC83NjBsVDVRL2w0?=
 =?utf-8?B?STZ6c0hlcUR1cmtjMUdTMFF2NEJPQlZSRXNJV2U1U1h6M0UybXpZQWlpcFVa?=
 =?utf-8?B?M2w2MFJjbW1qVTlmYm1XK1RmRnE5WXF1TVlrMUdPQkNWWERPQjZ5U3E0bTVF?=
 =?utf-8?B?b2ZTbWQ4UlpsRGdqU3dkREdHdnVlRUZ6UFNieHE2cW5sQ2F2Mi9qeXhRclUv?=
 =?utf-8?B?TEpEbExuNm1HVVF2Q2xBbEpPTGl5M2NmNHNtMGl3SHVaZS9ST1R4d0ZVVHpa?=
 =?utf-8?B?WDNueUE4V2Y3dk1zQ2JnNityaXZBSGk0cXQ3UHhkM2JhVDNULzNOb1JaVlR6?=
 =?utf-8?B?dStRZG1ZTHlYVU1IaU5MR1I4b3l0ZFl3aDFTYzNiZzcvVkNOdmpqK3RUY3BY?=
 =?utf-8?B?cU5TTFNZZElMNXV3ZlcrVmJuVS9HRTlmWEJDQVNaRE0zNStjeHpEUXRra1ZG?=
 =?utf-8?B?N2c4R3VyWm9hV0U3UzUyZjRnYmhjVlA3dE4yTFo3OVZxT000eUdkdTJGTlVq?=
 =?utf-8?B?d0dNOVhkMzJzazc0eTd1SXZNczZPS25oNnZ3VzFIMjNFSTB6cXFVTzhsd3cy?=
 =?utf-8?B?Y28vMjJCVHdmVWgzM0Q0SEE3elNIQkhiVjBrcU8vZzFyMnpZTlJubjhSMUQw?=
 =?utf-8?B?QTFhMC9OWURBT3pXKy9mR1dzQ0tUU01ZQUZXbmdMSkRvcVB1Qlg0RGhacmhR?=
 =?utf-8?B?UlpYd0lWemRxMHVLN282a281dm0zOHNESXlnZ2dSMzZsdE9qVWRxQmhidy9Q?=
 =?utf-8?B?bUZxcllrZnkvdUNGOTJHdTBlTmRWeUIvTTZpaDJXTzZseTVBNTd1Yi9qdkhW?=
 =?utf-8?B?UHRTdmw4Ny9Jdnlqa1ZSbHQ1aWJEclFWUHo1dzlNeDNqOUtPa29lTFVxeTBV?=
 =?utf-8?B?Wlg2NVJuTzZNSVJOYVVzaFFScE5ob1F1K2w4WHFwaCs5VVdBa21RQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9a4528-1f22-45b0-7cba-08da1b832f0b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 06:19:07.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udua1Z0kmXhxOAQqiaJqoxrcenRbx4rZfowsNITQkfOr/HbewS4dh1E4LG9+0dpzE9BdhaHuU0od7nN45Vem6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2022 8:31 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 06.04.2022 08:24, Ashish Mhetre пишет:
>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>> index 1066b1194a5a..c3c121fbfbb7 100644
>> --- a/include/soc/tegra/mc.h
>> +++ b/include/soc/tegra/mc.h
>> @@ -13,6 +13,9 @@
>>   #include <linux/irq.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/types.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define MC_MAX_CHANNELS 16
>>
>>   struct clk;
>>   struct device;
>> @@ -181,6 +184,7 @@ struct tegra_mc_ops {
>>        int (*resume)(struct tegra_mc *mc);
>>        irqreturn_t (*handle_irq)(int irq, void *data);
>>        int (*probe_device)(struct tegra_mc *mc, struct device *dev);
>> +     int (*map_regs)(struct tegra_mc *mc, struct platform_device *pdev);
> 
> Use to_platform_device(mc->dev) instead of passing the pdev argument.

Okay, I'll update in v7.

