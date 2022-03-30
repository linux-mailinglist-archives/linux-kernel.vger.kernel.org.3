Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965424ECA03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbiC3Qv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343785AbiC3Qvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:51:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A18F2908BA;
        Wed, 30 Mar 2022 09:50:08 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UEJLVv000462;
        Wed, 30 Mar 2022 16:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ARroIKBEvmL0KWXtnhmovWMBp2q8g4z6TFYDyygKASk=;
 b=KRzoQsD6PJq2G9kFzeRvUWII/EaOj8gNOezSHce7EUZzHFJYk8L3G7wMnqGHNUaYfBNZ
 tT0FrChzyFQQSOXdgfU4DqvUD21YnmntRVYIC5IoyJg9VaRBFvlEYjukvXmUyzAhVxAn
 eMHsoKuTPyn86zO1kum0w5/jhuBrdbbRmVLBCgTbugi2inIVv+Lh9lveTdlhj2B4rF+G
 vKb0KVbDWuGazpQt07aaINJeZRoiflDfzHQKUKmaAuQy6etr7v7t/qU/rxACRWa/n3oH
 Xn89v9c9Zfb2LM8sl55NZrAtVgRVU1tUgDpdpMqudv2KtvdBHywKKNEcBU38h19oPPbK uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4psu6gut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:48:56 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22UGfnPq005888;
        Wed, 30 Mar 2022 16:48:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4psu6gtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:48:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22UGhWGn024601;
        Wed, 30 Mar 2022 16:48:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3f3rs3m0ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:48:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22UGmnpC41288138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 16:48:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 095B14C046;
        Wed, 30 Mar 2022 16:48:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B3654C040;
        Wed, 30 Mar 2022 16:48:47 +0000 (GMT)
Received: from thinkpad (unknown [9.171.11.24])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 30 Mar 2022 16:48:47 +0000 (GMT)
Date:   Wed, 30 Mar 2022 18:48:45 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 6/8] s390/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Message-ID: <20220330184845.737efc45@thinkpad>
In-Reply-To: <20220329164329.208407-7-david@redhat.com>
References: <20220329164329.208407-1-david@redhat.com>
        <20220329164329.208407-7-david@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1QKLcZzt1jR5dzZvoETLyjNRF1Mo4qOd
X-Proofpoint-GUID: R2QabvWqUvukurysdgE-o4H0cb3QiG1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_06,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 18:43:27 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's use bit 52, which is unused.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/pgtable.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 3982575bb586..a397b072a580 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -181,6 +181,8 @@ static inline int is_module_addr(void *addr)
>  #define _PAGE_SOFT_DIRTY 0x000
>  #endif
>  
> +#define _PAGE_SWP_EXCLUSIVE _PAGE_LARGE	/* SW pte exclusive swap bit */
> +
>  /* Set of bits not changed in pte_modify */
>  #define _PAGE_CHG_MASK		(PAGE_MASK | _PAGE_SPECIAL | _PAGE_DIRTY | \
>  				 _PAGE_YOUNG | _PAGE_SOFT_DIRTY)
> @@ -826,6 +828,22 @@ static inline int pmd_protnone(pmd_t pmd)
>  }
>  #endif
>  
> +#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
> +static inline int pte_swp_exclusive(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
> +}
> +
> +static inline pte_t pte_swp_mkexclusive(pte_t pte)
> +{
> +	return set_pte_bit(pte, __pgprot(_PAGE_SWP_EXCLUSIVE));
> +}
> +
> +static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> +{
> +	return clear_pte_bit(pte, __pgprot(_PAGE_SWP_EXCLUSIVE));
> +}
> +
>  static inline int pte_soft_dirty(pte_t pte)
>  {
>  	return pte_val(pte) & _PAGE_SOFT_DIRTY;
> @@ -1715,14 +1733,15 @@ static inline int has_transparent_hugepage(void)
>   * Bits 54 and 63 are used to indicate the page type. Bit 53 marks the pte
>   * as invalid.
>   * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
> - * |			  offset			|X11XX|type |S0|
> + * |			  offset			|E11XX|type |S0|
>   * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
>   * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
>   *
>   * Bits 0-51 store the offset.
> + * Bit 52 (E) is used to remember PG_anon_exclusive.
>   * Bits 57-61 store the type.
>   * Bit 62 (S) is used for softdirty tracking.
> - * Bits 52, 55 and 56 (X) are unused.
> + * Bits 55 and 56 (X) are unused.
>   */
>  
>  #define __SWP_OFFSET_MASK	((1UL << 52) - 1)

Thanks David!

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
