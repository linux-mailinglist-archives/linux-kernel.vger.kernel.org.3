Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A1588383
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiHBV1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiHBV0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:26:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61402638A;
        Tue,  2 Aug 2022 14:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUSHqyz2ShfMRo3Oej7+uYr1W1PWPowOiPcmWiO5n2MpDV0NhdqnlWt4agq7wLACP7iwA1+IhBZnetbf7DrCF5xw53sTDBuBB+kLQXRrVtxgo29OWlBR0GYnFgUzy6SNN7wxtOBkGu9MvOmPWd6JtzDQnjUY58shFQztg6QIs+spV0Ngr/bIGr1jAYvDTnW7qoZDyEFOSHO8W6xLh7GZeZePGv6y4T9o06dWOCy2WZLCPusNh0MLOSGQZ9XpIdGIQWYSOwfpHmG7FylO+Z6ZRx5xtS04SKOWoEy0CNkwF+sxr/zLeMSMKn8qtuRI6PB/Q6lTdgwl9cX9vZw0sTsnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWMVzIa3MsonwoTA4zmKlX8CudrOmMoCK7RcdG87xM4=;
 b=HdWBaWyVwlEDi8qSBlDQ7Qgbjy+XCs6kq8uvkRodjvocjM2Zab6SNXUv6me+8CEVT+TZMtw2n1mnZdT9pKmyi/5wHcYUHYweMVx+RZM95uiwNs8taFmkVa3vMkpEgIl5rJ+t+/8aTru7cwAdH8OVvYbCnmRQimfuWxmwE6DS4UMVON0jEIgs4ap2rFKBT6NLfVpw4wLzc2sbHaTI/LIkCkpuO74JFCamjTRjwIA0kXBjsGAl5gIf1KktC5ekeZ7c2UH88kDMUtpnrNxpMK64rIowRqE44epAWgvTSYVlm0sKzdrywh5moyCq6TYlOsSXNCHigOtBjpw/Ubicpb/bbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWMVzIa3MsonwoTA4zmKlX8CudrOmMoCK7RcdG87xM4=;
 b=tBa7oY9wwYbll/5ikfSdpbsARzuUewl3u670PBXFPnYgU6Nb68Ow1gPn1017S1QOfx1ckIIw2FJsf2xWJxnP4bZUADzBMgWng8IiMJhn8WeRoswdtQJjxHuAe7ueF2OdE/ClsBPcymbcAOnv3TQyJ0mzc10uGb4JMD99dNbq9nhVPx15xzxHIxyjvZ+XD27OkYzbbDav7J6FLPISZUd5Ia5QyrT/aYxuZn3fPApBdByoAsK72FYlpfCISlCeRmBR+70nCXCs3IC5WEcqSiG00Pra8nEztKZvOMHMZBtFkmzAWw+ZWDtITHc6dO0yq9yusKWPnZqps39QnSKxMy177A==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by MWHPR02MB2414.namprd02.prod.outlook.com (2603:10b6:300:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Tue, 2 Aug
 2022 21:26:36 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%8]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 21:26:36 +0000
Message-ID: <BY5PR02MB700935025EB9A40B9E43CA48EA9D9@BY5PR02MB7009.namprd02.prod.outlook.com>
Date:   Wed, 3 Aug 2022 02:56:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-common:
 move common nodes to a common dtsi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <BY5PR02MB70091276EDE0CE4FCB6CFBD5EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <20220801185304.ozoydbmbgqe6fqdy@SoMainline.org>
 <822b24fb-add3-b49f-d64e-15b577929edf@linaro.org>
