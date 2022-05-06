Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233DA51D997
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441892AbiEFNvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiEFNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:51:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE2F5DA14;
        Fri,  6 May 2022 06:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZdM8i/5GJM7VGsTx7W8by3ZatiA838u2DL8zX+fEI4fmqOBarPeJR6M+K4P71ypElhrWamtq5yFSKHlrX6wqddslkiinRHUp4USpbBqmXNVrmOIrXmI6t7kJ71nvR3kxbjz2bpXNTEldcT+wdl14ki1dKAS/zOmN5vT5yLhIOMX7F6cJKkyx+nKO84N9MhIy/G3bshq8w+DHckn30pqtpecOIYzVvQ0mgyWIWUxMV7nQe1gxfCWwXZeq02A0HtQAOjoHBZT5dOcb2p1LYxZ8ljHdARVzlrf+y7hDrDstOIxYpwUc3C5T3Pjwr2oN4Wz1tH8aFKluHhh4IOhtJRBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkLcWO60FZxfjJk4OrvbouWq5KiU531844sLG+DRZVM=;
 b=i44dKAcopF5S8b1rzUhmLd0qXwCwEOGe5vofg42P/ORWsfkbyF0GgYOU/4FPGbzfYrIChD2QEAAtpbBnQVHnWWUs3WnvvCa3TrI2Iv6lYPHXaceflRG87XSeWv+ly8bQoEGa3wyQN1/V9NJTXHU1KiY4Lf5IjHHLSFzXrpqt46S1IYszqe04TxI4jwbsgrjdjD+YbRc3Rlr65XPUjUBTS81HORNM2/YWhauQLV0LlovdyJtEOq7JQ2EuniJpzXnT4PohLpYS4xugazElB8obBC8g3q2S7Q/3Pb3pSAEkuJiQyeT5ILLKrJ+fkQbrywIciN/cLh2yMSaE0v5u+vojqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkLcWO60FZxfjJk4OrvbouWq5KiU531844sLG+DRZVM=;
 b=ZKSAEV3q0le/tO+ZXqj1S1QAiJTDbAgAfUBFAGP7yne6+P99eNItEtJKE23GyrOujO5TfGJrDXVWECrAJ/DX3+sd+TfXmDxHX1W9RKj+/pO1ij+4CEdtuWST4fyMwNc0ZO2uW24av6UyMGl1gGBW828KvR+h+qo7KMhoxK0w5O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 13:48:02 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::28d3:b4fa:2319:83fb]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::28d3:b4fa:2319:83fb%5]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 13:48:02 +0000
Message-ID: <889135d8-575e-3f95-4c65-ff3c40f64b05@theobroma-systems.com>
Date:   Fri, 6 May 2022 15:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/3] media: dt-bindings: ov5675: document YAML binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504135543.59522-1-foss+kernel@0leil.net>
 <18d1032c-1fee-9de5-bd25-752ff9c39200@linaro.org>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <18d1032c-1fee-9de5-bd25-752ff9c39200@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0721.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::7) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bec18f8-fc7f-48d9-c81d-08da2f6709cb
