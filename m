Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37CD55C5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiF0MOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiF0MOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:14:06 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586ABDEE4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:14:02 -0700 (PDT)
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RA63w9032477;
        Mon, 27 Jun 2022 05:13:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=8gWFmd2uxiMGCfj/CZWLJUF8k6y0zmmD4mwWgulD9Qw=;
 b=R5v1pcQx63xaEdcxRTUplgbnB13fBqs+qNT/pnhI2uD9N3qgYztcoGKllg6jnT5ofpmG
 HAChaO+yCGi1A7XrvGoroG8xuWHdoiHPj26rARwZ8kfRjvSfo7nhHIGsqNmz0aWzJgQm
 IROMWtXR3iBMQHDpnrp2xe1mh77TRyiHhbgtLXQvnY8Y9y6ytneg27PKkahruPWydtlY
 XS6KtOPlYDLUAFSn18vJqwoGmmq2mYQesJCnOIbo9ujloYG6k7kb+INHWk1MNvCKQ9q+
 g8TmUHD3TdjnrhJYE6jCY5uglqo2TD5aN9PmR2aXSd81paDCONq07jn5VuBp0uSKvEEa hw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gwyw9kjdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 05:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGI2sEsnkxCd15DqKT4KNgVQTZKb2G8PAhPi1DOvD1RR5B8cGLAdiAcoKnz9/dW171UVCRZeOXf2dacz8g0qK/Op7YMD3XJ+gqyxRMS1czh+V2aDHcB0L4rYRHTV3XvNz1IWmahoScYzhjCcTX/TipXLAvnMfG4fkPOklE82XBTavB5V1UMUGZs4YUS6WbltRQC7D7Cz6KbQaENWhX+/j0CUm7AB6NtvJJoX3yGdyB+aOTnayuQahWQ1QrKC0h83GV9BpwMxOQ12/8qOAalW4+0PEy6HM+w/agnkqHmBrcEvg7dbs5OEa2IwWEXzlds7FNo4FLz2mgrDvetbnFSE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gWFmd2uxiMGCfj/CZWLJUF8k6y0zmmD4mwWgulD9Qw=;
 b=iuC0Ptc63nk8JPsWB8xhOg/f6n9tZiauEimCpmYBG4mPg7YuZuwZubJT4X5WuWO7CoSc/iW7SljgXrGfP4Je01XVBziEiBnhqtQSceTNherIaMbKKkYqJKimbcyaShRLM4UeVORf4ojrdxkwYd8keR1qjp9yoUisclwJBZKEypRx+qIYp/mEH56ruRbcUu03SsqpmbrJSsollB5YIKov6b9xaVUqJ1nEZ+aT/VJgC8Em5iVS6aD7ARkkH2Jt8td798OaSUEi7kJhf36m+21tVBZPA9RMiIEmdSluwqkF+YnFZiUdiBJqDFKveOx4jRm7n3AAT2yP2teZf5Cp3mv2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CH0PR02MB8225.namprd02.prod.outlook.com (2603:10b6:610:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 12:13:51 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:13:51 +0000
Message-ID: <4889b697-c962-a043-f2d2-0788a5bd1deb@nutanix.com>
Date:   Mon, 27 Jun 2022 17:43:38 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 03/26] hugetlb: add make_huge_pte_with_shift
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
 <20220624173656.2033256-4-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-4-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY3PR01CA0146.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::31) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ac9734f-0ec3-4b37-f64c-08da58367f54
