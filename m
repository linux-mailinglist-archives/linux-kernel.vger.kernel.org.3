Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCE74E4D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiCWHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiCWHu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:50:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332DE6FF6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m65yMEGir31igZp14VvuUg5CyxQFq9QyJuLfAixipedi/vhquyO8X5rULPIwrja4vG8wGiMEPRcx6KBcd3bhmeD9WhSUdZLVQDPOYjJ+6XMO8ACVTtDceBafW03jW4VmRNfmZIT02nHLptuqtuD3uiuS5MEjY1P8Enhlj7pz1SZ2B78GxzC3i0Mhnj2SaeoKXe84jaHLS2Ky7ob7sGMmZ4+et+v8q0QaIV2M1C6lkMMCYomq+04MCROBjqUvTrCsh6cd/spLNOgkdSj/mc7d/d2lcmqI6FFhYzCTMgCN/PmOmS2Hynw+XIZIbTLpkCxt3FYiE7VMcYc/IdDKeiYNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzTBHZkp/TvUxq+qBbHPuMbG3kEDK8whPuuQY9F2gvs=;
 b=B/9faL27hdM0c1SO6E3OWLH/OrRrUB8Xi23AVb/NGbGGWUfmSTuggkn3EZ3Zi8B+L7DIg2ene9jjV9+h+gNuh0/RJSNkR4/AEleHyNcpxVA2WEGZbr6/h4M2qgWZVEjH26qOvl/aV0Qa6yKibilbM6vD6b0uCFgXTPVhLQPTxbcolp6YFO/OSjMRpUx8pxfBDRGLV1yhuXlvJgPlm37hzIdMY9JW4QTG5PWu47YQL85tysIJVAHHfJtRWG/lmEKXljWE4kXwb7ic6aiCGxyOBnpV+2YFe5cXhvfv1KI34dicz2EIBc906grn1BMrno7eFYVXRzecbLwMej58ypL7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzTBHZkp/TvUxq+qBbHPuMbG3kEDK8whPuuQY9F2gvs=;
 b=0FcM8CqYT3THpyrYCD2R5hK17vSMRr2mTgn4mLVPXe7rtoSBlOOkb8BkSdhsLXYHE7wQiZFxBmvWEvW1iqa1PeUIA5jPocPus5Tolz+vyniZrfwSvfERjy1nw6F1UMOit8SlbbRev3AaX2MrI7i6YjVA3D4Fk0PZAkivobmKkRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 07:48:53 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f%8]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 07:48:53 +0000
