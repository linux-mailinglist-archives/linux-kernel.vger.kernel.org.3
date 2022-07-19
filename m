Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9050F5797DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiGSKso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiGSKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:48:40 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521810FCE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:48:39 -0700 (PDT)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J5n3fY001881;
        Tue, 19 Jul 2022 03:48:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=z+U3OcwQkgRDNC1K4to6Fwv6Re5PM+X/7AJR8lm4/Qg=;
 b=uIwQLar64BK3rELq3ka9jqiAnUkVModo81/zbProjxROiKYpVNNOa3bMKXgIPaWTnJ0M
 V4qxds3R1lwy0tWGK2zNWIi4pH8NphMR5NFsBB4TtUJjZrLbuPJfNswHLRp+zh4FMVHG
 9lxBhmB+s4uZwpXRp4hYHE/mKAcRoVQ+ltTBY81VnwSqRZUEeYB6k+0L/WI7oRSt378Q
 HUSbJx0h0sjiVjH5xumIlcOLWvLYE7aGO9gDL76K9HTISlqj6Ef8Yt1vcEuAPE3Zt+/N
 vb+4EXUzwj4btUhs/vOwO/GdO3YV+dspg3WjmH46yj3gdQfRpctsyr08ZJ7hE2/2GxQT qw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3hbs87wyt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 03:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqvTpvxUQTMi2yt2TAbSHx42K2WbRnqQ6wnCZkatKZEWuWxuE+eRAWki7yVW76kf+VGUbfvWcrss8564uUqLnjiTtuRSlc65Ttqj1IoF2xwl7QJbFEMK5kOWZ95+CAjAsKg/FHaPggStO8DJaiCbS+2ibj9gNzev92EUkSrEUQzeNQLZHeaNeCmWRKUNRqnZMuBeseNzjcCrkp+bj8cTqujidK0V75pkQgIlno3F57hzkJrg+lK5R88MRQYd/4mvkUappPFZlfVkPwg9nz7UvLf6JPANAmJ31qKymIWMVe+bzwLBOk6UIIX6YsgxHrmk9cHebQ8AlEOkG+4IzY+usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+U3OcwQkgRDNC1K4to6Fwv6Re5PM+X/7AJR8lm4/Qg=;
 b=VRdaVD1JfTqYL9AUTsrK5FP5Eg9uQSvZrc64zb4JKyjM+9CC4NEdfmvodrBTp3iL44QpNc710D2xSM7KdnVDjToRunvIcsmlWtScpZ9FDWQKNIkgvK5QYYsOcaqhevxAFox3IMNHGBCZtVo6QuO4HSdLzyRpdJXnF/x9IU1/LfzwaUSpECvcpTVqembwQGBugiYDQHh421IwYf9uW9mN57XZA5nSFEeGzhac0jee7uY2Xx/AkUimtTm2mi2w/wnkbADWMjQf9sXJAuDtFZxzYYnRrWe0gK36BOV320Nvx0/WyMR9GyQl2IJ/VX3I6+M33N72j6xHyG1/VPt2gQZR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SA2PR02MB7738.namprd02.prod.outlook.com (2603:10b6:806:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 10:48:27 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::fcb1:6348:1169:82df]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::fcb1:6348:1169:82df%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 10:48:27 +0000
