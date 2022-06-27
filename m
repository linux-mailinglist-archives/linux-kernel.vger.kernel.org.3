Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29B55C12F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiF0NJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiF0NIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:08:46 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2911144
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:08:18 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R900Nx032526;
        Mon, 27 Jun 2022 06:07:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=OH7EGTzCd30t3nDCaVjoSuH3nYevtYCQuFuHgKUzOtA=;
 b=vE7lb11dhKQKnIFC3+3QpYwBeyRpE9/U+fhIn+rZLEN//g5YJjzNlvftAlwbGwm7g+1E
 b57uJWiCLD92nK34ZlyfArHe+om4/xr8BiV2wdAnHDjixnd+nJrhXUHFRDwdwrGQ4wGX
 N/dRsDgX3n6f/Jclczc6G5BqgYpu4ZdEF8vJ6Slnn+dLELb0xT5W38xp+yGrIARHjT4B
 CXFyzegnx+rm/AOHRPRje8mo+OQrnHqq7MNuvn/qlFNI2VRz4VKQScuIu+2+FbJqe3m2
 0MDFIPJjqkQ2nuxnewYqj+V2MMuMemKmC4uBoJ4PL7HsAltC15yHzJsyOCBkgTotC4O1 Lg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1w1uhea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 06:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGn7/9rWXCt9wuiLFT43e+yFnanIUFaL9BAuQvhYTwynZKDYL7E6CLDtxi44qnpTMKTdZWeqOYSU6eYxZMPIYB/g1obqK/62VPL4qd9zz5yCuf0gE288r9sx5WFJ8JE6lryDC2JIhGnw8PvVT9ZcXYTLxEI2p1Z2YbqbQbCtue48bTW8P6+uiIkh00ObeyGx/PyayY/Lp0hVlgwK6yF5Nv82eOSOPxYjdS5I2V0sQPy4ASNHEWefJ/HVEUt0IEwjbYOADmr9K6FWsNSjZ2UmJn87eI1qLCl8BMMl+lwip2Vkzw9k3xCNk0Z0UELvtviFrub9jerzfYYmR4xhjdanbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH7EGTzCd30t3nDCaVjoSuH3nYevtYCQuFuHgKUzOtA=;
 b=NRPtcqxnFCNtyow9HE3MoFS5gA9b3iI8d3yCh2a5d5d3hLHx04CO20kdacZKL+V+E3VMLdtOgphyt+VBxo+7VO7Y7x3L7LbiPVFfG+BLhpXdE8WSZogkj0L7XH5U3LOuhGwdInpxZ9o8viGHhWajam+fuaZcbczb/QXH2GmDCmDPEDVHF+1I4PkOiXrCXsTBIleH6XiXey+1UTHZaHzI9/vhjcJUj4hU1t68GTpfZbf4Aikm1mddzw8Xolm8NOenDC6beVMgcqftZ6727hsSHFSaLdxwnJPzL/oj2CQ2sO101jEYFe+jZ8wPqDjF9y22LA+aBnVzswyeS2XkPVYnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SA2PR02MB7851.namprd02.prod.outlook.com (2603:10b6:806:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 13:07:53 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:07:53 +0000
Message-ID: <ac95fce2-b095-62ff-7f87-d803572e39f0@nutanix.com>
Date:   Mon, 27 Jun 2022 18:37:34 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 11/26] hugetlb: add hugetlb_walk_to to do PT walks
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
 <20220624173656.2033256-12-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-12-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0113.ausprd01.prod.outlook.com
 (2603:10c6:10:1::29) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efd3affb-179b-46ea-8426-08da583e0b65
