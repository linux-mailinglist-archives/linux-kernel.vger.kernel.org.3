Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB34ECA04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiC3Qv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiC3Qvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:51:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC102921DE;
        Wed, 30 Mar 2022 09:50:08 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UEj8Yi025309;
        Wed, 30 Mar 2022 16:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=yTlT5JEB/0TwTpTZDVWl7xqNE1GJtyNOF4xzIA6EnJs=;
 b=pO0toVj6sq3dJ2yJz/jbMvxAykA3fqvIbikJKI+MfmBrgR+x/5bzaer871tcqzBJphUV
 KVSh+PHCJWI3FUzK/VccKHRF0xak/7DD6KiDPbkwi8QOW1wbNEJ1gEr2r24ATu52LNLr
 DK3wNNFKWkqmlKx6kC8xsgYnrWmQW9hLdkSHpdc+X9vTRY75qxFiI4mBR5m8ZTO8fQiq
 0g1IOfUOyyGlJRZMHhmDf7fxqzYkRStrod+l2KlvMgqG3VsZl+yeB6SqB/fRxfHnn4IJ
 Mb6LRZ2z3xk7mMqTakFveLv+Pk7FaZgMvTSn2eBHxueJEqftZMgAE+UZnv1nKL/1txd7 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4s86jk32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:49:05 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22UGNQQi014067;
        Wed, 30 Mar 2022 16:49:05 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4s86jk28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:49:04 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22UGiY6d005572;
        Wed, 30 Mar 2022 16:49:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3f1t3hypxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:49:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22UGn3bc38076872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 16:49:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C858852050;
        Wed, 30 Mar 2022 16:48:57 +0000 (GMT)
Received: from thinkpad (unknown [9.171.11.24])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 23E8A5204F;
        Wed, 30 Mar 2022 16:48:56 +0000 (GMT)
Date:   Wed, 30 Mar 2022 18:48:55 +0200
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
Subject: Re: [PATCH v2 5/8] s390/pgtable: cleanup description of swp pte
 layout
Message-ID: <20220330184855.56916ba5@thinkpad>
In-Reply-To: <20220329164329.208407-6-david@redhat.com>
References: <20220329164329.208407-1-david@redhat.com>
        <20220329164329.208407-6-david@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AkaKn8XsCHiAbbf6Ip-8uRd9E1i0sd5i
X-Proofpoint-GUID: Sd03kvTYqrZ923F9E8Bi0z5eXElEe7EU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_06,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 18:43:26 +0200
David Hildenbrand <david@redhat.com> wrote:

> Bit 52 and bit 55 don't have to be zero: they only trigger a
> translation-specifiation exception if the PTE is marked as valid, which
> is not the case for swap ptes.
> 
> Document which bits are used for what, and which ones are unused.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/pgtable.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 9df679152620..3982575bb586 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1712,18 +1712,17 @@ static inline int has_transparent_hugepage(void)
>  /*
>   * 64 bit swap entry format:
>   * A page-table entry has some bits we have to treat in a special way.
> - * Bits 52 and bit 55 have to be zero, otherwise a specification
> - * exception will occur instead of a page translation exception. The
> - * specification exception has the bad habit not to store necessary
> - * information in the lowcore.
> - * Bits 54 and 63 are used to indicate the page type.
> + * Bits 54 and 63 are used to indicate the page type. Bit 53 marks the pte
> + * as invalid.
>   * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
> - * This leaves the bits 0-51 and bits 56-62 to store type and offset.
> - * We use the 5 bits from 57-61 for the type and the 52 bits from 0-51
> - * for the offset.
> - * |			  offset			|01100|type |00|
> + * |			  offset			|X11XX|type |S0|
>   * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
>   * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
> + *
> + * Bits 0-51 store the offset.
> + * Bits 57-61 store the type.
> + * Bit 62 (S) is used for softdirty tracking.
> + * Bits 52, 55 and 56 (X) are unused.
>   */
>  
>  #define __SWP_OFFSET_MASK	((1UL << 52) - 1)

Thanks David!

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
