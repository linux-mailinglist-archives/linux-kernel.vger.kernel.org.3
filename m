Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF84A854C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350840AbiBCNbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:31:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242953AbiBCNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:31:44 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213Av80j009705;
        Thu, 3 Feb 2022 13:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=pcabMoSA0vssBHPtHTJ1xHkkrc5E3PfzR96wyD8R2/4=;
 b=WCqvq3JHXIAuT8qhsMbeW2fVv3IWLg0mAHHTl1f6v22xmFikhy/EU0hhq7s+66gHpFwC
 vOZx7Il6TWXQt6oYSMeSOW9h2RoWNsvZNcdYpMvp2BpkbsDSiLdr/781iilMjG3vzWZb
 p97cwvIgW8Xfm7ri6SIg7s2EEfyyqFHAuMbOlU4HbBopNhYXtFgy0YYq5fAExRfyiwCb
 AK4by5I2Y3IK7bxnmh5N3Lzagl7PuCTbRHbOuFWA92tLyWin85gNjYmhx4p4Oe7jhV9p
 l5yyymR4ysHA8HdvSiFeV4+hyaPFruDNctegU/cR32DamQfPyLCiG74WqUciQLGM7KQN Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e03fn6d4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:30 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 213D82cT000370;
        Thu, 3 Feb 2022 13:31:30 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e03fn6d3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213DCtWV011858;
        Thu, 3 Feb 2022 13:31:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3dvvujxdet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213DVP9Q26804726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 13:31:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49808A405F;
        Thu,  3 Feb 2022 13:31:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8214DA405B;
        Thu,  3 Feb 2022 13:31:24 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 13:31:24 +0000 (GMT)
Date:   Thu, 3 Feb 2022 12:52:24 +0100
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/4] mm/gup: remove unused pin_user_pages_locked()
Message-ID: <20220203125224.0812f5c5@p-imbrenda>
In-Reply-To: <20220203093232.572380-4-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
        <20220203093232.572380-4-jhubbard@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6LykmUt2_LEZ2Ql1912HvlJaHqjXJWgC
X-Proofpoint-ORIG-GUID: wm6MO6EvryZSw8jY4j7JGFKbyIL0grqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 01:32:31 -0800
John Hubbard <jhubbard@nvidia.com> wrote:

> This routine was used for a short while, but then the calling code was
> refactored and the only caller was removed.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

if it's not used anymore, good riddance

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  include/linux/mm.h |  2 --
>  mm/gup.c           | 29 -----------------------------
>  2 files changed, 31 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 213cc569b192..80c540c17d83 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1918,8 +1918,6 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    struct vm_area_struct **vmas);
>  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages, int *locked);
> -long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -		    unsigned int gup_flags, struct page **pages, int *locked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  		    struct page **pages, unsigned int gup_flags);
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> diff --git a/mm/gup.c b/mm/gup.c
> index cad3f28492e3..b0ecbfe03928 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3119,32 +3119,3 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
>  }
>  EXPORT_SYMBOL(pin_user_pages_unlocked);
> -
> -/*
> - * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
> - * Behavior is the same, except that this one sets FOLL_PIN and rejects
> - * FOLL_GET.
> - */
> -long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -			   unsigned int gup_flags, struct page **pages,
> -			   int *locked)
> -{
> -	/*
> -	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
> -	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> -	 * vmas.  As there are no users of this flag in this call we simply
> -	 * disallow this option for now.
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> -		return -EINVAL;
> -
> -	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> -		return -EINVAL;
> -
> -	gup_flags |= FOLL_PIN;
> -	return __get_user_pages_locked(current->mm, start, nr_pages,
> -				       pages, NULL, locked,
> -				       gup_flags | FOLL_TOUCH);
> -}
> -EXPORT_SYMBOL(pin_user_pages_locked);

