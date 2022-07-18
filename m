Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69988578401
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiGRNmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiGRNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:42:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3E20F43;
        Mon, 18 Jul 2022 06:42:07 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ID4VHf010746;
        Mon, 18 Jul 2022 13:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Vs7SARRqKX7Yo7o1jX2FoNKWAfWUmz5pF9dOa7P+Mls=;
 b=YeQwYczYqk22zYDvsRSbdBwW+VbZSXdYW0VMTTj6BvFymkZn7Ru5b/op8F2DBh6L9e2X
 sS0wODb7EJ5D3RR/TIXBOOx6tHIRa6klfvmQ73p9P1vtleRZdIE2OSAVM3oaHCeG29DH
 xiMQ4dX9OrCgS/5e/z1GQLizsKqeCt7We/wKj0/BF9dXb3xGQV7iC+Fu1RxjZk5xrGF2
 Omc6n2NX7IlNeREyidUSeFf2EXtwC4FEK/0ivS+cyaPB6nu/cxP0DeQniyfHOoK9AUk4
 sHv6HAewhCB1EBF+YSx3bHXuBCGglcMYFj9hTCxfa80S41jZqa1WRpa5HSdCuIXlPzns fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8371pyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:45 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26ID4WkP010778;
        Mon, 18 Jul 2022 13:41:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8371pf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26IDKdMF016039;
        Mon, 18 Jul 2022 13:41:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3hbmy8tmnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26IDdfMv23855524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:39:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B4ACAE057;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 888D1AE056;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 7556FE02E3; Mon, 18 Jul 2022 15:32:41 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 3/3] s390/crash: support multi-segment iterators
Date:   Mon, 18 Jul 2022 15:32:41 +0200
Message-Id: <3d88ab5f5b02c53555a4a202648424ec9997fd6b.1658148067.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658148067.git.agordeev@linux.ibm.com>
References: <cover.1658148067.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CnNjMFIF6B-XcvrJGiOXxa2aNjlmZWxF
X-Proofpoint-GUID: 7q4b-kqha2-3yDsvpDjbVMgEj_20m31n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180058
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
 arch/s390/kernel/crash_dump.c   | 131 ++++++--------------------------
 drivers/s390/char/zcore.c       |  59 ++++++--------
 4 files changed, 64 insertions(+), 147 deletions(-)

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
index fd9fe93e48b6..8f918441a9de 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -115,101 +115,33 @@ void __init save_area_add_vxrs(struct save_area *sa, __vector128 *vxrs)
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
+static size_t copy_to_iter_real(struct iov_iter *iter, unsigned long src, size_t count)
 {
-	unsigned long len;
-	void *ra;
-	int rc;
+	size_t len, copied, res = 0;
 
 	while (count) {
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
-{
-	int offs = 0, size, rc;
-
-	rc = -EFAULT;
-	while (offs < count) {
-		size = min(PAGE_SIZE, count - offs);
-		if (memcpy_real(memcpy_real_buf, src + offs, size))
-			goto out;
-		if (copy_to_user(dest + offs, memcpy_real_buf, size))
-			goto out;
-		offs += size;
+		len = min(PAGE_SIZE, count);
+		if (memcpy_real(memcpy_real_buf, src, len))
+			break;
+		copied = copy_to_iter(memcpy_real_buf, len, iter);
+		count -= copied;
+		src += copied;
+		res += copied;
+		if (copied < len)
+			break;
 	}
-	rc = 0;
-out:
-	return rc;
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
@@ -221,15 +153,15 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
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
@@ -239,26 +171,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
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
index 516783ba950f..3846bf892b2f 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
+#include <linux/uio.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/ipl.h>
@@ -53,61 +54,47 @@ static struct ipl_parameter_block *zcore_ipl_block;
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
 
 	while (count) {
 		if (sclp_sdias_copy(hsa_buf, src / PAGE_SIZE + 2, 1)) {
 			TRACE("sclp_sdias_copy() failed\n");
-			return -EIO;
+			break;
 		}
 		offset = src % PAGE_SIZE;
 		bytes = min(PAGE_SIZE - offset, count);
-		if (copy_to_user(dest, hsa_buf + offset, bytes))
-			return -EFAULT;
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
-	return 0;
+	return res;
 }
 
-/*
- * Copy memory from HSA to kernel memory (not reentrant):
- *
- * @dest:  Kernel or user buffer where memory should be copied to
- * @src:   Start address within HSA where data should be copied
- * @count: Size of buffer, which should be copied
- */
-int memcpy_hsa_kernel(void *dest, unsigned long src, size_t count)
+static inline int memcpy_hsa_kernel(void *dst, unsigned long src, size_t count)
 {
-	unsigned long offset, bytes;
+	struct iov_iter iter;
+	struct kvec kvec;
 
-	if (!hsa_available)
-		return -ENODATA;
-
-	while (count) {
-		if (sclp_sdias_copy(hsa_buf, src / PAGE_SIZE + 2, 1)) {
-			TRACE("sclp_sdias_copy() failed\n");
-			return -EIO;
-		}
-		offset = src % PAGE_SIZE;
-		bytes = min(PAGE_SIZE - offset, count);
-		memcpy(dest, hsa_buf + offset, bytes);
-		src += bytes;
-		dest += bytes;
-		count -= bytes;
-	}
+	kvec.iov_base = dst;
+	kvec.iov_len = count;
+	iov_iter_kvec(&iter, WRITE, &kvec, 1, count);
+	if (memcpy_hsa_iter(&iter, src, count) < count)
+		return -EIO;
 	return 0;
 }
 
-- 
2.34.1

