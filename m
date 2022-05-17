Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE552AA44
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiEQSNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352013AbiEQSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:13:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5772C51597
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRoQXGiC/WnMYA6hnnT1ffkBpe0fl/fpIEzbOWdqubjZU8tqXyr/IswL0vLxLoobtfYxQI2vdfLnYsNQvloIdczJZfhwfn9x2fAOoS/7A1kCFCgdzgQYwhNsn7+qDmIaTDT8L8TZ6I+aBroB183pfHcXlXaYsFNomVVgYVt3+l3k9hhEPo6V3pMBMlJhep+4hm4+MUQioSPqIZB+dOSml39yuumDD9lhYNT/L5RMOtTaUFE7JrHTYjxiMC+/X9Mv+h5YvIc+zEbiQFrw73k3XtDOgaUeKBP6ZE+9d9LZD0y3nC/0rPlSmW3jDtmNgOhU80QAeCWfi9udxbBBIkH4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2YtxIs8tOVtfHWS8YsPk87VNALrajEk9+V42vvVud4=;
 b=fpjxerC4doazKEWdLwIKufKv9fQKEbelQorTzLUMQEskbJEzqshmHPiMMtsxO3sfwWZbhuX5bOAGWvTWoVqbkI6weiBwNxlyx/gEkwQ6BqqXJFrYMi40NMk78bNlgPz1aFG6UzkcCJsbv1+JL5yIRx5UVWbc9E0HK4P31kLD3TRu3m02bEpetIYO49B5tucpbBIaMfOCdLjjcDW9888QVuqK7IvdUpkdp8G0ZszaXNQEJdci+9l8WdRHLMP5KJGQc2dFmkVJah6nB0xu4G/FK66f3p+oXU/snE6NcT55ajttMWgPwXeYtYzCOWz+A1CMwbA2z10r8AIlrfUEizr8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2YtxIs8tOVtfHWS8YsPk87VNALrajEk9+V42vvVud4=;
 b=jVqLlvraNIyssVbRmPMSVzcx2JefLc0HbzZdC7oWYWv5CijIEE5zFH+VyK/txVZKC1tndO3XEggiR+6CCPSWdeEGVlpjBJBHJ1tCBkjlsqs0NK+aA70BxwKij4VpoAq+jYlLYANhU7GT9iVYmkerdzTi9Bek93OzwnPTR6I28kB3F8nkPMahWyRpYk9zkV0ZrezaiYnAg1b1whHs9l/buSiomO2jCwFw/KCXnJ1CBiDMmngRTD2awGFKOF2Bd/0Jrxb3quiNxWI+NiclNF3whPFdErHYFHDp2O6zjEH/80tZ94jzGv1fSWI5Xtw9yekTQ0uADPPw5TGxHI/RX0BU1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR12MB1399.namprd12.prod.outlook.com (2603:10b6:903:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 18:12:39 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5273.014; Tue, 17 May 2022
 18:12:39 +0000
Message-ID: <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
Date:   Tue, 17 May 2022 11:12:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Minchan Kim <minchan@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com> <20220517140049.GF63055@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220517140049.GF63055@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0200.namprd05.prod.outlook.com
 (2603:10b6:a03:330::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14335d69-9d56-4aea-7972-08da3830d3e7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1399:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1399256C9FE47E809E5F61CFA8CE9@CY4PR12MB1399.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8tt9LjiUjeu0O+WJQOgVDxp58UawBNjWjvFMujbbCqKSJwku6riVfPuKMdKFz57g0CUJZ/tJ5DmXmJiZz+guhyTcO8pF7MuuDmcDQRAR28g8A83MjVFnrzinAux/0W3IradH5Oc9WfTM7O07rvBPqtBI5QgqD+hqmeK1flX462ClPXI0t+k7b9nUoEx/AsPagyS2XSWvtsjrUqL5L25A+zegJ8HvNshg3cmcd8tvyGb1i//IKz8IAjiUQfInOLdAcBHMsIQOZvSH/JEwLtryGtaFXHBJdpeKQ/j4vlw8uvuYXaJIUwDyHkXxpFm0YhVsmcLongjo2B9wPfKPsXo0o7fTms9OTQu1Rz79QvUJcQYsiE91URU8wirPA8mh4of1VH/jU/5W3fmhdo6UnznfSwxPtwkj1aTjcjBDsmR3RqVqgeNh4W9J41scL8EUYX8ohbWuMXaDseO7iBbP68nCXgsQO/IgavZbMFTgJdMysFrX6Dm96YBULbD2ensWrUBmhnFUUXdiwuryfySuTJvzuc5mdDlRK6iW8sE2+9klvW0fqR5sbAM8JwtdVsPs0VTS5BxavNnnBC/CYHx6n5CxdgnURljTsbzFAorzulXDVCdl/RBpontHM7JSEiHJjwP/KYFaVnjKXGgM9h1Qf2Ff9MkCpfHlEasMekKmIXAiEHY15O51n/mkUC/SX/fix0Im9q6NhvXmxoHC9ZY+toVWhDUNHWf74MbkbyTaAb5frM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(2906002)(8936002)(508600001)(6486002)(86362001)(31696002)(26005)(6512007)(186003)(2616005)(53546011)(6506007)(316002)(38100700002)(31686004)(36756003)(66556008)(8676002)(4326008)(110136005)(66476007)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZkRWpQWjJwcXhaTXNrZk0yOGxGU3J4c0JteUwva1puN2ZYNmVlT1ppRmRh?=
 =?utf-8?B?YnViaElnU0JleEZGbDBHdjc5TVhXN2wvMHRQYm1pMElWV1czUHJmeU1UODhR?=
 =?utf-8?B?eWJaZWMyRHhoa1dkdTBNcHNGUlFJbFZrREJmb0h5cXFpa2d2NlErRDhKNG1L?=
 =?utf-8?B?QUF4OGFVUXZLNDNCQ3Y3amd0bE5JSTZpMlZpNWZEbTZiUkxLMXV2WG1VRTA1?=
 =?utf-8?B?WkNHV3hjRWNJam85ZDlDY0Z4YTIxM1JjdStXSk82dXlMMW1aalhwNzl4WWZm?=
 =?utf-8?B?bHAwVTY5aDduVHdkSDRUcWlRQWF2TGdNLzBwQmZadm13ajlrSWtPRWtlakNS?=
 =?utf-8?B?U3JEZWxiTHIxMk0xdmt4SGRicmNkVW5zNzRyR05vUXFndGtWZUxwS0dycGdI?=
 =?utf-8?B?N0ZqVEZ6Yjh4S3Vrb1U4aEVWcmdjLzY1OG5UK284eFBURDg5eHVaM1ZtVE43?=
 =?utf-8?B?SnNHbmZIZS9iSTYwQ0QrVldxbEx2UnJxampJcVlxQ3NsbUhvOUw0ekE0ZnZB?=
 =?utf-8?B?YjhGMy9udDNqUC8rdG1yT1BEalNFMkc4NTFMNWVjTHpSc01qc2VjYjFjMzR0?=
 =?utf-8?B?K1pCc2FqZGlpQ3h6NFNRMkJ1UElzVTk0aDRYTk1kS2NyMDdyZWhyblJHSzY2?=
 =?utf-8?B?aWdUTHRhbXBNZUpVeWNUSUlwam9XeTcxQ2FkL0s5eXVnUURXazA1ZnVIbXN4?=
 =?utf-8?B?eEtacjhZcUdabHhTdjk3b3lhQkEvbUtnL1hhR1lzSEZDNWlhRW5NZ01tMGxJ?=
 =?utf-8?B?dG5teUtJeU1GMTAwTW9kMFl6cVlxbVJ2dVZQM1AyK1ZjcHBhbExURUlPUysy?=
 =?utf-8?B?ZHZPdmZDVC94UmNlRzJMZmZocUo3REh0RklpemU2ZUFSckIzclhEYWczTXZM?=
 =?utf-8?B?YzRBVmRMMnhYR2hCd2FzSGFYTjVMVHl5QkN3SHo1RU5oUndINGJzQW15dXZK?=
 =?utf-8?B?YnhHdEZEdjhhMEtNOWFWZndqUEFDNlI1S3JBY1F4Q0QyMkUyRUwzYkFKYzkw?=
 =?utf-8?B?YWdJWGpmcjFKQ2U3MjkwMVgrK0t0UjdCMEUwZHJwZmxIbERkOXg5SGFHRTRU?=
 =?utf-8?B?b0xpeXhmMVltQWlGUWxLcXkxeDhvbkhrVndQOW1NSjVVb3lGTzlVa0FEeXFC?=
 =?utf-8?B?U1BjSTJ5ckRuVkJQUWF0V2w4UTRYajdkNU91RW5LYndjcm1oY2xaWE95U2pM?=
 =?utf-8?B?SHU1VHhRazFxV1ZhTjQ1RXc3anZRQjU1TjMzZ2ZrZ2VVUGdKbDhWZWdzanF4?=
 =?utf-8?B?S3ZzNG13dWROY2tMU1ZGdGlyRXFudEpXZ0F3VGQ5TktSaEtjcUN2VGRRbGdo?=
 =?utf-8?B?Sm56ZlltK3JYUW1mZE9yQ0E3aWpRV0ZLNnBPV3ZHd05FOTFsbzhEUzgzZkE2?=
 =?utf-8?B?VFJ1bHMvbmhlSmhjM29aZnN0a2tRQnVMRjJxajAzMUtrV0tOQ05GdzRoaW0r?=
 =?utf-8?B?SW5Uck5YMzZjT09YNFhXYytDNEoyY3BnaVBjd0RZMDMxVWpwZU12ZTVJRFZG?=
 =?utf-8?B?NzA4N1doRUZ5dXhESjJYYUdwTnMwSXIvR1o1bDNPemhPWHpzaVBYaXYvaGRm?=
 =?utf-8?B?RVNId3BFYjVmZ3ZVeWpWZWV6OGpGaGxrQWo3R1RVcmxMWkZXSk5KaTNTc1FX?=
 =?utf-8?B?K2V2S3R5MEh3ZGJCNVhXMkRzdVZoZDVFZ0k0aytCdVZ1UitwdVJEa2R4ZTVm?=
 =?utf-8?B?Nm84eHBUb0FZSjNjNHRDUjFLcUgyVWVaUDZSbzcrcncrN05IK043cTc0VUcr?=
 =?utf-8?B?empSdU1EcGd2NEJ4ZERUZkxoVlkycGtuRU4xNFhLS2R1c1VWc3JZVFU5RXVL?=
 =?utf-8?B?Y2NOcHJCTy9kWE9KUjd0YzdiSjR2N1hsdnQyaHZnMnllMmhmLzBiVUhuWXpR?=
 =?utf-8?B?d1M1VEpLVE9sRUZpZWlPZm1WQytWQXVlMmliQnN3dzNlWkhSdE9JWWVpemtY?=
 =?utf-8?B?NXdkeFcrUEl3RjRYZEd2N0VwclJZRm9uNkx6TjdWNW5pVHpKaUNnSFJUdURM?=
 =?utf-8?B?RkVld0p6V0pUQWJoNGk1M0JYM01iOHVYVjQxRUEwRjJJcGI4cDJDcFQvNU1U?=
 =?utf-8?B?ZytQN2NIaHk5dGZEVlJqVDVKaGt5UWlLTkU1OUR2T0U4Y0YwZGVCNzhmMnhm?=
 =?utf-8?B?R3p5SWo4U1A2M2hCWk1HdmlKVVJpU1dqbVMweTc0M0lmNTlSS0MrcUtHM3p6?=
 =?utf-8?B?UHM5dzdYbHFPVFo0cm9pNWwxVkM1ZStJRDdacUpZTnJTaVpLR204eWdwTWQ0?=
 =?utf-8?B?RlRpblBuck96c3lMUHRtcW9ZY1paNXJPdEc3UUZrYmlYKyt2UUZyaFlLblZJ?=
 =?utf-8?B?bVB2by9rY2lEbVZNbWMwUmJFdXMzV3VSajRhMG8rUFE2UXVoOEMxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14335d69-9d56-4aea-7972-08da3830d3e7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:12:39.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7i+LU5vtRv8F5USnCoR8K4LhkKl2ghLGNsxYsT0PqVnTkoKUE7BmTqrTxpCvhEDQgplOSrjt+2fkVhURS6YPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1399
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 07:00, Jason Gunthorpe wrote:
>>> It does change the generated code slightly. I don't know if this will
>>> affect performance here or not. But just for completeness, here you go:
>>>
>>> free_one_page() originally has this (just showing the changed parts):
>>>
>>>      mov    0x8(%rdx,%rax,8),%rbx
>>>      and    $0x3f,%ecx
>>>      shr    %cl,%rbx
>>>      and    $0x7,
>>>
>>>
>>> And after applying this diff:
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 0e42038382c1..df1f8e9a294f 100644
>>> +++ b/mm/page_alloc.c
>>> @@ -482,7 +482,7 @@ unsigned long __get_pfnblock_flags_mask(const struct
>>> page *page,
>>>          word_bitidx = bitidx / BITS_PER_LONG;
>>>          bitidx &= (BITS_PER_LONG-1);
>>>
>>> -       word = bitmap[word_bitidx];
>>> +       word = READ_ONCE(bitmap[word_bitidx]);
>>>          return (word >> bitidx) & mask;
>>>   }
>>>
>>>
>>> ...it now does an extra memory dereference:
>>>
>>>      lea    0x8(%rdx,%rax,8),%rax
>>>      and    $0x3f,%ecx
>>>      mov    (%rax),%rbx
>>>      shr    %cl,%rbx
>>>      and    $0x7,%ebx
> 
> Where is the extra memory reference? 'lea' is not a memory reference,
> it is just some maths?

If you compare this to the snippet above, you'll see that there is
an extra mov statement, and that one dereferences a pointer from
%rax:

     mov    (%rax),%rbx

> 
>> Thanks for checking, John.
>>
>> I don't want to have the READ_ONCE in __get_pfnblock_flags_mask
>> atm even though it's an extra memory dereference for specific
>> architecutre and specific compiler unless other callsites *do*
>> need it.
> 
> If a callpath is called under locking or not under locking then I
> would expect to have two call chains clearly marked what their locking
> conditions are. ie __get_pfn_block_flags_mask_unlocked() - and

__get_pfn_block_flags_mask_unlocked() would definitely clarify things,
and allow some clear documentation, good idea.

I haven't checked to see if some code could keep using the normal
__get_pfn_block_flags_mask(), but if it could, that would help with the
problem of keeping the fast path fast.

> obviously clearly document and check what the locking requirements are
> of the locked path.
> 
> IMHO putting a READ_ONCE on something that is not a memory load from
> shared data is nonsense - if a simple == has a stability risk then so
> does the '(word >> bitidx) & mask'.
> 
> Jason

Doing something like this:

     int __x = y();
     int x = READ_ONCE(__x);

is just awful! I agree. Really, y() should handle any barriers, because
otherwise it really does look pointless, and people reading the code
need something that is clearer. My first reaction was that this was
pointless and wrong, and it turns out that that's only about 80% true:
as long as LTO-of-the-future doesn't arrive, and as long as no one
refactors y() to be inline.


thanks,
-- 
John Hubbard
NVIDIA
