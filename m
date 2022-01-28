Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0182749F393
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbiA1G0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:26:21 -0500
Received: from mail-dm3nam07on2078.outbound.protection.outlook.com ([40.107.95.78]:50050
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242551AbiA1G0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:26:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay1vpxhQRefRZcMfaBs4gS205d3i/Q5iQ+ELRI2A19d9oVZryO4Lj92+UB2G8M0uLYsbXRmL2RvcOXQoNCtObmnOKiHnN5MThxxViXztOa+CqoEkF2SozMGku6T8VPkvHwVzR0xxXI7qEZcahUuoaYvbjbol8BI8Mn3Z7HLoxUvftA9u0EUckRY0TvCEMp8WuBsDACUd5UnBlw8JtmupGR3zF+UPXUHm6oEt//dnfZr3YPWI0JDBc24HaEd+NvaXGBX81N87hZCoBlJwEPVLBoon5ml7w3KeUMuJkRly6iixHm85QbS1OTk03H+nnLiMQib2P7iN1gRzLj9yZ4hZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk7QiJa1IElh0xr6uTsPbLT/T2uRwJsZ0Y9/7t4KTH4=;
 b=DvISQBKpLDHvdWi4x6p+A+S0PKpjlbc+mdflJSrKUFJBbKj+IJLW4YAbdSLJPO4pGrO+cNfSNMEC/2JosgDhN36N1I2rgkXB5vEKg4EJ4x+cJe7qXVDqmQA3KZBquylI3+nZkZpIaXPPwvx4zYeR5yMjombOMcJO5A8oMh9v9joMhH/aEO0XRgjZq7GZfFDnhZUbQUmtehfvHIVwh6XjSEWQyAu509UEuSRneJmlqPPd5SdaummjR3i0NRWHK9TyW5LLywNj8BjS86i0GxOCOe65GLwBGZNpWJEf2RP5xWw8UXmtguMKzJiUrglhkwXR6rRyT27d3W7Pvp1P4gSKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk7QiJa1IElh0xr6uTsPbLT/T2uRwJsZ0Y9/7t4KTH4=;
 b=oQwlbJGMWMtQG1nCVxXF+q0Q/QWZ76XBhqdnD9gL96lI5mS5oXTleRJb52oedEHkKHkp7jkyCoh8xsXA7GQ/S9F2BZxrP7klSlwokeKw31M25/XYsMzZkegxM9J0GcnGszUGOSD3tJQDhI8CK/t/DCDmmC6pG3M6eZfnvaLwDH71CwFXMMT/O5lq5LkoOjcX8po7zHWQe5i5GHGSxoCGAtuZzOP7EqRK4L5XLfcEMzH26p5xoj79HsMC8l7pZVtGcdOTSqPfHaxqJjviaBPk7uCgnrQf6AZpefoGXLgw2XISsVfN0MwL0u/Y/rnGstA3q6K3fl/ENoxbAZHIl0xT/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB3787.namprd12.prod.outlook.com (2603:10b6:5:1c1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 06:26:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 06:26:18 +0000
Message-ID: <1550f363-a1bd-bbf9-a7d5-47520137c9f4@nvidia.com>
Date:   Thu, 27 Jan 2022 22:26:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] mm: Fix invalid page pointer returned with FOLL_PIN
 gups
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20220128061918.20121-1-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220128061918.20121-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76eac4d2-00f3-46da-db2b-08d9e2271831
X-MS-TrafficTypeDiagnostic: DM6PR12MB3787:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3787A030B142EBCC5F614AE3A8229@DM6PR12MB3787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOk5+5AMBBNIHQSEZRz6h//BIJxls+urQkW/xvgvSgKOVt3BULTrxCc3wozTA+4BfpvJ8Y+8jJA356W02Ky2XN5dE82SB9ce9Jvz0dOMvcEpz0q4ZUJDcEekf/roondtwFj8Djl18gOHRp6NhdLX7oJiFIvC5fq9eE3scoU/RKnvvWMnevkyAlxegLtGFgKq1dHzgYXhrzH0ghqvPTemmqe1wHiBGMhHx21P8IjOfqP/cTWIR29aesxchspfJMeVs1LsSVzIMU8hifoRoFxDBAOs08E4GmEairgbFdGHrqX22rm+FOf9RWE+u8MNzioZutCaCuyqiuOmAN0qNQ2BLhTqlqxR6PvqFxz1z2B9+zearF59gXQ6A3qupcOszT7xG/Ht/blO7338aE5uCMjSPUo3RhjmPEx1KMNEzClAA8i4Kb9FdX9KeQmBhp+Z8oWnJ3xiGmI7xlISIrfgVcg+oOBoTphoXuev5PYJStPTFQvxWZGC+ZRqJ0a0GwthJWJXf4frHbjcmkIJ80iHs5jbPYyco5bH3BcDWP6ntMo7z2CgZBZaE++ApkOxcVCJqUkVtKE9qfh3bAwVpgJjrJRTUxx7wL8TEjacbQb/7iZoUbAD9mggrfKAUfYRN7uFVbCT8LVB4vh1wz91dswtmn9rGp1UjYoNgc0u+loLbyEIq5Ybo4a81pm8oHbzGDjkMkqWTU71IGhOHClqliZrj1u8QiZU2ZQ3SvGPYNmO2esvJ+mOugfThszzg9wHOJ5/jFfp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(66476007)(2906002)(508600001)(8676002)(8936002)(31686004)(38100700002)(4326008)(54906003)(6512007)(36756003)(6486002)(316002)(26005)(186003)(7416002)(66574015)(6506007)(2616005)(31696002)(86362001)(5660300002)(83380400001)(53546011)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVZCOEF6RCtoNmg5VWthYW9YclhUQTlNWFNBNG5qWkxPWi9yNUpiQmhYRERO?=
 =?utf-8?B?dlFGSnAzaWtaTVRxZldxcTJzLzhCRzQ2U3U5YjV0QjkvY2FHamtkK2V2Vjhr?=
 =?utf-8?B?NDVsOFpiR2tUL1pDZ1Z0MndrS2FmK2JoZGdyOG1wS2g4bm9wazNsVWFUSEdv?=
 =?utf-8?B?MlNnWk85WmNxU0IydWZlWlFBSnNxaUllTUlXTXhqdzQ4c2l2eVBva1duMTlw?=
 =?utf-8?B?TXo5Y2hrN3Y0ZWlwaU5IUDJ3SGY1ck1KMHF2ZTNGMENScGdBSmppbDhxNW1o?=
 =?utf-8?B?RWtEZUVQc1FHblUyWmRGMzBOSy9jNldTdFdtM0pwUlpCNDBCZDU0OTVRNkNV?=
 =?utf-8?B?Z1J6cXk5Y1dhQ1NsbXZlUnJvTGE5bFpOVEYvbU5Pa3h2YzMwMFphcHJNZmRC?=
 =?utf-8?B?aHk4eU0vNW9Jc1htcVpobmVPTFB1UExMdDlUbi9MOE94TkZpUERCNUNmSnlx?=
 =?utf-8?B?MVErNG1nRHhIRGVIcFgvYW5URGxIMWtndjQvSGQ3dkorOGhPb3UyL2k2c05Z?=
 =?utf-8?B?ZWxGRHhINzYxWGhYQ25JeVZsNDZHK2xSazNlU1dJc2UwUDBia0dqQkV3RUdl?=
 =?utf-8?B?TVg0OXZ1Z2NraVEzMm84TTBBNEhBRS9Ndm9hRjlvcFYycitCQjRZdEc1WmtT?=
 =?utf-8?B?WldQREtFdmNkNFMveGIyL3R6SWo5NVAyWkpHdUtxQUd6dDNRZVdHeXRRclAz?=
 =?utf-8?B?dXEreFB0d25JZ0Z0RjY5eHFJL1NMOFlvaENwNFNZSWRMbEpOQU4vTkFrcjdG?=
 =?utf-8?B?YURreGg1RUpvMGZYcnpGWEFjYTlvU2V4MHoreTFidXYrNjQyWWpxRW53SVk5?=
 =?utf-8?B?QUpIOUJwZGhVRWlsR09qSzl0U0RGeE5UUjN4K2crUVNOMitISlo5SXdxWWFk?=
 =?utf-8?B?WEtuK0FBMDRTK1pRSDlmSGpvdnphWkJhSXVzUTJkMkhFN2wxcGZtdENNbUVj?=
 =?utf-8?B?aENCdmloeE9tVWxqZHp6cVU2TUl3a3grazFsQ2pmblZ0U211OE1xR0NZTTAx?=
 =?utf-8?B?TXV3TEEwRWZ3K1BSRHU2VUhzZmcxUE96RFoydWUzUFBxUFRmYjcvSkt5UHBo?=
 =?utf-8?B?bTZSSVdPWk5ENkhHSi9qZjJEM1pHdUVuUlNVSEwvM3RKSnV0M0hLcFlJTkpX?=
 =?utf-8?B?SlFJV2FESjZNcGtXRENoY2xMcnNVL01YbEI0bDlla0tNaXJpeC9zcXFsQ29U?=
 =?utf-8?B?NjI5N3BBQmtLM1E4WktadzloRXhUQm8xL0NYUElHaGhGNzc5d1pjVXlMMzNW?=
 =?utf-8?B?cUNQTUJYaFNHV1JzV3JqR2ZkaG9CbXlQOWdoZk1LdzBwNS9nMlhGcFZwYTN2?=
 =?utf-8?B?MjgwSzB1Um5GZ2U1NG5URE41WnNraE9rcEptQ0JSQlhBRlFpbnlXVVRRWlNp?=
 =?utf-8?B?ZnNqa2U0SGlYbWd6MDY1ZE55cjdldUhyRFJHeDBoWld1TmxOd0VHSDRuYkFn?=
 =?utf-8?B?MVNxVS9RWmdlVXVqNmhuUXh6WHRlZk5pVGdmTUU4a20yTGdaMENPSXhRL2ln?=
 =?utf-8?B?Q0NUVWxRSmx6dFRnVTlSNjhZYzZwaWhPM1BOSVM2K3JCZDhPU3pZaEtGWGx2?=
 =?utf-8?B?Z2VZVUY0M05acVUzVFVjTDFNR3VLc3V6WmNhLy80UFJLOTdSZUMwYU9OTCtQ?=
 =?utf-8?B?TEoyQjI1MlUvTVRLdkNnNjlERkhhY1gyK3JVTWxYQlRpYzFIcFBZT0pDTjdn?=
 =?utf-8?B?VmhDalFBeksyWmRNWFhyWWFRNGFhSzJhVXZUK3pidVU5bGFmRys5YlB1YlhW?=
 =?utf-8?B?ZkJiT285WnZsc3ZiZElWYkJnREFtNVhyUlhNMHRRSDh0a3NyNWRGd1QzQzJq?=
 =?utf-8?B?dyttOSt3VWFOU3UvRjdZNEFZV2w5RjFKSC9xdnlnSnJTVnNYSEhQVGhXYUQw?=
 =?utf-8?B?Z1c0RTdLZjdBWHBBazZ4R09FK1NVT3ZWUlNKTjlYVS85Z2VzZ01aNWx4MlU1?=
 =?utf-8?B?Y1NoNTd2bkp1N1BoR3IxbzN1Z0hOQVhGZkNUWlRxalRUc1laTngxb1RodVJG?=
 =?utf-8?B?MENkT3NGcmZBZmR1UVFlemhmdEpNaWdFbnRHOCsveVFPQnJMZmFIeDdManZT?=
 =?utf-8?B?WjZZL1NCbEY5b3hveUhjWDNFaDRVekE4cnNST3hlWHRVN1BROSszUVBJQ0hI?=
 =?utf-8?B?WVRGMDFDbFBlcDJBZUlCdEVQYWVuczRkY296MDVFYW0xc09uYUtGcThuVExa?=
 =?utf-8?Q?W3u8TVxVvIAwV7xj89nc/3M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eac4d2-00f3-46da-db2b-08d9e2271831
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 06:26:18.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4fz+A1kZ9AJqYYCRXxmgR3M+NMkJmzgcjkRUaCQu7Qy8Tyh5RxLlE7pSejul5lm4Ma19sPG1MUPkH21YVuGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3787
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 22:19, Peter Xu wrote:
> Alex reported invalid page pointer returned with pin_user_pages_remote() from
> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
> pinning with struct vfio_batch").  This problem breaks NVIDIA vfio mdev.
> 
> It turns out that it's not the fault of the vfio commit; however after vfio
> switches to a full page buffer to store the page pointers it starts to expose
> the problem easier.
> 
> The problem is for VM_PFNMAP vmas we should normally fail with an -EFAULT then
> vfio will carry on to handle the MMIO regions.  However when the bug triggered,
> follow_page_mask() returned -EEXIST for such a page, which will jump over the
> current page, leaving that entry in **pages untouched.  However the caller is
> not aware of it, hence the caller will reference the page as usual even if the
> pointer data can be anything.
> 
> We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP handle pfn
> mapping unless FOLL_GET is requested") which seems very reasonable.  It could
> be that when we reworked GUP with FOLL_PIN we could have overlooked that
> special path in commit 3faa52c03f44 ("mm/gup: track FOLL_PIN pages"), even if
> that commit rightfully touched up follow_devmap_pud() on checking FOLL_PIN when
> it needs to return an -EEXIST.
> 
> Attaching the Fixes to the FOLL_PIN rework commit, as it happened later than
> 1027e4436b6a.
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Debugged-by: Alex Williamson <alex.williamson@redhat.com>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Drop the WARN_ON_ONCE() [Jason, John]
> - Add Alex's Tested-by too, as after dropping the WARN_ON_ONCE() then the patch
>    is exactly the one that Alex helped on bug verification, hence very safe to
>    grant the credit alongside.
> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f0af462ac1e2..65575ae3602f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>   		pte_t *pte, unsigned int flags)
>   {
>   	/* No page to get reference */
> -	if (flags & FOLL_GET)
> +	if (flags & (FOLL_GET | FOLL_PIN))
>   		return -EFAULT;
>   
>   	if (flags & FOLL_TOUCH) {