X-MS-TrafficTypeDiagnostic: DBBPR04MB7962:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB7962B2589DBB75EE05A80607C2C59@DBBPR04MB7962.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XcUISWDyt61EG1EhuDRsZ/mEPjILYkK7E8vGpaRzM0+7ld+YGUOc0b57E4uZn8uURpFPgsKY0CKwrgpvTePLSyOr2Oj9QhnlHVyBm/QFeeLNostT2QSQJxSf+1RSXZrOtGyPM26+T2M5Lv0h1kSrF3HDDzmh9yPvsr65q+jFr4mM1Aus8gnwDqm6DXjKeLyFQ7ROby92Oh/lwiyUXf6wWxB5AxbJT7/u/zDmH68+Uk+J3tcRH9qHL1CWXEAd/ycLVTAttGk8oaKD5OlQAhOj5dSYJ1x9eSNkMA+jVvuiRXvE+LYTQS2aULAGVyF5P304ovTknhQDxiXKDf5PvYuKKwYDe+U70IHoeuq5BGsH85MjJzpwIhYrsf1prybDtgrxmzGumeYjSXu2tr4rjGCqr3E4B0Yqw5Aa79ZGBkXNB2OH1KEoYUuXrxSJ+B27BTjeaLe0RHRNPKKDDBM+f64/nIptEAgJGacvejAAr+mxHolTcB//4Yl20VEwWfwqHvDpBwxQjLhXAaS/1o66HAAbWZSEfhrXZUsHtLGz8RM6KmRFbPWjVeUbgI3SDxcPSr6WSVyfhNXw5ow/W2ycMjXX+nL36ZqXqUyNO8uJCAkiQ0NXIO1ERoTzY1BF8XPuMbHcbAuMWICOzM3KMqBeufUnVfqUGLvaknHOmLxKJte4DYuY9Oi0sqgkJaaySr+PL2vEIw9N+GrBN0ZMF+Gr0U4bHR2HiVw+u7YOXztP5fT5Qenocf1RjtTrh8gVS6qEZmQMeF2a+weskf/FUg5XePe+9OY9b8cGrwY8sdyyyjzx8uV3bNiMpEOougiZEQRL2V5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66476007)(66556008)(6512007)(26005)(31686004)(53546011)(6506007)(36756003)(8936002)(2616005)(44832011)(186003)(2906002)(83380400001)(966005)(6486002)(508600001)(38100700002)(110136005)(31696002)(86362001)(66946007)(4326008)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHkveXFYNk4wWUR2WGg3dDlUSEdBZW1DMXdNcHVPL25mOW9ZNng2UVFCS0px?=
 =?utf-8?B?SWFzYWFEOWNDb2I3NmgyVmVQS3VwUVh4QkQ0anRpY3ZkWkgzWTVoR2txNVRw?=
 =?utf-8?B?MFkvbGpLK0VTM091bFcva05TR00xd3d3KzVPK2NjM2lZcERaaHh5TWFKcHRH?=
 =?utf-8?B?Z0JrdnpzSVNUTWFUdjB0SE1kZnVDWW9wRnA3ZFF0ZDlvRGxVRWtGOXMzVXJW?=
 =?utf-8?B?VDZEbUwrNW4zY2lyTmZpOHBZZ0F5V29lK1k3djhuQlR0bklzSTN0YVZEK21x?=
 =?utf-8?B?dldvUVROT3hqcFEyK2lCaTVQRzFibFJkek1WKzhBVUVIa0hJUmI2ZVY1dVI2?=
 =?utf-8?B?SUdlUWhoZ3ZNUXJUdnN2dFNoQmRjcFptZU42MTlYYnovc0x6TjZvcmVnTW1j?=
 =?utf-8?B?dE9QSTloRXdqSjZlRUdJT3RiUXF3TmxyY0Y3T2wrZFc0Z2V4ZWtCS2hZRmtT?=
 =?utf-8?B?OExXTit6ZHp6TGpRQzF2eTZkazJXd0RhNVBOdUQ0L0VsZXRCZkdWQmVuR2s4?=
 =?utf-8?B?aCt5RHIxdUtLU0ZzZ3JrR2poZHAzbWNDMm5CRGZGNXM2dm85aTYvczlBdStO?=
 =?utf-8?B?eVNnd1dVVzNpenk1d21PQXcrdnM2RW1BaTV6NVhnQ3dxc05pSExLRm5yVXEz?=
 =?utf-8?B?dGFWT3VUWktxY2dTNHhYZDR4MGRaYUVtVENmSVA3SUgrWitDV2JiMEZraS9X?=
 =?utf-8?B?YnU3NnRpZHFheU94UXF1ajBrT2FtOG54Y0lQTTZ5anVFUE5pQ1FQYjl3Vm52?=
 =?utf-8?B?Zm42NkFFNmpZSjZITlJhVnIzck45OUJSWG1VbWc0SkQwaGVhYzZhcmRLVHFh?=
 =?utf-8?B?MHVjc25mb2lmRitIOThPQzZhL1lzUmJVZU9TbGxxOVd2YUdnbnNybTlvbTdr?=
 =?utf-8?B?cnhSS1diUnVMQTgyQS9QTE9CbjRxNnVLNEZrWVBucnQyNW9VZ2pCd3kwVTMw?=
 =?utf-8?B?Qzc2RDc5WForS3pZT2w0R2FXK0prZmV0WVljbmZFTWtqdVpBNUNnOFdkVTYy?=
 =?utf-8?B?VmZFc2FxME5oMmp5T2JUTER4dmgxeUFlV2FQQkxLY0xkeHRTRkZ3RlNHekF6?=
 =?utf-8?B?RjJTeFB4akVNRmE0VzZlZERCUmZJeFlEZ3JTYXdacjNlcndzVjhYVitOT1V0?=
 =?utf-8?B?cVRwOHY5ZjhBVm1QaW40OHlub1JHL25GV1VDVnQyb0dIZTFuZEpGK1lYRTJB?=
 =?utf-8?B?WVYweEk1ZkIxQWoxWXJWWlBNVm1tQjZmVTRHUW0xdjZYL0dmZDRwenpidWgv?=
 =?utf-8?B?Rk03MTZNem00UlZQcFgvbkFNb3VYdTB2NFloTW13QThNZmlGeEJJY1dQdjlr?=
 =?utf-8?B?dWZPMWliOU95YjVvZ2hUeVE2QUFNRnRYN0lwSEdEWHV1ejVqc293OTdGR09q?=
 =?utf-8?B?MG5rbG5SdzRLTUxVbXNCRHg0S2VJbDhiVTNpd1QwME15Qlo0RDJUVGVBeW83?=
 =?utf-8?B?RVVyUGxjU1J0UzF6Q2xuTlAydGRGQjZhd1JHNnNXdmp5MG12TkZnMHF0Zml1?=
 =?utf-8?B?dmtDR3dTNFRUQjJoTUlnWGFLamhVZllOUWxRZFhkOExzYjl3K05INmh5QVdo?=
 =?utf-8?B?b2ZValZOYmJ6cXltdkNHVjVENEd6bjFGUXFFZllOSStZZ1JmUjFCSXIzWVBi?=
 =?utf-8?B?Tk9EMkVxV2Nrdmp0amNzQjBvZk9CdTRJak1XeFl2cDgxSzJ3ZC85SlUvcnl0?=
 =?utf-8?B?Mng0VUhzSmhSMlVKazZvTVpsdnl6L2ZINzRFbEZvWU84blRHcHFZM3ExYjll?=
 =?utf-8?B?SVVRcXlkTTdxR2FaRmJsV0IyMmZvODlNUGtpNkJIdytEWnIxNnVFZ1UzbjNj?=
 =?utf-8?B?alNad0pVanNnTjRITzZIeWs2K0ttbnAyaTdneU5aRWY1d0RaWi9kZW9oTFFz?=
 =?utf-8?B?SitscDlKdFZzUDJZMk03U0V1YWNZeGFNRmQxMzV5ZHg3cEZJVHpNTjdyK1V4?=
 =?utf-8?B?TlpSOVRVL2JVVm9tY0s4bGRCM2pmNTEzWVh3YjdUZ09JVHl4eFpTYWxlZ3BQ?=
 =?utf-8?B?OXg1TW1GaVVEUkxiSjBYdVR3cGErWXpmb3hJRE1ZVGw0Ujl0endFcDVEQ0Iz?=
 =?utf-8?B?RVMwbUR2emk2SitRNmdDdGp4eUMyM3gyaWtEem5DK1orN3RSVmpkQlZkSU05?=
 =?utf-8?B?Qms5S3R4RFZ6MkU1bDhncWd3d0t3eGY5Nm9hNUM5UVcrcEpnRUxaY2pjaFVD?=
 =?utf-8?B?NGtRUkJQcnMxN2podktPQm5FV05tN3VyV0pDWWVPZHYyR2Y4Y3hPVXdPaTlN?=
 =?utf-8?B?bXNUMURObk9tVE1zRGRCZlpKQ09EMW1WeWRteG9OUWhUTWJUWEJoa0EzVm1j?=
 =?utf-8?B?RjZ1TjVSZ0d2cjhtUHRQa1FhZjZxWTE0ZlB1V1hya0hOM29ScG5XMFIrY0FZ?=
 =?utf-8?Q?kqcVLVW1HEICmOhGI3jFPzQE7DHSwbqZO/7KX?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bec18f8-fc7f-48d9-c81d-08da2f6709cb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 13:48:01.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4jkn8VXgGwWIXeal8/t/pFxojCWuW39cgx+KNrhljzSKYvrwmrExJazHLFRjvdFEdMcyNvg5ZRQ/ublUMN1TAGsCEs3MsFCSXbewWESF8hWhVP9a1sZTdualO5kxKoD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/4/22 16:46, Krzysztof Kozlowski wrote:
> On 04/05/2022 15:55, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> This patch adds documentation of device tree in YAML schema for the
>> OV5675 CMOS image sensor from Omnivision.
>>
>> Cc: Quentin Schulz <foss+kernel@0leil.net>
> 
> Don't Cc yourself in commits. This goes to the Git history, so
> assumption is that the "other you" knows that you sent it. :)
> 

It's a habit I've taken so that in the event I switch jobs, there's 
still an address where I can be reached.

But I forgot the kernel as a .mailmap :) so I can avoid doing it.

>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>
>> v2:
>>   - fixed incorrect id,
>>   - fixed device tree example by adding missing dt-bindings headers,
>>   - fixed device tree example by using vcc_1v2 for dvdd supply, as requested
>>   in datasheet,
>>
>>   .../bindings/media/i2c/ovti,ov5675.yaml       | 139 ++++++++++++++++++
>>   MAINTAINERS                                   |   1 +
>>   2 files changed, 140 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
>> new file mode 100644
>> index 000000000000..29df2f82c631
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
>> @@ -0,0 +1,139 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
>> +%YAML 1.2
>> +---
>> +$id: https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_schemas_media_i2c_ovti-2Cov5675.yaml-23&d=DwICaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=5gh6rUPawGp8Fw7sPXVsvOViSUSnEVGWWB9RK_CSQCeBjoEfunHaI0w2GiB0zjq_&s=W_iQiFCa2XM4k350eNawjzJR2ZTUuSx-VM4E1iuknz4&e=
>> +$schema: https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_meta-2Dschemas_core.yaml-23&d=DwICaQ&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=5gh6rUPawGp8Fw7sPXVsvOViSUSnEVGWWB9RK_CSQCeBjoEfunHaI0w2GiB0zjq_&s=nrri3o0sr-6AopqJCaHZ94dUfOwS8r1V7ybfSwD7v2M&e=
>> +
>> +title: Omnivision OV5675 CMOS Sensor Device Tree Bindings
> 
> s/Device Tree Bindings//
> 
>> +
>> +maintainers:
>> +  - Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> +
>> +description: |-
>> +  The Omnivision OV5675 is a high performance, 1/5-inch, 5 megapixel, CMOS
>> +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
>> +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
>> +  Serial Camera Control Bus (SCCB) interface. This chip is programmable
>> +  through I2C and two-wire SCCB. The sensor output is available via CSI-2
>> +  serial data output (up to 2-lane).
>> +
>> +properties:
>> +  compatible:
>> +    const: ovti,ov5675
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    description:
>> +      Input clock for the sensor.
>> +    items:
>> +      - const: xvclk
> 
> Just "xv" is preferred.
> 

