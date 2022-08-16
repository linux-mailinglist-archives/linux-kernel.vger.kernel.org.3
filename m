Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D3595354
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiHPHFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiHPHFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:05:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A991367C6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5xbosBjU/lNdkaWRFs5L2PJNCxHFW/A0GbKJlvI6kb6ijnSt9tBBwhE2/6zia6wCppiB2dj2ogdVu0fUlUKquMWCKDa0Zzx825PkhhIvxKFQnQgsdhxsFKeDoNjtBbtHadaxWZNU8O9wzF7yOHEPwez5n+vh9vI58O2LlSfk2AY7M+G74gL3er2QMZ/2td7TG/QCqKDiIsKXnBsjhLubAIAfqCrSttsT8UcLGdSt64/TFbqA3m2FKa8hufJhyxxOCXh/9GzLPAbxpscyX9nj1siL71j5FFHt3vGoY5K4h9dCP+NH8ns5awwDdKB8chCQfXMhCPeHmQDqKp0GNeSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDKlatv2bmqZJ4bdx3J2Y6Vkpl8Ulu0oYEQXUam3I58=;
 b=YK8XnDWEEVJHpXmuYA3qvFOxhfby2vh9jO/oJkkvZarRSCflfPe+6dtlF11/wUbfPRPpQ5rsOG0OkjW4x9y4iSIRacYvJ0QjSpmwf6iOBxVaRk9FWa40AxYJgpopDbehwctXObCgudx9cFMRefoYLIOubHWovVRgfQG5c4yqBx/IpVsAMNqog7pL0VPsabone8IKyhheouYfdMyB0V+Nyutb8/B9NnQZJlOrLhEjcVyIPbylzpg2oLQyI6pKsTKIXoYwASo3xqjxmSqWlmyM7ozOnbPZKipSvIL2Ks/YpTscpAGOVpyzK+YefjebpRq0ft60G2X3o5zpdc4thT93eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDKlatv2bmqZJ4bdx3J2Y6Vkpl8Ulu0oYEQXUam3I58=;
 b=BMit2yuadumscikuR/iJAOOtN/02nN+rZY69m8Lm8CSFtA6FSWRsqnyvHasS7HjT4neb6LQd1zr2+T1qJnFM0uqbuBKHdQTVNPQz3NDBnidNCYMqnKwHpqpodnnIEBiRs9tCgHz7KwDzQDW3J3coZXzx0S2/h4kdHOCBh8FeKa059w2lEJmGSbRoh906mq4Ju8d+dw8LFqWuwZROPtCA1suz2u54HPFOKKpDOTjabPj0xW2W+t+ZdsBJmOc7mwCLib+db/n8Pd4Z1Oc7IgIj1IY1/PG7IT0cF4w5hLS9Hp3RY4pal27NDyHZn6m25WAAq70xNYV3Nui8EO7pub0QuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 02:49:26 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 02:49:26 +0000
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220815070240.470469-1-haiyue.wang@intel.com>
 <20220815070240.470469-3-haiyue.wang@intel.com>
 <874jydvxfh.fsf@nvdebian.thelocal>
 <BYAPR11MB34954F8869F88E8BD34035B0F76B9@BYAPR11MB3495.namprd11.prod.outlook.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     "Wang, Haiyue" <haiyue.wang@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v5 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Date:   Tue, 16 Aug 2022 12:45:23 +1000
