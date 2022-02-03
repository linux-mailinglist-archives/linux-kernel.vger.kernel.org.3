Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB804A8FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354962AbiBCVZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:25:15 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:55521
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231464AbiBCVZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:25:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLbzbTGR+37Qv6EpoZdFGZlb4PY0Yf940x8zZ6r3gMISMRYRWBcIymnfsV6ncMs97RS+dC7+6tL1VwnLzaJ1rYyfTOlTDNsBJpEhpbFKRLgvbJgiUNGqnvIBWGXs8xHKiQL4yrEsYUR3ze6FSz9ZM7FeT1Ri6DQI3zMJnHz6zMBJMvc4oaarG0jSDmmAxpatBIC+H2SM75n13TfF/MzEZoWQN2rvhZzHiEb6m4Ak+wEdsk+g2bw3m8cRYjlYXC0mQRayN2lggRudPLoDBEaLwO9IYLGBkNs5vVjcMpuKTUyn78181ooBusZW5bivMUfnQb6vFABkG+cGxKDHQETJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3/bHzGeT0SnnNSJ4sQ/Ctlfs56rIqimS/COd2dUbg0=;
 b=KJjrXKXeEnOPsRlCFtkEZqERo/gXPnpDngf4nUkL7+imXhFuiMRcAyCgt3BAKzz+PbmFwsVc9bgqz09sLHbllzgJesMk6spfbmWhFwBl1qFLqKwFjZ8BbLaoRo5Ct4lVaBYbLpYZwSkmv9NyeU3Y1jVYKJOPE6lMVWdnGIBEEpQ2nJxhX5Dpn6LbK99T/d4kUXw0ABW3BKLR3qolRW7dKKZryATtzHP9XuSDEW4jlO+cATfbLEbikMCGc/c3H6Gf6Vpc/GqJakU9vnE0ntllwO8pLPNeUzWHidcUCzvnmwckgztXYwHQGfOi8v1tP00HSOa9pWr6y0AZhVm591SUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3/bHzGeT0SnnNSJ4sQ/Ctlfs56rIqimS/COd2dUbg0=;
 b=eKURW1CTNvcik/sTOmO9Sltb49WpRfeCrkh1mCb2E15bQEXneT/TCqUYq6vHSckG+X8qgn2v4+XrXWl1QeFTH7MDYiADRvunDTmzFx5z9PybOO+hP5rTQYXjANcS1q7W6stL/Q/rodjurTMbOr7vO3bgr2lE/M3xX1AYV63tIRKasaSHa+q33BxDB2mGtUdk0WXs4x7zFpREcaEVz5MFWrShy8s/G8Uoih7BXnooVbB/zfwqdw5VdqD7jBbFYP9ETM9zt+gMrk5MrA75VxbrL2eGW7vXbOnqko4kRVrhj5G/DogfoaYNNA23knmWs2jFBgUWL5aweuXIa0UXlod6Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 21:25:12 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:25:12 +0000