The name of the clock in the datasheet is XVCLK though. Wouldn't it be 
confusing to describe HW by using names different from the datasheet?

>> +
>> +  clock-frequency:
>> +    description:
>> +      Frequency of the xvclk clock in Hertz.
>> +
>> +  dovdd-supply:
>> +    description:
>> +      Definition of the regulator used as interface power supply.
>> +
>> +  avdd-supply:
>> +    description:
>> +      Definition of the regulator used as analog power supply.
>> +
>> +  dvdd-supply:
>> +    description:
>> +      Definition of the regulator used as digital power supply.
>> +
>> +  reset-gpios:
>> +    description:
>> +      The phandle and specifier for the GPIO that controls sensor reset.
>> +      This corresponds to the hardware pin XSHUTDOWN which is physically
>> +      active low.
> 
> Needs maxItems
> 
>> +
>> +  port:
>> +    type: object
> 
> Open other bindings and compare how it is done there. This looks like
> /schemas/graph.yaml#/$defs/port-base
> 

Did that but used an old kernel as base :/

>> +    additionalProperties: false
>> +    description:
>> +      A node containing an output port node with an endpoint definition
>> +      as documented in
>> +      Documentation/devicetree/bindings/media/video-interfaces.txt
>> +
>> +    properties:
>> +      endpoint:
>> +        type: object
> 
> Missing ref
> 
>> +
>> +        properties:
>> +          data-lanes:
>> +            description: |-
> 
> No need for "|-"
> 
>> +              The driver only supports 2-lane operation.
> 
> Please remove references to driver. It's not part of hardware.
> 
>> +            items:
>> +              - const: 1
>> +              - const: 2
>> +
>> +          link-frequencies:
>> +            $ref: /schemas/types.yaml#/definitions/uint64-array
> 
> The ref should be already provided by video-interfaces.
> 
>> +            description:
>> +              Allowed data bus frequencies. 450000000Hz is supported by the driver.
> 
> Again, skip driver reference. However you need to describe the number of
> items.
> 

Currently, the driver is limited to 450 MHz link-freq and 2 data lanes, 
while the HW advertises: "The OV5675 supports a MIPI interface of up to 
2-lanes. The MIPI interface can be configured for 1/2-lane and each lane

is capable of a data transfer rate of up to 900 Mbps."

Was wondering what I am supposed to do in this situation as I see 
Documentation/devicetree/bindings/media/i2c/ov8856.yaml mentioning 
driver limitations in the dt-bindings.

Cheers,
Quentin