Message-ID: <673a3024-bf82-3770-b737-4c7e53e70fe5@nutanix.com>
Date:   Tue, 19 Jul 2022 16:18:11 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 17/26] hugetlb: update follow_hugetlb_page to support
 HGM
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-18-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-18-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b649a6a9-7966-44f6-4b72-08da69743649
X-MS-TrafficTypeDiagnostic: SA2PR02MB7738:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDqeyrca8z63t0JKQGyt4an8lEqtFc6mGUWqPTIkWAAkP3spyN+IQ7VkVDcTijkoPFaZvrkpnjQEOPDbO/16t94DK01vC1GXwmTJm2Vw7hDpHQhDhIwF3ZfKIvQDbo/kr3Fy5EjO1Df4MAnbe5ppF97Nb8ch45Pf+UGtBiN5R0PAFzj/PMH70c1VJi+1j6O/KZzEGta3NOhERpOMRFtT99W3R2obTU6tmC2nsKKMY6iH98w0LXubccZDgjnX2tZzOduNI7kxqNRa/9JRp51REBBK8MBXH0rCWFQiaj2fb7z97HbaCiR1LQ88h8Uzsnj6SiylilvErbAxqLkT1QiOBgr3CrkvTdRUv3/0FH+URJYoT3sDN+7GVed2BNiO8J9lK7XgTsmIugl+di2HOpVzxkYjvzoYrl1Uv0SPRWHDYyyETqHzv/o2YXKK3v3XaVpeH3d0XsOkGkwWsa3v55bDTFwsppzHPkQJvCPQ3m+QoD7suiaNLohc2zkM2Fl3RDzWl6RgqXHNiyn6kJQuh67Iq00ok/bQZMp8sMusnz+Q90X6hLKEDWo/5gp+Vmz5scE2t86HYsUlYe9yYR2v5w5wKnWG22X2F+BmGpbMJee2HUvGfz7NQbCkVmdrnzWyRwDL++odv9v1d2nBU3l7ZDrusR5YuW/WCWltTGNXMeSggFIC93qP411NP6p4FqJ5Ul5mDTwqZErNZi+Vo/eGRYSH0D4ZgBWlrTvWl06jIw+d5CWmmRVJ6ba1jGutWRbPuPjxvVDCwr/BWCJMEdWzd1v4XVFypjoH2SqAU+0O0WZ0sX3FSpesxmnvri/IFZG6+HBhd6n1PG665UdLFhvBFpdKSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(39860400002)(136003)(396003)(54906003)(4326008)(110136005)(41300700001)(53546011)(6506007)(6486002)(6666004)(478600001)(2906002)(26005)(7416002)(6512007)(8936002)(66946007)(66556008)(8676002)(66476007)(5660300002)(316002)(83380400001)(36756003)(86362001)(31686004)(31696002)(2616005)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJvdzVqTm1zeFJpbGxvUERkRlR3YS85c1RMajdkN2RVczBrZkhJYnVwK1dx?=
 =?utf-8?B?WUp2T0h6MUdwMWFEQkY0SmxGdFN0VWk5K3c5ZDhTVHlyZitETkZyR0o5TGlH?=
 =?utf-8?B?OFRzUlduYnBvT01BZTJuV3dYM0UyYUdxa0w2WFlKWjc3bjVTTkJzL09lV0NI?=
 =?utf-8?B?cXpQZDNLb1BIRFpvN09hb2gwWXdOS1ZOYzlTdUpDWlBhbisvV0JybWtQYlZu?=
 =?utf-8?B?NVdOQkhYN3Y5bFdUUTJTNmFjYWpJa1lidVQvQmZBZzU3TDdNdVVLbnJlMzdK?=
 =?utf-8?B?UnRHYjJLRER6TVJoeFJsS3NyUTFFMWlMWEpwcU9CQWY1QzVueW9TNTltcjFJ?=
 =?utf-8?B?TnpUM0Y2QU1FR05VLzJkbVhNcG9YeENTcndtdHpITTM5SDhNNFV1TDJGQzVE?=
 =?utf-8?B?Z3hQcVllbHpVb2ZhSWlLTjI3dVFBWCt4czVCM0krVCtybVBoYWcyVW9La1U3?=
 =?utf-8?B?RmNjcE9LR2VUVzZtUmJRcWFkVlZnMC95MEVnaUJZdW1VSkh0WW1mMTF1MmNk?=
 =?utf-8?B?cHNCTmpHNE9zZGR4d0FFRG00VlFYekV3RDYwWm1idk53WjNEV1l1YXFSc1Q3?=
 =?utf-8?B?SFlTRDdzUUlxeTFLWU04c3g0Z1h6YTVoTFRDU01IbW5xc09PdUk4QUlIWml3?=
 =?utf-8?B?clBJeWpPRGdFK2FRTnlKOUVSK1dIVHF0TkFzdW95TVdQVXdQWXhkRnJsc3Jo?=
 =?utf-8?B?Nzhxb3FsUFJjUkRycTRFM2x2YVhHS05KUFNNNmZ2blpJVFV2OXJkRTdmeWNq?=
 =?utf-8?B?bWE0Y0p3RmF4YWFXUHFJU0lIN3htdkJSOXRxb0JEQjhCd2RTRlJWc0graEtK?=
 =?utf-8?B?SUQvT2Z6ZExjY3NWMHFmcjNZUGxlWWdBd2d1RjZDMzg2SWd3eEdmTHBoRU5j?=
 =?utf-8?B?ZVB5aUN3V2NHRTBiUWh3MDJidTEzS1ByWXpCbmxMa1Y5WWphQ0NzRmZ4RXB5?=
 =?utf-8?B?T0k2MmpWMTdDY095dmF0Z2ZBVHpsRUlxSU4yNVM1dHprOVNZUTdqM1YzWEFM?=
 =?utf-8?B?eFU0d2lyb3MwZjUzZjdNYVM0WGpIbGtvaUlJcWc5MGk0UUh3UjVrSHcwb2Mx?=
 =?utf-8?B?ZGZJd1Z5emc5eXJOdTlrSmxvSlJ3c1VxMEg1eHVkWTZZU0FXZDg5Mzh4QS9S?=
 =?utf-8?B?a0JGTEpCcXd0Ujkwd09RRFVGL21Ga2JPMDZhUjUxN2RpWERXVGhyOUlLYTI0?=
 =?utf-8?B?QXp6ZzVSTTV6cVlaUEs4WEMrTHFQclFjdmJvdUhlWWpHZ3RGTU5nTXpVOUg0?=
 =?utf-8?B?bkIxN2RXK0xCWHkwaXNSbHkxUTBJWjRtQzZnTHJMWHdQZ2ZWNUNzbHljTzRy?=
 =?utf-8?B?OXpud01BQnJocnBPM0dXanAvdXlnNjZYUFNoNklmZ09oQjc4R2NNRFowQ3dL?=
 =?utf-8?B?cjUwaVhxbElKaUhCTVVNUUpBNjRZWW1iTEo5R0toMktXQ3YxY1FnRm0rN2N4?=
 =?utf-8?B?NUZxaW9nSnhOVTVxM3BOdC9EM3JyTFlxaERLQnpTcEVwemt0NkwvTW53ZUlR?=
 =?utf-8?B?cFMvamx6VXhFUWJ5YXd4R3c0M0pGMUl4WVVXaEV4b2FmTGJRRTJuZXR6UzRS?=
 =?utf-8?B?b2NsbXJNaVl4bXFNQkovMkJMVVAyNVo2NUZTMDNGNXR3RXJUZlU1OHN4SFF6?=
 =?utf-8?B?S0s4c3RncTFPdmFiUnJsUW1SZFp4RTNDUk0wS0l4cjJXZlhSRkxTaHhNWGtr?=
 =?utf-8?B?cVQwcGhGc3NhektxTGdjNWNqbk5sQ2E5cTVIQU1lVVMvVURDQm5SVWF3YTJ1?=
 =?utf-8?B?M0lIdmdDL3hsZ0tUdVFuNG1NcTYvMnc2N2U2UHEzSEZGYUFySzA5dEFScldx?=
 =?utf-8?B?N2twSmNTaXBVS2FCRjRTRTJmQTlqTVNuVDQveVBVak9VTjdzMXhjODhQMjZj?=
 =?utf-8?B?b3RYRGlGZnRpd0FJUzRMai9EUDNEUFFuYkJRc29iMmtoT0QvNmpmL2IrM1RW?=
 =?utf-8?B?SXRVYVlKNDBnd1Y5aTZ6Y3hReldIcVRqOGFEY0VzNWpScEd4M0tBUlFaZHF6?=
 =?utf-8?B?Sjd0eVRCODVtcTFJUU9kT1N2bm5YSTlHY0V1VFQxRG1acjg5aVVYRE11NTFE?=
 =?utf-8?B?ckRIM21TNWwzRnRrS3J0d0ZJSlFkN3J5cW4wZGp4WVFiV0wvSnVFQUN2UGNl?=
 =?utf-8?B?WHJVZTVJKzdVdncvak16aU5XTCtXZWJaNTUraHp4N0lCdG5UTkUvR2hiY1VR?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b649a6a9-7966-44f6-4b72-08da69743649
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 10:48:27.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPBihyLuzFl9xhqXzyrXzW2EVy3Fr35iQk6P2o1aCEPcp65tBRfHuBV+ciaMxaFbkXzWrsF0c3AkHJezRgcJ4LgyaE1Ed++WMOzvxxuegCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7738
X-Proofpoint-ORIG-GUID: jcMwp_Hjnzqx-Fy5qpTy4TFDgP9kjMSO
X-Proofpoint-GUID: jcMwp_Hjnzqx-Fy5qpTy4TFDgP9kjMSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/22 11:06 pm, James Houghton wrote:
> This enables support for GUP, and it is needed for the KVM demand paging
> self-test to work.
>
> One important change here is that, before, we never needed to grab the
> i_mmap_sem, but now, to prevent someone from collapsing the page tables
> out from under us, we grab it for reading when doing high-granularity PT
> walks.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 57 insertions(+), 13 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f9c7daa6c090..aadfcee947cf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6298,14 +6298,18 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   	unsigned long vaddr = *position;
>   	unsigned long remainder = *nr_pages;
>   	struct hstate *h = hstate_vma(vma);
> +	struct address_space *mapping = vma->vm_file->f_mapping;
>   	int err = -EFAULT, refs;
> +	bool has_i_mmap_sem = false;
>   
>   	while (vaddr < vma->vm_end && remainder) {
>   		pte_t *pte;
>   		spinlock_t *ptl = NULL;
>   		bool unshare = false;
>   		int absent;
> +		unsigned long pages_per_hpte;
>   		struct page *page;
> +		struct hugetlb_pte hpte;
>   
>   		/*
>   		 * If we have a pending SIGKILL, don't keep faulting pages and
> @@ -6325,9 +6329,23 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		 */
>   		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
>   				      huge_page_size(h));
> -		if (pte)
> -			ptl = huge_pte_lock(h, mm, pte);
> -		absent = !pte || huge_pte_none(huge_ptep_get(pte));
> +		if (pte) {
> +			hugetlb_pte_populate(&hpte, pte, huge_page_shift(h));
> +			if (hugetlb_hgm_enabled(vma)) {
> +				BUG_ON(has_i_mmap_sem);

Just thinking can we do without i_mmap_lock_read in most cases. Like earlier

this function was good without i_mmap_lock_read doing almost everything

which is happening now?

> +				i_mmap_lock_read(mapping);
> +				/*
> +				 * Need to hold the mapping semaphore for
> +				 * reading to do a HGM walk.
> +				 */
> +				has_i_mmap_sem = true;
> +				hugetlb_walk_to(mm, &hpte, vaddr, PAGE_SIZE,
> +						/*stop_at_none=*/true);
> +			}
> +			ptl = hugetlb_pte_lock(mm, &hpte);
> +		}
> +
> +		absent = !pte || hugetlb_pte_none(&hpte);
>   
>   		/*
>   		 * When coredumping, it suits get_dump_page if we just return
> @@ -6338,8 +6356,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		 */
>   		if (absent && (flags & FOLL_DUMP) &&
>   		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
> -			if (pte)
> +			if (pte) {
> +				if (has_i_mmap_sem) {
> +					i_mmap_unlock_read(mapping);
> +					has_i_mmap_sem = false;
> +				}
>   				spin_unlock(ptl);
> +			}
>   			remainder = 0;
>   			break;
>   		}
> @@ -6359,8 +6382,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			vm_fault_t ret;
>   			unsigned int fault_flags = 0;
>   
> -			if (pte)
> +			if (pte) {
> +				if (has_i_mmap_sem) {
> +					i_mmap_unlock_read(mapping);
> +					has_i_mmap_sem = false;
> +				}
>   				spin_unlock(ptl);
> +			}
>   			if (flags & FOLL_WRITE)
>   				fault_flags |= FAULT_FLAG_WRITE;
>   			else if (unshare)
> @@ -6403,8 +6431,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			continue;
>   		}
>   
> -		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
> -		page = pte_page(huge_ptep_get(pte));
> +		pfn_offset = (vaddr & ~hugetlb_pte_mask(&hpte)) >> PAGE_SHIFT;
> +		page = pte_page(hugetlb_ptep_get(&hpte));
> +		pages_per_hpte = hugetlb_pte_size(&hpte) / PAGE_SIZE;
> +		if (hugetlb_hgm_enabled(vma))
> +			page = compound_head(page);
>   
>   		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
>   			       !PageAnonExclusive(page), page);
> @@ -6414,17 +6445,21 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		 * and skip the same_page loop below.
>   		 */
>   		if (!pages && !vmas && !pfn_offset &&
> -		    (vaddr + huge_page_size(h) < vma->vm_end) &&
> -		    (remainder >= pages_per_huge_page(h))) {
> -			vaddr += huge_page_size(h);
> -			remainder -= pages_per_huge_page(h);
> -			i += pages_per_huge_page(h);
> +		    (vaddr + pages_per_hpte < vma->vm_end) &&
> +		    (remainder >= pages_per_hpte)) {
> +			vaddr += pages_per_hpte;
> +			remainder -= pages_per_hpte;
> +			i += pages_per_hpte;
>   			spin_unlock(ptl);
> +			if (has_i_mmap_sem) {
> +				has_i_mmap_sem = false;
> +				i_mmap_unlock_read(mapping);
> +			}
>   			continue;
>   		}
>   
>   		/* vaddr may not be aligned to PAGE_SIZE */
> -		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
> +		refs = min3(pages_per_hpte - pfn_offset, remainder,
>   		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
>   
>   		if (pages || vmas)
> @@ -6447,6 +6482,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
>   							 flags))) {
>   				spin_unlock(ptl);
> +				if (has_i_mmap_sem) {
> +					has_i_mmap_sem = false;
> +					i_mmap_unlock_read(mapping);
> +				}
>   				remainder = 0;
>   				err = -ENOMEM;
>   				break;
> @@ -6458,8 +6497,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>   		i += refs;
>   
>   		spin_unlock(ptl);
> +		if (has_i_mmap_sem) {
> +			has_i_mmap_sem = false;
> +			i_mmap_unlock_read(mapping);
> +		}
>   	}
>   	*nr_pages = remainder;
> +	BUG_ON(has_i_mmap_sem);
>   	/*
>   	 * setting position is actually required only if remainder is
>   	 * not zero but it's faster not to add a "if (remainder)"

Thanks

Manish Mishra