Message-ID: <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
Date:   Wed, 23 Mar 2022 13:18:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        Oleg Nesterov <oleg@redhat.com>, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::21) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dce802b-be66-4486-9c1e-08da0ca19386
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675ED5BB57FA14BB534227DB0189@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soWXzF3nNcv63N/jbGHOe0iWNO4lHaevFlobUMTL33xdfXqPKK+8JPJZYkeBPkQ7qsWpcXsThnI8uYFQt+dgFjvqJT48jDLaku4SIxvExrsmwtzTNC8FQ460GpQ8wwme1JgncM9KJFVYQbxi7NcgYA+VCrVGER99SJXsdvrC0A3qt4/i2fpvrnhSoIqNWwdqHHy1EIVqZ6zVusnjXqfJoQMc4JySshN+ZWLOJR0KN8l/St2U3pPdwjIamFroJRcMftyqd32zgBU5KqM8kktrPPYp8+hhDiPRusbCSvyX2zDhuOAYukL2QqLNTZ1ULZiHi+V4Ik4ZwW7JlS/PL1khTPDgSKNaPQJdw/73v0saL3ZtuJqCf5xc3+NtvcQdHwZo+e9fKuwpb+ICPY76+zsskvba2vBOBOCeGwQ7d8tS+UiyxOHVO/960txbEPQ9ILJaUbSzdbPLSjGbjOjiFuh9tgx8KuGtRP55yxAQYrwzlXcdyOqgwK/cYGkr+iR0gEg6LyAJ1EmBAIkBj52TMjr+TmZjUc76KmYVytl+/E2e4FmxgosEtiV6KipMHNw6ar+YAbwE6XthoYUQJyhJLMVFQfdvnTtV6yAwv52sGubWifXKTUJxn44jyQTg4CVUG7GdJpqwrccwnKH5GFk0lxy1YZhQTZT3SwL9QhYrYC1OLioFMFf5FYWacyHywja4HUYcpUuN5dmqk/KiHAh89j/wW10z+y5wHfuDfS9a9rQdYxo50BNzbx41n6EdgjFnohONLWSvJv72uFnXr8e7wA6xRD38aZcScuviK3hZ9LDRJUbs3H2ao7TIuDmSPWbpWn99
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(8936002)(4326008)(86362001)(26005)(2616005)(186003)(6512007)(38100700002)(2906002)(6506007)(5660300002)(53546011)(7416002)(31696002)(83380400001)(966005)(6486002)(31686004)(8676002)(110136005)(54906003)(66946007)(66476007)(316002)(66556008)(36756003)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFoQ1lFb3ZzV0NDR2Z1Y1NwMkJMWTM0amtZQmpNTkJjYlp4Y0svL0Y3U1l0?=
 =?utf-8?B?a3VXbDIzRnFOODVRd0QyQytNbk5zMnFTRzdobC9McEp1NjJKaTFVLzFnb0Vw?=
 =?utf-8?B?NnQxS0hrVkFBOWlqYm1aekxrYTArbkpXTGh1OVd2Tmw5MDdjQW5LQXAxTCt0?=
 =?utf-8?B?ODVGYlB4N3ZNenB2dXAyenhJazMxdEE3anZVNnhxdnNhVGRhbWtQaGxDRmdU?=
 =?utf-8?B?OWhtWG9GNW5ReDA1TGFZc21MSnQySXZCM3pzamV0YnVmUFhDMzF0WkszNWdB?=
 =?utf-8?B?TEVpRW1UZDdKQ290MVY0RVVuQ2xXYlA2T0w2UmtWYW1jUUlqV3hGUGlCbmZW?=
 =?utf-8?B?cGozcnhGTTYySGFGY0d0SmVkdExUTFZWWXowc1ZFak1tQkU5VXJLbkhQU2Zs?=
 =?utf-8?B?YmhBTnYra2cwT0lBTWE2RjFpV3l4OURwK0swK2NOckRGYmlFbjJxcTh5SEZu?=
 =?utf-8?B?Y0NqZlBuV1d3WWVxdDVHQU1hVEg3ZStXdkRQeGU1b015OWowRTkzYjROMVdv?=
 =?utf-8?B?NE5raG5FZWFacU5EZ3kyaTJNVVlqRGxqeXFDVFhuSHIwWkUzbThnTjhPa2tV?=
 =?utf-8?B?Z3pzUXlYc0ZFek9YNHczUGVoNWx2cGZHeHdVZ2F5VjFTelZUTTdqcTJmK3Vl?=
 =?utf-8?B?NjV2K2crZFYremlpdGFhd0pYYVhQRGptZEk2cWtkQklqWXIrMngwM0hYUDVr?=
 =?utf-8?B?LzNUSTVPYlVyV2FGUXVjd09qOGZJT1VwN3ZSM0xPVnVPZjB4SkJwZU1ieW4v?=
 =?utf-8?B?ek5Tenc4SVQ3OUw5MXJ6VFdVb1RoYi9hcXd0N255Q1ZaeW9qTXlMcHJFVEc1?=
 =?utf-8?B?SzhBMVJjdDVUZFBEcyt3bU5GMm1iMVJ3Q3plWndVWVowaWtGZnNqNHY5ZWl0?=
 =?utf-8?B?eDdhYkI0b1E0MzhFZzUvTlMwTXVtNWpKZzE3UlR2aGd0VHYvL2krdHdMeWY1?=
 =?utf-8?B?MmIwemFpeU9nOEluWEJjTDVvZzhZK2tJRWtoeTRPVUsySi8xWnVoY0xsU3NQ?=
 =?utf-8?B?N1JtZ1dhc1Q4Z2VPS002ZUFaWURoOXV4MFo1L3BWSnBHelhuRWdEMXBDOGhl?=
 =?utf-8?B?TnIrMnViOFZSV3Y5S3dCN1UxZjQ4THMvaG9rTC8zMzNlUmRibTVDc2M5Ukph?=
 =?utf-8?B?c1ppVldlWmFEcXM2dkVOVjdzU0hPZFdmaVZWcUxlN0IyQmd5UFczNGQzSW5a?=
 =?utf-8?B?TkdpZFZyZlliUXdCclBjNW1jVXVWNVpTV0RNMzg5a25WUGpLK3dzblpwSFcy?=
 =?utf-8?B?S2VyNkJBMWx3LzJnMXJsRWJCU1RsNzRRUExiZlJLYkdvWlgwN0lvTzJJVDZn?=
 =?utf-8?B?Y1FhamtsaTZsM2hGVjN6cTVKc0k0Q0ViS09rWk53bXJMMDFFaTdGdmtpaHNK?=
 =?utf-8?B?VWUvQzkrbUp2RmJ0UVF1OEovVjdOSVBaVksyT0ZrVmtRZ3ZpWHN6UW9USUJY?=
 =?utf-8?B?YUgvQXRsbElTY3dmdFlOWHp2Uk1JaGFtUFYyeC9OTmFpbEV0RUhUYkNKQVZ2?=
 =?utf-8?B?UVdqcnMvRWZ4L2V3VVVFc3JXdXRNZEJUUmkwZ2NnYjhjaStQVm9Ca3hiYlZN?=
 =?utf-8?B?b0drUEp3NFhUME85MTFlWHhvczc3SDFrbFdMTytvUmdoa1R2Z3VJRFdGaEdU?=
 =?utf-8?B?d0RkZHZkMnliNENQQjhjM1UxM1NzZmQ1K3BSNnBjK1FraG45WFVLZU8rWFlO?=
 =?utf-8?B?OHV5c0dPNVZUblZucld5YkExOUdKLzhXQzcwSno3ZnpqMUt1bFgrbSs4eGdy?=
 =?utf-8?B?bU9uYjR6OU9pOUROUGFyd0lDZHNyMkx3ZElzL3d3Q0JPOG82Z0JVWU5pRk14?=
 =?utf-8?B?b3NtSHJsTHY5cUVKNGZ4Uk1zQzFOZ1NsVUFVdzZWVlUzQXlCOENZNk9vaUwy?=
 =?utf-8?B?b2FpaGpaMkx0b2VWZkY0VkVHRUt0MTZqTi9aVHZsSGVnaGdjektwSEk4czgv?=
 =?utf-8?Q?Fb9rfaWP2Q8VST+dVuzsmiLywN7wdSk8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dce802b-be66-4486-9c1e-08da0ca19386
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 07:48:53.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jmCPG+QZoRFSKLutNSqXf3YLMTvQNmgP7z2GFkPZ/pzckF5iyFu5IzzZ+8wrXViD5rrXgtrq2sL7J4hBKwodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2022 3:59 AM, Andy Lutomirski wrote:
> On Thu, Mar 10, 2022, at 3:15 AM, Bharata B Rao wrote:
>> Hi,
>>
>> This patchset makes use of Upper Address Ignore (UAI) feature available
>> on upcoming AMD processors to provide user address tagging support for x86/AMD.
>>
>> UAI allows software to store a tag in the upper 7 bits of a logical
>> address [63:57]. When enabled, the processor will suppress the
>> traditional canonical address checks on the addresses. More information
>> about UAI can be found in section 5.10 of 'AMD64 Architecture
>> Programmer's Manual, Vol 2: System Programming' which is available from
>>
>> https://bugzilla.kernel.org/attachment.cgi?id=300549
> 
> I hate to be a pain, but I'm really not convinced that this feature is suitable for Linux.  There are a few reasons:
> 
> Right now, the concept that the high bit of an address determines whether it's a user or a kernel address is fairly fundamental to the x86_64 (and x86_32!) code.  It may not be strictly necessary to preserve this, but violating it would require substantial thought.  With UAI enabled, kernel and user addresses are, functionally, interleaved.  This makes things like access_ok checks, and more generally anything that operates on a range of addresses, behave potentially quite differently.  A lot of auditing of existing code would be needed to make it safe.

