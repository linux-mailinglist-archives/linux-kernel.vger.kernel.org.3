Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383334C90E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiCAQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCAQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:51:02 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B656254
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:50:20 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221GIHGi016548;
        Tue, 1 Mar 2022 16:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=Gh0GqLspMvTvwvXYAgolNSAveiOEEAf2SSkZXzSi8ME=;
 b=Yx2Cou9K7z1Wp8dPzRyH8xfQk5W6HFswFvzmhy7mEosE9TkQQYGvcn0Ar3QBttPFI8Ts
 yDaEtr6Tx5wIkOanTOk0fRyVtbgOrPByJooigTEzzVyKUtKgsYIerx0jMkgHOpV6Bxdq
 W9iDfwG4szK2g2ewZeisgV/Xk2qmH2/44sGWhbIGVBRZatDNfuK3LIL7HdoMOUfydioN
 bGPo5OUfzg4qD/ScXuVHHX1IGaTnHM+KbFE45BDOXyAXfoMvoKxHy4GX3GSswHfkuxSl
 vMw80HeVJRsrokVPKqivk4IydFpC42ufE9EA43Y9KeWKAuFfyx2aoxZD6/3ismLck4aq UA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehpd4st0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 16:49:54 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221Gc1qW008913;
        Tue, 1 Mar 2022 16:49:53 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3egfss48tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 16:49:53 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221GndGu14418500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 16:49:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6E48AE067;
        Tue,  1 Mar 2022 16:49:38 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 422D1AE066;
        Tue,  1 Mar 2022 16:49:38 +0000 (GMT)
Received: from localhost (unknown [9.65.81.114])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 16:49:38 +0000 (GMT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, mopsfelder@gmail.com,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        "Erhard F ." <erhard_f@mailbox.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Nick Child <nick.child@ibm.com>
Subject: [PATCH] powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set
Date:   Tue,  1 Mar 2022 13:48:43 -0300
Message-Id: <20220301164843.29170-1-muriloo@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ehXpSUCSWPVpdlCeQ3AGqPVG_BFouthc
X-Proofpoint-GUID: ehXpSUCSWPVpdlCeQ3AGqPVG_BFouthc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build failure occurs when CONFIG_PPC_64S_HASH_MMU is not set:

    arch/powerpc/kernel/setup_64.c: In function ‘setup_per_cpu_areas’:
    arch/powerpc/kernel/setup_64.c:811:21: error: ‘mmu_linear_psize’ undeclared (first use in this function); did you mean ‘mmu_virtual_psize’?
      811 |                 if (mmu_linear_psize == MMU_PAGE_4K)
          |                     ^~~~~~~~~~~~~~~~
          |                     mmu_virtual_psize
    arch/powerpc/kernel/setup_64.c:811:21: note: each undeclared identifier is reported only once for each function it appears in

Move the declaration of mmu_linear_psize outside of CONFIG_PPC_64S_HASH_MMU
ifdef.

Fixes: 387e220a2e5e (powerpc/64s: Move hash MMU support code under CONFIG_PPC_64S_HASH_MMU)
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Fabiano Rosas <farosas@linux.ibm.com>
Cc: Nick Child <nick.child@ibm.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215567
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index ba5b1becf518..006cbec70ffe 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -202,7 +202,6 @@ static inline struct subpage_prot_table *mm_ctx_subpage_prot(mm_context_t *ctx)
 /*
  * The current system page and segment sizes
  */
-extern int mmu_linear_psize;
 extern int mmu_virtual_psize;
 extern int mmu_vmalloc_psize;
 extern int mmu_io_psize;
@@ -213,6 +212,7 @@ extern int mmu_io_psize;
 #define mmu_virtual_psize MMU_PAGE_4K
 #endif
 #endif
+extern int mmu_linear_psize;
 extern int mmu_vmemmap_psize;
 
 /* MMU initialization */
-- 
2.35.1

