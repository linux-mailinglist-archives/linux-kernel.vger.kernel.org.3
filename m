Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303624C974B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbiCAUty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiCAUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:49:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187331DCD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:49:09 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221Jcf1i026322;
        Tue, 1 Mar 2022 20:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=NzmemcIvh2KgUCy7fzhsxYkFZy2vGLqre8sjxZP5R68=;
 b=kF+4eIyayhrSMpnvBFd//l22qlJpx1ZYHeY8mAf6EQrsTZItnjbcIWpzkdXTkEdYOYLT
 KEk9g/cwDBspW8qO9WbWREyOHAuYSGPlJ4JKmn7wBLZ9TqBiN9FzDrzYQHfuEwmQ0Txr
 pfsWDCNFfsasAaH4z7uQp4ej12SI00XVADKkvWEk6bMh1LrOoH5qwbNU0OVXBkyR7hPP
 5jqKsGF328/pjh1ZhSFZAei7r/j6VjEB7NJfmgnwwVDc1em+ruqIQfYIeudctnBf0y7z
 yCRv34VBvQ83usRvF01hNUpePwZ4UARtNpTVt9VzO217mga831ttQMLBbt93syS2m3jS vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehqp2vg3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 20:48:28 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221Kf5oc013621;
        Tue, 1 Mar 2022 20:48:28 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehqp2vg38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 20:48:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221Km4sK021560;
        Tue, 1 Mar 2022 20:48:27 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3egfss5ubs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 20:48:26 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221KmNoX47907140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 20:48:23 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01CCBAE067;
        Tue,  1 Mar 2022 20:48:23 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5484EAE066;
        Tue,  1 Mar 2022 20:48:22 +0000 (GMT)
Received: from localhost (unknown [9.65.81.114])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 20:48:22 +0000 (GMT)
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
Subject: [PATCH v2] powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set
Date:   Tue,  1 Mar 2022 17:47:43 -0300
Message-Id: <20220301204743.45133-1-muriloo@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: at-I7ZtJdSHfDzVpnXQa3viA3xdvEebj
X-Proofpoint-ORIG-GUID: mprGZymhnLIFYLdSyAXV8aPK4MB-unCr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build failure occurs when CONFIG_PPC_64S_HASH_MMU is not
set:

    arch/powerpc/kernel/setup_64.c: In function ‘setup_per_cpu_areas’:
    arch/powerpc/kernel/setup_64.c:811:21: error: ‘mmu_linear_psize’ undeclared (first use in this function); did you mean ‘mmu_virtual_psize’?
      811 |                 if (mmu_linear_psize == MMU_PAGE_4K)
          |                     ^~~~~~~~~~~~~~~~
          |                     mmu_virtual_psize
    arch/powerpc/kernel/setup_64.c:811:21: note: each undeclared identifier is reported only once for each function it appears in

Move the declaration of mmu_linear_psize outside of
CONFIG_PPC_64S_HASH_MMU ifdef.

After the above is fixed, it fails later with the following error:

    ld: arch/powerpc/kexec/file_load_64.o: in function `.arch_kexec_kernel_image_probe':
    file_load_64.c:(.text+0x1c1c): undefined reference to `.add_htab_mem_range'

Fix that, too, by conditioning add_htab_mem_range() symbol to
CONFIG_PPC_64S_HASH_MMU.

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
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
v1: https://lore.kernel.org/linuxppc-dev/20220301164843.29170-1-muriloo@linux.ibm.com/

 arch/powerpc/include/asm/book3s/64/mmu.h | 2 +-
 arch/powerpc/include/asm/kexec_ranges.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index 7a90000f8d15..f83866a19e87 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -9,7 +9,7 @@ struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
 int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
 int add_tce_mem_ranges(struct crash_mem **mem_ranges);
 int add_initrd_mem_range(struct crash_mem **mem_ranges);
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_64S_HASH_MMU
 int add_htab_mem_range(struct crash_mem **mem_ranges);
 #else
 static inline int add_htab_mem_range(struct crash_mem **mem_ranges)
-- 
2.35.1

