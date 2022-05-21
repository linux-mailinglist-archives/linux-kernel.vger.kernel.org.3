Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674852F83A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiEUEEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiEUEER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:04:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC901900F4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiTiDDjeN2yiLwtxYbBhxoKewHeFpbaUPC9CKZ3cu7zHGfEw8uU5G/kBLcJArga91FF93oP5GX9X4mbmONxJqOrQwLUkr6PjdQrTHMLZFIE8vjfutZnQEnR86EBfqocpOKHaiUPnL4500OLdFnboHZMMnSmbQOUOKdzHd8oB1aO5NaRRUTu2sVxYuebnv5IusOHKgsBwrhf/PyuHICU/LdPYZGGbRfP0HER4DFt2d8ipGsq8dNVJOcjeKrDrnSpRm2WK8g/9xPH+cJMfXV9/7L3XbDfEm3+rv1PwRtisvpAnkZS4vZpm69Zt3P/XYsCAFLmWe4qcp1DHZM8Hj+qJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0QK2NpAfnFa5m8rHEYhn5n0C0PhNrSh20Psuat4paQ=;
 b=E+lqdRULxlzgio0z3O3PgOtUKuy641zIpGMMQHAdYHRAUEe0CFR1UJjkOOYI3USmG4apcJ/34Pm5HHJkix0npNaj+Ddkybr6qrvTg+Z9Y5oxsACe/L1VX422Lziyh9+WKaGJrCz71atVFMnP1hd+A1dw7gLtqvBOue5fQtnYx89h+Ypvgh6CstxnzHy0AM/8I+6Ep5zQgRlBa2xUhrlIxpfX7QjNwnuuXxTBgfzvBT2sXixcsUkOB1CReT71VODlPxxDsfqGk80S+qfH4zUR0nxtdfiJyOBTGVxh+xw4Q2Ut7KPCRmLjT93NyDR0HpX4/fBH13IFMjuVFiDNWph4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0QK2NpAfnFa5m8rHEYhn5n0C0PhNrSh20Psuat4paQ=;
 b=nGA9m/RUv13kRR2mmJINpy1b+UiWL/G49D8VBoOpNUBUysjTQ98upMBDtAfL6HP/YsFmzXpLWoviuUYOjmVz/rzhQ4nnecXz/MIunJdDTunf2ry/zn9aP6FV3ciw4QXaraHK5dS53MF7Qa38TK3CVp49OkTULCrnPv7I+wIbmQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sat, 21 May
 2022 04:04:12 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40%11]) with mapi id 15.20.5273.017; Sat, 21 May
 2022 04:04:12 +0000
Content-Type: multipart/mixed; boundary="------------apgQKvJ1vqQpSThQ0TSN4Cki"
Message-ID: <8df16635-658b-b381-9a40-3544828910fc@amd.com>
Date:   Sat, 21 May 2022 00:04:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
 <YodIquufXzK581gw@slm.duckdns.org>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <YodIquufXzK581gw@slm.duckdns.org>