Ok got that. However can you point to me a few instances in the current
kernel code where such assumption of high bit being user/kernel address
differentiator exists so that I get some idea of what it takes to
audit all such cases?

Also wouldn't the problem of high bit be solved by using only the
6 out of 7 available bits in UAI and leaving the 63rd bit alone?
The hardware will still ignore the top bit, but this should take
care of the requirement of high bit being 0/1 for user/kernel in the
x86_64 kernel. Wouldn't that work?

> 
> UAI looks like it wasn't intended to be context switched and, indeed, your series doesn't context switch it.  As far as I'm concerned, this is an error, and if we support UAI at all, we should context switch it.  Yes, this will be slow, perhaps painfully slow.  AMD knows how to fix it by, for example, reading the Intel SDM.  By *not* context switching UAI, we force it on for all user code, including unsuspecting user code, as well as for kernel code.  Do we actually want it on for kernel code?  With LAM, in contrast, the semantics for kernel pointers vs user pointers actually make sense and can be set per mm, which will make things like io_uring (in theory) do the right thing.

I plan to enable/disable UAI based on the next task's settings by
doing MSR write to EFER during context switch. I will have to measure
how much additional cost an MSR write in context switch path brings in.
However given that without a hardware feature like ARM64 MTE, this would
primarily be used in non-production environments. Hence I wonder if MSR
write cost could be tolerated?

Regarding enabling UAI for kernel, I will have to check how clean and
efficient it would be to disable/enable UAI on user/kernel entry/exit
points.

> 
> UAI and LAM are incompatible from a userspace perspective.  Since LAM is pretty clearly superior [0], it seems like a better long term outcome would be for programs that want tag bits to target LAM and for AMD to support LAM if there is demand.  For that matter, do we actually expect any userspace to want to support UAI?  (Are there existing too-clever sandboxes that would be broken by enabling UAI?)
> 
> Given that UAI is not efficiently context switched, the implementation of uaccess is rather bizarre.  With the implementation in this series in particular, if the access_ok checks ever get out of sync with actual user access, a user access could be emitted with the high bits not masked despite the range check succeeding due to masking, which would, unless great care is taken, result in a "user" access hitting the kernel range.  That's no good.

Okay, I guess if context switching and sticking to 6 bits as mentioned
earlier is feasible, this concern too goes away unless I am missing something.

Thanks for your feedback.

Regards,
Bharata.