X-MS-TrafficTypeDiagnostic: SA2PR02MB7851:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXAZAWNV4mDkJ0ICQ7JrUZYo9Ym1plx+PxbWRDIb90FKmP73rQOlXhBoZ0nFAswOxOaTSmOq9YwxRgxZLBtsXA5cmFCXEs577Z66Fk29NTt36oM7+AmmKbBRIRxepCiDLQK0n/kJ3/NwqK/sZoeIoEMzD15TpghMRxwErdP5OSIFqLY1MKVLJGadYNPjCe65A1bakgB6MqTsOSiWZhnTYO4UIYPRSCRBpO51XQh1i2xzYWIRQ8iEvfjGdKT6JPCdrr+o1IePF58GSYVGxBgcbV5PFfLjLQv58vWOmf+8wNQE2XowdOK3zps+b686g7BkUI29c7WKTIQStvQvotodVdkVUEVBvZLIeXcrxVjSRSTVw62vyGpRFIwX/fgIHKWVGGaB4UInKGXu5hIqh9cuuSCR/QYE6cHekyM646sSm1fgqGfCTpdusuxbCACqUSmFrX12e78G/1YPXrRavUO4gEvTPxuJHJO3rtcPstNOn4zUyFnrk5khhVBR/wtDp3+JMazB3WANb1lmeyvb2RS+/Y7iCjTVsJ03+nb4yJduj6Hg5/AF8uUGVeTeFAkFXoLLoIudh4+o748gcEe5/C7ji5ZhlmQkVrMf6EzDe8FvMn3dwnx5H0pH62RA3mrxOgu7b8UcGtajyRUFqbDPFb30U0GNm5OZmugbdaweyF37pkxNxjj6f4iDO5totnjl6CZe3nPVQEDpCKa/uUbuH8pHUF8C3sy+ya/Ok/EGqtxR0x6/3GHo1ZsbB5x/3CKtlA2FC67pZ+iPWEX4yUMvqpHwTvbcKd91NLz9DTztHk+Twf6kilo6pLSEtvksxocL5tsN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(346002)(366004)(39860400002)(53546011)(2616005)(110136005)(478600001)(26005)(5660300002)(7416002)(54906003)(41300700001)(66476007)(6512007)(6506007)(66556008)(8936002)(4326008)(86362001)(186003)(31696002)(83380400001)(38100700002)(6666004)(31686004)(316002)(36756003)(2906002)(66946007)(6486002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhBcTVNM1NBN24vR2c1eVlLOXhKME5xamVGSEJROTRZbVFWVWdTMzQ3TTJw?=
 =?utf-8?B?b2V3WDJCK3JTSUdrMkw2Tlc2T3Rvb3k5bEEvck00L0xQUTF1U2hoVVZTNVZy?=
 =?utf-8?B?QlNSYlZ4UW1UcmszSjhtYTREbUZHZkpRZ3BPRGw5aHorbWdFeHpPeDV0L09U?=
 =?utf-8?B?WmYvSUtqUFdGU2JkSEJpS1luZnFSNFFyb3VlZG0zUWtlLzByV1RFeEtmdFJk?=
 =?utf-8?B?T2lqTHVCRVI3NXJVS1BRcEVjZkVubHlxMTRmdkRsbzFrMy9udE5TaU5FWFUx?=
 =?utf-8?B?ck1DNVI1V0h2RG1ST0NlMXJreTVtQS9RV2FsVXpCdGNZdTMzejhmbTRybWxp?=
 =?utf-8?B?bjZMTHRwalYwV25DckhldU1vZjREY0xMeHpmWC9WbWZ5RGRvc29ucEVJc2hG?=
 =?utf-8?B?bFhzWWJsQzJ1bGYwUUNnY2RQN3gxeDRiM1ZyaWozZElZeTdHeDVzVnpSazAz?=
 =?utf-8?B?U1ZTLzFXbXVSVDExempFVGZEYjN4U1JMb056bmRjdnZhUUZUdWorcmlCYjRP?=
 =?utf-8?B?YVV5Q0t2N3pJRlZmVlpGTHB3OTB0cGV6VzZ3QUQ0ek0yZ2YvcUoza2lFV2F3?=
 =?utf-8?B?eEZXV1N1MjBVMFZ0NHR4d0xSZ0diY2V3RkZjSjhUZ2dxcncyM2NKOTFWVHhF?=
 =?utf-8?B?cWRVT3ZOZFRua2xrMWQrUEZ3TUtIaHZRTmg5cUVrNy9zUXBVUzM4VzZsdXJI?=
 =?utf-8?B?aHB1d0hkODhGUFVIRTYxOVA3ZTdzdGFGMTAvS3VKMXdkSUV1ZllZL2RzM0Mx?=
 =?utf-8?B?VkhialNkNENQUlhXWnVwcUFtNit0V1VzKzIxck5heDlYS1hheDcxdFB5TUtG?=
 =?utf-8?B?cUl5TjQ4NXdqWnpMMTcwZ0ZubjlOMkVFd2xwNTN1VWJSUFJoQk82Y3pWUGF4?=
 =?utf-8?B?NEg2K3J1M2YxMG1vSnZJdEV1KzJoRlBJTWRBZVhyMnVMMXU3KzI1WDRnRGZ6?=
 =?utf-8?B?cmw4YXZBQ0ppcjZSTm1tdlRzRVp3c0R4dGJsTEJMUGFHNlFGYjB2NGVibldq?=
 =?utf-8?B?RWVqYTI1emlxaW15bVpyVDRpRXdyWCtWUlc5akdYM21Xb3oxNDhrTGFWM2NN?=
 =?utf-8?B?Nk9OQ3B5L2thSFlCdFpINUtNYmhjWGxMK0p3NXkxeEcwR2RwZFBwQ1duOXZp?=
 =?utf-8?B?VHVoUUgrdUJEVDF6WTV6aXA5cjM3dHY1UkxUNUp2WlFuT3lRMkthazB2Mndq?=
 =?utf-8?B?SGZWWEZhR0g5R3BPZnJ6elNCQklUenhVRUpDRXZjR3R2WjlqWnlqakRpZjM1?=
 =?utf-8?B?YWVTZ0EyUVpCL0RSSUlLZGlPV1p2L3VTSUhZWnN6ZnB1d1hBN1JSbmQzbXFU?=
 =?utf-8?B?dzZlYy9xNGZJdXViZmRXSk04WVJqYk1wNkg2aEQ5a3BybjJjelF6dHFMeks5?=
 =?utf-8?B?a1BkSGIyS3JCWGlNVkRhL21SVzdoaGhUUEd4WXdzZWx4NlpnVzZjdEc2MDkz?=
 =?utf-8?B?QVlHMzgzZkx3NGtRNlJyaWdZaEM0TzlKR3ZkNlo4SFhKRHdFODExZzVuT2ps?=
 =?utf-8?B?b3dycy9MM3pLeW1vbCtocUdlS3BKMFN3NkxmUStlT2FpY2dRYlF4NGM0RDJ2?=
 =?utf-8?B?OGtheU5icmdGb0JIblcvU203MjhCNXZIRzNDSEZLcThlMVdFQ01qSGNaeHBZ?=
 =?utf-8?B?SVkxUmtVWFc3VHFpYmQwVTkxZFFBL2RhYlRFaU9YcmE0a3dZZEZBSW5tTXRZ?=
 =?utf-8?B?UmR4VWEyOWtnL09rSjd2MjNWQUl3ZkEwNmRNUWJ1MXM3ZUxDaWMrVmE0WWZq?=
 =?utf-8?B?WnNMZ0pNNTlPazNZTno4eU16dTlmd0ZEeHJSQ0dHcWhzbUJNMys4SE5SLzhW?=
 =?utf-8?B?eG1qeVhVNC9YdGMyRXJBNTZvYzVIUWVVYzZ1cVBuWU1pVStJcmJ5QkR6c2NU?=
 =?utf-8?B?ak92U1FsQlRsM0JkeklJQ3lBWkI4L3RQNlBSanBkS2FYNlpsQ29IaVJSK1dT?=
 =?utf-8?B?b0l5RUY3a0FJQkJNR3BtZjE5Skhnbit1OUpLNzl1NCtxb3JFRlh6RU00OFQz?=
 =?utf-8?B?ZFVoRXpBM25RY0pYbzhQUEovNG53TXkybWJkTk4xTnhTdXhVcThGVmxQN05n?=
 =?utf-8?B?RWFGUDR2dm9CYVRjZSt3bHNjYkswQnBiSm9saWhtUVdFRzZtMVZ5RVRtZE50?=
 =?utf-8?B?N2t2Zm12Skt4bXZCM3FkcnRCWXZpL3hUdmxmdVQ3eXl4c1JIbDRYTHBuRHJw?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd3affb-179b-46ea-8426-08da583e0b65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 13:07:53.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0vv8YbqU2C7i2ePGj74wl8w1yV3ZjJn1pG6CyWR4Iq064ck5IIhiHoEd7Lfrr/gPknYLkZabZbf3fwzZQ1s38DOgw4JL7/c13DKShYAdyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7851
X-Proofpoint-ORIG-GUID: HmhNBB9mxQphEnacI9nKp0Bz05VolayG
X-Proofpoint-GUID: HmhNBB9mxQphEnacI9nKp0Bz05VolayG
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
> This adds it for architectures that use GENERAL_HUGETLB, including x86.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   include/linux/hugetlb.h |  2 ++
>   mm/hugetlb.c            | 45 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e7a6b944d0cc..605aa19d8572 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -258,6 +258,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>   			unsigned long addr, unsigned long sz);
>   pte_t *huge_pte_offset(struct mm_struct *mm,
>   		       unsigned long addr, unsigned long sz);
> +int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		    unsigned long addr, unsigned long sz, bool stop_at_none);
>   int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   				unsigned long *addr, pte_t *ptep);
>   void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 557b0afdb503..3ec2a921ee6f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6981,6 +6981,51 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>   	return (pte_t *)pmd;
>   }


