Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA25602F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiF2Odw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiF2Odr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:33:47 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA211E3D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:33:46 -0700 (PDT)
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TCUXRa031333;
        Wed, 29 Jun 2022 07:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=NRHi5PXfqcURXdm+wG+KHaCJ5jWvHG7qokRuQFumo3A=;
 b=LAVpNjxX2aMWQDd/UYYtxbV6mDrz9heORDl9vl3eIMtBeytZVdVpbAZg+5okI5YHJf+k
 cJv5eVdWrWhgVCzDd1VL+nb56e/c430GqU2diAe5RtcwhEv7GgyfuHBTUaLFCQW3W6I4
 NIWC7yPtaKDTIAfOLmNM3NLttFHKf+owSYX/8jFBV0a/+TK6v3qVxX4gvWH3QZ7wXaFQ
 X2uzj+zujLRw4UUgKwDeUcBurQWkwrb8LgCeFknQww9ob4sGQsQvMMHJg4ln4AkBmMNx
 PtXKigjRbvALEy6B3acAsW8mYRfMjLOWa7+hxy7Ls6iNowRf6G4blTNfvk0RfKX74nWH 6A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1eh0w5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 07:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqqkcwK/RBmyAVy5/3MDBVBMFy5dJL/vFOrHHj4vjxKQ6yJoJ+en5uF+d4c4hHtxeLOt6XEkCuVCHGDDRJnCT6NAKsiVr0XvxItgWgzGDcITanaNRprgJ4hqgTCdrhRmZeW+xVbmrBuwdjuNQSPjtKOmK33zARNeaEfvLOrUEztizEguTjGj+I98lTrHNi82vkDeE2wGwkqQRFaRQttHytVnpN++6dWVKhPTz8VqqfJNQyAYjYJRnf6RkjGL5m4dAgLWbriLFMbcSbiTicIenFk0srUOjkYOWtWnCw28cWUzAGJSj+3DY2baUj3RPi/wef8O5bRe9ILDco9U8jBbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRHi5PXfqcURXdm+wG+KHaCJ5jWvHG7qokRuQFumo3A=;
 b=aibACFTrvKh8U/XiCcdu7nqu6bZcgGBS6HWGCWxlnOm5fqSM+/24S7GBZ7yiTcIhAMh6qvqgCllslv8EGQN7b4p/aOFXWW1RCD+jdfsXDQeOAzYUeNePHJdo+SEjv6R421MPtYzPNfsu9xjA7qnPREVdPTKrBEz+GhqTVycQifCLCk3e+B7Bgo7YPaIOlPx99Z5QUN08GN6vY5WxHztMxrd+Fb3oZMjAzaymzBphdLW7BMqMrnG9PX2GZOizWO9G3VJkD+81HjK+cBGELCkSzT8qOG64UDUkVIemRpbFluvUogj2UWFe5uIpb60CJgt7FprFEhJftI7crEKo5h4SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CH0PR02MB7963.namprd02.prod.outlook.com (2603:10b6:610:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 14:33:30 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%4]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 14:33:30 +0000
Message-ID: <54e46486-8886-f5d4-4900-8a250bb5e805@nutanix.com>
Date:   Wed, 29 Jun 2022 20:03:16 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 12/26] hugetlb: add HugeTLB splitting functionality
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
 <20220624173656.2033256-13-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-13-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3906e10a-98ba-415e-e019-08da59dc5633
