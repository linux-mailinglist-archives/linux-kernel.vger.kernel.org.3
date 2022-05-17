Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4852AC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346914AbiEQUMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiEQUMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:12:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E873ED2E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBquk1UW4xTTKc0OvJVT++NQNqezsAbiIxjzbrGvhMrRSRsgQvbKfgTlu2q0GvQIhciWhqzbmuOeOrL1LaqWSfsN6GL1P7ewQWgHYbpFiwnOhB9zlu75C9+R7nr7oQzEISjNHEYT3Gcb3zwjPzxkviBszOVRLFgETZGxyPVLOiUe20pV1wwdXiLdnU7QvvNGUYiHKlS44NxLmLB8Q7jEGdmEwvMEUdHQuRVa04GC4Za59Wzv0poDAlRDeapAINQst2NyvKIgRtMb35mr8T9aic2vY+naUO/PWgvbsgS+wVnBj7bv+HR3gL+ZfwbUDdBlxivOAAvG2+vXGBFrh3wofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMdWNYHIAHRq6F0a6tx7eoQy8PpW8s8zWXSztDPgkUM=;
 b=HanVB4JPvL6CgqE2O8SoCqEAMyl1+7qKNs6r+p7iz0p+a1zH+7HA7g2KH5spLFN/R7fiGvescs4088EgFI+Oxkc7fCy1LKkc90dL7ySDc2xrjpmbStiiY0gLsGyLnNURy2tMoSkJsGxaUppwM/xLVfvDoJhP9D1PVciU7Kt/6DEji3y4cxyk9IyFRAuoLytWV5m4BpT8LDgcvM0pPKdq8lcgAFdmTSAX4rdWzjcO6JxEO1rJgy9WHBXdshAnXLo5u8qIKaux3EjBrYQzl5nArMVNHaob5qoBVLJZ7wvty7cvVY6+Q/rgbfY3E2wlQOEP1zUYj8UUuWuqckMKUCNGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMdWNYHIAHRq6F0a6tx7eoQy8PpW8s8zWXSztDPgkUM=;
 b=uk/kNH9/gYeiRal0sMfno+ygSybiDkL8FeTtLfmPrzbFe3grVmD5IT1s8Z3i+phHQz/DzsGX8Z7k/dYVhm2lg8panw3DaKIfyu0+01qKAbRPLVE5nw19rSNUVR8Gz5PWIMzzb4uJy6gPq1160FjP8/3f+2MqKA/sNLuVkZNX87uQl/6xl79aif2/lgxw+MZK5DDs+7V997EStE7LvQGu32PZlN1Lldkuy1VeHCg7hp3MoqGGzDgH7aR1Y28ihe81pWBgaKDrUEbNj6skcVHAc7qspuZF3UBOYoYbSNpCgWK2VYuG5asTJXQh65R1Uz4HtrW7yfuuxcHWvlB4tV7mfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 20:12:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5273.014; Tue, 17 May 2022
 20:12:04 +0000