Message-ID: <ed77ae0e-f632-a077-7f79-c856aeff62eb@nvidia.com>
Date:   Thu, 3 Feb 2022 13:25:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/4] mm: Fix invalid page pointer returned with
 FOLL_PIN gups
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-2-jhubbard@nvidia.com>
 <20220203131007.563d21e7@p-imbrenda>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220203131007.563d21e7@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39ca085-1996-4f2c-f679-08d9e75ba9a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359FC7C1A75A9B26C6B596DA8289@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zFiFyZz7yUvJZ7oHdyH2rSHTaYtDgLkcLaTSrecSqBCjv/+x42Xh6wk3FBna9UPyz27faj+p57AmrHjcVBAZ1enMvyUnsiGGEVT/VGzFisfoJkdt+nsj2kthOP2vyLfiBr3tqo9dXeyPaI2T1j5j/v/3Ln7Kb1yMRw1iLGqdEgrsHyoHhaMmhPR0lbZhaTwen7N/kt1QWep+y28WU7vwgA4ATOKKSlU5CuHbRvPejoxw+i6lmo9UEWjBxMfwrS7Buy237xJCWNe2FpN5GZz31Fz1QJLZhuoM8XrLWz9N2oh/CI7Ksy5ZxhzqQKwfYAo/goV2nJtyltpEYsTf3aVi7fLBXkEUjEvdF4n24TfKAwpftq4fd++0jYwa+kPtvagxM7P1No0KC9nh5mrtYiRAl0zzVw/6Ep6HOahor/x9gjxltfmMOYHxE4dT5PcWF/3ewq9GVPsmn9J2sRnA5iVXFWwayzesSyhWR0parqVhZnSLG1l88ZorRf04wASaMmZEp7LftAv3WB0n0sut/dubPE39N74BHylzM9X+95DhNi3L5O6EaTgr7hazGirroqrcE+Xj/HyC7X+cA1DRWujn29AORoe0NHNA6EjduAK0mBXHSw+ibdnHLvVaV3odfRWfZeug5O6aQdpL2enCOrEw67T9QiUm3DpSANku+I5kfXQBX0sQv+nUY6vnB0GOBgYYN+UVKHG7BsUpzoVRf5wZzCxGYtTCckkKCfqfmzBiJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(8936002)(53546011)(38100700002)(7416002)(66946007)(8676002)(316002)(2616005)(4326008)(6512007)(26005)(6916009)(36756003)(86362001)(508600001)(66556008)(31696002)(2906002)(66476007)(5660300002)(6486002)(31686004)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlRITTJhTkRrcjFPWXhlaTJEQkJ0ZE1RakJuaHoyeGNiQnFnWmZQQSttaXJ4?=
 =?utf-8?B?MVZUaWJldjJPUCtmR29yMVJScmRKaHhLd2E2cWNKVGxlQ3daYWV5OHg2eVph?=
 =?utf-8?B?dTVkaFdlcVdvWnhFZzBUWG54STJTaW5DK0I5RDdBYnJqN1ljcmRHb0t5WVh0?=
 =?utf-8?B?cHhSWTgwa2l5cHhCclBTR0lEYlFUTlB2ZjVybTMzK2laS3QzaXJrYnlDTEcw?=
 =?utf-8?B?ZHRxUjNyQnBGNGIyaHBvbGs3N2Y3L3lDOE9EeHo5SWVaUDFZb0E0NjBOOGxD?=
 =?utf-8?B?RmR6Y3M0c3BTSUpLbWE4d1pBbmY5bXJSZFM5V01ndmxpTXVySGxXWnFJbVV4?=
 =?utf-8?B?c1RMc3l5akhtTDREbVBjUkdWU2lhSFM0bm9ud0duNmhNQnpxcU1sUXU2Yy96?=
 =?utf-8?B?NGNuT0ZiOEpNclJRNVRRRGhPcmt3YVk1V3F4QndaN3h2TmtoK1RnN3lSTTJj?=
 =?utf-8?B?NlZRalZoeTlyVTFKYjZrQU1GVkhpc0U5azRteUVIM2d6NkNZWm5ORFlmSmJF?=
 =?utf-8?B?ZlhIK2cwWEJQcEE4NVVyUWRDWUtzbzdCQVphekhRNmR4YnVWM08rQkk5K3FZ?=
 =?utf-8?B?K0M3Vy81L2I2STBWQWZlaWFsWG13d0I2R01lOXdaNlduVm5aNXhpQXY0ejJs?=
 =?utf-8?B?eFFraFJTYlVnSThRSVdoKzA3OTRkNmpGdXB2TmlnNFErYjJuT2ZMSjQ1Nk1K?=
 =?utf-8?B?U01YT2xVcnBRclVhK2lCOTFzWmRGUGdVUG90d0lIQXhPOFdzeGNtdGxaQ29n?=
 =?utf-8?B?UkdZNEJSYlZCS0NVa1J4WkROajNqZmJTZlV6cVlkbWRjQ2l2bUhKWE1RZGEx?=
 =?utf-8?B?T1pMY3U2UVNya2dUK0dqTkw3RFlHZ1NPeDJtNHhzMnEydlBpeFoxc0o1Z3lS?=
 =?utf-8?B?RDhRSmFJcjZ5aTlUcUNUd1FCYW1ZWlBWN1A0V1Rpb2ZEOWl0NlVPRk9PMUs1?=
 =?utf-8?B?WmE0ajFTOVRTb21vcVl4cTV1dURJYktlVTJ5Y1Z5VElZZnJMZDNqdDZ3VHpZ?=
 =?utf-8?B?TUgzQ2c5eTg0TXBpcUpDZDl1WmQxOEFXcDd1bVpNcVhNMzR3SElObnVSOEg3?=
 =?utf-8?B?NVptUXlzUllMamFBcEpraSs2Qm05V2FCNlpHRlhOZEozRHFRZVdpMFNpTjJS?=
 =?utf-8?B?WDlxWXhyd3RwcWtPWUdMc2QrYjN2eC85TlNQN1E3NW51dXdJNDFGYmI2MGJC?=
 =?utf-8?B?TzJEMDdSZTRzL0NWWmZyb3VXTGd0eC9KKzlTUmlsSUQxMWdkK0dOL1ZJU3dN?=
 =?utf-8?B?UmhDRVBVM2Z5a1l2Rlg3dWZpa0VOcXhWR0xvcUdMK20vcGtDd0t2d2JGVVNp?=
 =?utf-8?B?WEhWSGxTZWpOY05Bb25CWWZiZmtmUUE3enBZNGVWMy9rTEVGNzFobFRsS3VG?=
 =?utf-8?B?SDNWU1c2R2tQWjBBR0pZWURHZjNtS2psV1dGblFBMGt5NHN0SHNNMnlpUzJI?=
 =?utf-8?B?c3pEeGtrSzF4ZW1Zb1dIV1BHQVJpOGlxSGJhRWMyRTNXT3JJcWlpTDVsMER4?=
 =?utf-8?B?NldETkxFM2hlMStOYys2Yk02b0dGSm9hb25UOXJqeWhMTWJtWWNEb1lDbnJa?=
 =?utf-8?B?N0NWOTlxeU5ZS0VqTmFVWjJZWjM1ZnEwZDJ3Smo1Wko2ZE1rWUd3cXgyS1BR?=
 =?utf-8?B?U2FpUnJoeG0zMjZDYUZCUStaSThuVlpKMFRHemJVNkhmQWRFanpjVXNQRmJ6?=
 =?utf-8?B?THRNOUZNSWVlU3FiQStQT2VxeVJGY1E2NzI4WlVoTnJSelJFcnBOYWZ4SlBm?=
 =?utf-8?B?Y25aNXR2R2JZQUV4VWZJR0ZCa3NQcnlGYnFVRVBVRnhrRXlIMTJmZDJLblBF?=
 =?utf-8?B?TWJiUWJsZ3lZVjFQek5qN0VIVnRLdWtLZ1JOcncxVThtUmlzRHNyUDZQdEdI?=
 =?utf-8?B?ZVJUSTY3YjJqalFlZ09YakhHMmdwYTlnU0tNMDdMWFlST1cvZTZoVTdoSHNC?=
 =?utf-8?B?dXVCT3NWK3dFdUJIUmp5UHcyUktHSDlCajRsQlZHeC9tTHQwenQxTDFCOVU2?=
 =?utf-8?B?NHk4Nmw2Z0pvdWExNExxZk0xeWJTd09ISWlhTWNYNDlzclZyYTAzV1Rrc2tt?=
 =?utf-8?B?WWpubFg0dmJtM1pXakFZL3hFa2ZuY3BtMGUrQ05oMEZWZkdRdXFvMDFoWmln?=
 =?utf-8?B?WTVkaVpSYzJ1WkQ1VkdFK2t6eUxCTndxRHQrV0s4cXRBSzFnR2h4SHVTZ216?=
 =?utf-8?Q?VtIsVtCb8XrJj/XeofjxuDQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39ca085-1996-4f2c-f679-08d9e75ba9a5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:25:12.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vs6GDYckdDPZCDmvxAxUPrr7YP7dgqz9rCZtI5bCU+Sna7u8jNbm9Ef3X7w+/goH/XSLSZuB1VG5R20lJ0E+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 04:10, Claudio Imbrenda wrote:
> On Thu, 3 Feb 2022 01:32:29 -0800
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> From: Peter Xu <peterx@redhat.com>
>>
>> Alex reported invalid page pointer returned with pin_user_pages_remote() from
>> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
>> pinning with struct vfio_batch").  This problem breaks NVIDIA vfio mdev.
>>
>> It turns out that it's not the fault of the vfio commit; however after vfio
>> switches to a full page buffer to store the page pointers it starts to expose
>> the problem easier.
>>
>> The problem is for VM_PFNMAP vmas we should normally fail with an -EFAULT then
>> vfio will carry on to handle the MMIO regions.  However when the bug triggered,
>> follow_page_mask() returned -EEXIST for such a page, which will jump over the
>> current page, leaving that entry in **pages untouched.  However the caller is
>> not aware of it, hence the caller will reference the page as usual even if the
>> pointer data can be anything.
>>
>> We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP handle pfn
>> mapping unless FOLL_GET is requested") which seems very reasonable.  It could
>> be that when we reworked GUP with FOLL_PIN we could have overlooked that
>> special path in commit 3faa52c03f44 ("mm/gup: track FOLL_PIN pages"), even if
>> that commit rightfully touched up follow_devmap_pud() on checking FOLL_PIN when
>> it needs to return an -EEXIST.
>>
>> Attaching the Fixes to the FOLL_PIN rework commit, as it happened later than
>> 1027e4436b6a.
>>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> Reported-by: Alex Williamson <alex.williamson@redhat.com>
>> Debugged-by: Alex Williamson <alex.williamson@redhat.com>
>> Tested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> you can add
> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 

Thanks!

> although maybe this would look better if it were squashed into the next
> patch, as others have also suggested
> 

I was thinking about that. It seems like this patch here cleanly addresses
an oversight, and it is tiny and reasonably suitable for backporting.

Patch 2, on the other hand is less of a fix, and more of a "let's improve
things". And now it is expanding now to cover move_pages() too. So maybe it
is better to leave them separate, after all.


thanks,
-- 
John Hubbard
NVIDIA

>> ---
>>   mm/gup.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index f0af462ac1e2..65575ae3602f 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>>   		pte_t *pte, unsigned int flags)
>>   {
>>   	/* No page to get reference */
>> -	if (flags & FOLL_GET)
>> +	if (flags & (FOLL_GET | FOLL_PIN))
>>   		return -EFAULT;
>>   
>>   	if (flags & FOLL_TOUCH) {
> 
> 

