Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E255D198
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiF0Nv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiF0NvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:51:24 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9AB1C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:51:23 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RA6W7E026193;
        Mon, 27 Jun 2022 06:51:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=HSEhKMH26lyhW05bHZxA4fIAPOgsLcKm2j5gL8Gyl9Q=;
 b=lFrz+giWFuBrmnhbmq0C4kLk/gGfzT+T65l8Myj9qw/KgldEbkFtRUovcUqkymNtrmXe
 jOV2HH1DQNm0FUHZ2DCYy+ambE93UzaGj3aCH7I2z8qqI2lvJ6/R/5kBX15rAUcECNfH
 Jo2j+kDC6KfBJGBy4IyZuhpN3Zca4mTmNjugS2DJl4E8A1FeBCT3ZuYgvt/7IGS9p4VV
 raPSoG33yXHIWvn/3HxcOZ76QcvvqA3im4HZgCmn8BflMBup6TRUEES4Wf7wjv3zu9kp
 rnyVFSzploHI7DPBSO3LcGf7YymY3qerZYDbmf/IWT+rqzpY0ynQDJwh/TM/hUf9ujOg Qg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1w1um3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 06:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBls5VB8SMKmQbATcWjqT3frEgFdZItOfdNscNz7lj4Zn3U+DF5PaCeGsN7Zn1qabBJDrIUvYEykXG9HNWAUu7IXWhDDh+TC2pypT4hx+Yl3QsqC2nFOJk52ibtEo+VjV5F+5zLCglUWDA3rdGcF314RkbCHfdej3hvmj2r7q4nue1/30PM27KRFX+KcEXI0gfcn/yLl8lv81S17hEroBo5BvbyA/igG+fFoKswJ5XduBcNllRiaASrREgNl++r3BObEJLhO86FsrxprzMcU/s86zpWz6/vS4AUE5T5KsSjpBvh/fpQxKBU71L2wZjXog7hqyaQNih5PZKwuacQidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSEhKMH26lyhW05bHZxA4fIAPOgsLcKm2j5gL8Gyl9Q=;
 b=PiHg8w3yDC6xMv9yoJrkJ4VS6D5rz1KS9hV0p31n2FxOmH4N4OirVRAFPtHrIOLd+yxDCR4hbUTlV0WJyqSfvroPMGUWzn6AVkgbkuwgg3GBvaUndinYf+DCN5QYW38ZsSdMv40nh7MhTfItgcdRZEUcHRW+kIoarhaG5VncqOmuX+3YzwF5AFTeJDEyXKJKDKqZNhn7Kfhf2mNq9cyFDK8k5qZ/thxdYBK2qEAPWcDESeZJGp308bebiR5IFLehdjCnF3GnBFqHjTu3/ZQ10wdc1k3u5OMMvifYcDYJzfsPvhGfD1I726rB7QAjvD08jNSInZpQHgVPtVazOZtrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM6PR02MB6364.namprd02.prod.outlook.com (2603:10b6:5:1d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 13:51:14 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:51:13 +0000
Message-ID: <142229ce-fb50-992b-3b11-a1fb5f9175f9@nutanix.com>
Date:   Mon, 27 Jun 2022 19:20:58 +0530
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
X-ClientProxiedBy: SYBPR01CA0196.ausprd01.prod.outlook.com
 (2603:10c6:10:16::16) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cb2516-aed9-43a0-760b-08da58441988
X-MS-TrafficTypeDiagnostic: DM6PR02MB6364:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB0Vae2Z3RJd+J6noE+K2WAbmL2nDFqBPejl5mTu2PIH3ELJ6CFJ8rC2X4UPBg6ajigLFYTEjD0BdUmuMiQ5O8HY9R8lU0GKX6F8bktRjLVZ1pYiUCl5P6mwk7XfkRLUV8yjSUSPC72R5z45cyjMmFJjNK080M8ZgWt/92LbMYzodq/eS3e1E5pLTE49eZQNNixyu2gNiW9frpH7ShrGfuDPqqnQQ/12Cw4Kz2DJllhmBY7wci59mrtD7G+TN3APVOvkrrcxGqgTOk+jmjO7bpjeYB0//wYhlnE5DtjEBXZE/G5bXJEnmws/ZrvX7MJCOfMS7rMttHFKSJlyZIrEA+/Iq/qMS5krQtTOKFGl2o6dISlhGkYGohhvsgT+hhf9OTnQM/f1XG85IoDSMlmK2IaX2KNKLPgEdeTXR5kAdhimvalLjZEegZ+0X4Gu1eCJfGlJ4U7spVW17svD1kIuXv5j0P2St+1u/e3/mpHQnxzCrhGA4g4kL6GZJ94lsMS+3T/cBUAxlDjsNtVeHLaCba9e2GLc1R9Djo+BH08y2E3rnvGmOjarKgvuSlnVcfRsE/Ab0XR/hkKx1n+cVy+NyYLTdmGBU+zl13puM67EjAOKmtaOLq1gQxxgV5Rd9LhaWxhKalrT4nFLr6nFEFo6zpcl2hVCPYA0xZo7d7YcY380OFXbz928oMc0J/+Urya87V8yymM9miVAWaSQFZzk8CbCvn6cfgN0bPSfV21OLdAJZ94gdsyrqVIlxdt1rsoFRBAdTxenKQQXBVJGHyOKeATeoaxuf35dDQCJ81ehrEtR312E7XYBQTltcDehLtMP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(396003)(136003)(5660300002)(2906002)(54906003)(36756003)(41300700001)(86362001)(7416002)(31686004)(2616005)(8936002)(186003)(83380400001)(478600001)(6666004)(8676002)(38100700002)(316002)(31696002)(110136005)(6506007)(66946007)(66556008)(53546011)(4326008)(26005)(66476007)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNBbVY0SkUxUDdpZUtzWERDaWtUdDV6bGFibFlnWWdSUG93UnpuUXRZSEFB?=
 =?utf-8?B?VG1mWFZyVWJhNVozOGQxSUU4VTZISXFFTEVSbVVTSWdyU3Y4Zk96VFRuRU41?=
 =?utf-8?B?Ni9mUzRDVHZwYTFuM2o3MU01blVVVnNxNE5aTDNBTUtpMjhGaUJINWZoSHhq?=
 =?utf-8?B?a2UyU1pVVy94T2xxSktFMkNOYWhFQUNNK3ZKNE1vVDdtb1BZZ043VUhIU0ly?=
 =?utf-8?B?L01QT2xzT1g1YjVVaGtFNkRocUQ5WDVxM0g4enlucUprcm5IWkVQUmFOcFNi?=
 =?utf-8?B?bndtMDBhc2FtWVMvNk9XOUk4Y2ExZWN5UXlNeGVicXkrOEhNcHVhek1KSzZn?=
 =?utf-8?B?VmExQzRwR05pWHI0aFF3akErNS8zVlQ2ak4rMkVNc3h3d2VNem5HMnd2cC9u?=
 =?utf-8?B?OHBVbmREWk92TmlJRXdENXdXemdjQUVFZ0VVZThFTDd3YVQ0S2Q2VjVaME01?=
 =?utf-8?B?N2FnandVdkd6UGgrQVA0MUtBenhFTklnRGJTSHJEZTdCSmI1QndCTERmQWNn?=
 =?utf-8?B?MVFwcmRZNm9ocHFYV3k3emhNN2tvaEJDWU9MUVQ5RW80SjZEK2FvRVN5U0g0?=
 =?utf-8?B?bDh1R2JFTEgvM04rU29aaC9XOThYL3NkNEV0UFVVbkZ6L3RGa1pLSTlMb09H?=
 =?utf-8?B?bVJkT0hlS2tVS29ycmt2bFR1ei9mczVSWmdTZnByY1JaVjhBZ3BtWjVJVytj?=
 =?utf-8?B?WGlKYkhac3F4WGxodGc5RTRULzVxR1BqYnRCOHc2RUhuQitVdVBab00rQkc3?=
 =?utf-8?B?d3YvaVl2dzFQcHJZdTZoYkNRaVN0aEFhQ2FXRFpLQXJjamFydEp6aEZoNkF6?=
 =?utf-8?B?UFNIY1V0M0RMRDdMWmlBSGNtZmR1RHluVTdKNGtZdGlpM3gwTDdYY2Z2MVc4?=
 =?utf-8?B?Z1lRc1NBZ0gvdnMrMHA2d1N3Nll3TVlBdFJBRW1lUFVLZkNSdWZqQkJMY2dY?=
 =?utf-8?B?TWtiWHRyUmpRKzJLSmZ6MkNVZG1wVy9LRTZma0RIb3ZaNHZKcTE2V09kT00v?=
 =?utf-8?B?STRhVEhLcnd2TFhMYWNiV0VRUC9vcGl2N0pjVFpDQWxXdk5hb1NvZmNHRUVN?=
 =?utf-8?B?MzF5Mzl3T25WSVJ5cFV1K2twa01NeG1MZ1cwTGs3cVBadU5hRkZubDQwblBY?=
 =?utf-8?B?bEZBVnVnUTJ3NkpxRnhPWTlFWVhNNy9ud2tLNWU1WExFVC9QUUxLbVFUeWR3?=
 =?utf-8?B?THlaNXdpRlNPMWY5THRqUGpZL2g0ZUxiSDVqSUtaYk9pclpObmJzODlHRWJX?=
 =?utf-8?B?MUFZZGsyTllGWVFtQk5OVFRhdkJVMENuNzBPM1dxYjlvbk14RFNpRDlucElF?=
 =?utf-8?B?djRpaDJWK2lCQ3h6aHAzWUxuWHhKSzFsUDUwaHNiOXNMVW9QeXF5R3IvdkZJ?=
 =?utf-8?B?SlZqQXpURE1GWlFKM3ptS0ZLZzA0Z2NiUmlzUjEzK0JsYUk3TFJZSlZIbTk1?=
 =?utf-8?B?ZmZmYnFBYzI4QnZmSnMzNUdUbFpqTW0yWXk4eEhmeWlPZmVydXQyU29LR1hz?=
 =?utf-8?B?UFN0eS9oWC93dzhPVlhpUzV6K1ZFa3Z6UWI5K2FpczBNSFQwV2gzdGJ3OXIz?=
 =?utf-8?B?WklzMnFrQ0RjUVFtMkphZWdmWXJPdkphZUhIcmNmZ1ZNWHZVQXgzRDBXbVpM?=
 =?utf-8?B?WjFjY3M1VlREdzNEN0dISUprV3VXVzJkRjhXZ04yT0JBZXZLa1htSjRkZWZZ?=
 =?utf-8?B?SjZqVUVMM1lhblFEbDVIZFVnbUowL1hvbFZNays5NStaZUF4c0Z1TFI1MVBV?=
 =?utf-8?B?Q0NrU1o2OVhQQXFkK2FPeWdDR2Q0T2RHOXd1MlJNdzE2VWFqdnM1NTk2UU1l?=
 =?utf-8?B?UXdoUVJTUEh4eC92RG5nVStLNWdWemdUM0l4NGZyRHBhQTMyZzMybFlrNk1w?=
 =?utf-8?B?QVlmZVc3a1ppck8rMU11bU1tT2ZaczBaS2U3N21ob2JsQlpYUjdDbXlmZll2?=
 =?utf-8?B?Zkt3YUY4OGpyclNuY0pkclVSSGt1ZWhnNHFCY1A2cWpyc3NObXdSYzhWRTZL?=
 =?utf-8?B?V25vbEtueHlQUDVET1A5eU9ZY1lBYVdsRUR5QitSdWl3czdBdUt3d1hzZmdY?=
 =?utf-8?B?aFE0UmpLRTB5YXBsSGY2TmYrYTFESmVTckZuYUwxMVlsS3RJSXkwMHZBdnA0?=
 =?utf-8?B?V25Sb3FqT1NZWGVCMWpmWDVJN2VVQ3Q2dkp4VkQwWXZxYnNZS1RWSnJRU21x?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cb2516-aed9-43a0-760b-08da58441988
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 13:51:13.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFlt5QIUHxbrQntAO1LgqXU0UF5UIA6ZNViJOCSTYCPLX1zyBasrc9CDp6A2mbWLLTchShYuWAKdlpUNh8VBQtB/UXiStcpmRCurcewMqhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6364
X-Proofpoint-ORIG-GUID: WsWMcN4sx5v1nP_DL21v0I0D_nO356v8
X-Proofpoint-GUID: WsWMcN4sx5v1nP_DL21v0I0D_nO356v8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
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
can it be BUG_ON(hugetlb_pte_size(hpte) <= desired_sz)
> +
> +	start = addr & hugetlb_pte_mask(hpte);
> +	end = start + hugetlb_pte_size(hpte);
> +
> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);

As it is just changing mappings is holding f_mapping required? I mean in future

is it any paln or way to use some per process level sub-lock?

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

As i understand this for_each_hgm_shift loop is just to find right size of shift,

then code below this line can be put out of loop, no strong feeling but it looks

more proper may make code easier to understand.

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

sorry did not understand where tlb flush will be taken care in case of success?

I see set_huge_pte_at does not do it internally by self.

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