Message-ID: <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
Date:   Tue, 17 May 2022 13:12:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com> <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220517192825.GM63055@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e3e9c6-f84f-4f38-fda1-08da384182a5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52511EA3D840C67CFE5C0CF5A8CE9@CH0PR12MB5251.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9Gk6IKjwE6PMbVvUdeSRdoHtECfVNiZtj8gRimxNN11lnKI6DtQEZ6IVZMtMVtRG0WWbUwErk6whPnDmyC+b4Kh87aIxm0dKVv0RVrVGF0m37Mpgu2iCNDtNC0txYPt18SnQKKNe23esrQeM0PowyrNiUCtwBjrfZQp0njxph/gPxHIcGVjjuSr72bpEl1IpfOnQtCU/xCdUU6e5YU6tbv+V2qiUz5x54UHkHKG0JnSC80+djYX7rO+ewGVkMIh7KGstYu8kotzdqZFxV8PiC9xUot97Dg5hT7ixCpzzs/aaL9kApY0JM3fhF1PpickgwzkRscCJ+UW+jXix8l4fXa0fNM//Yk/Te+fR/6pLugd3XII+dSZJCrlHWt2LHV/1gcFGs3d2R5b7tMP/iXNHm9JIhLZgltauLLSq0LE2SXIJuRLD410fKcx60JiGbZVS3lUXkUY9CiggrasitepUvjjWKua2eD+GPcWUc5cMNE4AwFh00i6OaJFHtACOJcZ2afwvoBLu3NidSJbKqu3reYJn9raNIFaAb9FjYJCIYuCKm/YHgKjBM96N21oonG1EsfvNcnj2hDmFS831uGkdK2f9wlJ+6FmAkzcJp4IKSidqbSvDPQCGzyIQtBVNoYiyxr3hobpLIdijXPcrSpVMNGqEib92lLE1012cV373ox2sMk8bjsV4GM4iDi1kEVr74kpncJk+FFt4eNa5zYikqGGbQFExITysk+2/ng7JGYXoYUorti38WB1kev7MksL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(83380400001)(186003)(36756003)(2616005)(508600001)(86362001)(5660300002)(38100700002)(6506007)(4326008)(66556008)(66946007)(8676002)(66476007)(54906003)(6916009)(31686004)(53546011)(6486002)(2906002)(316002)(31696002)(26005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZjSEswT3dKV2xjZi9iU3B1N1pkc1NHZXQycGxManpMNThSRk1UVzN1K1R6?=
 =?utf-8?B?dHFibnFaL3ZCRy9mVmZlTlhOcDFPSi9WS1BQVGJmb2pTL3drWEMrK0Z3c00z?=
 =?utf-8?B?YUJON1VuMjA3dmtaSzJvL2Y1dFU3UWJENHoxZkNWcldoQVIzNCt5SzJnOU96?=
 =?utf-8?B?d3Q2c3BrYm9wSDcvRk1SMVg5R2NlMXdSbHRDNm1zVkdubk9GeWQ1c3oxdHNJ?=
 =?utf-8?B?WGVaQXExSXl3ZW9ZNjdndTF5WFpXNnVhQVN5ZjJpMWJDdFFpSnhlV3NoVnFC?=
 =?utf-8?B?RGJ2Rk9uR0tzU0cvNUhLZ0dLU09hQUtaTzJDWXhpcy84MUx6blQvOUM4dHE5?=
 =?utf-8?B?M3M0ck5TbmtPdUNYWXY1ZDVvL2REYmhDVUlVaGJKMEZncEVQbnVvNTZmMTBr?=
 =?utf-8?B?aWVqeVBuZ3FLSTczYnYwMTNoRjI4eTQ2OEd0NG9tZUFpczlKOUVRcm1YMVc5?=
 =?utf-8?B?UFkzdDNXRW5zV3ZGMUxNYnNrWTNBNlRleS95UkhCbkdhMjFETVRPaFJzM01j?=
 =?utf-8?B?THlIcXRoOGdRTEpqMzNxUE5TRmhiakk2QUQxYUVFQVRIYTEvQzNGVVVNU3Nq?=
 =?utf-8?B?OUhFMVBRYlExN05NeEQyR3JpdFZDdldFL3BYc0ROMHdjNEpnRXg4aGJZTmtE?=
 =?utf-8?B?YWU4T1QvQzJERlhTc3A4U09jcUN5Q3pqdG1Sbm4rOU90b1NGc1o1WXlHMFZV?=
 =?utf-8?B?dWpOc3lUZ1RUaXVwb1F5d1RZYmdGQVBydWVYOTdHVHF2TkNjWHFPS0VOeHJW?=
 =?utf-8?B?WjQra21BQ3EwWlBEMlU0bmFhQjNTQ2QzcFZYU2p4RVk1U2xmTlRBL0pOc1hB?=
 =?utf-8?B?L1lBdno5OERNMzRQOFhyRmtFaDFrcUFRemFKTkdDL0VNSFpaV2RvdEpNckY2?=
 =?utf-8?B?NDRkRVdUMHVCK1BaMHJuZTJGVkNrcVBEWWtpNTdVamc0NnZqVks1dFp3UXYv?=
 =?utf-8?B?MEEvT2prd3dkVTJFRFp6OGJHYmhBTHVScUkxSjhWemhTM0JFUVFobWo0cGlQ?=
 =?utf-8?B?aExuSTBJdStRQ1E3UlpSVnhhV2FDUEZ3dVNSb2l1ZVZvakpoTEpFVnBrREhx?=
 =?utf-8?B?ekJkbjJsWjM0RmFrd3VTdUt1U2ZXQkhyOGN5TDV0UE1tWkwzOUtZSnhHVklF?=
 =?utf-8?B?RGZYWEQ4aVRRWDRXVUN4a0ZKdTdUbVVUeHduZ280WFJxL0lQNFBIVjFibUp6?=
 =?utf-8?B?MmRXMmwwQlp5ZHY1YU9JQnZkQWdtUnpFa2sreit1YVFXWDlrdk9DOThVcjhI?=
 =?utf-8?B?VDQvY3ZQLzNRSzRvdnFrUVZibnUxcXc5N2VMOEZETVh4cUhwd1g2TzF6Y1JM?=
 =?utf-8?B?U0x3R3BQREt3TjdQVmtySHBXWEQrNHhlOCtGdjhELzBiYmZCOGhpU2dRNm45?=
 =?utf-8?B?WFlSVVhjSmpIbEQvKzNiNC9NNlAyQTJzdlAzUjhyZ0ZzVklqMzRnelJUQWF1?=
 =?utf-8?B?K2Q0WmRVVDkxU0JSeFdJekptMG0wTHB3aG9xZUN2R0lWVVA3NHNuMFQzQXZp?=
 =?utf-8?B?Wm5zLzZVblRmRGY4YW4zU1dsc3hKMnd3UStOd0MwcnhOQkYvMytkQmszeEdz?=
 =?utf-8?B?KzZqUHpNQjVXSGxMQXQ5NmJwNkxDL3BCblFRVzJ2cWZyRE92c3YvWmZPZ0lr?=
 =?utf-8?B?Zm9uamxCdVlLaVQzQ3dKT2lQcXdMWWhrSHBwdmYrRTFnWkQzUG0rZjRibXNa?=
 =?utf-8?B?bVFSaDVGUW5nVHRqcHJNa09nZEdqSWJzQlBQSjAvMlBiQ0NGNkl3Um5yNEp1?=
 =?utf-8?B?NWVtdjRXb083by9oQnlSY0JiUys4MmlVcEZiSitJb1dNS0pGd21qRys3d0Vm?=
 =?utf-8?B?UkhMS2V4K1crUGlsclZZWTZpTE5DaThVQXFEN0dSbHpvZ0FZaDMvWmhkWjBE?=
 =?utf-8?B?T0I2Y2JhYkxycldBaUlVbjU1WitZQzk1WTdPZXBTanZZeXFaUm9Od21zeFBw?=
 =?utf-8?B?d29uZGNnak5Yd0tMU2RUSWFYWWd3YWVxbzR0aCtBWjdDQ0ZLT2xGVlRGNXlO?=
 =?utf-8?B?WGdjbEYxR2M3cU8ybUo0ZFU2Nm0xeGwzcklBTmxpNlRQa0JXeE83R3QxY3JO?=
 =?utf-8?B?a1EzVzBpRmorWXgxOTFpSTlVNVlaRmhoYnNOcHgzR29GcXo5bDZwcHhiVHBs?=
 =?utf-8?B?Q29MWkIzQ3F5NUZCRXY5UjlhYVhQY3E4bkdsQmFYVUhxaHNzbWdYZmZCcWNu?=
 =?utf-8?B?VDZwUzM5RVpNeU44cWhtaUxIcVJEOEV3NDczeStYMFpOcnl3QnpJTE04TjZO?=
 =?utf-8?B?aXB2M2VrcFZZdktWZDhKRkRPWlNqdy8xT0U0aDZ1dU0vTGo2TUUyQk5CRUZ5?=
 =?utf-8?B?QWRpODFKK2ZLRnNycjVDMEZ2bkd2VU55TDljT1N5bnJZTm1xU0phN21ndFVn?=
 =?utf-8?Q?HVXj6GYFujwQVhB8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e3e9c6-f84f-4f38-fda1-08da384182a5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 20:12:04.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO3P0oEivtTg0Pc27LZhbJ2EUcWgYn+1zc8z3Y8wlZqmYBlVshDXp+40sVTAEltDmdRmazxLMaYfavR/OU7RoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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