X-MS-TrafficTypeDiagnostic: CH0PR02MB8225:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Za4zA5btTVXMAWsuTbCnon8iUdamprHuTI9AsCoOgkOZP2pTQ3Nwm2azbLWOvCztz4vvGUz9Dx0qI3H8AKt6Tsf7Wu+ds5/k4yCaTKWstfh0Owm11Qr3/KwCBEYIIuu/+0NgVx7KirAVPBSzsCSumsszltW3nBBwi/yDcsz7z8DaOfxdT7AskcF9iNwFtoPL6//baZb5y1eOsk7EAbjQBJg17BjSLI9VFp6emyT+kQvsZW5LPsSNFJ8CWX+ojZeX3CMI0yuGgqmbqwRLVWFpdfg6Hbp0TrjgbNVp5L0BiTW5z8ezC+ZGbZl30HQtrU4xri+rhWjwLSjwZN/hPeCWBlgPPCrNg9sse/Kf19ARM75+pozwT7ZraSGZlb9JMINo7qOsmeL5/GcKU+vT0v3XbOKEnS9jSQte/AyVgd0kJXBxOzMGEBQZucb7RqSLspszJj5kVr4gi+WV5WO/4K6D+qxeyc4Ne+26izTlYTIolHq9KvCckM3P3kkBSs8XpyOv5vEx8Pw73lwI2oJ2+vPUSJD0rzk+pIJXRpnN+ZTv6c/IuPmYL6Wspt/Ckeybo4mpvcu77HLLQDL7CytO+qCESw2q+yYzOMa3RR2tY1eANYYhn4oeWK+gmpR8oN/fOfCIjO63n4pGpL7srjW/EpW/bHppc8hQN/pK2vJUU5JVTSZA1YC6E4rdfcqPe05lj+5zOgBwF6qqgQuycVZfDzKmpe9RRCqeQiLEveE87cohk5GAvMTIEW0b7DSMI3IS3D6A9ZMdwK0GaL/K8Qvv4hu/kNlBrFxoU9CzQq5dO2CisGRF3LFc6A8fgMj1/kyCkwylQBh9EyOBqWgZ54rcriAWaPjkofPudNrQyAJQuf6DFA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(366004)(396003)(136003)(31686004)(8936002)(38100700002)(53546011)(5660300002)(2906002)(7416002)(478600001)(4326008)(66476007)(31696002)(66556008)(110136005)(36756003)(83380400001)(86362001)(186003)(6506007)(8676002)(6512007)(26005)(6486002)(2616005)(41300700001)(54906003)(6666004)(66946007)(316002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1kvWWc3bDhVZnBPQnhnVVlRcWJwcnFTQ2hkeC9BbitNZk0zU0EzdlZkNksv?=
 =?utf-8?B?djFxMUZyblRZT1BWcWN0dDQzdVpQaXBncVlkK1MvWE02SlVyZnNFSXNwUklU?=
 =?utf-8?B?T3FWNXlmTUprbnMvWE9WWFYwVThTZjI0djkvbDhvcDhLMXlRQ3FJV2xpL0pv?=
 =?utf-8?B?dk1BL0lGN3YwVlFpSDRVcFVEcTU5Vk01L1N5MzhWb091amh2SkhGS3BhSzhH?=
 =?utf-8?B?V3FmcTc3Z1NjM09KMnkzL3JtMDlSTDd3NkJqMkRNdy9ZTmVsd1Fqa2VXeEg3?=
 =?utf-8?B?b2k0NGpuU05IbC9xTWs2YWRHMUh2VVM3SU5wR3YxTjFqMS9PYnVwWjIyZG8x?=
 =?utf-8?B?MytHaWhWY2hxTWRCSFJSYTZibEtHYXVFOEUzYitWSU9rMkJTbVdvSU1MK05a?=
 =?utf-8?B?S2YwMm54cEZlSGFDVHRRQVJqOHg0WVB6c0svNnE3QWN2bDhjLzJMZmFlbXNH?=
 =?utf-8?B?eENaSTEvdU5XSE5UWllKUkhzREkra2treVFldGpzUE1HT25RY3pKMUlHN0Z4?=
 =?utf-8?B?cjllNW11WU9hTW55U09MbldMQ1V5NE0wZGUzZUhCM2ZYTFB3bjk5NWV0TVFa?=
 =?utf-8?B?SVB4L2hYVHVnYUE4Z1BBUVc3VTlVUFdJamxhcDJIdzdNSmNDTFFGK2ppbk9m?=
 =?utf-8?B?UkpFN1dDQmE2M0llOVZ3SERkZ09ES0xMVmlLYXIzcElKWkhJOVpTSDFYdm1K?=
 =?utf-8?B?OXZ0OWZzU2RjK2VuSVAyY3FwMG5hc25hZkljb2FiNVYzNmIxc1YwaTBpSVdL?=
 =?utf-8?B?SGdJM2sxYUg3RUc1Qy9la0NzQUpqTUNjVDVoU05oam95Vk5zZm9Uak4rOEN2?=
 =?utf-8?B?WU9RclN3Z1hJV3Fyb0lVY1EyUUdtME54Z3pXOG1NdW5ZNko0NWdEUVNRelZn?=
 =?utf-8?B?VTNtQTVJM1I1TDEwV2tuUUJYbUFXMG90dkZKazdtYis3cExWV3p5K1lyeWta?=
 =?utf-8?B?SVFBUGk3N3gvSW5RdzY4L3JMdEE4MnhGQTVkZHVxTDJSa2lnQzZDM2VlL3A4?=
 =?utf-8?B?eGU2ZlF5U3Q1RHRIL1U0UTBSTHM5M0pYVTEwL3JqMWZFZ3VjTDlKNTBkM2li?=
 =?utf-8?B?QTNOSGxMRVlOOGE3ME5kZU5JOVNjV3lqdnNrQWZ4bFhYVUxpNEdqM2NtWjYw?=
 =?utf-8?B?bHFzT1J4Y2g2YjNJaUpneEMyWVpBL3M4QkVVLys1VVlKTnFzb2xvVkJ0U04v?=
 =?utf-8?B?SW5Xc2hjd0NtZlBvcFBKYkY0YXE5T1R6Znk5ZXk2Rkl6VVFMWE52WU5UcFkx?=
 =?utf-8?B?ZWpEaU5TSkRab1F6RDlPQVIxYXArSFJoRkZMc1diRVRadFJaYUthMmdNZkVr?=
 =?utf-8?B?SWtBZEIxQnBkeTNkdVl0Zm1keE93UnpSVlkrM3pWOE5TY1pMRmpvdi9vUGcx?=
 =?utf-8?B?QUwrQnFES1V2STFGT09tSzB6TzhCK005WEhpSnNNaktoNVJ1Mkh2SVNXL3Er?=
 =?utf-8?B?TCt4dGZ2N0tzVzhaRjNUQitaMjBiVS9KRnkwNU83dmNqdUphbkVaVTdtOGhD?=
 =?utf-8?B?Z0xva1NJSldPZEYvU2hyczhBTG9XRi9zK3FrbHdpZzJjVHRDUk8yb0p1YjZ4?=
 =?utf-8?B?bUU4UnZYcDYyWTVvb2RRMmVOUkk1QVBHb3phMEFPemQvR3dmZ1RYZ0ZqdndG?=
 =?utf-8?B?b3ArSGZSdUhhdGJ6d1JUT1hhMG1WS29Rc0pzWUNBRDhxc0lzZGYyaklhNXVS?=
 =?utf-8?B?UnQrUVhpMjZKVTJrQkFqMytNSmZHd3doa3dmWTNMUDBQWHJtUXh5UFdXbDFr?=
 =?utf-8?B?NlN1dkxqdnhveDdLdHJrczBzV0JScWhEbXNHMXJmUFpHb2E4UGdVRnhZcG10?=
 =?utf-8?B?Q0sxVnlSUFF5WTgxTEh4c2FVN253VzZOeHRCeHk4ejhYc2pEYkJLT3Z3UzJ0?=
 =?utf-8?B?VGZtdjZWakZOYXBGbjk5em1raG55a0tUVEdKMEVVQ3pSemRYY3Z3RXlPQWhQ?=
 =?utf-8?B?YXpldjMxam8rcDNDVWNTOE9VUGJYRFZBcktpSG5CR0FRSVpDL0NPYmNYWGN4?=
 =?utf-8?B?R2lWaUN3Y0U3dzk5c3BjVnR4TkNRbTVSTzVBSWFGK0owMXVHYm00cEZGenBE?=
 =?utf-8?B?STA5d3RjbU00KytlVVlZeFNYRkV4dlhVR3E4M0RGcjQrYUViNlBTWXdYMVAv?=
 =?utf-8?B?c3RSbUFSeWxhUjh2SlFORC9BNkl4dnBIdloyYm1FQjVyN0R6L1VFdmZPYVFW?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac9734f-0ec3-4b37-f64c-08da58367f54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:13:51.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuwnMAZL0rAWBGxk0bABpEGiq8wkROwR2yAslGtLEvEcpJH8B0ZN1u6AslvAOXiueIELakyBdcFkWs0UsD920IHSwbO8ZKdj9ewFrFbAg1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8225
