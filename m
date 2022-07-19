Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C157926F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiGSF04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiGSF0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:26:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479C2408F;
        Mon, 18 Jul 2022 22:26:41 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J5DhnY023315;
        Tue, 19 Jul 2022 05:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GHbIcTb/DqS73smnmwTzFigD5dqs+A/EVrmL0mtm6AM=;
 b=AdZOizW9qY7D1N0IxyAuBSH86MwS5gqkRQJUwWdW5r5iZN/7EvQZdCg/a7T628tiqW4M
 JAJB5vxQEAJoBFjstiHBVup8m6Lu2tI5u3vvoZ6Mh8Zh+EEPLjHqDMjuQ2ng3DHPQt1a
 VwD79eXlx23Zr5UesrhnTmOK82J2AAzhZ6l2bESN2vw/dpay4Kgq2O6FBC04yMYRCSuU
 ZFPq7hdPN9UyTFiGnv49qRjzWb8bHXGMkASd6aS4MDZ2gQG0g2Gbz9h+PyyPGgbZimyT
 yyz0VDL7Aa965OIsste/jDmr3gRSJ0bb0qMLgOnDv4TK72ziz4QAPY2nteIU+F/Wm+h/ bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdp9cr7v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:32 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26J5Fn0I003868;
        Tue, 19 Jul 2022 05:26:31 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdp9cr7ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:31 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26J5KfqX018179;
        Tue, 19 Jul 2022 05:26:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3hbmy8um9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26J5QQai21823868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 05:26:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFB7F5204F;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DE5255204E;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 8494BE050F; Tue, 19 Jul 2022 07:16:36 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 4/4] s390/crash: support multi-segment iterators
Date:   Tue, 19 Jul 2022 07:16:36 +0200
Message-Id: <5af6da3a0bffe48a90b0b7139ecf6a818b2d18e8.1658206891.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658206891.git.agordeev@linux.ibm.com>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SuhCjwKEJDMXjS9EkVen5x1XA-BUYV-X
X-Proofpoint-ORIG-GUID: xU7Ynz_IEeT75Qibfkoll8XKTLhUHwmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to handle not only single-, but also multi-
segment iterators in copy_oldmem_iter() callback. Change the
semantics of called functions to match the iterator model -
instead of an error code the exact number of bytes copied is
returned.

The swap page used to copy data to user space is adopted for
kernel space too. That does not bring any performance impact.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Fixes: 49b11524d648 ("s390/crash: add missing iterator advance in copy_oldmem_page()")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/os_info.h |  17 ++++-
 arch/s390/include/asm/sclp.h    |   4 +-
 arch/s390/kernel/crash_dump.c   | 128 ++++++--------------------------
 drivers/s390/char/zcore.c       |  58 ++++++---------
 4 files changed, 63 insertions(+), 144 deletions(-)

diff --git a/arch/s390/include/asm/os_info.h b/arch/s390/include/asm/os_info.h
index 147a8d547ef9..85248d8fee0c 100644
--- a/arch/s390/include/asm/os_info.h
+++ b/arch/s390/include/asm/os_info.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_S390_OS_INFO_H
 #define _ASM_S390_OS_INFO_H
 
+#include <linux/uio.h>
+
 #define OS_INFO_VERSION_MAJOR	1
 #define OS_INFO_VERSION_MINOR	1
 #define OS_INFO_MAGIC		0x4f53494e464f535aULL /* OSINFOSZ */
@@ -39,7 +41,20 @@ u32 os_info_csum(struct os_info *os_info);
 
 #ifdef CONFIG_CRASH_DUMP
 void *os_info_old_entry(int nr, unsigned long *size);
-int copy_oldmem_kernel(void *dst, unsigned long src, size_t count);
+size_t copy_oldmem_iter(struct iov_iter *iter, unsigned long src, size_t count);
+
+static inline int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
+{
+	struct iov_iter iter;
+	struct kvec kvec;
+
+	kvec.iov_base = dst;
+	kvec.iov_len = count;
+	iov_iter_kvec(&iter, WRITE, &kvec, 1, count);
+	if (copy_oldmem_iter(&iter, src, count) < count)
+		return -EFAULT;
+	return 0;
+}
 #else
 static inline void *os_info_old_entry(int nr, unsigned long *size)
 {
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index addefe8ccdba..9d4c7f71e070 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -17,6 +17,7 @@
 #define EXT_SCCB_READ_CPU	(3 * PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
+#include <linux/uio.h>
 #include <asm/chpid.h>
 #include <asm/cpu.h>
 
@@ -146,8 +147,7 @@ int sclp_pci_deconfigure(u32 fid);
 int sclp_ap_configure(u32 apid);
 int sclp_ap_deconfigure(u32 apid);
 int sclp_pci_report(struct zpci_report_error_header *report, u32 fh, u32 fid);
-int memcpy_hsa_kernel(void *dest, unsigned long src, size_t count);
-int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count);
+size_t memcpy_hsa_iter(struct iov_iter *iter, unsigned long src, size_t count);
 void sclp_ocf_cpc_name_copy(char *dst);
 
 static inline int sclp_get_core_info(struct sclp_core_info *info, int early)
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 1662f1d81abe..bad8f47fc5d6 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -116,102 +116,35 @@ void __init save_area_add_vxrs(struct save_area *sa, __vector128 *vxrs)
 	memcpy(sa->vxrs_high, vxrs + 16, 16 * sizeof(__vector128));
 }
 
