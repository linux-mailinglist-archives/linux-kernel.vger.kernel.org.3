Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E054A67ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbiBAWYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:24:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61708 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239569AbiBAWYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:24:23 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211KTNn4022156;
        Tue, 1 Feb 2022 22:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fWKPVah1x9Fr/p7eCEyNmlv14BH89OFYe9aWJA/LhGU=;
 b=Da23qiDyIs2HWSntze264PtJh7SKWU6SOVm6OLzDrfcZYynTGp0HHp/hNVOe7YYzMeYp
 EcA0vrSl2IrPvaKaHO63x8PMvP+/F0ZnjaUUJ26cQ+z7ptdo6/A+5xJJK5IymmoIa/QK
 Q1v9iF7WAdHoqT4Cd/ME3CWcUBBYaohvprwbLLhMsjdJSg5UdcRXTkyuEw3lFhbc5mub
 wO2e1Ay3UW40kdllXnmjomeH1/KRG+2xhm7Y8kZL7Qle2Y8cKyLY6Z0xUWWtwZ7pT2TV
 uwaAmC1Z5rCggj+3+ZZ+ue4GA2fi+hxeB+prWWNL7AD5TvHPVE9ZYp4nfxVgYFyWJRvI +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2ktva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 22:24:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211MHO2A107957;
        Tue, 1 Feb 2022 22:24:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3dvtq194we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 22:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix+0M9f4wzlEu+pVEr8ALyGg4Dnk/QBB85V1DE06m4m/Ty/oEmIvLJaCH1+PGXOAY+754lJkAK+WlhQ0KK3fvnZbZTw02Zia7DuMMabqgShzHyxj2obwNQjahxGopOrkdhCt48WVmFzmcNXS/it/Kpvr0C1LOsw6m00cXzOZh8uJrzCL/USrZpsdeEWO7z9Ub54LKYpB5qMlrjtz06ZY0Ix8tijc5dG++KrkjTzgnehWToZfKWWWJnq2C5dn29ywySFm3GGjfLIDzKhd8xuxu3aCaSnEXVROD1mOq8PC62u7iI2RH9stdx5PazgnYf02ugKp2Rg6Ll0YygEd9Ns0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWKPVah1x9Fr/p7eCEyNmlv14BH89OFYe9aWJA/LhGU=;
 b=bNzhlSCt1ldnY1m8QJx+zo4kIJht2i4wShS4xOvo7qmbWkPoyM3tSwi51wWpo3lB6A1yj1iCpK98gjs7GV34bClcTleE5p5T7BMFg69UDsVAqyCt0vTbmUEdVL9sV1Sd1fHavvu5L4ohQX2GFLwkWqSdetWimRdERfnojzRlRYpksUWnTUFCqnG9+rDolrvmbMyiPA/jEP1wCbVPO2+ITdDjZ7/zkOD6FtgVR6xjVe4AzbOBsfWTiSkxbZJOKYQulUonPNH4WLylJtXG/m39udNdmsuo8eNJHR23s/P4Kbiop24B4dnhN8pPS7EY6H7K4ZCAqkAeTF4D7LDAecf42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWKPVah1x9Fr/p7eCEyNmlv14BH89OFYe9aWJA/LhGU=;
 b=LEnOYunZ95Vl0ToY5SbkbhptYLnCADSXOImBeiE/nE+qi0w2NvPQBDpjO+XV5fr1nHp9xwd5slFzDZsEu5vUuhnM1dvGcKaBSz7jv8vvNUzg1kryJNWmA69GHr9tgW7eSrq1KVc0424zu8Lxp7rxm+fUSs5JFJ9ZMIrvHe6qj5g=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by CY4PR10MB1685.namprd10.prod.outlook.com (2603:10b6:910:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 22:23:57 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4%8]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 22:23:56 +0000
Message-ID: <14df55c2-cab5-8ff0-5986-fd186c2f60d7@oracle.com>
Date:   Tue, 1 Feb 2022 14:23:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/5] mm: hugetlb: fix missing cache flush in
 hugetlb_mcopy_atomic_pte()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        rientjes@google.com, lars.persson@axis.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Matthew Wilcox <willy@infradead.org>
References: <20220131160254.43211-1-songmuchun@bytedance.com>
 <20220131160254.43211-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220131160254.43211-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0065.namprd14.prod.outlook.com
 (2603:10b6:300:81::27) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2fad9a2-9d75-44ce-13b5-08d9e5d1824c
