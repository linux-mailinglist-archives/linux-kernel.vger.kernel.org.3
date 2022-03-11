Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151634D5E12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbiCKJMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiCKJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:12:34 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5771BB70D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:11:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7epAFy3IaXq0fDFKyMqApkFlU6gjBf/c7vYoagupCzqwPjk2QufKFLoaJTyrSwcC19GRymUt1p2WKmG4aYTKoNeN3ZZolKSqIW4dTr85II6ve3qfaJz91GSesUnY+BiEk/UvgzHP1OgbMl9oKCQ3UvAsSx25uI50v5JDMlTYYqlCTXilMXUWxGxKvAgepJT7XXkq7I9uPD/KrQRVQNYwsVFcQE3qoY9ydjdt1VLUYANu2g+J5FUbpwEwAujDDU334DerjyLAaWgyxQr3zvz5B/jh6LO4aVf0f3IgcL4JFknIHlBGFbTJ9VZXVkvI8ViexTmKQonDogmI5KkkdOtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/6A2/vlaSpoNctO/65HTjq3bjGnIf4SkgaweTTC6Sg=;
 b=Bh7rsnGSNurl96zDWHwI6AkR98NkWtsggZtC5TKlYzngAtbvrdmTAuZ9K9fjMHvGpzOeyu1yaFAO696hhXJQMmcsuDc5owiMhBz2jybWlCloeMjRai+59ixFGqOuOKBzBt0EHTG4iO32qIJZG+jEp3HDcG6rG44qXpFXKH9zrW6AZgatt6YVjWQ2TKxK6H7CtsLcQadsVREbu7y4sfe3O/P8r99KdzKnmfjpFB5kLHhchhmiVgbcvUzQyf/PhOJaopo6czi4ZwsrPmqnML+X1emaCAZllz0yU8VdgKHBSCbk39sKH41p33olFFCtcvVkzEIBYNY/fdmRamXb8vbJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/6A2/vlaSpoNctO/65HTjq3bjGnIf4SkgaweTTC6Sg=;
 b=wqXeqslhD6rG2SguDgPQS21Jyf6ZiqP6I3+R3aeMBYSKsj3UjIvv2ZqgiWyRQwTfCMYPiwhLt80eN8bBBfB8oEeNeLSKT1PXtGs2UI/S7AduJ8mhzuUeJd69a954sq+ICEiWZaum3sSJm8LRCTgWgwXVd1LttNmLgczSjGXRKrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:11:29 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f%8]) with mapi id 15.20.5038.029; Fri, 11 Mar 2022
 09:11:29 +0000