-/*
- * Return physical address for virtual address
- */
-static inline void *load_real_addr(void *addr)
-{
-	unsigned long real_addr;
-
-	asm volatile(
-		   "	lra     %0,0(%1)\n"
-		   "	jz	0f\n"
-		   "	la	%0,0\n"
-		   "0:"
-		   : "=a" (real_addr) : "a" (addr) : "cc");
-	return (void *)real_addr;
-}
-
-/*
- * Copy memory of the old, dumped system to a kernel space virtual address
- */
-int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
-{
-	unsigned long len;
-	void *ra;
-	int rc;
-
-	while (count) {
-		if (!oldmem_data.start && src < sclp.hsa_size) {
-			/* Copy from zfcp/nvme dump HSA area */
-			len = min(count, sclp.hsa_size - src);
-			rc = memcpy_hsa_kernel(dst, src, len);
-			if (rc)
-				return rc;
-		} else {
-			/* Check for swapped kdump oldmem areas */
-			if (oldmem_data.start && src - oldmem_data.start < oldmem_data.size) {
-				src -= oldmem_data.start;
-				len = min(count, oldmem_data.size - src);
-			} else if (oldmem_data.start && src < oldmem_data.size) {
-				len = min(count, oldmem_data.size - src);
-				src += oldmem_data.start;
-			} else {
-				len = count;
-			}
-			if (is_vmalloc_or_module_addr(dst)) {
-				ra = load_real_addr(dst);
-				len = min(PAGE_SIZE - offset_in_page(ra), len);
-			} else {
-				ra = dst;
-			}
-			if (memcpy_real(ra, src, len))
-				return -EFAULT;
-		}
-		dst += len;
-		src += len;
-		count -= len;
-	}
-	return 0;
-}
-
-/*
- * Copy memory from kernel (real) to user (virtual)
- */
-static int copy_to_user_real(void __user *dest, unsigned long src, unsigned long count)
+static size_t copy_to_iter_real(struct iov_iter *iter, unsigned long src, size_t count)
 {
-	unsigned long offs = 0, size;
+	size_t len, copied, res = 0;
 
 	mutex_lock(&memcpy_real_mutex);
-	while (offs < count) {
-		size = min(PAGE_SIZE, count - offs);
-		if (memcpy_real(memcpy_real_buf, src + offs, size))
+	while (count) {
+		len = min(PAGE_SIZE, count);
+		if (memcpy_real(memcpy_real_buf, src, len))
 			break;
-		if (copy_to_user(dest + offs, memcpy_real_buf, size))
+		copied = copy_to_iter(memcpy_real_buf, len, iter);
+		count -= copied;
+		src += copied;
+		res += copied;
+		if (copied < len)
 			break;
-		offs += size;
 	}
 	mutex_unlock(&memcpy_real_mutex);
-	if (offs < count)
-		return -EFAULT;
-	return 0;
+	return res;
 }
 
-/*
- * Copy memory of the old, dumped system to a user space virtual address
- */
-static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
+size_t copy_oldmem_iter(struct iov_iter *iter, unsigned long src, size_t count)
 {
-	unsigned long len;
-	int rc;
+	size_t len, copied, res = 0;
 
 	while (count) {
 		if (!oldmem_data.start && src < sclp.hsa_size) {
 			/* Copy from zfcp/nvme dump HSA area */
 			len = min(count, sclp.hsa_size - src);
-			rc = memcpy_hsa_user(dst, src, len);
-			if (rc)
-				return rc;
+			copied = memcpy_hsa_iter(iter, src, len);
 		} else {
 			/* Check for swapped kdump oldmem areas */
 			if (oldmem_data.start && src - oldmem_data.start < oldmem_data.size) {
@@ -223,15 +156,15 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
 			} else {
 				len = count;
 			}
-			rc = copy_to_user_real(dst, src, len);
-			if (rc)
-				return rc;
+			copied = copy_to_iter_real(iter, src, len);
 		}
-		dst += len;
-		src += len;
-		count -= len;
+		count -= copied;
+		src += copied;
+		res += copied;
+		if (copied < len)
+			break;
 	}
-	return 0;
+	return res;
 }
 
 /*
@@ -241,26 +174,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
 			 unsigned long offset)
 {
 	unsigned long src;
-	int rc;
 
-	if (!(iter_is_iovec(iter) || iov_iter_is_kvec(iter)))
-		return -EINVAL;
-	/* Multi-segment iterators are not supported */
-	if (iter->nr_segs > 1)
-		return -EINVAL;
-	if (!csize)
-		return 0;
 	src = pfn_to_phys(pfn) + offset;
-
-	/* XXX: pass the iov_iter down to a common function */
-	if (iter_is_iovec(iter))
-		rc = copy_oldmem_user(iter->iov->iov_base, src, csize);
-	else
-		rc = copy_oldmem_kernel(iter->kvec->iov_base, src, csize);
-	if (rc < 0)
-		return rc;
-	iov_iter_advance(iter, csize);
-	return csize;
+	return copy_oldmem_iter(iter, src, csize);
 }
 
 /*
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 92b32ce645b9..f6da215ccf9f 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
+#include <linux/uio.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/ipl.h>
@@ -54,38 +55,37 @@ static DEFINE_MUTEX(hsa_buf_mutex);
 static char hsa_buf[PAGE_SIZE] __aligned(PAGE_SIZE);
 
 /*
- * Copy memory from HSA to user memory (not reentrant):
+ * Copy memory from HSA to iterator (not reentrant):
  *
- * @dest:  User buffer where memory should be copied to
+ * @iter:  Iterator where memory should be copied to
  * @src:   Start address within HSA where data should be copied
  * @count: Size of buffer, which should be copied
  */