On 5/17/22 12:28, Jason Gunthorpe wrote:
>> If you compare this to the snippet above, you'll see that there is
>> an extra mov statement, and that one dereferences a pointer from
>> %rax:
>>
>>      mov    (%rax),%rbx
> 
> That is the same move as:
> 
>     mov    0x8(%rdx,%rax,8),%rbx
> 
> Except that the EA calculation was done in advance and stored in rax.
> 
> lea isn't a memory reference, it is just computing the pointer value
> that 0x8(%rdx,%rax,8) represents. ie the lea computes
> 
>    %rax = %rdx + %rax*8 + 6
> 
> Which is then fed into the mov. Maybe it is an optimization to allow
> one pipe to do the shr and an other to the EA - IDK, seems like a
> random thing for the compiler to do.

Apologies for getting that wrong, and thanks for walking me through the
asm.

[...]
> 
> Paul can correct me, but I understand we do not have a list of allowed
> operations that are exempted from the READ_ONCE() requirement. ie it
> is not just conditional branching that requires READ_ONCE().
> 
> This is why READ_ONCE() must always be on the memory load, because the
> point is to sanitize away the uncertainty that comes with an unlocked
> read of unstable memory contents. READ_ONCE() samples the value in
> memory, and removes all tearing, multiload, etc "instability" that may
> effect down stream computations. In this way down stream compulations
> become reliable.
> 
> Jason

So then:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e42038382c1..b404f87e2682 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
         word_bitidx = bitidx / BITS_PER_LONG;
         bitidx &= (BITS_PER_LONG-1);

-       word = bitmap[word_bitidx];
+       /*
+        * This races, without locks, with set_pageblock_migratetype(). Ensure
+        * a consistent (non-tearing) read of the memory array, so that results,
+        * even though racy, are not corrupted.
+        */
+       word = READ_ONCE(bitmap[word_bitidx]);
         return (word >> bitidx) & mask;
  }


thanks,
-- 
John Hubbard
NVIDIA