Content-Language: en-US
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
In-Reply-To: <822b24fb-add3-b49f-d64e-15b577929edf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [6QBWqs77HXsvBMLNOVfciWEYlmash8XqXl6eBPQwlnZkXwxab9Va1K1h5KkQDe1u]
X-ClientProxiedBy: BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::31) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <b736fca7-3efa-faee-02fd-8203fa0f87f0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0e223b6-431e-44f9-03e2-08da74cdadc2
X-MS-TrafficTypeDiagnostic: MWHPR02MB2414:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMWkQUKqqB3K5V6Jugwzkn6vrbCcRdphpyQV2fKtnnN6OquU6hB2z4zSRA3Q23I/zNeRiFQpkIOpjiqr7+08x1eiiFSiBqBp1AEu5Y7MxYcOSwSuRrF2TdlIWNt6fvHTt89uYXkZxCIlG13hSehbtw6z9mNhlf0OrslsBGmTzSL4Y5yNGVDQGj/Yk5nPr+w3rDXdriUyqMdCCYDYotg2M5dbGZD/bHpyPLvE158Sz+nPQ0QXtCLEV5FObaIwfc7KOMg3JJtqhJzUIL2J2yTlDK7EE1qeG+hbKpGpCLnZo6RUV8Ni+lsygTfiWmtm/ZHmZfDJhsmboklXWsdlaLYwaL17DUjohHjbXX1Zwf0QQVoaRGrMyxA6YO2kJVeOWA5vYTIOyceCtAMcs+e9upSHnKEOCD13zAoy6vyWCNJ5BV0PNEIXIVbqTPAO78+QCrvhC/A4Lc0dx7InKtxVDTdgknK7Ulr29XLU/0xFQy3zynh/48nRIJg1KLhmu3mgolJCDnhKw3NWiE8y7a6djDixFX9jZPA5GZoklsTdqkVMgAXH93/x1rWfbEbSOw91V3zLHdGXK144NK7CyABJAQ8KKC1LFFmYTCtk7pmMgGGhe0AzNcw0s6AQuS3fYo/lAiSUtJCxBYH2T6MDzlGCTtOE12ykZn56ozziRfH9ifg5iD6Oa5Myi4Hb7NOyApGP8oJA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUM2clRoSUFrOHVseFNQa0JHcjJLeHprdThOaWZyV1Z6LzI4eHJwTXFLemMw?=
 =?utf-8?B?Q2diK2xUemFhRFhOVUJPSWYyQ3VHbUI1RmxPVkp3Wi9TZzMyYi9rNS9JbUFq?=
 =?utf-8?B?cDV5eUdGM1pWS3RTNjN4Z2xYWllGSEFtZ1dmMmR0RldVTUtLVVVvek5WSkd5?=
 =?utf-8?B?VmhLK282czNpVmFHcnlscXlqSWprQUN2cUJQckIzV0VJa3J6S1VxQ3ozYnQ2?=
 =?utf-8?B?UjVkZElxWEVpR0lNSEtqTXhWSTByekJ6eFNDVVpRY01KVVNZVDhVUTFkNURp?=
 =?utf-8?B?YlBldXJZR3ZKeS90MWg0QnlSU1JQQmpnZmYyamVGQmxjb0hLRTBqbStnWEJS?=
 =?utf-8?B?VWdnTXlleFBUYWtkQ2cyL0dzQzFldTg4UEcvZnBBd3VrTEdFWURlRTgvdkZh?=
 =?utf-8?B?QnNlZGFzWEpDWFlObWlrSTY2UEw1Y2hsTDRMY1g5aGZJeEVJNnE5MXVBWVQ0?=
 =?utf-8?B?WWdFYXRhWDJWUVVpUXBZeGtYVjJNRmQ0enFjVmFJK1hvYmtnQ2tyQWFTUUd6?=
 =?utf-8?B?d2xTbjJxUUtJQlAza24wKzVBczBidXlEN3dYTFNyQWhrcy9idisySy9tNWM4?=
 =?utf-8?B?c0s1NkUwYklsdHlZVUY4dmpIWU5VUlZPQjhXMmJjNkxPTkp6YUIxWDRpWWR6?=
 =?utf-8?B?alFyMDdOb0EvL0h2bndlaUF5VnZYanB1NzM3VzhRSGFYTUxQbXdHcGV0WWEz?=
 =?utf-8?B?d25MRzh5WGp6aFZjejVxdlFOV1RsbzAydjRXM3IvQkhEZUx0bnBPbnlRY0hB?=
 =?utf-8?B?cDcvK2tDQ0xRbnRGNlNqbFBMY2QzM21DSHZIbmlCemQ1L1UzN3BsdHRkemVz?=
 =?utf-8?B?ZzJ2R0R0ZTBtbXVRZG9kdE51MjE5ekp3S3Y3ODJUcUV4dWtUNUowdjRXMktF?=
 =?utf-8?B?UC9YODc5RWRveEY1VC8zUS9TMTFUaVNlVllzbFBaRVlGYmh0RkxiYStKZVBu?=
 =?utf-8?B?YVl3amxkVkc2c2tpbkxNYXJPZXFLcUx2dEJIcDZWVVo3YjVKRXV3cVZnek55?=
 =?utf-8?B?T3Z2RXg0dUtwdFU4S25qcmRMWG1hQUp6WmUreUt1eHdnMkdjeGpEOVErRTln?=
 =?utf-8?B?Y3JVV2hmNEg3MENlQzhuZ2JQY2JpWGE1aHJ4R0lyTlBFbUx5eWJBZVpmckZX?=
 =?utf-8?B?THhBTzIrTVQwdXliZW4wQldCNU1YNHQ4ZmdaTnpJUUptL3czcm5BSW92NmhX?=
 =?utf-8?B?b1JvTC8rNTg3M1YzRUJsUlQ3eVVOOUthOXF5eTFNVkFIUmJiUGlEdGVLVVM3?=
 =?utf-8?B?QkcxVFJ6RjBIV1BaQlUxMi9EWUhPeHNsd0lGOG9ZUlBqT2E2WlpOenkyV29m?=
 =?utf-8?B?QjRYSXhCSHdkL1NUU0pCU2xNbGRvaXptWnhCN2ZXYXZmbWR0cExhSDlubGtl?=
 =?utf-8?B?SmV4a0NONFJiOWl5TmY4M3NFRG1lUUhXbDdhcm9rK1VEdUl3dlE4Mm1ZdjBB?=
 =?utf-8?B?QndzTi93cGxobVkrTEdxaVZYKzhpVzRwS0RKak1DdGRZSWg5V2x6Q1E1UE1K?=
 =?utf-8?B?c2JGNXNUTkxDQnFpa05iclpHNTg5eUdoRDRSWnBIb0FBZ3pMTElYcDJ0Q0E3?=
 =?utf-8?B?dVZxTzYxdVVHUGhXdVdTMFF5THlBbVo2ZkNmYnFKYllMSVZIN0tqajFSUGM3?=
 =?utf-8?B?SzlEakxVVzROTkdYYi9tZ3YxcXZiUmtUOEpxVnpHR0JIMTdTYmNPdnFFcm0x?=
 =?utf-8?B?RVdjOEY2bnJ1YWJzNW1KdXdZa2pHa25rNm94dTVYMTlSdXJMUS9MdTR6SUNW?=
 =?utf-8?B?S2FieXA0bGF3cml2MmlseVdTQWlrWU1NYll2T3hWeGJlUkVQRW1XajJ4aEhC?=
 =?utf-8?B?RGV1bTBtU2MybDhBSzIrdz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e223b6-431e-44f9-03e2-08da74cdadc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 21:26:36.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2414
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski and Marijn Suijten

