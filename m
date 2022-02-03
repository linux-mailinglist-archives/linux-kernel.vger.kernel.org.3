Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB64A852E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbiBCNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:31:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231955AbiBCNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:31:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213BbJf4003414;
        Thu, 3 Feb 2022 13:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=HitBZKpE6KMyaGTf1UTC72zyQwZjkU4C57dlGY5K7Hg=;
 b=l+KNiCXhgU5K3W2XlsfZtj5Zps7pfV72BrA/MUmNUTT7yKtZrxXTTHjIJ4tVmT/SE3Pf
 9YKnieQZb1s6zugMEa8yFEFcEPYmdFIuHDjvOFf3FQhg+G3YyWYVxeE39LgzOXmC5qH/
 xPQ2/vG25s59lYJXO7hFBNCxAACubt60kBSNj8aph23eBIYsS3LRzEQMhXvGR2U7SViG
 fRs+xbGMTUEZ9LKtrGM2yZlzqZLuqK4kCz6K41PAd4hAlx5gsX6lLpTJMJ27SCAwgIIs
 v9rXsVPk5+T/vTU9BQ8yk+21srHXKbX1qAtSAEbQhxkQo8qduqdBw3qJXIk/+oiFGcfD 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e04m6598b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:27 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 213Crl3I006696;
        Thu, 3 Feb 2022 13:31:27 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e04m6597h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213DCfw9029778;
        Thu, 3 Feb 2022 13:31:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3dvw7a4gc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213DLTrR48234958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 13:21:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9B66A405F;
        Thu,  3 Feb 2022 13:31:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07356A4054;
        Thu,  3 Feb 2022 13:31:22 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 13:31:21 +0000 (GMT)
Date:   Thu, 3 Feb 2022 14:31:14 +0100
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
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 2/4] mm/gup: clean up follow_pfn_pte() slightly
Message-ID: <20220203143114.42d59bbe@p-imbrenda>
In-Reply-To: <20220203093232.572380-3-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
        <20220203093232.572380-3-jhubbard@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VYOFWgMDHQCNwsAsCcSS0XWBQztY54HN
X-Proofpoint-GUID: zWyyqxjiLkSW97wRorv6O7TwdRSjyZLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 01:32:30 -0800
John Hubbard <jhubbard@nvidia.com> wrote:

> Regardless of any FOLL_* flags, get_user_pages() and its variants should
> handle PFN-only entries by stopping early, if the caller expected
> **pages to be filled in.
> 
> This makes for a more reliable API, as compared to the previous approach
> of skipping over such entries (and thus leaving them silently
> unwritten).
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 65575ae3602f..cad3f28492e3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>  		pte_t *pte, unsigned int flags)
>  {
> -	/* No page to get reference */
> -	if (flags & (FOLL_GET | FOLL_PIN))
> -		return -EFAULT;
> -
>  	if (flags & FOLL_TOUCH) {
>  		pte_t entry = *pte;
>  
> @@ -1180,8 +1176,13 @@ static long __get_user_pages(struct mm_struct *mm,
>  		} else if (PTR_ERR(page) == -EEXIST) {
>  			/*
>  			 * Proper page table entry exists, but no corresponding
> -			 * struct page.
> +			 * struct page. If the caller expects **pages to be
> +			 * filled in, bail out now, because that can't be done
> +			 * for this page.
>  			 */
> +			if (pages)
> +				goto out;
> +
>  			goto next_page;
>  		} else if (IS_ERR(page)) {
>  			ret = PTR_ERR(page);

I'm not an expert, can you explain why this is better, and why it does
not cause new issues?

If I understand correctly, the problem you are trying to solve is that
in some cases you might try to get n pages, but you only get m < n
pages instead, because some don't have an associated struct page, and
the missing pages might even be in the middle.

The `pages` array would contain the list of pages actually pinned
(getted?), but this won't tell which of the requested pages have been
pinned (e.g. if some pages in the middle of the run were skipped)

With your patch you will stop at the first page without a struct page,
meaning that if the caller tries again, it will get 0 pages. Why won't
this cause issues?

Why will this not cause problems when the `pages` parameter is NULL?


sorry for the dumb questions, but this seems a rather important change,
and I think in these circumstances you can't have too much
documentation.