not strong feeling but this name looks confusing to me as it does

not only walk over page-tables but can also alloc.

> +int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		    unsigned long addr, unsigned long sz, bool stop_at_none)
> +{
> +	pte_t *ptep;
> +
> +	if (!hpte->ptep) {
> +		pgd_t *pgd = pgd_offset(mm, addr);
> +
> +		if (!pgd)
> +			return -ENOMEM;
> +		ptep = (pte_t *)p4d_alloc(mm, pgd, addr);
> +		if (!ptep)
> +			return -ENOMEM;
> +		hugetlb_pte_populate(hpte, ptep, P4D_SHIFT);
> +	}
> +
> +	while (hugetlb_pte_size(hpte) > sz &&
> +			!hugetlb_pte_present_leaf(hpte) &&
> +			!(stop_at_none && hugetlb_pte_none(hpte))) {

Should this ordering of if-else condition be in reverse, i mean it will look

more natural and possibly less condition checks as we go from top to bottom.

> +		if (hpte->shift == PMD_SHIFT) {
> +			ptep = pte_alloc_map(mm, (pmd_t *)hpte->ptep, addr);
> +			if (!ptep)
> +				return -ENOMEM;
> +			hpte->shift = PAGE_SHIFT;
> +			hpte->ptep = ptep;
> +		} else if (hpte->shift == PUD_SHIFT) {
> +			ptep = (pte_t *)pmd_alloc(mm, (pud_t *)hpte->ptep,
> +						  addr);
> +			if (!ptep)
> +				return -ENOMEM;
> +			hpte->shift = PMD_SHIFT;
> +			hpte->ptep = ptep;
> +		} else if (hpte->shift == P4D_SHIFT) {
> +			ptep = (pte_t *)pud_alloc(mm, (p4d_t *)hpte->ptep,
> +						  addr);
> +			if (!ptep)
> +				return -ENOMEM;
> +			hpte->shift = PUD_SHIFT;
> +			hpte->ptep = ptep;
> +		} else
> +			BUG();
> +	}
> +	return 0;
> +}
> +
>   #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>   
>   #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