-int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count)
+size_t memcpy_hsa_iter(struct iov_iter *iter, unsigned long src, size_t count)
 {
-	unsigned long offset, bytes;
+	size_t bytes, copied, res = 0;
+	unsigned long offset;
 
 	if (!hsa_available)
-		return -ENODATA;
+		return 0;
 
 	mutex_lock(&hsa_buf_mutex);
 	while (count) {
 		if (sclp_sdias_copy(hsa_buf, src / PAGE_SIZE + 2, 1)) {
 			TRACE("sclp_sdias_copy() failed\n");
-			mutex_unlock(&hsa_buf_mutex);
-			return -EIO;
+			break;
 		}
 		offset = src % PAGE_SIZE;
 		bytes = min(PAGE_SIZE - offset, count);
-		if (copy_to_user(dest, hsa_buf + offset, bytes)) {
-			mutex_unlock(&hsa_buf_mutex);
-			return -EFAULT;
-		}
-		src += bytes;
-		dest += bytes;
-		count -= bytes;
+		copied = copy_to_iter(hsa_buf + offset, bytes, iter);
+		count -= copied;
+		src += copied;
+		res += copied;
+		if (copied < bytes)
+			break;
 	}
 	mutex_unlock(&hsa_buf_mutex);
-	return 0;
+	return res;
 }
 
 /*
@@ -95,28 +95,16 @@ int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count)
  * @src:   Start address within HSA where data should be copied
  * @count: Size of buffer, which should be copied
  */
-int memcpy_hsa_kernel(void *dest, unsigned long src, size_t count)
+static inline int memcpy_hsa_kernel(void *dst, unsigned long src, size_t count)
 {
-	unsigned long offset, bytes;
+	struct iov_iter iter;
+	struct kvec kvec;
 
-	if (!hsa_available)
-		return -ENODATA;
-
-	mutex_lock(&hsa_buf_mutex);
-	while (count) {
-		if (sclp_sdias_copy(hsa_buf, src / PAGE_SIZE + 2, 1)) {
-			TRACE("sclp_sdias_copy() failed\n");
-			mutex_unlock(&hsa_buf_mutex);
-			return -EIO;
-		}
-		offset = src % PAGE_SIZE;
-		bytes = min(PAGE_SIZE - offset, count);
-		memcpy(dest, hsa_buf + offset, bytes);
-		src += bytes;
-		dest += bytes;
-		count -= bytes;
-	}
-	mutex_unlock(&hsa_buf_mutex);
+	kvec.iov_base = dst;
+	kvec.iov_len = count;
+	iov_iter_kvec(&iter, WRITE, &kvec, 1, count);
+	if (memcpy_hsa_iter(&iter, src, count) < count)
+		return -EIO;
 	return 0;
 }
 
-- 
2.34.1

