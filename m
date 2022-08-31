Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0325A7AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiHaKIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiHaKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:08:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC97CCE2A;
        Wed, 31 Aug 2022 03:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+Ih7dG3NhvRXsKIFNhfm6SEVsrS2B1ZgR7uxvYw35WSPZSyyuYNSt7fssV7zkHbljk34PLyDv6CWki4w1KcWfovHtdGeohdTHZxnSFDpAK4IVSh/8t4/mq0ssriqhB1ix7hDvT+pWpNeN/zzWL07DKEA8VlkNX46vv64lPIs/+rY5I0QMQ46nCbN4w84gZW7K+ezw1hvUNoaG+yrh+fCDrsyCWEig3CJStVueStSrCvVLs5Dnc8OR29ZepRfzg/lyttSvJWE3o4ms8pB5JPEZetB19F/n7LwXET6VnXMPcHz5IAo/dLrZCigJ6Qhgm0wQ0JADElrBYnUsbBHDBEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCeVpoKO/1/N48+nunxs9vCvXF+91+hJk5qV50u2PQM=;
 b=mgohtSypxdxA9UT5uoDQF6GIfNjzYoqHIBsWC+Veu63c/zBeGFqdauofL5AkxfxaC/RU7OyMBBlzH2ryAF3g7WUu2Hq3u8Yp7EPI+XwojzDSzA7oZqAt/bpsD6S5MxAp7mLdNTYPwdyFFap8pMJolAGSZbOYbCrqch8E5p86kulLirGiU//wMj6mlvds31zw3WpinvptDvLnEip6Kqr3M6bcd8hhzLu83bYualuEczYoFFrZCUAYj9znAD9adxpp4KuhZ9rjRqLtWz36bNNVey4tVcG2UDMl0d99GzT67OXvwELZR2G1zBXYfUGoegJNjD7hFpQwt5sqyJRMgoHXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCeVpoKO/1/N48+nunxs9vCvXF+91+hJk5qV50u2PQM=;
 b=imGwrfoSe0tOLBHU0KQDzEzd8mggFIXoYFcgTQGfAHFj61POpTPvqdnOUWUZaoFsgEqHgAw2FDySwCK/1irLMOC0mjbaeToN/ds+4YoAQsQw/yNSRzX7yRjPJby+efY8Vk8IpF7JPig9gDOypARXgdsBIxN3ZFrgQWy6N+YL6zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6175.eurprd04.prod.outlook.com (2603:10a6:803:fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 10:08:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 10:08:29 +0000
Message-ID: <9c7854a2-bc9c-f4e6-3b37-f740e05768c5@oss.nxp.com>
Date:   Wed, 31 Aug 2022 18:08:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9
 syscon
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
 <20220831074923.3085937-2-peng.fan@oss.nxp.com>
 <cb3870bc-451a-ff62-e671-f2045eecc781@linaro.org>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <cb3870bc-451a-ff62-e671-f2045eecc781@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb5c95d-ac34-4e8c-2f70-08da8b38c09c
X-MS-TrafficTypeDiagnostic: VI1PR04MB6175:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ogk1nxzNyn5+YkdhftaqLI5HJn6H00RmfiFLvUP0rD2LTYLXQVESUibDpKJqHEdbXcZFgf6KKmQMkmQRt9PW/vAc6oTGtyUM8iGjGcKYR+ZwSWyjZgO+y8MIqznAzuUez9Dv+sREImIlkk15di7bT6SETe1XkMCAZqKkGLmR4A392YIanmwBRn9C681zoRgvAc89NT3I7kQwpg1vH4SNzxXo2f/jEX87a2Uw7Ec7FXiTEwlpjpRsGfC09yqMACPGHAoAdBzyN2uFTZuv5AtvRVczEc4hdW15R6yr5ifOjvT3cNtfY6cG5moWPD9gdNa7q5srQxGdFcpQEWZ8Bh8fJ2xy7L1vSVh8UbMgmb2jtZW5lHuKTM7wyExx9rj1fhoiajFb7JEEhT7cCukH3gabbeiZNsN3081G7lpMM4QPurRC0xDY02voKBqUqAGRV5uSdrgk3Y9gcCZ8VQ0AbUh9FIuq9Uqp6R82Je9hS1q724iGrpTM/unJ4v7iGMDenlRljrWtBJMLgpncdhFITgmBNFkeblDgG3bT4DbofUxCZXTFP4ojd5fsV0T+995/LdMvl9yjtyPBsOknCza+ctC2y+snnbrycUJ2UpjPPDVQItEhFBTrp1NyGFvvmmetknS/unsZDtEPcdSC5d658Bv8Da28SZFoxduc+qp2J4dLXdM9xGFcVFCoTBpDlGRBzBlw31wAb5wKQWUXWc/fbRoC7xXDIwMGlnJilf+Zub3FVLRERIlTJeod8HHJL9zsGManqPUK/e2BULQ+ianDWPDkITpl/PZuutlY24eDxEIHI9eEBIJ93EXs+KzQauiiuWI8izlpSQ9Yd5mvXVn+sMy8qw5G9bJHMEME6b7wR+gqL5ESWHknJ/g0Tsc7Y3UEPyhuw54v64ZYCf8y4MUlQhtnWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(66476007)(478600001)(38350700002)(316002)(31686004)(66556008)(66946007)(8676002)(38100700002)(6486002)(4326008)(8936002)(41300700001)(5660300002)(7416002)(6512007)(6506007)(44832011)(86362001)(26005)(83380400001)(2906002)(52116002)(2616005)(53546011)(6666004)(186003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FxemdsVS8xMDVCZHhqQXUxZFdDaDdDSXFuZzZWR1JGSkNRbTd2U3pHdFA2?=
 =?utf-8?B?Rk9sMnZIMGg5ZFdTSUY0dHR6ZDRKNHF4bHJZM2dQZEJ0L3g5K2FYOWs0SkpJ?=
 =?utf-8?B?cWtLbkRUdFlVSzh0enlDVlZMR2NTUFpUUG1wMnZnYjBWbHAzcE9tbDk2S1dw?=
 =?utf-8?B?dmZUaDFvLzBhak9xd01VM29hTXEvZGpwR3pPbjNpWW5iZzJnRkVMcW1YcXZn?=
 =?utf-8?B?SnBXU2NWbTRuejAyQTg3NXhmM1BucER1R1ErRG9TRGx5TnlGN0RpSFVibXY0?=
 =?utf-8?B?K2ZrVm4wSXQrNTZ3a251RnZoUkxOVmk3aGhSckl6MVl6OUhSUlJvT3RaUER1?=
 =?utf-8?B?NzlLNHE4aTJMNmxRbXJ0V05naWx5VFlUbEJyOGQxZDhtdGhhcHZLMDUybHp6?=
 =?utf-8?B?K0g0eWQ2ZlNGODZmZFIyUVRINkwyNHVBbEtENEJ4aXZ3eDg4OXFDdGhtZnZ2?=
 =?utf-8?B?S1JaWXluaVJSR28xb21LUVNBcmlqT01VV2N4bmlCRmhZV1NCazZxdzVuOEdY?=
 =?utf-8?B?T25CZThoN2g3ZWpFUUYvU0pTZGN5Rnk3aWhmSFJham1YZzdzQkJ5WGV1TzB3?=
 =?utf-8?B?QmlScG9WbFhpaVV5dEpuMDl2dmpiUUFybVV4ekxZVzEyQ3BlK1NhdTdBMGlu?=
 =?utf-8?B?RFFDU00yNmdVcmFCYlBsYXVHR3VBQnpQWEcrWHZEejlqM0ZqODVPNFBrdFpr?=
 =?utf-8?B?Vm5JSU1FdHQyN2djQkN1R2pXNGtwQk9iRDlyWC9RSEJmQTgycmg5SXZDVyt2?=
 =?utf-8?B?K1A5cnhEdTdEVUUrTE9pMC9WbTNGOVRUeFV6NThTdVBZbzZueWJIbnFHN21D?=
 =?utf-8?B?T3VVZzZiaHk5enZvbURrVWE1cEJsVjdmbGkzSVNiamFFR2NzS1ByWERUM1kr?=
 =?utf-8?B?WW9XTFZkd1VuTFJCQ3czZndqSEIrZ04rTlN4ejloSDZqN2V1U1dnVUNNeU00?=
 =?utf-8?B?eS9sNUJsYzRHdjlveWhVZkhFN2Nra0xoZTFPOXVSZXpDbmR2STBVUnVGZElB?=
 =?utf-8?B?eERkcGtXeC94a2RRczVTcngwUFJTMDZRbkl1UWo1VEUxYVJDUlZPajlDWHNk?=
 =?utf-8?B?L0J4N0I0WHQxWjBYUkl0OGpSbGJmakJLdnFzRENNY0ZCNUtmclRvVVc5UkRV?=
 =?utf-8?B?MnNxcDFGNDl4NUp0ckU0NWp5alprUlEwaWU5RWpwWXphdktyUG52SHo4Z3B2?=
 =?utf-8?B?TW9GV2dmb1oySVVCTzJPU0V2K2ppeER1a0N4VVlMUmF1bG9xczcranNFc0FH?=
 =?utf-8?B?dTEzSzUvaUhUc2hkUDllZ2QxTEJyT2hkQ1dJUWNnZEpCaWJ3UmVmZzhiTVh6?=
 =?utf-8?B?L0VCOW1IWCtoclNqUDNZOTcyb1QwVEF6ZWFkdWQzK3pueStGWVd1dnRqZGEx?=
 =?utf-8?B?WFR1RndWekVxZzJvSGE5aFBjRTEzVTF1bkNvQTFUOC9vYlJzT3UvcmpMUmpU?=
 =?utf-8?B?TDlqWkdUa3VHcVhzU1YwU01IUE5uV1R4VzZoZll4ZSsyS1cwMzFqVVdMV1o5?=
 =?utf-8?B?aUVzZ1l1SlRhTEZzdXN6eUJGeUo5aDNBcFVCT3dScXIxMjZteGQ5YnFQb2R6?=
 =?utf-8?B?NDh6ZkVhbk9jdFpTU1pMVGxXcjR6azQ2dlZIUFBySHh0M21YUkpsUWszaE9x?=
 =?utf-8?B?NisyY2FaT3pZVWlQQTRkOFp4elQwbjdxN3JId2JTT01XQUJuQTFQa2txMSs3?=
 =?utf-8?B?WFlIek5VTmRFbC9Za0FBZytaT1Z1dS9PeVgvSE54RlBqeGFjcUtQbzA0MTNQ?=
 =?utf-8?B?dHhhblZKT1FnV0ozWlZKM2ozaStoYUJJcFZXV2kwcTJKSS9IYnkrNVBxdGM2?=
 =?utf-8?B?bC9uamwrODF5c0p5bmkvOXZMcTYxanQ1a01OdzRXcGVGVko4N01VSmV2bEpx?=
 =?utf-8?B?WkpscU9DTEdZVjRPNmREbGJKNU5HbFBPLy9WMHRWZ3FTSlRscDM1RDh1TFJM?=
 =?utf-8?B?eCt3RnBlS1NJTVBMU1JXMVBmMy9TZlE4L1Jmb1NSeUhyTGV5ZWNiZWF0cHNi?=
 =?utf-8?B?NjlkVFlGcmJ2ZFJXamZOMEZLcWF0RmxLY1I2SWRkUFpnZFIrTFhaSGN0eHZR?=
 =?utf-8?B?OFYwNXAzL2RTM1o3L2hZNitITDNZQml5NHJjalhwN2NNVEwxYmtZb3RIVmFa?=
 =?utf-8?Q?7O/rfnpB60NkAQrNMUYLqv2Sw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb5c95d-ac34-4e8c-2f70-08da8b38c09c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 10:08:29.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcO+o3LKxPUOcqeZqoAau37X3zSiWPZQQUrZTEmd5GrqNPJyjqZbsTSyr2UZvfFpatRCxsg8pdMFLHkf656XPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6175
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2022 5:15 PM, Krzysztof Kozlowski wrote:
> On 31/08/2022 10:49, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>> new file mode 100644
>> index 000000000000..90c5e354f86c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/soc/imx/fsl,imx9-syscon.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> One more - drop the quotes both lines above.

There will be dtbs_check error. I updated schema with:
pip3 install git+https://github.com/devicetree-org/dt-schema.git@main

So it is ok the drop the two quotes above? Is there
any new update in dt-schema that not landed in repo?

Thanks,
Peng.

> 
> Best regards,
> Krzysztof