In-reply-to: <BYAPR11MB34954F8869F88E8BD34035B0F76B9@BYAPR11MB3495.namprd11.prod.outlook.com>
Message-ID: <87mtc4vr64.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe518e25-02df-4c13-f295-08da7f31ee97
X-MS-TrafficTypeDiagnostic: DS0PR12MB6535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YapL7GD2Y4LSJYXNVrvJsTTK6oenp5Rh8IbN6UXQYvEehlenc99CIa1CTbEqECbKDj1sTR4hktRV/wduAEN7PY0ry/MxSmaPw+i833ZC2dBS0OJ+mX+TSJIcCUJYZfjwwthsbBP9Wth7ADfiIA6MsmjA1CYgxMcest5IIh+IaDULnVhzAtiAZTCfN3IQsKLRJGFR7tQ3KmSLu4h7nvFwxtF+8NcKWPygvFHK9xuQ5nsivukjSQf/4edTezD7fVm9p0NUQ/0cRKv2+HgopSO6YfUlEWOeQm5axKZhiLhDeR8mktDe1LVqwEV+kgspOY0h4KCejqjLK5zvKOjJbnEG4NqRPaPySFkotBP58sFBgefTUem+623lGGB0ykKoK22SG89x+We1ep2+g5iq42UH4vfx8ng1PRKzx+iMARnMaswiHVdHIXFrLffqZGw1dJtxpRxwMCBM39bYUog3o/+wUorp92a/oo33p7BT2TNivtmjndrAPfw7nPM+cBk2VDGaAfGKW9D474wYMJ14JHdemF+e+e6nY3W/49fzmnx5McEym9LW+Lv3hhVdyRtSUVphYiM/BscQsxxrQM9+8Tdp7MVpomJfZMm2p7nr2T158Go61fx6xJNe8eSXq2HKYsI0jhSDpBr3CSOGAorUXgk4h8k+8aCV4FkPG4PwhwRr89nvR2iKoHEQrLOEV4jFd/PJ46guE0JAJn63ghrr2yGgf7wjsir0G4NADR0pi/19t/U5o5A5srya5p6eOb4LOXrA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(66946007)(41300700001)(66476007)(2906002)(8676002)(4326008)(316002)(54906003)(86362001)(478600001)(83380400001)(6486002)(5660300002)(66556008)(8936002)(7416002)(6862004)(38100700002)(6506007)(26005)(6666004)(6512007)(53546011)(9686003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+dFRnAEIuk8EHor5iXcVNpSn+wAAp5tlqtZZKXKo6n2B2SDEUoFy5gz20k5a?=
 =?us-ascii?Q?lz3Wj3+blbX2mtju+Y9/Lq3u5GtxtQ1bffKot8HEpQdZ+zMAm6sslk3xEF6Y?=
 =?us-ascii?Q?mCspQTMNpVPYsCP7emtmESwZvlh/JEyo21JnFHxDUUa/8qbmeiQ637LEdiaP?=
 =?us-ascii?Q?Cs1yfeAcStfyPgzBqTW1TXcjyifg22U0bmWpDkeYuW1FJboSkWnMK/DkbC88?=
 =?us-ascii?Q?dUrprBMmCuF34TwHOrGyuEaTAQPht9RsPknPL2D6ycctwh+nC+iIqnCGw6Xm?=
 =?us-ascii?Q?I1rFlFzWU7mbgipKYuF4rdKbkJcN6i6JQIKuUvr0ucgmVJyluGSjxfVtENfl?=
 =?us-ascii?Q?r48mdoYcVfDtYPE+PgdlEWaz1umr6yflw6Kh4NkIb657RbX1hRbodP3BDdMO?=
 =?us-ascii?Q?Ho/KcYra7oMNk28QPvqYz4L2X7mt6HrHEIL1GgAlAlivmlRWzXWRSgp939F0?=
 =?us-ascii?Q?3cNGI++DC+U1u4Z0wR5j/EByXJdJCQ+HFg+pUoQ3iRccRpS2DLnWHbJrRG/r?=
 =?us-ascii?Q?oO+n3fxKb1lBkKhKQqyPEY4Qy08ivhi2vYnfHvPeeEEyFZ1HUuzZn2KMUBxO?=
 =?us-ascii?Q?CLrNfH20LMpmpTiMiZ3cKl+qFPP2k3ftD5/+P5uskrUz8v2v6JuWgkNC0A3B?=
 =?us-ascii?Q?urhsQNj4Qvp+5yoaZKCztcPpZ5kVO5k1bxWc92AcIJQvc74bR84aKqBqKaQe?=
 =?us-ascii?Q?J9i7i8QofoprsLL81aRUWbwbUJ+oKTSptGSmb/9bU4WyG/ziq4y+Q822SVRY?=
 =?us-ascii?Q?X+DAFeKZXMCZtncYYptIVpzVy3Wi881lhbubwmnn39YS5iOUughnXBEeScrx?=
 =?us-ascii?Q?J2qNa391AZW4NP9+bP/WyXIK0cigRVFpvTC/L1oT9vkSC81I9A4UvTsAuEj0?=
 =?us-ascii?Q?H0vxt4/KDmgOFxx87zA7UK0lnNd9U8Pb+R3T7FIxmDiyfy1xwBMaJ3tAxKoI?=
 =?us-ascii?Q?cYvDFfRDb4zH3ycDvJ8cCYIKbCPBm2MrZv2I/4lL4HUsOQ7ylBGLq9cMw4kD?=
 =?us-ascii?Q?VYRrFawOKBCQGO6suywBuhlpIj9kdAcSC9IQOwFyGCvO5X66hxnYxLZSww9e?=
 =?us-ascii?Q?MmGLnziu5P7/Q0/41Px2VBqKOQAaciryc4+Lqy5ziz+OTS00otPO37tTLbff?=
 =?us-ascii?Q?D5BbLg0WHrp44kUs54Myjmbj5J4YaG3Rfg0dn3BS/G9e7NRCsCTvI1/fPOoN?=
 =?us-ascii?Q?tBp2uUHlf6KUNIcOWsD9ydlH+YvwxT6GIKiHv7ADqjHAEP04E9JyFHZ2FbNu?=
 =?us-ascii?Q?VT02GkTD14uDXrodNXzQkhLpPOGEKL8IO8SjTSlJyLunY29RLDAjJbTCC+b9?=
 =?us-ascii?Q?RW1vuBYJ9U8f2Wb1PVCqo0WB1nDZFJPOqBTpgaoUtm1OPPgLiHnsGTowirkp?=
 =?us-ascii?Q?dyNf3nJflW88HWRxZmqPw5ZvzrJct3SAGYz7FreFKOWhaBDSuEPHkAoHcNMf?=
 =?us-ascii?Q?zB5ALFLO/ivegHMvU6nGkf7z4VUyDJV9CVvS8+ZCiHn5AUSAmBnI4hcqF+oR?=
 =?us-ascii?Q?eaEGTQ67vuKVIoVcKrBT4rD9lC9nS6R0kgAve9tNss3/SaAu/LxCFoDRmjGq?=
 =?us-ascii?Q?YzE4K6scIzz/W2Y6BNOEQQh54JSbIO0XXXBWuQ7z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe518e25-02df-4c13-f295-08da7f31ee97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 02:49:26.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCI1Q5j5/DKOHmdPYppcceLYN6nU88yVV3KrElNwYQroX1p0sGVGl0Xb/xlRhS/bCA5Gpt7PNwfUbBPfXqTt5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Wang, Haiyue" <haiyue.wang@intel.com> writes:

>> -----Original Message-----
>> From: Alistair Popple <apopple@nvidia.com>
>> Sent: Tuesday, August 16, 2022 08:01
>> To: Wang, Haiyue <haiyue.wang@intel.com>
>> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; david@redhat.com;
>> linmiaohe@huawei.com; Huang, Ying <ying.huang@intel.com>; songmuchun@bytedance.com;
>> naoya.horiguchi@linux.dev; alex.sierra@amd.com; Felix Kuehling <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH v5 2/2] mm: fix the handling Non-LRU pages returned by follow_page
>>
>>
>> Haiyue Wang <haiyue.wang@intel.com> writes:
>>
>> > The handling Non-LRU pages returned by follow_page() jumps directly, it
>> > doesn't call put_page() to handle the reference count, since 'FOLL_GET'
>> > flag for follow_page() has get_page() called. Fix the zone device page
>> > check by handling the page reference count correctly before returning.
>> >
>> > And as David reviewed, "device pages are never PageKsm pages". Drop this
>> > zone device page check for break_ksm().
>> >
>> > Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
>> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
>> > ---
>> >  mm/huge_memory.c |  4 ++--
>> >  mm/ksm.c         | 12 +++++++++---
>> >  mm/migrate.c     | 10 +++++++---
>> >  3 files changed, 18 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> > index 8a7c1b344abe..b2ba17c3dcd7 100644
>> > --- a/mm/huge_memory.c
>> > +++ b/mm/huge_memory.c
>> > @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>> >  		/* FOLL_DUMP to ignore special (like zero) pages */
>> >  		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>> >
>> > -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
>> > +		if (IS_ERR_OR_NULL(page))
>> >  			continue;
>> >
>> > -		if (!is_transparent_hugepage(page))
>> > +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
>> >  			goto next;
>> >
>> >  		total++;
>> > diff --git a/mm/ksm.c b/mm/ksm.c
>> > index 42ab153335a2..e26f57fc1f0e 100644
>> > --- a/mm/ksm.c
>> > +++ b/mm/ksm.c
>> > @@ -475,7 +475,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>> >  		cond_resched();
>> >  		page = follow_page(vma, addr,
>> >  				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
>> > -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
>> > +		if (IS_ERR_OR_NULL(page))
>> >  			break;
>> >  		if (PageKsm(page))
>> >  			ret = handle_mm_fault(vma, addr,
>> > @@ -560,12 +560,15 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
>> >  		goto out;
>> >
>> >  	page = follow_page(vma, addr, FOLL_GET);
>> > -	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
>> > +	if (IS_ERR_OR_NULL(page))
>> >  		goto out;
>> > +	if (is_zone_device_page(page))
>>
>> Same as for break_ksm() I think we should be able to drop the
>> is_zone_device_page() check here because scan_get_next_rmap_item()
>> already filters out zone device pages.
>>
>
> The 'page' for scan_get_next_rmap_item() is from 'vma' which is NOT MERGEABLE:
> 	for (; vma; vma = vma->vm_next) {
> 		if (!(vma->vm_flags & VM_MERGEABLE))
> 			continue;
>
> The 'page' for get_mergeable_page() is from 'vma' which is MERGEABLE by 'find_mergeable_vma()'

Oh, ok. I'm actually not too familiar with KSM but I think I follow so
if you think we need to keep the check by all means do so.

> So they may be different, and the unstable_tree_search_insert() shows the logical:
>
>  'page' vs 'tree_page':
>
> 		tree_page = get_mergeable_page(tree_rmap_item);
> 		if (!tree_page)
> 			return NULL;
>
> 		/*
> 		 * Don't substitute a ksm page for a forked page.
> 		 */
> 		if (page == tree_page) {
> 			put_page(tree_page);
> 			return NULL;
> 		}
>
> 		ret = memcmp_pages(page, tree_page);
>
>
>> > +		goto out_putpage;
>> >  	if (PageAnon(page)) {
>> >  		flush_anon_page(vma, page, addr);
>> >  		flush_dcache_page(page);
>> >  	} else {
>> > +out_putpage:
>> >  		put_page(page);
>> >  out:
>> >  		page = NULL;
>> > @@ -2308,11 +2311,13 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>> >  			if (ksm_test_exit(mm))
>> >  				break;
>> >  			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
>> > -			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
>> > +			if (IS_ERR_OR_NULL(*page)) {
>> >  				ksm_scan.address += PAGE_SIZE;
>> >  				cond_resched();
>> >  				continue;
>> >  			}
>> > +			if (is_zone_device_page(*page))
>> > +				goto next_page;
>> >  			if (PageAnon(*page)) {
>> >  				flush_anon_page(vma, *page, ksm_scan.address);
>> >  				flush_dcache_page(*page);
>> > @@ -2327,6 +2332,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>> >  				mmap_read_unlock(mm);
>> >  				return rmap_item;
>> >  			}
>> > +next_page:
>> >  			put_page(*page);
>> >  			ksm_scan.address += PAGE_SIZE;
>> >  			cond_resched();
>> > diff --git a/mm/migrate.c b/mm/migrate.c
>> > index 581dfaad9257..fee12cd2f294 100644
>> > --- a/mm/migrate.c
>> > +++ b/mm/migrate.c
>> > @@ -1672,9 +1672,12 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>> >  		goto out;
>> >
>> >  	err = -ENOENT;
>> > -	if (!page || is_zone_device_page(page))
>> > +	if (!page)
>> >  		goto out;
>> >
>> > +	if (is_zone_device_page(page))
>> > +		goto out_putpage;
>> > +
>> >  	err = 0;
>> >  	if (page_to_nid(page) == node)
>> >  		goto out_putpage;
>> > @@ -1868,8 +1871,9 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>> >  		if (IS_ERR(page))
>> >  			goto set_status;
>> >
>> > -		if (page && !is_zone_device_page(page)) {
>> > -			err = page_to_nid(page);
>> > +		if (page) {
>> > +			err = !is_zone_device_page(page) ? page_to_nid(page)
>> > +							 : -ENOENT;
>>
>> Can we remove the multiple layers of conditionals here? Something like
>> this is cleaner and easier to understand IMHO:
>
> OK, I will try it in new patch.

Thanks.

>>
>> -               if (page && !is_zone_device_page(page)) {
>> -                       err = page_to_nid(page);
>> -                       if (foll_flags & FOLL_GET)
>> -                               put_page(page);
>> -               } else {
>> +               if (!page) {
>>                         err = -ENOENT;
>> +                       goto set_status;
>>                 }
>> +
>> +               if (is_zone_device_page(page))
>> +                       err = -ENOENT;
>> +               else
>> +                       err = page_to_nid_page(page);
>> +
>> +               if (foll_flags & FOLL_GET)
>> +                       put_page(page);
>>
>> Thanks.
>>
>>  - Alistair
>>
>> >  			if (foll_flags & FOLL_GET)
>> >  				put_page(page);
>> >  		} else {