Message-ID: <363b91f7-a1d7-b5b5-de86-40bcf61ef818@amd.com>
Date:   Fri, 11 Mar 2022 14:41:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Dave Hansen' <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
 <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
 <f6212ddf70bc408a80d7eb690c46bccc@AcuMS.aculab.com>
 <de443f8b-8ce0-8664-65d6-daa767ba086b@amd.com>
 <15fb8774026b4350b2653ce119c85820@AcuMS.aculab.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <15fb8774026b4350b2653ce119c85820@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::22) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1eca16f-37a0-47aa-5c43-08da033f203d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5228:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5228818F6A802D2D02DEF7C1B00C9@BN9PR12MB5228.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GfF2VR/uk3qtHQzw8MBy5Arx71MIU4/uijbet/zPZMxax9qRgp2YJWhbaVBG7wFUlTOnVJlqeRVAVwaRUDxs/MCYx8+H4EaBr1/uZnRQt2jDWu/M1PLgzqD+JVrwrxA/cqObT70UPI7rnj/M9PBbMnmSO0sH6/mDoeFA6HHTY11xst9ojQ+/xTFGfVT2U24xNhxWy5vsCYpsQz3/r6h0KlNMlDgOtVYx0f3uxIHkMsoGbTFza5oOA/0viACYs0uEMkrrHvINsvHVAzSKCDrlzE2GZLM6Hi/NSc4uOewzRIE4TyaNeEHZ9GIZnlYKSXM+oDu1P+ibWn9dMtoHTI11x18T8ZTZ055Vp/XpBF/Bufs9S8Eb+0LfIhf69+pNng8a7ZoHRhKDagdSJoGU6NgXHer30l2aO8/1nhmJQfdnmjpMfD5+TOXfcLwDpSwFvhWYkxHNzBZEfCzwFlWsLYJz7yPLKPW9oVczOxrG0uYAEs+Mx8Jahq/R49QYIt/AeJWAqvvPUcbmAuA7uV4OP69Q3G3qJdK1Mw+v+MQqs6FDNZrHDxhX7DSuD8dsCvl3hBBgowIF6tzSXxjfx8RmXUCOAYQiSJMx+0RGmijoS8oBBss4OykyXEfbrj/s27NRYmEO7DMSgQfgaX+JhGT+E9orx8T2L7RNBpQgta6tSEusixxPkEZpex8aiQTqaMM8AwywBFBWC27uBP8LQphK311SUb/79ULkDwrTflrV8fbW04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(5660300002)(2616005)(66476007)(8676002)(4326008)(31686004)(66556008)(508600001)(66946007)(36756003)(38100700002)(316002)(31696002)(6486002)(86362001)(83380400001)(54906003)(6666004)(110136005)(2906002)(26005)(53546011)(6506007)(8936002)(186003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGYvQVdrZ0tTK3F3NGwvYkN0QlVvMytDVDZMb1BobEhtaEQxdUxvWXptYkI5?=
 =?utf-8?B?ZzEyUTNDNmQxaGtaWGJjeElrWWVpT1kxeGdQOGxpUjRTeExZUWNJN2FCNUFM?=
 =?utf-8?B?cndPakdKZEw2WVlTYU9PdEFYMzlZNzcySHdpZDlHMTFXOC96YTZTMHR3emhO?=
 =?utf-8?B?VVUzQVJEYUV4UFhOaGEzWFY0OFpoYUsreS9GL1FqekFBR3hmVVRYK3pLVnhK?=
 =?utf-8?B?dnJOSzlkOEs0NE45YU5mbEhLZVF2QktPUU1qQktJdTRGWkRiVHVvWkZ2dXcw?=
 =?utf-8?B?akdwZUpwK1Q5aHNndTd2Skp0THROV0ZISCthRGlIdWwxM0FYTEFYQ2MvOXpB?=
 =?utf-8?B?S3gyeVBaNy80RWxHdnAvK0NvZVJmTkkxWE9NWmxWY2FSVUtoSms3MzFGTGFp?=
 =?utf-8?B?cW94WlhrcVZ3NENnQitFNE4vVUhaUUFCUTloOUdXN3lmUmZFSXNCalU0Nm5z?=
 =?utf-8?B?Tm9GWWNUNkp0OGpjN1hIc1NDcmNGYlU1TmpTNEFXL2dIVzdabnhTQ09KVjFO?=
 =?utf-8?B?MmNWTmFvdmU5eC9WbWlNb0g4Vys5czVFN1p0eXVNWEh2T0dtN2xJVTJ1Vmhx?=
 =?utf-8?B?VzJDYTlZR1J6RkVzMUtSbDlZc2lZZ1IxKyttS0FjMkk4c1FRZ0pGZnJaRE9l?=
 =?utf-8?B?eENWcFFQRHUzdjlYNmdvS1NmNXdydk55WUVJTFF1RUxncUtEUVJtZ3ZxL1RB?=
 =?utf-8?B?VXhLSFcwSktDb3BvdjFYa2FkY2M0ZjJldHVWQmdoamprRVpHY2tjWjFrYVlH?=
 =?utf-8?B?Z3dTRjBUMnRub1BKajZNTWV0L1hNd1UwSWxRZzZHUzdhd254WnhDb0tpYUV1?=
 =?utf-8?B?VjRpTGtnb0ZndUY2aHFlNVFRV3EwNGpPSlpnN2YxMTNObndsMTFWU1h2QnVO?=
 =?utf-8?B?UkI0ZXViR0N4WHc5WmpLMzFQOHl2U2FRSXNlZFdjWUROdklGR0E3ZmEzQjJt?=
 =?utf-8?B?WFB5aUdpOW9SSkUwMzJrOFRQSnZxcjd6Rkx4VG1UcGhISWRVTjdRa2l2Ymhh?=
 =?utf-8?B?VnhzZ004bis4TnN6MDBCdnpYM21Ba25PZ0RCcCtCNWluR2dZcWdJOFNKRDdm?=
 =?utf-8?B?aXp0VUpjZVRpZFd0VmNsYlZWRDFoZWlKWUIyY1hYeGlpTVovZWRST3pJVVNn?=
 =?utf-8?B?bllwYmRzbVZUQVJ0UXBRQkI0TnZNTnNGT0lFNnBzbkJ0ZW15U2ZaUm13TFlO?=
 =?utf-8?B?SFVSQWdvMlpyOElhRm9Vd1JUbUNqbDNIYzZ2MTV3RXNVVUlyV0RHTityY2dU?=
 =?utf-8?B?SjlXaUZUejA2SUM4bm9sS3QxNTM5MVNkL0prMDZDaFlVZG5XOG1YOHFLcGpS?=
 =?utf-8?B?YXFXcmhtMXFSY0dNRWR0UTNsRmZpWXBSeHVON09Ma1pYWUYrMmxLN1FRR3VE?=
 =?utf-8?B?Tk8zalM5cHBtaTlhazl6OW1BbFRWTlFFakJCb1ptTTlqdVFkaGw5aHEwRkNr?=
 =?utf-8?B?eHVtUHJTKzN3MWhCdWhZb0ZOQm9UcUpCUDE3dFNYTkhGYnR4SU1iazNDYVJv?=
 =?utf-8?B?ekdNVE1wT2JSUXBMM3lPNVNTeUpZYm9TU0RBcE5DYTM1dEErVHhvZUlpK1Bq?=
 =?utf-8?B?WG1iakZhOUplUFNjK3lSNmRHVDRDcFgzY0xlRWFXNjJXVkQ4K2huTW5wL2o3?=
 =?utf-8?B?LzlHMElEOS9yenBTdFVsZ1JkNi91eDBmSThhUEoxTTBucVY2RHlWTDVhSnJD?=
 =?utf-8?B?NmFlaWYyZDVUSUxNVTVaK0NkVW0xV1JDNks3c2tmdmJaM2lla3hOSisxa0I2?=
 =?utf-8?B?bXVhMTFheldYb2xNY2xOVW9BeTVyRGdPZ291a0F1OXBQUnZ5QndMNzR0ODFv?=
 =?utf-8?B?R1I4UGdoQ0VLc3M3QWVQSkh5Rng5QUxmQmVWY1dGTnJNYU1vSFMzQ0hObWJ3?=
 =?utf-8?B?VGJrNXczcUgxNDh0bGNUU0psYk16MHlTVTcwWk01V1dqZVFaZ3NoK0dkZWp0?=
 =?utf-8?Q?pmHELV+cSFJ2dLT103wciQDsPWaFUoij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eca16f-37a0-47aa-5c43-08da033f203d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:11:28.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9HGLIRlefgruXWaDFO8qOBZLbJ5Aec/JWbNc2r4YKxPK99jmbdXm1ngKynPcVFYolAQkKANzAIFXK5kNg2LVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/2022 1:45 PM, David Laight wrote:
> From: Bharata B Rao
>> Sent: 11 March 2022 05:43
>> On 3/10/2022 10:49 PM, David Laight wrote:
>>> From: Dave Hansen <dave.hansen@intel.com>
>>>> Sent: 10 March 2022 16:46
>>>>
>>>> On 3/10/22 06:32, David Laight wrote:
>>>>>> UAI allows software to store a tag in the upper 7 bits of a logical
>>>>>> address [63:57]. When enabled, the processor will suppress the
>>>>>> traditional canonical address checks on the addresses. More information
>>>>>> about UAI can be found in section 5.10 of 'AMD64 Architecture
>>>>>> Programmer's Manual, Vol 2: System Programming' which is available from
>>>>>>
> ,,,
>>>>> Is that really allowing bit 63 to be used?
>>>>> That is normally the user-kernel bit.
>>>>> I can't help feeling that will just badly break things.
>>>>
>>>> Yeah, this does seem worrisome.  The LAM approach[1] retains
>>>> canonicality checking for bit 63.
>>>
>>> Actually it is rather worse than 'worrisome'.
>>> Allowing the user all address upto the base of the valid
>>> kernel addresses (probably tags to 3e, but not 3f)
>>> means that you can't use a fast address check in access_ok().
>>> You are forced to use the strict test that 32bit kernels use.
>>
>> From what I see, there is a single implementation of access_ok()
>> in arch/x86/asm/include/uaccess.h that does check if the user
>> address+size exceeds the limit.
>>
>> Guess I am missing something, but can you please point me to the fast
>> implementation(that benefits from bit 63 being user/kernel address
>> disambiguation bit) and the strict checking in 32bit kernels that
>> are you are referring to?
> 
> You can just check ((address | size) >> 62) on 64bit arch that
> use bit 63 to select user/kernel and have a massive address
> hole near the boundary.
> The compiler optimises out constant size from that calculation.
> On x86-64 non-canonical addresses give a different fault
> to 'page not present' - but that can be handled.

Ok, so are you mentioning about a future optimization to access_ok()
that could benefit by retaining bit 63 as kernel/user bit?

Since you said using bit 63 to store metadata will break things,
I was trying to understand how and where does it break.

Regards,
Bharata.
