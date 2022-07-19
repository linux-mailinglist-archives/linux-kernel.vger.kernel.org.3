Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0C57A19A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiGSOce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbiGSOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:32:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9536E6FA20;
        Tue, 19 Jul 2022 07:21:15 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JEDnZY017144;
        Tue, 19 Jul 2022 14:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=6BchNWndvq2RoIW6HJPS1KPURa5/erXwK9S4Ym4B7tY=;
 b=BBFl3JBZ+s/GpejmLT1G3uWyRbccF5/Hcp4o+7Xz4bdbqWBN2+sb899pArm+Vb4/6JGM
 kba0FhsnvaYukdGF5i6JPbAnNgX9t0+N0nRTycu8B3IBMxMqWo9NCBOfFJxStKJPDCqW
 XfCX64AO8SojmdVc7oaHD8PzOnEJrUKyqRZ6WvVYcvkRmiffkVy4frWgIVYxlN6xxeIT
 aPQa3pahpu06JbehZva3WYGNKw23ENO4Fb5MZspqpzCSw8DlMXSbojQx2HbUcvu171jP
 M1kjvX75El+zM93Rhxagasgt3gdbKCHh6K3TTd4hPGg+V68SejMVV7rONhC6UP9kZiyh vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdx6k08qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 14:20:49 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26JEETs5023201;
        Tue, 19 Jul 2022 14:20:49 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdx6k08pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 14:20:48 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26JE5J5b000772;
        Tue, 19 Jul 2022 14:20:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3hbmy8u7st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 14:20:46 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26JEKgGQ18088288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 14:20:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8505E42045;
        Tue, 19 Jul 2022 14:20:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33C1442042;
        Tue, 19 Jul 2022 14:20:42 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Jul 2022 14:20:42 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>, hca@linux.ibm.com,
        alexander.gordeev@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
        <20220621204632.3370049-14-Liam.Howlett@oracle.com>
Date:   Tue, 19 Jul 2022 16:20:41 +0200
In-Reply-To: <20220621204632.3370049-14-Liam.Howlett@oracle.com> (Liam
        Howlett's message of "Tue, 21 Jun 2022 20:46:55 +0000")
Message-ID: <yt9dy1wpi3pi.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VqItlfgRnn3a4zrf6tp2nk8poAUm6Avy
X-Proofpoint-ORIG-GUID: SfROzVBq_eWye3iOd9tvAHgH0rtEfvDO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_02,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 mlxlogscore=936 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

Liam Howlett <liam.howlett@oracle.com> writes:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The maple tree code was added to find the unmapped area in a previous
> commit and was checked against what the rbtree returned, but the actual
> result was never used.  Start using the maple tree implementation and
> remove the rbtree code.
>
> Add kernel documentation comment for these functions.
>
> Link: https://lkml.kernel.org/r/20220504010716.661115-15-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 253 +++++++-----------------------------------------------
>  1 file changed, 32 insertions(+), 221 deletions(-)

With next-20220718 git bisect pointed me to this commit because the
following code fails in compat mode (31 bit addressing) on s390:

#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <stdio.h>

#define __2GB__         0x80000000
#define VMA_SIZE        0x10000000
#define VMA_COUNT       (__2GB__ / VMA_SIZE)

/*
 * Repeated mapping below 2GB until all memory is exhausted
 */
int main(void)
{
        void *p;
        unsigned int i;

        for (i = 0; i < VMA_COUNT; i++) {
            p = mmap(NULL, VMA_SIZE, PROT_READ,MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
            printf("%d: %08x - %08x\n", i, (int)p, (int)p + VMA_SIZE);
            if (p == MAP_FAILED)
                  break;
            if (p > (void *)__2GB__) {
                  return 1;
            }
        }
        if ((i == 0) || (i >= VMA_COUNT))
               return 2;
        return 0;
}

With linux/master:
# ./mmap_compat_anon
0: 67a00000 - 77a00000
1: 57a00000 - 67a00000
2: 47a00000 - 57a00000
3: 37a00000 - 47a00000
4: 27a00000 - 37a00000
5: 17a00000 - 27a00000
6: 07a00000 - 17a00000
7: ffffffff - 0fffffff

With next-20220718 (and older, we're seeing this for a while, but i
didn't notice due to vacation and other priorities):

# ./mmap_compat_anon
0: 67600000 - 77600000
1: 57600000 - 67600000
2: 47600000 - 57600000
3: 37600000 - 47600000
4: 27600000 - 37600000
5: 17600000 - 27600000
6: 07600000 - 17600000
7: 40000000 - 50000000

So the first output is correct - mmap succeeds until there's no space
left, where it returns MAP_FAILED. In the lower (failing) one, mmap
instead returns an address that is already in use.

Regards
Sven
