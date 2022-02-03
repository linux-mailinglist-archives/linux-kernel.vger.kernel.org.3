Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA14A854A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiBCNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:31:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231955AbiBCNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:31:43 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213BEHKB009625;
        Thu, 3 Feb 2022 13:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=LzgkLky9xlcekWDvQkdpsjozHbfe+QBnFce5XgZUaAU=;
 b=pu4gdwZ3A9xBKpL6ygW6farzKAf+bn9Kb/J00p5X1zguY19o2N/oOtFCHRUUUHw4q9L5
 rOZ8YRYr47mCMzsHLtrTyxf6U0C5IdVg40B6u3h137wy83Cx2MirXP/U9qdxsGkcXms5
 mLV2UnTusucKZ+4JH7BUv3UMqgclokf5Nd9sXOZoekIvLyXnqCiXHxxd+2VxWnnpSKHy
 s48QZrBRNYRUAApExh0lJsOT1vQXsBEv3YNBL2eqrkrvn878oYgXM2TOD+2ehyNgaY25
 Nu3m4Xl8uwTyaqbK9/10uX8Sbe9skPNUK2pyek4ZLuhPoJQV7fgvmz6YPg3rzDs5YRuM Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e03fn6d5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:33 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 213DJx2E018631;
        Thu, 3 Feb 2022 13:31:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e03fn6d4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213DBQeL008425;
        Thu, 3 Feb 2022 13:31:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw7a6a57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213DVR2X41157042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 13:31:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8B9A4064;
        Thu,  3 Feb 2022 13:31:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09624A4062;
        Thu,  3 Feb 2022 13:31:27 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 13:31:26 +0000 (GMT)
Date:   Thu, 3 Feb 2022 13:10:07 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/4] mm: Fix invalid page pointer returned with
 FOLL_PIN gups
Message-ID: <20220203131007.563d21e7@p-imbrenda>
In-Reply-To: <20220203093232.572380-2-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
        <20220203093232.572380-2-jhubbard@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b1SyVhSjdIn05u-iyrMiLziRIkWXePDj
X-Proofpoint-ORIG-GUID: KOyPhJ1qB3ffunMlu7sYKjvPx1S6-ngh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 01:32:29 -0800
John Hubbard <jhubbard@nvidia.com> wrote:

> From: Peter Xu <peterx@redhat.com>
> 
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
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Debugged-by: Alex Williamson <alex.williamson@redhat.com>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

you can add 

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

although maybe this would look better if it were squashed into the next
patch, as others have also suggested

> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f0af462ac1e2..65575ae3602f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>  		pte_t *pte, unsigned int flags)
>  {
>  	/* No page to get reference */
> -	if (flags & FOLL_GET)
> +	if (flags & (FOLL_GET | FOLL_PIN))
>  		return -EFAULT;
>  
>  	if (flags & FOLL_TOUCH) {

