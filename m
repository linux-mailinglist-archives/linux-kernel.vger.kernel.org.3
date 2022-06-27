Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD055C344
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiF0Mrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiF0Mrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:47:43 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C57FFD34
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:47:42 -0700 (PDT)
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R9aFC3032403;
        Mon, 27 Jun 2022 05:47:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=i9pc1dOVmAck8cC2Grb0ccnKOQhdWutDESmMjEc0/ww=;
 b=BJaN+n6khhYXaEaBdMq/7M83dcHQEKnGVy+IDs/MyM1kmXz/U8XJU4cUJpXAP3vG1XvJ
 qAISXEOYbMJ5DUb07qQ6iZR1WAG2X6wIDGc4rmG7u3XHtUMumnK3licyLTluqUnC5NPr
 hlfL+UB5GqnwujX8AjvBb6nVfpohnmGYHNV3hh/VH8v+Vgg4CBuut87uIaJwF1N6Clsu
 JWVyEQaTPdpYL4oruQvrqcCbfH+UHUYFebQ0rzg1rGHFX97cUDQSDxJayfxE5Qdq1xKm
 4nJw4/A6r7ueLlPU5TfXfL3rnbN2zN/2dMPttw6yTNcB3XIFtr+HWIxsSqmDlfod0M1z TQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1pfkg97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 05:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPmGH8pEVAYrstbmBYXjV6m1VkeR1KPwbxCsvV8hbpzncTd0IRlxwVuOy6NqZGL6Pqv4l2SqFqawkmusmGHTphaVpKFlpbnynRwAOOf8mljWV2vxkCXN7cXjvfC6jbSDvXPJnY4Ut8q3lyCBCV5NywTOSzJ1h4RU9+wmDd8Z5SrueaeWIVk1DiMmtvvQJcAbT5v6A1rGiIHh5PdiVOVGiHAYGnh4OHRReZkvTJ2I55ITh8oMtYholpbujPwUBQ16ZaxO4i4YdPFYgF1+d4P+ILUltNUEqYCwrRgz58ynZTjWwFLEUI/ZTcHB0gIsQPjV29fHMgqUxzUZAEhVknElyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9pc1dOVmAck8cC2Grb0ccnKOQhdWutDESmMjEc0/ww=;
 b=Xgfdd6WTQf1+eUo94GZKW07YaF8Y1npKJ3vLfMo7lKP8u0AhL7e6/tVRk27895nrJ9p3whetLThhsfJQo4L47Qer3cLlOk2J9pz+RWm4zy8oaT5f8sl8mcXOrRsTJGrSQ99EqkO3MwyKrD6E2NmKT+3yDK21SClE4R2baGSJYm84FZD8QqZs/vxs3ZCDboaxDOV7fHEefm1EPcQ93mLImNc+gB6Q9eu+gTyhNjg2PyGV83rJfqxUuMLI7r80EyNq4oTwTxY66bNdG3cF/ILcrWHJCtCQKjhm/EI/Vm4Rx212NE6smJUoHw3ROM2pnNtT6WFrZ2lGfFn0/6eqGEGEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM6PR02MB5706.namprd02.prod.outlook.com (2603:10b6:5:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 12:47:31 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:47:30 +0000
Message-ID: <562b3cbf-19dd-0453-855c-d4bc1c599230@nutanix.com>
Date:   Mon, 27 Jun 2022 18:17:12 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
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
 <20220624173656.2033256-8-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-8-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYAPR01CA0014.ausprd01.prod.outlook.com (2603:10c6:1::26)
 To PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 424f0daf-b99f-48d2-5df6-08da583b32b9
X-MS-TrafficTypeDiagnostic: DM6PR02MB5706:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogXvbBzSNjEvjp7KRbwYOWTQLzjAY+Au9N52WKsbNpVVIZpLLVeHmCTzkSPKyjSEGKOnM1jGpoMusz4z9DOkv6k23Tc1jorsJBwLfX02IPqJNq9TNpuKtVEQcjzQ+gUxvqM56F+mXYG0foiEUfVx2IC8Fb0PuIzvQnZtX6UqjUpCyE8YEkAr4pOcJq4Btssp8E6LGYJJhmqMF9DdeCsToxEzIOnctiV4xkTjzyHQQs3mDT0T8X+PO3xawMQ6t+Ne/X/a4cbUNuMPlEoCIt6K9D1jk3bflz3qnrLfEMj7bYdEIr1y1KwKHniow5woXmyAgORHscQKWp3ZE/JeX08y8FwqP05vcsiN31NDi/O1Sxi+NwjnNYVA1R67TrNqklf5yQW9ZffGiN2cl+wDpPkHVF6XihY7S1SiVfVhSMwIMj1ZRxsOfjzCIjr+kC+OqDQfmpmkVRaa0dEK9vUFE2MZVxX4qTDptndsG4hC0x1MCg8wmI6G8doYTI5EQo9ObmB1gOoC7s2gLo+4uBqoyGh584JLp0bMefZXXRMX/f+bClcUjWlelivRJivS9PHxYQNQY5fbCF6+ivmQ+Tk0ymF/+Jt1c4+VJfiVEsJV96Nas9Fq1vEfXRThXbFtf60aqkLA0D3f/nR720ZgzOlJ4JkYn/c0JFz6Gk5kS2l36gBOC62QN9viesZFg07NgOpdQJxvfa2HTsfaycqADAqIL71vif0fhZF1JkNrJRNTIQYwkbaeEdDV9a/ROCLoSDxImbDtrKJWWxc+JqLX6sAG70WBKuj5rEBw7kQQXL70ZWz3ktUhMnv1TcGGY4rLySok5IX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(396003)(366004)(4326008)(54906003)(26005)(6666004)(7416002)(53546011)(31686004)(316002)(86362001)(110136005)(5660300002)(2906002)(83380400001)(41300700001)(36756003)(2616005)(38100700002)(31696002)(186003)(66946007)(6512007)(66476007)(6506007)(6486002)(8676002)(66556008)(478600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFoNHRvNmIrUS94UUEzelNPKzNYVTQ0eWxNUHFzbElDblpSRjZBdFY4MWh0?=
 =?utf-8?B?K3E1RXU1OWUzMlJBbjJkRWxiVkdmcWFxMzBVSmU3TEhSVExQK2xhKys2aU9z?=
 =?utf-8?B?OGlNU2w3T0RSaHVEWnF2aEloOXBtUmMzbWNLdFZ0UUIyUytIMWo0VVBSTDRN?=
 =?utf-8?B?ZWtKeXNhVnpuWm8vU1k5dEdPcnZPenllWXZRcU1LVG00bEhFakpheXJHeTRP?=
 =?utf-8?B?S0FoY0NPY2R1b3Y0TENkeGJ5Wk52a0JMSHRpNlR2Z3J2OFgyZS96TmYzV3Q0?=
 =?utf-8?B?NkpybmJhaHIxYVJ4czJaQ3dRTElFMFRLNk5oUFdUekp0TG5YckZtSkNudW8v?=
 =?utf-8?B?MHVuN1FzY3hwNDd1SlF4ZTRqZlFsMFpyTnpNYjZXUEJ0aHV3L0dQT3M3c0hS?=
 =?utf-8?B?T1hDQ2VTanNuSkdVRXlPUTVPZ3RzOXBGaUREVGd6aUdVY2xYOUREdG1qcUJF?=
 =?utf-8?B?am5ic3IvTUxmNFNubEkzbU9LY2tueWx3MUk0ckRxVnU5aGJoaW40by8wR1Zi?=
 =?utf-8?B?T0N5RDBQamNUQmtRNkxrZTkyQUVGUXdJcEZxVE5GWFdqTVZHYU1hdnhYWXJp?=
 =?utf-8?B?VUJzekFTdXpXNUNnUUhFL3Y3Vk4zOW0xRllvWHhIUDJBcXNhM2I2dWlPQTFt?=
 =?utf-8?B?WDdERkdPRUdSZFZkV3E3QlNrSkl6c1k4VUYyelJ0TVZmRUZpK0hhWUdkVlRp?=
 =?utf-8?B?RkNUV08wWS9NeEpIUmovbndRVERxZTFoTVV3ckYwakpNTlZ2eGFlTDZKdTFF?=
 =?utf-8?B?VnRWZ2ExNENJdm5Fclo0YWdwdTdwUStEQjUvci92aGhuaDZ5V2YwRTFRQ0Y4?=
 =?utf-8?B?MzBlWnUzSVlyR3oyUnhYREpheUhaaFBqMlRvanByUk9lVjRjS2NlbHBJZkU1?=
 =?utf-8?B?dzBOSHI3aHRaV1VaOFg2TVhUVmhtS3pPZFhkYnpweHRONGhoZmt5TStXZEdU?=
 =?utf-8?B?Q2tnVGoxd2swQUI5dVA1UjFhSGRhczVCSGwxNkdrQkNabndIRFIrR1NjSlRz?=
 =?utf-8?B?bzdGNGtFSFFDTU9QWklHWkNQS1V0NVdabUpXSTRyQStjK1lQY1JOcmwvME5U?=
 =?utf-8?B?aGVpYmVwYWVmZ1l2SW44c0t0QTdsTndEVDdwVWYwMmpqSVVMYnZYV3hacWNE?=
 =?utf-8?B?NkJxSFU2a0gvMCszQ0xod3M2M3d0OEUwczVVb3NyVG4wZHZzVDZiQktQSERK?=
 =?utf-8?B?Ny9VUW51S3RFekM3UjdOOFBnN2YwS2lUek1vUlZuN2QvVkZ4ajVuanltek9s?=
 =?utf-8?B?SWlXeWg5cHRpSlZtblkrOHpIWU1jc3hPMklwR1o5VHdyQWlYaFh1c1FpMEJ5?=
 =?utf-8?B?Ly83ZktuekljdFdBcVYyWVpRU2IxYktyZmVRenpoK2dkdFRuTjU4empMRmVZ?=
 =?utf-8?B?NUdiRnNkY0FnSWFwZTFOcmh0VC9ZMHNHTVk1UUZrcFhCQWNEa3lXMlIrTHh0?=
 =?utf-8?B?dVA5VmNJYWN2VkpQRnVFckU4OGUyR0VnKzFhVmJTUDIxdVNHYTVia1NNclJl?=
 =?utf-8?B?YzNBb1RxUVFvQnFUZE4ycFFUZWVEOE9sME41aExreU9ENmwwWXNDWTJZSkVr?=
 =?utf-8?B?WmxGbHo3SXZiYXZHUjFGZUZuUC91Z2s1Qmw1VVlkTitBbHM1bjFoZHBNUjhn?=
 =?utf-8?B?a1dSZzY5enA0MVFjUzRXd0RpcFk4RE5BSGtVb2p3UGs0clJjRVloVjZrenh6?=
 =?utf-8?B?anVzTklDazdlQk40eUphaGxOdHY5cjhFa3I3OGdacmlEWlBIMnBvR2hJZ2hN?=
 =?utf-8?B?RjYwTnhyTmliVllpb1psM2F6K2htdDBnL3h6QnNpU1NEWHJINHpwaTRjd0hp?=
 =?utf-8?B?WTBoeTdRUzJmWW54WEJGRk9Mc3g2K1FzZlo3TFl2NUFZQ0xwT2t2emxTR3dv?=
 =?utf-8?B?dWpaYkNkWDJMTnNqYmhqQlo1TUJsSkNBdTc0c25VTGltbjhJMHNqb0xhVjRO?=
 =?utf-8?B?ZnRNNWg1TXNBWkxFekRhcldoNllFWFV2RkhWNWhvN0RyMHpVbXlHNjBacmVk?=
 =?utf-8?B?Ynl5RXdWb01WTyszc2ZTcDBNMng4aElkQ1d1Qk1KZGtIV1lpc0NUYloyKzFU?=
 =?utf-8?B?K2JLMExBbXlycnZKTFdFMXRPbGVkN2dPcjVwam50US9wNlIreFhtMDJLdzhp?=
 =?utf-8?B?R2ZqMm9EZmZtd0R4cWdQUVhyOEMzdTRJYjIxWE96YWdyV2xOL3VsdFN3V1cr?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424f0daf-b99f-48d2-5df6-08da583b32b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:47:30.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz7KJR0yT+RWa/RbqW8HNslIYXa83ZLhpTkh7kEeUVFZ5EKnwslQPUoCi2/+4cWWxVZvrlbV3UgmI2rcgTTRRnjHrRKJ/loS6gY9cONJg4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5706
X-Proofpoint-GUID: ZaAxUhm3VesgTPj4NfXqjK8mA8DIx28_
X-Proofpoint-ORIG-GUID: ZaAxUhm3VesgTPj4NfXqjK8mA8DIx28_
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
> After high-granularity mapping, page table entries for HugeTLB pages can
> be of any size/type. (For example, we can have a 1G page mapped with a
> mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> PTE after we have done a page table walk.
>
> Without this, we'd have to pass around the "size" of the PTE everywhere.
> We effectively did this before; it could be fetched from the hstate,
> which we pass around pretty much everywhere.
>
> This commit includes definitions for some basic helper functions that
> are used later. These helper functions wrap existing PTE
> inspection/modification functions, where the correct version is picked
> depending on if the HugeTLB PTE is actually "huge" or not. (Previously,
> all HugeTLB PTEs were "huge").
>
> For example, hugetlb_ptep_get wraps huge_ptep_get and ptep_get, where
> ptep_get is used when the HugeTLB PTE is PAGE_SIZE, and huge_ptep_get is
> used in all other cases.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   include/linux/hugetlb.h | 84 +++++++++++++++++++++++++++++++++++++++++
>   mm/hugetlb.c            | 57 ++++++++++++++++++++++++++++
>   2 files changed, 141 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5fe1db46d8c9..1d4ec9dfdebf 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -46,6 +46,68 @@ enum {
>   	__NR_USED_SUBPAGE,
>   };
>   
> +struct hugetlb_pte {
> +	pte_t *ptep;
> +	unsigned int shift;
> +};
> +
> +static inline
> +void hugetlb_pte_init(struct hugetlb_pte *hpte)
> +{
> +	hpte->ptep = NULL;
I agree it does not matter but still will hpte->shift = 0 too be better?
> +}
> +
> +static inline
> +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> +			  unsigned int shift)
> +{
> +	BUG_ON(!ptep);
> +	hpte->ptep = ptep;
> +	hpte->shift = shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> +{
> +	BUG_ON(!hpte->ptep);
> +	return 1UL << hpte->shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> +{
> +	BUG_ON(!hpte->ptep);
> +	return ~(hugetlb_pte_size(hpte) - 1);
> +}
> +
> +static inline
> +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> +{
> +	BUG_ON(!hpte->ptep);
> +	return hpte->shift;
> +}
> +
> +static inline
> +bool hugetlb_pte_huge(const struct hugetlb_pte *hpte)
> +{
> +	return !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) ||
> +		hugetlb_pte_shift(hpte) > PAGE_SHIFT;
> +}
> +
> +static inline
> +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> +{
> +	dest->ptep = src->ptep;
> +	dest->shift = src->shift;
> +}
> +
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte);
> +bool hugetlb_pte_none(const struct hugetlb_pte *hpte);
> +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
> +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
> +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> +		       unsigned long address);
> +
>   struct hugepage_subpool {
>   	spinlock_t lock;
>   	long count;
> @@ -1130,6 +1192,28 @@ static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
>   	return ptl;
>   }
>   
> +static inline
> +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +
> +	BUG_ON(!hpte->ptep);
> +	// Only use huge_pte_lockptr if we are at leaf-level. Otherwise use
> +	// the regular page table lock.
> +	if (hugetlb_pte_none(hpte) || hugetlb_pte_present_leaf(hpte))
> +		return huge_pte_lockptr(hugetlb_pte_shift(hpte),
> +				mm, hpte->ptep);
> +	return &mm->page_table_lock;
> +}
> +
> +static inline
> +spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> +
> +	spin_lock(ptl);
> +	return ptl;
> +}
> +
>   #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
>   extern void __init hugetlb_cma_reserve(int order);
>   extern void __init hugetlb_cma_check(void);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d6d0d4c03def..1a1434e29740 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1120,6 +1120,63 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>   	return false;
>   }
>   
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
> +{
> +	pgd_t pgd;
> +	p4d_t p4d;
> +	pud_t pud;
> +	pmd_t pmd;
> +
> +	BUG_ON(!hpte->ptep);
> +	if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {
> +		pgd = *(pgd_t *)hpte->ptep;

sorry did not understand in these conditions why

hugetlb_pte_size(hpte) >= PGDIR_SIZE. I mean why >= check

and not just == check?

> +		return pgd_present(pgd) && pgd_leaf(pgd);
> +	} else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
> +		p4d = *(p4d_t *)hpte->ptep;
> +		return p4d_present(p4d) && p4d_leaf(p4d);
> +	} else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
> +		pud = *(pud_t *)hpte->ptep;
> +		return pud_present(pud) && pud_leaf(pud);
> +	} else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
> +		pmd = *(pmd_t *)hpte->ptep;
> +		return pmd_present(pmd) && pmd_leaf(pmd);
> +	} else if (hugetlb_pte_size(hpte) >= PAGE_SIZE)
> +		return pte_present(*hpte->ptep);
> +	BUG();
> +}
> +
> +bool hugetlb_pte_none(const struct hugetlb_pte *hpte)
> +{
> +	if (hugetlb_pte_huge(hpte))
> +		return huge_pte_none(huge_ptep_get(hpte->ptep));
> +	return pte_none(ptep_get(hpte->ptep));
> +}
> +
> +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte)
> +{
> +	if (hugetlb_pte_huge(hpte))
> +		return huge_pte_none_mostly(huge_ptep_get(hpte->ptep));
> +	return pte_none_mostly(ptep_get(hpte->ptep));
> +}
> +
> +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte)
> +{
> +	if (hugetlb_pte_huge(hpte))
> +		return huge_ptep_get(hpte->ptep);
> +	return ptep_get(hpte->ptep);
> +}
> +
> +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> +		       unsigned long address)
> +{
> +	BUG_ON(!hpte->ptep);
> +	unsigned long sz = hugetlb_pte_size(hpte);
> +
> +	if (sz > PAGE_SIZE)
> +		return huge_pte_clear(mm, address, hpte->ptep, sz);

just for cosistency something like above?

if (hugetlb_pte_huge(hpte))
+		return huge_pte_clear
;

> +	return pte_clear(mm, address, hpte->ptep);
> +}
> +
>   static void enqueue_huge_page(struct hstate *h, struct page *page)
>   {
>   	int nid = page_to_nid(page);
