Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1749D69B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiA0API (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:15:08 -0500
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:40896
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229589AbiA0APG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:15:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCvw3QY+IcT0/GxHsIj/zksvC/WCsNQUK4loOPFIOHzESKSOtaYxFEZTEQ6hjddkQL4x09tl4WID9cpWX4pN5/0Q61hhxiTkODBgOgevS2HfVi3lgpa+yVsk1srqapRpe8SgJzLRyhlICW8Gopmt6hHug+OR09Tr7A7t8mgbC1Ohe0PrE4rGKnjOFCoTEw3BA1yV3z7nQ+4dStKx69Uwhcjkz/j8SfmKoAHO2dkF6b6/E/JB9htoHOwLUE91BVfexujQrhx/VkeFh9sw4kZF5hGBRPRKux6frZQWetxYWUZsx4hKvumkzzaj6X3jVWX59af9tKwC9rAZDJMR1i58Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh5uo1GA937LpWYDU1/rPykejLvX3J1SWkDA15OIfro=;
 b=JmlUZlOPll1aVs7l3FNypuRk/K8MZhaDrRatgFlhiYAzoOsv6W24UieuD9Yp/C5LCXbB7u7H6LDO0euLVZCVt0mA5BDB9skCxAf77JIgIuPY0DGETGHBb+5ujVeLgfXorGR3ps5tCWl5d+TY4uaBaWi5K0fC/E+oGba9Uwz32j1giGwEdL3W8Gw0bFT/MHKFKclbBGPO0/AmJDJgL472shYSMSzGLAFwls2LW8Cyn2My0VVCm56XJGsBHAovJ2tt2O9iAcmcFi3fpUMyod6lCfj1z9iomzzQuOzHVv6AYLc3uOYY/3SmC8lTLnFU/vjd4d9Qb62kYeYhMEnoeeLwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh5uo1GA937LpWYDU1/rPykejLvX3J1SWkDA15OIfro=;
 b=L3Y38rP/DQicCP+OOZsBFLUt7BtBrNjR6Q5MrnUXR3xYrVg6rg4g/29af3pkKJ63ERu8j4eCrztQT39iyjntjZ7mZnXd+iJ4w5dzHke/xsRcmhf1y3cYXkN6R5n86XIJ+4FxqoHUc5yfj4VS+wgMKRVDgTkQz/QITLjrdAMGo9eDuHo2h1GQdLSOA5GV3hl219hXBdIyJf6uxJOjuuvTB9xenYDHZaUJc4c+aSBFgRu+UDzvAmgXhe+IySt9IrFS7fLd0oJ6QPpnF7J3Gen22t/vFnuhSLEJMrMO6LJXBQ4OpF0lTkAoEEDxEDmklAOXR2jenRKCv5kP3OIekU2aFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Thu, 27 Jan
 2022 00:15:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 00:15:04 +0000
Message-ID: <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
Date:   Wed, 26 Jan 2022 16:15:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20220125033700.69705-1-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220125033700.69705-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 276a2a89-fd08-4b41-2966-08d9e12a1149
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2677297A56E8C70CB14B22FBA8219@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSKw7/RcOEhiGU7bezrI33wzSqHdBz6aoxnorsItmG9UN3RGxFyRmpyqAtCRjqocZ3T4oU93YQRuRdW8ljwgNdiGEhdal3wKzUoal1Mt2Qz5ShO7kNw2o1tvJvGyHdXmfhu/e4OIlPQ4fIBVLbuEYBAF0c/JTwilVexxFqK22nqjwPjm0+I3WgzujPytokRNyOBsIVexwqT2CSrSivbejOqFCbVjJOMX6yRvKxnF2oi/iIdTWysMhm15FIKoKHAhNxhBNnWUxQV2yEG1Yhwsp6CImXRwTsYG/iutRFLaSB4CcmMIZoyMztdxm2Bq58NZhzfRbo6ivptX0IYjO9RSL/UNkSNaIQoDLUGaq0ZEHkbpIkmt+BmygJvVSolemg35aTT+1NKFAE+YiEcFp22mbF438Q1t/eFXqqsC+2vExL79FpOcvP9D9YFRPiFoE7xRtMG4spAt0xlWh844Vm7kZl2S+/WsmYa6IJh6i8Rp0s7OohR7DxpVHzPp/tMlgsHF+2jLvxiBC6B1iGtCqN/Ar0cHdI9/y5cKbHIeC5J1asl8kez/e99pBn3OHgNcJVpnpUoLJx6A31hHIR+nv3HCGsAx8ExIBsBr4/f0Tgoo6d6/FywHYlFxl8K09OYmGR/9vgl21UycQgGv07HKkH2UcfiotpFX+Sclnq1IOfSRAW82wGGJphbK4mNqR0a7NO2FDsqqwr+IqFZc/ALP1dcmmQEVD22CxpAzHupbxiQaalPlmVxxpdnRpnZj7BclalQy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(54906003)(8676002)(2616005)(4326008)(316002)(6512007)(31696002)(31686004)(508600001)(66476007)(66556008)(66946007)(26005)(8936002)(83380400001)(36756003)(66574015)(186003)(5660300002)(6486002)(53546011)(6506007)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJTeGVpdlV6aVRrNkdBRStDZHd1bFA3cWhWZElWM3dwTW9sNHhiK25aTFhw?=
 =?utf-8?B?TWRkd2VyUkU4MDE4VGVwOW9CcUhuMkY2S2VscC8vM3JGTkFjTTVHU29PNGNT?=
 =?utf-8?B?OVFMUmNjanhteHFHd0UyS3AvWVVTV211OFZwRVpWQld5RFF0NVBzdHpNd1cv?=
 =?utf-8?B?d2dFbVJYeDBzNEt1aGxBTjBnRk1TMHZWYmtRT0ZNNjE4azM2N0hEZEswTFpt?=
 =?utf-8?B?aWphbVB2d0pwUFRtZUthNnlCOHRRVkxWL1YrbGcvcVpOZ0kyZy8rTVRHSk5P?=
 =?utf-8?B?Z0ZXMTRxeTdWQytQcVZ0dVlaV0cveUZIeUlWZUp0azhBODZxL29zVWIxbzIw?=
 =?utf-8?B?a2FnQ0JpR2lPQTRhTTR4QUtSa1Q1UkFITko0d2xQcHUydzI2REtKeG4xQ3l6?=
 =?utf-8?B?RVBrT2xHN3B0UEVaYmhkMmpKT2hLanJzQVZId0MydTk4eGk1WFM4SlNjU0VO?=
 =?utf-8?B?UXRORzJ0Y2VnUGE2ZWFNUUE5cFg4OElCTit4azhZNDhzd0JPYWJEYUVwRThl?=
 =?utf-8?B?amNhc1JZTjBNWnJibTdRR1haUEVYOFhWT1htYjlFQzRwZ2g5OTZxemE2RkRt?=
 =?utf-8?B?RjV0bloxWGN2aU5DTXkzREV5TCt1RGYvakkrbTZodmRqWUQ3VUtTSjF5Ry9i?=
 =?utf-8?B?SE1qVUJ0WUNYMTUxb3F4UXp6c0dLTXlmbnlEeisxb3J2WXdnWldNb1ltYkJI?=
 =?utf-8?B?VGxVVHN3NGJjenppM0ZZN3JGQzd6aUhNM1Z1eUlSdjBaMnF0NXdhUmRMU29l?=
 =?utf-8?B?bnhuWGt3cm9ZT0tjS213Sk9qTERaUVB0WDB5dXoyYmpuNTl0RkxYcVk4UFQx?=
 =?utf-8?B?SWlHZWlzMHA1eGlyYkdxQnI0UzdZWHlNNGFpckYyK3Z5b0lYUmtmMTlPSlZK?=
 =?utf-8?B?aUZuWjNjMDE5N3VEVnQ0cFloUDdzSVRDVUx5SXlLUEV3eVc2K1JWdHBWNy9Q?=
 =?utf-8?B?TVBIUUNobysrWGJIWXpwUkt3bGFjaXZsRjdabzRiTDUxOU5EdjdKcGxQSXNV?=
 =?utf-8?B?RXFnQ0lpWkZ6M25ZY0U2WHRmUjdkWmtEamd1UTVabk5QTDBpcS85aFU1TlFr?=
 =?utf-8?B?K2Rsclo0bytpU1hLNDU5c3pBTnZsQ0VvRlFrMUNGaFNIRUR2by94MlVSVnov?=
 =?utf-8?B?UGxIenpuVzZVdEtINS9XMStrampHL1YxSFNOQm1IbHNaQ2p0a1JaUTdZbHFi?=
 =?utf-8?B?bmNOSXorQVJxTjlqOVdNaTg5K0VHUE41eVFpVVU0S01HbGRROEo0RXBHOTZR?=
 =?utf-8?B?Q090anhZNFRiOEFpNFlZemQrK1h1am5Rc01CNnNMVFNNTVUyZGpuVU5OZklB?=
 =?utf-8?B?YzBKRVNOU1BiYmM4bTd1dWZhZkMvdDN2T0wwWkcrMEt3ZG8rMThXSDJZQjJS?=
 =?utf-8?B?YndHSGFoUWVYcjVpdjdOaVRNd1dDNEJjZ1I5RFp0dUEwcDhxV2Z1Yko5emd4?=
 =?utf-8?B?N2MydDRuUVdUQVJoVHJhaWNMclhaSU1JYVhJTGgwRjhEVldBZkpvSENXN0Vv?=
 =?utf-8?B?Y0UrMnpkL0pXcGN4U09ldnRHZVdlV1BqT3VZeUlYZjRxc0dlZXVDa0RmZ21P?=
 =?utf-8?B?cEdFb1B0ZFMzVDkxSFUrQkdKdm5GODhmdUtMZXZoSVFQUGFjdVBGVUhUdmx5?=
 =?utf-8?B?L1FDc1g1ZXJnVUkrT3N1S1R5Yk1RN3RhalFTRlExNExJaCtHdzFEVStJR0NB?=
 =?utf-8?B?RVd3TktEbnpIeEh1Zk1qSTZxM2xYS0dycnZlYjYzaHVJaXVUUCtkMnZDQkNU?=
 =?utf-8?B?bHlUT3hRZjlnQ2RrVW1hRHRHVWRlMytFK3lVNVh3K0dJTXphbS8rWWRlWnhB?=
 =?utf-8?B?MjJFMmhGOXlhMjZSTkFua3FTVlJ4T3N3RTh1cmtFNHJGS0ZmQlpESWZSMXVs?=
 =?utf-8?B?RXNJMkFZR2t4RDZJWFVTcWJsOENqN2ZZZURzcDVDMkVjNFkwT0xRM3ArWEhw?=
 =?utf-8?B?M1B2elJ0cVp1OUEvdVlqVFlsZW9ua0xmUWNmNFcvTU9WTFZqSUtwZFZmUzU0?=
 =?utf-8?B?Wlg1TEx5NS9HbjZsTDFRNnRaMlhOVWxwbHU5dTUybS9NUFR4NmFBbC9DNWx3?=
 =?utf-8?B?eUZVWCtRajdITEdHc3hUSWdSa1RCb01oa3NOYmdqa2xuUzRrbkJGNUxQbjVu?=
 =?utf-8?B?aXlqZUswM2VPVlA0SFgwTW9nVTA2TkR3TVJuL2diMXFsRm9iZm81Qm1FS0p6?=
 =?utf-8?Q?lL/Spq+kMz7f4gI8MI2DQvo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276a2a89-fd08-4b41-2966-08d9e12a1149
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 00:15:04.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rruFmuEP0CmHLo3i1mUDNWxYhw/Hg5RVl9Fetms1rmbVntsxh/LHc5uuLauLyBIrSlW49S0g0Ga8LppdruP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 19:37, Peter Xu wrote:
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
> Since at it, add another WARN_ON_ONCE() at the -EEXIST handling to make sure we
> mustn't have **pages set when reaching there, because otherwise it means the
> caller will try to read a garbage right after __get_user_pages() returns.
> 
> Attaching the Fixes to the FOLL_PIN rework commit, as it happened later than
> 1027e4436b6a.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Debugged-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/gup.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f0af462ac1e2..8ebc04058e97 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>   		pte_t *pte, unsigned int flags)
>   {
>   	/* No page to get reference */
> -	if (flags & FOLL_GET)
> +	if (flags & (FOLL_GET | FOLL_PIN))
>   		return -EFAULT;


Yes. This clearly fixes the problem that the patch describes, and also
clearly matches up with the Fixes tag. So that's correct.


>   
>   	if (flags & FOLL_TOUCH) {
> @@ -1181,7 +1181,13 @@ static long __get_user_pages(struct mm_struct *mm,
>   			/*
>   			 * Proper page table entry exists, but no corresponding
>   			 * struct page.
> +			 *
> +			 * Warn if we jumped over even with a valid **pages.
> +			 * It shouldn't trigger in practise, but when there's
> +			 * buggy returns on -EEXIST we'll warn before returning
> +			 * an invalid page pointer in the array.
>   			 */
> +			WARN_ON_ONCE(pages);

Here, however, I think we need to consider this a little more carefully,
and attempt to actually fix up this case. It is never going to be OK
here, to return a **pages array that has these little landmines of
potentially uninitialized pointers. And so continuing on *at all* seems
very wrong.

Can we bail out at this point, without breaking the world? I think we can...

Also: this part, even if it remains as is, should be a separate fix and a
separate patch, IMHO.

thanks,
-- 
John Hubbard
NVIDIA

>   			goto next_page;
>   		} else if (IS_ERR(page)) {
>   			ret = PTR_ERR(page);