X-ClientProxiedBy: YT3PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::24) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6abd60ba-4660-492f-e748-08da3adef68c
X-MS-TrafficTypeDiagnostic: CY5PR12MB6058:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB60585210EA33D6D958EF63C1EAD29@CY5PR12MB6058.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6JXYxyaU/NR/VlyQVsNHefdaXyAhaL3GAGDpCfIrm62RJJAEL8J4Ap6ojQR7Vul4skRF+wEDApooALgUrbW6TpuzN4nnPqA4FbpGufUc19IlxYdaOZw5FD+gEPac5wNinT30hMCsbAp4Sy0bHbSNOcuceXDDsahzIpb701O+E8DgzKbIgN/bq+DuTfYy2p3wNqQ/324vvopQS8ri0RY38hDvEO2SL+6gjNtZ5ogbHhD5j5R0Vx4lCPdlYGAeGmtvbj89EY3n9VWP6/OTgdUxTNcQDWQ9SZ2eVQJBYmJcHU6PxyTRbJOaULnMgbB1jBPiTSGGojRwE7rMog7kg6YOEiXbAwfIX3+1EPOolLwtNloDjg1Vs9ZSWBWid8dvGKX+3N970/xI9tGxXVH61kCKWL4b+LZBELSdRqa4c9JGsCpFlhIV15rKDm0SyYmcC7OANm9F+WzrLm6dOO447tGYyIA8+KLUEHd5orxqIWoNFC8fCVWqCtfRbeccQnKTYCYY7cMae1FhkM7jpeTRa9GQfq55V4YM2EsD7GLhHmxFPkcEoSHcvsXHKOX2+G0q6gADHuLf1/5fWYouHIhwbtTcSRPF8ou1m+7FROhuqMmLiv982HJtHifYjKGKKxdoiVQV5IIMDFzmXVkugWuf5wtyVDeAo4DfOIPiZsFW0EHwFFxGv1p0I+7VMbrK8R3ebQtMQbW5ZegAXl+0qpkldh/izEiNClc2h3ABr5MewvdU5loSx8owtG4pmORSg9TSf4GHpPbmRU6TuIbJem5znHluhJ1INZGYYcM49vhNK3wxHX9w/+wu5be5XYPswB6bTi+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(54906003)(38100700002)(110136005)(6486002)(66574015)(45080400002)(86362001)(186003)(966005)(2616005)(83380400001)(44832011)(31696002)(6512007)(31686004)(5660300002)(8676002)(2906002)(316002)(36756003)(53546011)(33964004)(6506007)(4326008)(66556008)(66476007)(66946007)(235185007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJLTi9wQi9vdmJYUHRTbk9aakU1QU5NYnkzRDBEQ0hwM3V2Z2NFOGVlbVVh?=
 =?utf-8?B?LzNXK3F4cCt5SUFlZDAvTWpZQ20rbW1iMExKbUZXV2VHUmNyTVUrWXAvM3p4?=
 =?utf-8?B?V3dSVEpvNk4zZ2E5bG0zdXNIcy9hdVZsalB4bUZMd1dtZzIxeDBFTm5scnU2?=
 =?utf-8?B?SGdlazBISjFqcG1UN29xQlc2V0VYRUdaT1IzR2REU2dKeWx4RHhvUmlpVnNj?=
 =?utf-8?B?VFlvNzZuMEZHOTNFVEJEU3JsK0szMDQzbjZEQ1FZT0R2ZElmUmFQOXREY0w4?=
 =?utf-8?B?M2lKNStFVXBCaU4rL3FESFJoYm1Wd1NkcjJLT1RGaGJWWVIrYlRHMjk2UlRh?=
 =?utf-8?B?ZUZZZDA4Sm11T3ZUT3lvaWZhclBobXowSE83VU84ZUdGL0JQQ24xVzBSRGlN?=
 =?utf-8?B?SERqejBhSjhUNnBoSGtUdzVweXo5QUdhbGs0V1RYS2sxWk42bm5pRU92Wjk1?=
 =?utf-8?B?dklkVDJSbXdjTDVScEJUVGJyZ0YvQ1lYWXFNYmg1cVdNVmpyQmlSZnNRaGhV?=
 =?utf-8?B?WFJ0U1pFeGdKcGFWUzdoSytpTXloTXdoSlgyUWJnaHFuVk8wUWlsZHNqY3NW?=
 =?utf-8?B?NVdrbm5vTVRBZE10NnRsd0xqMmEvZWxPTFJhR0tTMXFZby96SFhJVVFia2JS?=
 =?utf-8?B?RElTc3RXdjNka0VEOEg4VDlXRzMyQU9sd05yVWM2ZVVSYm1YNG1CeWxFeFVK?=
 =?utf-8?B?c3dzTW5oNFJmVnRYT0xQT0llK0o0SS9hVGNTZGw4WFJ5RVNJZzIreDRQdm5F?=
 =?utf-8?B?V2Jjakl6d2dWYzJGekhNOXM3OSttSjhYSnZTUnpQSGE3elk3UGdHUk55cXN4?=
 =?utf-8?B?Ylcxam9rOHJHYVlOcmZ2eGpWTmpDNi9Bdi84WHV2K0x0VnU3NEJKbm56Qzlp?=
 =?utf-8?B?a2w0ZWtKcStPS0FjZU04UUw3alF5QTc5MlF5aDlsZURvejY0SndHVGV6V1k0?=
 =?utf-8?B?UnlxWE51QnVuWWRRSzhuM2RQUnVmdGc3dy9DbGs1Z0V3Y0liS291ckFreE5E?=
 =?utf-8?B?SEw2M0Z5bnJGQXo4c01GNVpOZUpsaUtyUXlGaW0zdXJ3WDFySlNWSHp4Q1ZP?=
 =?utf-8?B?TStFbVNSb1RmdW11akNsWVBBcllDYkxWRTI5cmJoV0hmeXBoeE13OE51c3Q2?=
 =?utf-8?B?MVFvb0JPSFFObzFwV3FYWHRUeEc2eEVVQW4waHNWQW41empzVlRuTzVrVlk3?=
 =?utf-8?B?TnVCdGRlUGdRMTdKZ0hhbVM2bnNBMW5MRmlGOUJIUC81U0l4N0xXSDkxRUt3?=
 =?utf-8?B?cHUxdzZlaGVsbHJpZllaODd0TmF1STVBRlg3d1UvSkNCdWN1MXFwalpJSjNy?=
 =?utf-8?B?NFlNdWQ3RXk1V2hpbTRDYzZWNENLYlZMTUlPaHh2cnBreEx5eWV6S01TaXE0?=
 =?utf-8?B?K1JPZDkyNFRBR1NPcFJKZFRlM3lCZVpheXZUeWVJa3kwYW5HbVIxQy83eExR?=
 =?utf-8?B?di9mc3hpZlFUTkU1RDRqTk45MnZmdXFpZG9EdXVlWkdFcHRkaTh2L3VhWmNY?=
 =?utf-8?B?SVdrTFAwTWN1ZHAxYXQ5bURqZnRNRXkzZWFHeUdHS1FjUlB1T01CNXRpVmtD?=
 =?utf-8?B?UnUrNytIR1RtNjNUWWlVY1Z1WUhTZURYNlRteFRDcmNVbnZZSGpMTUhLbVd0?=
 =?utf-8?B?cCs5SS9JUUlGbG1Md2RnOE1xQnpJcXZpdzFzTnRCblI1T0psTkQ1bUJsOUtV?=
 =?utf-8?B?ZXpseWVNRUhJaHZOazk4OVJEbVB0UXBkZVZST3d0elNoTStMeXFLZVdZb0hS?=
 =?utf-8?B?L0xrc0MrRW1uVDVtd0p3UzRoU2RTOTNuMHJ0a1FscUsyc2YwbVh6UStJU28v?=
 =?utf-8?B?NmZJMUZERHUwdmNqNEhnMkg4UzBabFRuRmI0cTZtQzZlQWs1M2NYelNqeVRu?=
 =?utf-8?B?QWNSTW5pc1R4YUFnQ3RHT2lwY3VyaUtrdDNKTlBMbVZ3R294dFcvV084aWZM?=
 =?utf-8?B?cjJGNHFDVHljUlBlc1NrRGRXOTBuN240ZDlCRGNpYlpNNWs3QmQrdXZaTFR3?=
 =?utf-8?B?TFYyN215Sm1xc21JNGFlN0JpOXpOTHRacFpSRDhFaGV6VmZpM1ZnN214OG1v?=
 =?utf-8?B?VGMrd0ZsRitUbGlFbS85c0dKQlNrRHlNeG9mQ2ZWM2xnYXdET0NIOURNNm1v?=
 =?utf-8?B?b0pITnVoMHJFOHVqdm53Njk1dmpteVRybkRBMysxQWpFTCsrbnRvaVFidHIz?=
 =?utf-8?B?bWZVZUQ3a0tRRm1KZ2IzQnYyeFYzRVk5bDdZMWowZ2FVMFBNZnlEeXJQYnVv?=
 =?utf-8?B?YjJrT3l2WkJKYTdxODJMT1B5OU1PZVQ2OEU2cnZCRndSMGRub1V4cmpFdDFN?=
 =?utf-8?B?WmhsamdoNW5YWkErU3lPS2NpMnB1VjBlbjJ4Rzk1QW1JTTNRRDJNcFZMWDUv?=
 =?utf-8?Q?mlxftnm1BCjNcWbvfhNiDuuq8GwXJSMN0lhsrBT++scyp?=
X-MS-Exchange-AntiSpam-MessageData-1: 4eBF5FTdDrADBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abd60ba-4660-492f-e748-08da3adef68c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2022 04:04:12.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4AoaQAYjUu1fiO2fihTAxC8xr9s3abqgCPLFbIZ7niI12EoOg15LOQqd4eMe0i/hCPuN16jpxYbGfcGADm/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------apgQKvJ1vqQpSThQ0TSN4Cki
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2022-05-20 03:52, Tejun Heo wrote:
> On Fri, May 20, 2022 at 08:22:39AM +0200, Christian König wrote:
>> Am 20.05.22 um 02:47 schrieb Lai Jiangshan:
>>> On Thu, May 19, 2022 at 11:04 PM Andrey Grodzovsky
>>> <andrey.grodzovsky@amd.com> wrote:
>>>> See this patch-set https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg78514.html&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7Cb25896b7e8b14e605a8d08da3a35a7c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637886299388464620%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=TRabWQQrhy6nwkLfuXI4A%2FOcF9f%2FtFKdxIRfGc8Das4%3D&amp;reserved=0, specifically patch
>>>> 'drm/amdgpu: Switch to delayed work from work_struct.
>>>>
>>>> I will just reiterate here -
>>>>
>>>> We need to be able to do non blocking cancel pending reset works
>>>> from within GPU reset. Currently kernel API allows this only
>>>> for delayed_work and not for work_struct.
>>>>
>>> I'm OK with the change.
>>>
>>> With an updated changelog:
>>>
>>> Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>
>>
>> Good morning guys,
>>
>> for the patch itself Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> And just for the record: We plan to push this upstream through the drm
>> branches, if anybody has any objections to that please speak up.
> 
> Andrey, care to resend with updated description?
> 
> Thanks
> 

Just adding here as attachment since only description changed changed.

Andrey
--------------apgQKvJ1vqQpSThQ0TSN4Cki
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Revert-workqueue-remove-unused-cancel_work.patch"
Content-Disposition: attachment;
 filename="0001-Revert-workqueue-remove-unused-cancel_work.patch"
Content-Transfer-Encoding: base64

RnJvbSA3OGRmMzBjYzk3ZjEwYzg4NWY1MTU5YTI5M2U2YWZlMjM0OGFhNjBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lA
YW1kLmNvbT4KRGF0ZTogVGh1LCAxOSBNYXkgMjAyMiAwOTo0NzoyOCAtMDQwMApTdWJqZWN0OiBS
ZXZlcnQgIndvcmtxdWV1ZTogcmVtb3ZlIHVudXNlZCBjYW5jZWxfd29yaygpIgoKVGhpcyByZXZl
cnRzIGNvbW1pdCA2NDE3MjUwZDNmODk0ZTY2YTY4YmExY2Q5MzY3NjE0M2YyMzc2YTZmLgoKYW1k
cGd1IG5lZWQgdGhpcyBmdW5jdGlvbiBpbiBvcmRlciB0byBwcmVtYXR1cmx5IHN0b3AgcGVuZGlu
ZwpyZXNldCB3b3JrcyB3aGVuIGFub3RoZXIgcmVzZXQgd29yayBhbHJlYWR5IGluIHByb2dyZXNz
LgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFt
ZC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC93b3JrcXVldWUuaCB8IDEgKwoga2VybmVsL3dvcmtx
dWV1ZS5jICAgICAgICB8IDkgKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3dvcmtxdWV1ZS5oIGIvaW5jbHVkZS9s
aW51eC93b3JrcXVldWUuaAppbmRleCA3ZmVlOWI2Y2ZlZGUuLjllNDFlMTIyNjE5MyAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC93b3JrcXVldWUuaAorKysgYi9pbmNsdWRlL2xpbnV4L3dvcmtx
dWV1ZS5oCkBAIC00NTMsNiArNDUzLDcgQEAgZXh0ZXJuIGludCBzY2hlZHVsZV9vbl9lYWNoX2Nw
dSh3b3JrX2Z1bmNfdCBmdW5jKTsKIGludCBleGVjdXRlX2luX3Byb2Nlc3NfY29udGV4dCh3b3Jr
X2Z1bmNfdCBmbiwgc3RydWN0IGV4ZWN1dGVfd29yayAqKTsKIAogZXh0ZXJuIGJvb2wgZmx1c2hf
d29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspOworZXh0ZXJuIGJvb2wgY2FuY2VsX3dvcmso
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsKIGV4dGVybiBib29sIGNhbmNlbF93b3JrX3N5bmMo
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsKIAogZXh0ZXJuIGJvb2wgZmx1c2hfZGVsYXllZF93
b3JrKHN0cnVjdCBkZWxheWVkX3dvcmsgKmR3b3JrKTsKZGlmZiAtLWdpdCBhL2tlcm5lbC93b3Jr
cXVldWUuYyBiL2tlcm5lbC93b3JrcXVldWUuYwppbmRleCA2MTM5MTdiYmM0ZTcuLmY5NGI1OTZl
YmZmZCAxMDA2NDQKLS0tIGEva2VybmVsL3dvcmtxdWV1ZS5jCisrKyBiL2tlcm5lbC93b3JrcXVl
dWUuYwpAQCAtMzI2Nyw2ICszMjY3LDE1IEBAIHN0YXRpYyBib29sIF9fY2FuY2VsX3dvcmsoc3Ry
dWN0IHdvcmtfc3RydWN0ICp3b3JrLCBib29sIGlzX2R3b3JrKQogCXJldHVybiByZXQ7CiB9CiAK
Ky8qCisgKiBTZWUgY2FuY2VsX2RlbGF5ZWRfd29yaygpCisgKi8KK2Jvb2wgY2FuY2VsX3dvcmso
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoreworCXJldHVybiBfX2NhbmNlbF93b3JrKHdvcmss
IGZhbHNlKTsKK30KK0VYUE9SVF9TWU1CT0woY2FuY2VsX3dvcmspOworCiAvKioKICAqIGNhbmNl
bF9kZWxheWVkX3dvcmsgLSBjYW5jZWwgYSBkZWxheWVkIHdvcmsKICAqIEBkd29yazogZGVsYXll
ZF93b3JrIHRvIGNhbmNlbAotLSAKMi4yNS4xCgo=

--------------apgQKvJ1vqQpSThQ0TSN4Cki--