X-MS-TrafficTypeDiagnostic: CH0PR02MB7963:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDlCampNp3jK99+H69xjodPe5rLk9WmYfNKkmn2+ZdKSZ7fCxQsdKSJgUVBHQym6BBKC/4LH2TOh7V6n1Q0azBrAWfWN3EJMk0O1nkSKBMaU1ygxOfj6rDA2JwkdQB4D9Aepot+a+rvrbEovXNax3WbtsAlxrHGvEb82IGowiXOCbj1Wls0Pip1yPt5+O808NyZoGbJCQn7RQE7woREjMYH/EsFSZ6SnVL3ECwKHbY4JH5+1iJ5QNoV/yNIwGuo5MpU1+Xf5OGgVGFEkBGVOQMIOUtNk+OKFC7h+sxfGD4NQGTbonQavk2//MnjV0jlnlZ8nEnCTmyZQvVMimCCXChIFIoCLEeIXaisP7F3obhE5w0ITSKzGxlbubu7ahtmPY76GhflILJp+Rcce/SgTxKAhsGb+FqVVuHFmds9B5lqc5mAdPysMzrQHmGnwL4ncn2u18MSQvc4WJqWeR0ltgIrz/DIFPan8vuuteP5BCCRPH22BxldlCna8r/hho+JbqVQ31EmzcybITohpJGPK+Jp4mQRe7wTtFYuH6lQQEJjKS+6Hq7qT0b9SvpGBM2mreN/yiLurE3R4Q/ACH+E/aNKwxk0oTRZ3P6B9Y8emmYsAvR4h2CgcnJ6kDraJgDjmjJNH3KaBCPtBaux3NYEIbtHSqz5aw8w9jOu384aItjeu5UALs6hL2saoCOLK2pGEfXj/wnduEk01pDNj+bTBaJEMitgKTxKR680W0rp3u0mhdtxGQVoIqXNmYALKCi5noSPbuZWDkIH0tc11diahva1+Tlw3W4qmeluldfGQ+bg/73MYChVc0S7R9FuiAFcN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(86362001)(66476007)(66946007)(66556008)(8676002)(8936002)(478600001)(2616005)(36756003)(7416002)(5660300002)(316002)(54906003)(31686004)(110136005)(4326008)(6486002)(41300700001)(6666004)(6506007)(2906002)(26005)(53546011)(6512007)(38100700002)(186003)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U004TEdoVHJNdzBrMlVsTlUwNzJscG5PNnhEbkVoellzN0lHQ0JMWTYxQ1hz?=
 =?utf-8?B?eVBTcFNlcHFPSmtNSU41RGpQUis1K0JNNDF5Z2lpNU9EdlJyUTIyU24ySUxS?=
 =?utf-8?B?QzdIY1l4bUVpVHcrMjJYdXN3anc1U2RQaXozNnU5TDc1RTJxc2NudmwxckhW?=
 =?utf-8?B?V2ZzZW5DUkVwZjQ1TDg5RlBNNkZzRS90cEZ6Y0xNSHdHNVFLU2R5Skc4akt1?=
 =?utf-8?B?VWZZUDE2TEhWZ3pVb29wbzh0TnArbXJqbDR5bzR5WEJla0ZqYjV1TG5lNThq?=
 =?utf-8?B?UEwraXU3Z3had3YxbmVQWG5tRXljNGxBWXJUUEhCaXVjSlBsSUVMcWxnSFB0?=
 =?utf-8?B?RG9MRENzZWh4STUwM1BDSDZJbkVoeTYrRG5Mb1hTRlhYaW83ZkZjSC9Nd3Js?=
 =?utf-8?B?aE8rbGVESVRIWUJ1WWdDY0tOaWRuamNGYXpFbkxoK3ZNVkRyc2ZIL21yQnVI?=
 =?utf-8?B?WXZoRzJpSVNXZjBlVjJQS090VlFCdmRobUZLM01IYU9JMVJadGhZdTRuUXdP?=
 =?utf-8?B?UE4yMC9pL2FJaUFoVVpDcjB5RklqdkVSK3JnZmJJayt3RFpVcWpsUXpzeXNY?=
 =?utf-8?B?NkhmSGxvcFNJTmNUczVzc1pzMEpZR1libXJNWXFTc0ozVHJVcXB3dlFINUNn?=
 =?utf-8?B?c0lkWlF2TTNYRXJld0RjWk5BQlJwT3dvZXVhQWlyUmR3UGl0c1BuNVhjU1Yv?=
 =?utf-8?B?UER6Y0xXU3NBdVRpbHJuR0dUczNCMWJvZktsRHI2Q24vZ3lhNGNTNDFpQUNz?=
 =?utf-8?B?NHhZUkpqZlYxTUt6elVTdXNWc0ZMamFRZ0U1WGY0cGJTbHpmdXBKWkd4aGpV?=
 =?utf-8?B?enMzamovVUdZSUFhUnJ5Q1B4ankxTHJBNnRnT2QrNk1oSlBTN0tRcS9Tcm9L?=
 =?utf-8?B?UEx4RjA3VzJMSHlsbEg5b3gydGtDdlhlTE02Sm9hM1d4N21XeHd5R0xLdUNJ?=
 =?utf-8?B?bGp1bytmY29EeUpxVzVQbGtPYjJhUHg4Y0RKdFdnL0loSDJLL2l6TXF6aSt5?=
 =?utf-8?B?VU5pVG52dzlnbDkrVm5qTy8ycUtHN3BxeVBNWFh4d1dFVndDb2lEaElYVmNp?=
 =?utf-8?B?dmNQbzdjYzV2cEN2V1dqZ0dzb1lsZ2FiK2dWaVpieU9BTTFIWGx2eWRlM3dm?=
 =?utf-8?B?djhQQ0ZMMEFMQW5zRUxSdEtMOWJPRGYzckxXV21MMDFOSGU2cXUvbXY2OUVS?=
 =?utf-8?B?a1J1MjErNk1namhvMlNTVjY1eTh6S2lKVEhyWmM1T2tTMER1eWo2V0t6dFpQ?=
 =?utf-8?B?bi9Bd0NUbGpkY3hhUlNrR283VC9JYUlNZWlyRDA4Y2xQN3htdlZ1cVltbGpJ?=
 =?utf-8?B?eThYYkJxb3cyTG04SXhScmZvbEhZNFA5T09aTnhvZ3EyMzVFMVllM1AvUkto?=
 =?utf-8?B?MGkzSlg5Z3Q0MGVEU0JwYm04TUZEaUMyWFNkWlRtL2p0aEdqTysxdjdiaVRs?=
 =?utf-8?B?T2NZOFJBdzRadlQ0ZlpJVStWUHMvT0V5Z2Z4L0dMdTlpK0JMdE4xRldOYzZ2?=
 =?utf-8?B?bkJ5NExFYXVaWFZhdGVGcHRTL2NrSlpaNFUxUFJSR0Z0YUJjUk9vVi9Ha28v?=
 =?utf-8?B?YnhrM2FUaXovM2NlU2JqMGFqK0dydy9sZXZFQUV6UUppSnBmOGhvTXFuMk5R?=
 =?utf-8?B?N0xyNFNNQzBtT3ZDTWtLUU14dVpjZW5MUUg0Ti9CVStiSXBLekxUekNQR0pv?=
 =?utf-8?B?cFQwdFNhV1h0VGx0aElpa21HYjBQb0lrRVFUbnFzaTZDdTQyRGt1Y3lHclVJ?=
 =?utf-8?B?dkR3RFcxbGUyYzBpVURSY1ZoNCthSVd2NnVuYVh4a3ZXK1NQaHdjUitWSzRB?=
 =?utf-8?B?Ny9ESyswa3hyQVNCRFJGeWF2OWZrbFFyMGNlVXdDNGtFTFp0TytJc1JKYU1W?=
 =?utf-8?B?Wjc4clZGSm9ML2MrTWlILzlvMG5venNGU0ZqeFN0OW1LUGZyajRyTDdXS1U5?=
 =?utf-8?B?YjNVTUVVb2ZzZEJNbTFuSGplZzVSMVJJaHNWMUFqbTJyRDhiZU9uQ3Z3Y2U1?=
 =?utf-8?B?d1FrR05GUnpGM3Zjc1V2SGNaSk1JTnVod1YvMXhCUWtNb29TVXVSN0V3V1JO?=
 =?utf-8?B?bm53RnNMdXVsT0QzelpaRHJRRkgzV0NGbE5QekkrdVh2VDhpQVZ1M3h5VUZj?=
 =?utf-8?B?aDNsdGlSRWlwazZUOFZxQjlJdXQrVy81S2hNcmdzdFM1Z2duODhiaGlPMVY4?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3906e10a-98ba-415e-e019-08da59dc5633
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 14:33:30.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQy+ifkFx8qzEJQ0/dzunRJg06u3VAyPvVDjsR3Sq53gxLPvaJsE2WF/aG/TAHQ2+L+VxmAqnNlrFD2wxDTbqlZLBl+U9HgAhgRy4iymyxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7963
X-Proofpoint-GUID: V_sg5qgX2uGKR9Zr1oD6V3msqafxhy1J
X-Proofpoint-ORIG-GUID: V_sg5qgX2uGKR9Zr1oD6V3msqafxhy1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_17,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/22 11:06 pm, James Houghton wrote:
> The new function, hugetlb_split_to_shift, will optimally split the page
> table to map a particular address at a particular granularity.
>
> This is useful for punching a hole in the mapping and for mapping small
> sections of a HugeTLB page (via UFFDIO_CONTINUE, for example).
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   mm/hugetlb.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 122 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3ec2a921ee6f..eaffe7b4f67c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -102,6 +102,18 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>   /* Forward declaration */
>   static int hugetlb_acct_memory(struct hstate *h, long delta);
>   
> +/*
> + * Find the subpage that corresponds to `addr` in `hpage`.
> + */
> +static struct page *hugetlb_find_subpage(struct hstate *h, struct page *hpage,
> +				 unsigned long addr)
> +{
> +	size_t idx = (addr & ~huge_page_mask(h))/PAGE_SIZE;
> +
> +	BUG_ON(idx >= pages_per_huge_page(h));
> +	return &hpage[idx];
> +}
> +
>   static inline bool subpool_is_free(struct hugepage_subpool *spool)
>   {
>   	if (spool->count)
> @@ -7044,6 +7056,116 @@ static unsigned int __shift_for_hstate(struct hstate *h)
>   	for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
>   			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
>   			       (tmp_h)++)
> +
> +/*
> + * Given a particular address, split the HugeTLB PTE that currently maps it
> + * so that, for the given address, the PTE that maps it is `desired_shift`.
> + * This function will always split the HugeTLB PTE optimally.
> + *
> + * For example, given a HugeTLB 1G page that is mapped from VA 0 to 1G. If we
> + * call this function with addr=0 and desired_shift=PAGE_SHIFT, will result in
> + * these changes to the page table:
> + * 1. The PUD will be split into 2M PMDs.
> + * 2. The first PMD will be split again into 4K PTEs.
> + */
> +static int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
> +			   const struct hugetlb_pte *hpte,
> +			   unsigned long addr, unsigned long desired_shift)
> +{
> +	unsigned long start, end, curr;
> +	unsigned long desired_sz = 1UL << desired_shift;
> +	struct hstate *h = hstate_vma(vma);
> +	int ret;
> +	struct hugetlb_pte new_hpte;
> +	struct mmu_notifier_range range;
> +	struct page *hpage = NULL;
> +	struct page *subpage;
> +	pte_t old_entry;
> +	struct mmu_gather tlb;
> +
> +	BUG_ON(!hpte->ptep);
> +	BUG_ON(hugetlb_pte_size(hpte) == desired_sz);
> +
> +	start = addr & hugetlb_pte_mask(hpte);
> +	end = start + hugetlb_pte_size(hpte);
> +
> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +
> +	BUG_ON(!hpte->ptep);
> +	/* This function only works if we are looking at a leaf-level PTE. */
> +	BUG_ON(!hugetlb_pte_none(hpte) && !hugetlb_pte_present_leaf(hpte));
> +
> +	/*
> +	 * Clear the PTE so that we will allocate the PT structures when
> +	 * walking the page table.
> +	 */
> +	old_entry = huge_ptep_get_and_clear(mm, start, hpte->ptep);

Sorry missed it last time, what if hgm mapping present here and current hpte is

at higher level. Where we will clear and free child page-table pages.

I see it does not happen in huge_ptep_get_and_clear.

> +
> +	if (!huge_pte_none(old_entry))
> +		hpage = pte_page(old_entry);
> +
> +	BUG_ON(!IS_ALIGNED(start, desired_sz));
> +	BUG_ON(!IS_ALIGNED(end, desired_sz));
> +
> +	for (curr = start; curr < end;) {
> +		struct hstate *tmp_h;
> +		unsigned int shift;
> +
> +		for_each_hgm_shift(h, tmp_h, shift) {
> +			unsigned long sz = 1UL << shift;
> +
> +			if (!IS_ALIGNED(curr, sz) || curr + sz > end)
> +				continue;
> +			/*
> +			 * If we are including `addr`, we need to make sure
> +			 * splitting down to the correct size. Go to a smaller
> +			 * size if we are not.
> +			 */
> +			if (curr <= addr && curr + sz > addr &&
> +					shift > desired_shift)
> +				continue;
> +
> +			/*
> +			 * Continue the page table walk to the level we want,
> +			 * allocate PT structures as we go.
> +			 */
> +			hugetlb_pte_copy(&new_hpte, hpte);
> +			ret = hugetlb_walk_to(mm, &new_hpte, curr, sz,
> +					      /*stop_at_none=*/false);
> +			if (ret)
> +				goto err;
> +			BUG_ON(hugetlb_pte_size(&new_hpte) != sz);
> +			if (hpage) {
> +				pte_t new_entry;
> +
> +				subpage = hugetlb_find_subpage(h, hpage, curr);
> +				new_entry = make_huge_pte_with_shift(vma, subpage,
> +								     huge_pte_write(old_entry),
> +								     shift);
> +				set_huge_pte_at(mm, curr, new_hpte.ptep, new_entry);
> +			}
> +			curr += sz;
> +			goto next;
> +		}
> +		/* We couldn't find a size that worked. */
> +		BUG();
> +next:
> +		continue;
> +	}
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> +				start, end);
> +	mmu_notifier_invalidate_range_start(&range);
> +	return 0;
> +err:
> +	tlb_gather_mmu(&tlb, mm);
> +	/* Free any newly allocated page table entries. */
> +	hugetlb_free_range(&tlb, hpte, start, curr);
> +	/* Restore the old entry. */
> +	set_huge_pte_at(mm, start, hpte->ptep, old_entry);
> +	tlb_finish_mmu(&tlb);
> +	return ret;
> +}
>   #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>   
>   /*