On 02/08/22 13:16, Krzysztof Kozlowski wrote:
> On 01/08/2022 20:53, Marijn Suijten wrote:
>> On 2022-08-01 16:55:11, Joel Selvaraj wrote:
>> Any summary what changed since v1?
> 
> +1 (although I already reviewed it)

Will add them in v3.

>> I haven't re-read what was discussed in v1, but doing it this way causes
>> git to _not_ record this as a rename but instead state that everything
>> has been removed from sdm845-xiaomi-beryllium-tianma.dts, and a new file
>> sdm845-xiaomi-beryllium-common.dtsi was introduced with inconveniently
>> almost identical contents (see the unnecessary size of the patch that
>> follows).
> 
> The patch should be formatted a bit different. I agree that if combined
> with first patch and proper settings (-M10% -C10%, optionally also
> experiment with -B although here it looks not needed).
> 
> I reviewed the diff side-by-sie and there were differences (labels)
> tricky to spot. If you generate the patch correctly, not much of review
> is needed...

>> Instead, I'd keep the original patch with a rename from
>> sdm845-xiaomi-beryllium.dts to sdm845-xiaomi-beryllium-common.dtsi, and
>> _also_ update the existing:
>>
>> 	dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
>>
>> in Makefile to match this rename so that it keeps compiling, even if
>> that means we treat a .dtsi as a .dts which may (likely) not be treated
>> correctly by existing build rules.
>>
>> If it doesn't - and this approach is probably frowned upon anyway - it
>> is perhaps easiest to generalize sdm845-xiaomi-beryllium.dtb (as
>> suggested above) _and_ introduce sdm845-xiaomi-beryllium-tianma.dtb
>> _and_ update Makefile in a _single_ patch, such that everyting keeps
>> compiling and stays consistent wrt how git treats renames.  Later
>> patches update the compatible and add the ebbg variant.
>>
>> - Marijn
>
> Best regards,
> Krzysztof

I will work on v3 based on both of your comments.

Regards,
Joel Selvaraj