X-MS-TrafficTypeDiagnostic: CY4PR10MB1685:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1685C71DD734C3DFCA0CE8C9E2269@CY4PR10MB1685.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gURevgeR1lmvt0pcvAtlxuvPbe08sq3CVjCl9K+1lk8QY5SUZlc6S+K1D6rV9ICQlbnUhMbs/8Lg7DePdzvOyakgUlvkXySelBhBBIADnXo9fYJDi6PQizBdl5tSabT1A7tNKMpRq8JZjQrCyDAaAe5VsouvLb62i7F6dxP+H1lMD9X5/Ru0fre4P6VHMDToHbtK3UKWhWlhX2BxwmfKEk+NhixoGmvWp7SNQFkDuU98CYE+IGoAdaiShv47/2iQ0nGqqiXXamqx/C01QmrNduR/ib0pH1C6muZZfKt9atdeiTy9745rhOFBVNpTxCQr+rIbETcSmhXeaEcAkYqqnHNYq+L5H/TSeaD5buEzTxwRI5eAdv271V9KObLSlZic7sf61FVzlzJ2LPiXNYD35ag0FJ4/dqAhs/arfe5yfwNeA3b31FWG7AJOyfqHqnnrYePJ/KN3wGGupChEihqfSirtwWxf8nOeNIESD/l5o3KLRLBwbUIHGNP24jHozWPTWNTNKGCyXYGmRpHImfRtkeA54XuLvj5Pcf2pthawJYcG2BhEmdDXy32X60R6aZ48H07NYrqUPKuKl83T1XI0HLDBJwECmMkHWENLtpeVvidXsncfMlXbyOA8EbbrROrWwISgpXETSUiAp8BM+X+ILdw62JrDGrLWHacfzEPK0q7BG6ISTfwL/oEESKoFiNQYzIiZ0Xq6O0RDTv3f9LjU0yoYoZX/3Hv3cVGCA/nrXdrc2uuHdVjAuLQeFabr2y/xiUSfN9zkbeRKJOcEeFoTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(186003)(5660300002)(53546011)(26005)(52116002)(6666004)(44832011)(2906002)(7416002)(2616005)(6512007)(38350700002)(31696002)(86362001)(316002)(6486002)(38100700002)(508600001)(66476007)(66556008)(8676002)(4326008)(8936002)(36756003)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVM0TmV4cUExTTRRWFZLTVFTVUkwV1htQ0dGam9MQzljbXBqWDBZSC9sZ0dj?=
 =?utf-8?B?a0ZaN3RsSHByTWNHNEoyS3ROT0txWVIyeVY3M2JXeGQyQk5odnppdkYyanNp?=
 =?utf-8?B?MVcrY2ZFcll6MEk0Ni9MN0s2OUw0S3YvMmtQa29ZWVNkYm9UV3ZFdFJZZEQ2?=
 =?utf-8?B?dEM5enpmQlBnVUZvNm45dUd1bjl6Z1VFNDJYNGgrcndPTjloc2FzMDd0SnQ2?=
 =?utf-8?B?V3ppOS80Zlgrb3hJMzFUSmVoVEJtV29NNzh2TGloZSt5YTNYVGRsQ2tPWHdm?=
 =?utf-8?B?RW5aTjgxUEVqNy91ZmlkVThyck5xR3ZQMjB2ck9zQVBDTUZabU1MbU5hWk1m?=
 =?utf-8?B?dXQ2ckhCQW5VcU1xWlJvZkVXT1dOaEZhcmtRRklmenBTS3ZQdjBSSjJ5KzE4?=
 =?utf-8?B?Q1FQZEo3TUxhU1ZEYUg1aU5zbXFJNjFYY1dwUE1PS2RhU3Eva2t0VWFFa2xD?=
 =?utf-8?B?RjY3aG9nVEYzNmJxYUp3WGdKYnhoTjNWbkNTdTVmZDZ2bkw0TXhrbjJlOVFK?=
 =?utf-8?B?TjR1SmI3OHVHbFZDN1JEVjh4T3hPemlxd1RHNWZXOUhWdjE3ZE9YRTMxM2E3?=
 =?utf-8?B?M3JySFJPdktJTHhwaXY3bHM2aXFHUmVHWFZaSnFjK2JscVlIdER3UHc3eG8v?=
 =?utf-8?B?dkJ6TG5Pb251akVOSmFyc25oTy9TQ2FVbkNVSGlnMm13NTBGaG1IOTZlbzdM?=
 =?utf-8?B?OXlwV20veEJ1YXhYd1RkM2hjYTl4YTgvdkZpVlI5eDZKS2RNWVFKQjFhaDNC?=
 =?utf-8?B?a1p0NzhtR0lvOURRM1dINk9IaGlCMlRRWThsSVJ2azVmaWtkY0svUGxMSjN3?=
 =?utf-8?B?bXI4OWFvVW9CTFVwM21QaThoblhJRGlDR1NBWGFUeERpclFmUzJpV1B5T0ZC?=
 =?utf-8?B?cXNVRU5xRk5yRHRQRUlrOG5sRUJKVlpDRVNtU1pOeUZDdjlOVVh5cUlhdE1i?=
 =?utf-8?B?U0NpWXV0Z2lLREF0VTRWd2FjazR2QUlvTXMrM3o5Y0pJZFZERXJoTithSTdH?=
 =?utf-8?B?cHhMSWFtTUh5cDRneVM0bjY1ZGIrR2NSd3hEUmRIT0VOR3h0ckFtMG92TVJi?=
 =?utf-8?B?SWoxMmVDUms5SGhRVGl1TFFKZFVRU0RDVHU4cWxUcSszZEY2UDVEL3dBanh0?=
 =?utf-8?B?ZVlMa1pQeE1JZzBaaWFVRW1DN3pSS2sxVFhDZW9lblFvSThxcEUvTCtRZGpx?=
 =?utf-8?B?SnpZWmJreXljWlZNUHBSaDZ6MjkwSXRDRCtNNUozbHNuWkgySVNHRmNNbFdv?=
 =?utf-8?B?QjVuNDNVbG5xUW91QjlEeDRueXVSTzAyL0U3b0REUDQzdWRtK2J3WWUwSUlX?=
 =?utf-8?B?blJqTlY0eXNQZStoR3pIRi9KUWJ5MW5vb3NlMjVjN3JuVDgyWEpLWDBqUGxR?=
 =?utf-8?B?Y3Z4RFZKZGgzN0tQZVdwT2VoTEt5dVBVaFdkY1lJcVIxOFo5VlRQQm9KQnJC?=
 =?utf-8?B?UUZWaG9aanovYngrQkhhR0FpT2ZjMVdiUGlMdEJQS0FnRFlaaHNOdUQ4ajh2?=
 =?utf-8?B?VldqcHRqWStTZzUwMm16OTF0ODZKUWZiQ1RLVFdubEw5ZXRGcFJCUitkNGZz?=
 =?utf-8?B?UHR1ZUlGMHI3U3hLZ1VsbmpHV21qM1JJQncvdkxDNldkU1FvS3pYQVpUb2ov?=
 =?utf-8?B?YlhLOXk0THFVcTk2SmN0eVM5Z3BIcjYzejFHVXVSM1VYTXJvVGk4Ly91bVpp?=
 =?utf-8?B?bE5hVkk4SzFnNVFCeTVaT1Rkc2ZpMjZxWmhoNEZvQjltcnpzMG1XSWJDazNX?=
 =?utf-8?B?U1hYdENta0NIYUUxbWZISUVSTXZUcE1pcysrZVROdkdjT0hYdFNzU1hnY0tC?=
 =?utf-8?B?S3E4UFMvT0xCVGFGV0ZLU0wyZDllVFJ4aHdOT0R4bEhrNytRNHRySHhNUWMr?=
 =?utf-8?B?Tm9KWFBaYUFaSkFpUE5OS1dtZStoazBtQk5LWm9GbnlmdG1uMTVMZlpIeU40?=
 =?utf-8?B?SXl6U2d5Zm5RWkpmRzI4RG1vQjR1M0NSZGlpczFwUDJrcWx0NVhTaGpzb2R1?=
 =?utf-8?B?b010Z1ZDeDFzSkxJVHdRQmw0cU9wRmFUcUYzVGZJSjF3ejBuREFUeDUzdmI4?=
 =?utf-8?B?ZU1CbjZzcTluOUsyK3ZnaWpiSW16dnIzaDNKTDN2WjRwZFdqdi81THZZTUdn?=
 =?utf-8?B?Q2VkcXZyS1crZWE0WGpiMThPemNwdUZ1L2FiYm55QzBxVXVsVm42eXhueWlk?=
 =?utf-8?Q?k0yA5kXtJCzsxXaj2S9xujs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fad9a2-9d75-44ce-13b5-08d9e5d1824c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:23:56.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqBlGEOWNqXsPBHHuNOoZOYq2onTV/IitcsnRvzlJ/vgnNcqvV1Ih593clnqrdydgx1Aq1F1GFZPDixspHCvKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1685
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010123
X-Proofpoint-GUID: zm5p0yBSEw7IV83k-80mBCdxTzQGDKao
X-Proofpoint-ORIG-GUID: zm5p0yBSEw7IV83k-80mBCdxTzQGDKao
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Matthew

On 1/31/22 08:02, Muchun Song wrote:
> folio_copy() will copy the data from one page to the target page, then
> the target page will be mapped to the user space address, which might
> have an alias issue with the kernel address used to copy the data from
> the page to.  Fix this issue by flushing dcache but not use
> flush_dcache_folio() since it is not backportable.
> 
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a1baa198519a..f1f1ab31dc8a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5804,6 +5804,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			goto out;
>  		}
>  	} else {
> +		int i, nr;
> +
>  		if (vm_shared &&
>  		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
>  			put_page(*pagep);
> @@ -5819,6 +5821,9 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			goto out;
>  		}
>  		folio_copy(page_folio(page), page_folio(*pagep));

What if we changed that folio_copy() to?

		copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
			pages_per_huge_page(h));

Seems like that would take care of the flush_dcache_page and it would be
backportable.

Of course, Matthew may hate the idea.  Not sure if there are any plans to
convert copy_user_huge_page to use folio type as it has some special hinting
logic.
-- 
Mike Kravetz

> +		nr = compound_nr(page);
> +		for (i = 0; i < nr; i++)
> +			flush_dcache_page(page + i);
>  		put_page(*pagep);
>  		*pagep = NULL;
>  	}


