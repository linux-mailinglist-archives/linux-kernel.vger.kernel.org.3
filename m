Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C041561DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiF3O32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiF3O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:29:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE29C9BB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:12:06 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UDni2S005113;
        Thu, 30 Jun 2022 14:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Tp7jYxvH9F3lEn6rbNK23sm6RwbyTdBNIoz0/QMJry4=;
 b=bGkZ2O+QyWmfCHmZlsHgyebNM2OmZJ+AGIJk3AozhMPTNhdTeJfOOnFjimU1lqjphKBD
 /4SekLwVGmuwd7bq5QnyiyCsmjUVKFrxgyT33TpENhb0iTfFZ639eBU563W28dzEp0g1
 7FXtzpv2N2KyQPg3vW+LGSXtRzIUHrws+a2I/x7riNue7A9jLB6Kb6FvfVBtBcld1Uin
 H9nALb/X47DOrN0qFVUapiOZWl47+7m3V1rneNz1aQuZuSTeUsP1Ev797rpapT3iBxRV
 pP4cambcejMQEAJJTdecHuXht3O/vKMU5v7JPPqNjONHff3Qa+nxv2qXTJJY9RVry+pU 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1d2c8pfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:11:40 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25UDuGse002063;
        Thu, 30 Jun 2022 14:11:40 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1d2c8pek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:11:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UE5KxM019086;
        Thu, 30 Jun 2022 14:11:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj89p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 14:11:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UEBh1A31064528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 14:11:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B388B4C040;
        Thu, 30 Jun 2022 14:11:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 257FE4C044;
        Thu, 30 Jun 2022 14:11:35 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.154.93])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Jun 2022 14:11:34 +0000 (GMT)
Date:   Thu, 30 Jun 2022 17:11:33 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] mm: Factor out the pagetable pages account
 into new helper function
Message-ID: <Yr2vFQVPUWX3t9RB@linux.ibm.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <9c527d4d2eb1f457306e575ce16c6acdd8141e02.1656586863.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c527d4d2eb1f457306e575ce16c6acdd8141e02.1656586863.git.baolin.wang@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IJcKMiwvx-klPrQlNZdImYF_NifllsmN
X-Proofpoint-ORIG-GUID: Zjqkfhimnf5lBHUt1IcmY8HZOXNVIApf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 07:11:14PM +0800, Baolin Wang wrote:
> Factor out the pagetable pages account into new helper functions to avoid
> duplicated code. Meanwhile these helper functions also will be used to
> account pagetable pages which do not need split pagetale lock.
> 
> Meanwhile convert to use mod_lruvec_page_state() in case of non-order-0
> page table allocation.

These are *very* rare. I think only parisc may have non-order-0 pmd and pud
tables.
With that, I'd suggest making use of compound_nr() build time opt-in.
 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/mm.h | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a2270e3..3be6d2c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2353,20 +2353,30 @@ static inline void pgtable_init(void)
>  	pgtable_cache_init();
>  }
>  
> +static inline void pgtable_page_inc(struct page *page)
> +{
> +	__SetPageTable(page);
> +	mod_lruvec_page_state(page, NR_PAGETABLE, compound_nr(page));
> +}
> +
> +static inline void pgtable_page_dec(struct page *page)
> +{
> +	__ClearPageTable(page);
> +	mod_lruvec_page_state(page, NR_PAGETABLE, -compound_nr(page));
> +}
> +
>  static inline bool pgtable_pte_page_ctor(struct page *page)
>  {
>  	if (!ptlock_init(page))
>  		return false;
> -	__SetPageTable(page);
> -	inc_lruvec_page_state(page, NR_PAGETABLE);
> +	pgtable_page_inc(page);
>  	return true;
>  }
>  
>  static inline void pgtable_pte_page_dtor(struct page *page)
>  {
>  	ptlock_free(page);
> -	__ClearPageTable(page);
> -	dec_lruvec_page_state(page, NR_PAGETABLE);
> +	pgtable_page_dec(page);
>  }
>  
>  #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
> @@ -2452,16 +2462,14 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
>  {
>  	if (!pmd_ptlock_init(page))
>  		return false;
> -	__SetPageTable(page);
> -	inc_lruvec_page_state(page, NR_PAGETABLE);
> +	pgtable_page_inc(page);
>  	return true;
>  }
>  
>  static inline void pgtable_pmd_page_dtor(struct page *page)
>  {
>  	pmd_ptlock_free(page);
> -	__ClearPageTable(page);
> -	dec_lruvec_page_state(page, NR_PAGETABLE);
> +	pgtable_page_dec(page);
>  }
>  
>  /*
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.