X-Proofpoint-ORIG-GUID: a6vK394OPPHDMCm1qDn86FdeBYKTHN-A
X-Proofpoint-GUID: a6vK394OPPHDMCm1qDn86FdeBYKTHN-A
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
> This allows us to make huge PTEs at shifts other than the hstate shift,
> which will be necessary for high-granularity mappings.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   mm/hugetlb.c | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5df838d86f32..0eec34edf3b2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4686,23 +4686,30 @@ const struct vm_operations_struct hugetlb_vm_ops = {
>   	.pagesize = hugetlb_vm_op_pagesize,
>   };
reviewed-by: manish.mishra@nutanix.com
>   
> +static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
> +				      struct page *page, int writable,
> +				      int shift)
> +{
> +	bool huge = shift > PAGE_SHIFT;
> +	pte_t entry = huge ? mk_huge_pte(page, vma->vm_page_prot)
> +			   : mk_pte(page, vma->vm_page_prot);
> +
> +	if (writable)
> +		entry = huge ? huge_pte_mkwrite(entry) : pte_mkwrite(entry);
> +	else
> +		entry = huge ? huge_pte_wrprotect(entry) : pte_wrprotect(entry);
> +	pte_mkyoung(entry);
> +	if (huge)
> +		entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
> +	return entry;
> +}
> +
>   static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> -				int writable)
> +			   int writable)
>   {
> -	pte_t entry;
>   	unsigned int shift = huge_page_shift(hstate_vma(vma));
>   
> -	if (writable) {
> -		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
> -					 vma->vm_page_prot)));
> -	} else {
> -		entry = huge_pte_wrprotect(mk_huge_pte(page,
> -					   vma->vm_page_prot));
> -	}
> -	entry = pte_mkyoung(entry);
> -	entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
> -
> -	return entry;
> +	return make_huge_pte_with_shift(vma, page, writable, shift);
>   }
>   
>   static void set_huge_ptep_writable(struct vm_area_struct *vma,
