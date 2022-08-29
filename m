Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CECF5A42AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiH2Fy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiH2FyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:54:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11A48EB9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:53:49 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5Pmcx031214;
        Mon, 29 Aug 2022 05:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LtGVxWxBrgEredZV1nBB0IQs+GM+VaBR9zo0w2cg7tM=;
 b=f+AC7NOJdXpAOsloauFt0RiffRWkV59xvdyfYG62Ukoi2YFZbEE5E2jNXmV0NSBFdF0T
 NlqNw2dZ+knlvi8uA8qMCrKLRWXjZUcEGsOlos7dmWNFdWRzh0IRWyfZZrnXcsiB9ZHK
 XSwPpwxeXG5MekpFVjgJhXTirMGjZ3OtxjD7vBfs5IYPMArsRaJFdvRWXI+BnI01/Ay1
 0liv3ksDMAuZbMyBU68vs5kO3WGisP1MoL2CQVpGjuk66tKltDwlxVDyTyR5yO1c3n32
 s4bozIsBuBh0pxjhPep2/+mlATRba78lk0Jkmyu9qrzCF+0CXa+7rKBUBxKtmbEjmADl 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8qa4rgt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:53:25 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27T5ol8j010374;
        Mon, 29 Aug 2022 05:53:24 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8qa4rgse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:53:24 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27T5pkcK016617;
        Mon, 29 Aug 2022 05:53:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3j7aw8sbx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 05:53:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27T5o9S541812442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 05:50:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A62B54C044;
        Mon, 29 Aug 2022 05:53:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9FC74C050;
        Mon, 29 Aug 2022 05:53:15 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.67.34])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 05:53:15 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH v2 09/16] objtool: Use target file endianness instead of a compiled constant
Date:   Mon, 29 Aug 2022 11:22:16 +0530
Message-Id: <20220829055223.24767-10-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829055223.24767-1-sv@linux.ibm.com>
References: <20220829055223.24767-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0dUG7WHEHSbduAdKhv7O4jK93YI5YSCl
X-Proofpoint-GUID: bcTrMez9qIaqb6AIUeT2u-7-GA71SQov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Some architectures like powerpc support both endianness, it's
therefore not possible to fix the endianness via arch/endianness.h
because there is no easy way to get the target endianness at
build time.

Use the endianness recorded in the file objtool is working on.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../arch/x86/include/arch/endianness.h        |  9 ------
 tools/objtool/check.c                         |  2 +-
 tools/objtool/include/objtool/endianness.h    | 32 +++++++++----------
 tools/objtool/orc_dump.c                      | 11 +++++--
 tools/objtool/orc_gen.c                       |  4 +--
 tools/objtool/special.c                       |  3 +-
 6 files changed, 30 insertions(+), 31 deletions(-)
 delete mode 100644 tools/objtool/arch/x86/include/arch/endianness.h

diff --git a/tools/objtool/arch/x86/include/arch/endianness.h b/tools/objtool/arch/x86/include/arch/endianness.h
deleted file mode 100644
index 7c362527da20..000000000000
--- a/tools/objtool/arch/x86/include/arch/endianness.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ARCH_ENDIANNESS_H
-#define _ARCH_ENDIANNESS_H
-
-#include <endian.h>
-
-#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
-
-#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ed2fdfeb1d9c..a948b2551520 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2075,7 +2075,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfi.cfa.offset = bswap_if_needed(hint->sp_offset);
+		cfi.cfa.offset = bswap_if_needed(file->elf, hint->sp_offset);
 		cfi.type = hint->type;
 		cfi.end = hint->end;
 
diff --git a/tools/objtool/include/objtool/endianness.h b/tools/objtool/include/objtool/endianness.h
index 10241341eff3..4d2aa9b0fe2f 100644
--- a/tools/objtool/include/objtool/endianness.h
+++ b/tools/objtool/include/objtool/endianness.h
@@ -2,33 +2,33 @@
 #ifndef _OBJTOOL_ENDIANNESS_H
 #define _OBJTOOL_ENDIANNESS_H
 
-#include <arch/endianness.h>
 #include <linux/kernel.h>
 #include <endian.h>
-
-#ifndef __TARGET_BYTE_ORDER
-#error undefined arch __TARGET_BYTE_ORDER
-#endif
-
-#if __BYTE_ORDER != __TARGET_BYTE_ORDER
-#define __NEED_BSWAP 1
-#else
-#define __NEED_BSWAP 0
-#endif
+#include <objtool/elf.h>
 
 /*
- * Does a byte swap if target endianness doesn't match the host, i.e. cross
+ * Does a byte swap if target file endianness doesn't match the host, i.e. cross
  * compilation for little endian on big endian and vice versa.
  * To be used for multi-byte values conversion, which are read from / about
  * to be written to a target native endianness ELF file.
  */
-#define bswap_if_needed(val)						\
+static inline bool need_bswap(struct elf *elf)
+{
+	return (__BYTE_ORDER == __LITTLE_ENDIAN) ^
+	       (elf->ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
+}
+
+#define bswap_if_needed(elf, val)					\
 ({									\
 	__typeof__(val) __ret;						\
+	bool __need_bswap = need_bswap(elf);				\
 	switch (sizeof(val)) {						\
-	case 8: __ret = __NEED_BSWAP ? bswap_64(val) : (val); break;	\
-	case 4: __ret = __NEED_BSWAP ? bswap_32(val) : (val); break;	\
-	case 2: __ret = __NEED_BSWAP ? bswap_16(val) : (val); break;	\
+	case 8:								\
+		__ret = __need_bswap ? bswap_64(val) : (val); break;	\
+	case 4:								\
+		__ret = __need_bswap ? bswap_32(val) : (val); break;	\
+	case 2:								\
+		__ret = __need_bswap ? bswap_16(val) : (val); break;	\
 	default:							\
 		BUILD_BUG(); break;					\
 	}								\
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index f5a8508c42d6..4f1211fec82c 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -76,6 +76,7 @@ int orc_dump(const char *_objname)
 	GElf_Rela rela;
 	GElf_Sym sym;
 	Elf_Data *data, *symtab = NULL, *rela_orc_ip = NULL;
+	struct elf dummy_elf = {};
 
 
 	objname = _objname;
@@ -94,6 +95,12 @@ int orc_dump(const char *_objname)
 		return -1;
 	}
 
+	if (!elf64_getehdr(elf)) {
+		WARN_ELF("elf64_getehdr");
+		return -1;
+	}
+	memcpy(&dummy_elf.ehdr, elf64_getehdr(elf), sizeof(dummy_elf.ehdr));
+
 	if (elf_getshdrnum(elf, &nr_sections)) {
 		WARN_ELF("elf_getshdrnum");
 		return -1;
@@ -198,11 +205,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, bswap_if_needed(orc[i].sp_offset));
+		print_reg(orc[i].sp_reg, bswap_if_needed(&dummy_elf, orc[i].sp_offset));
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, bswap_if_needed(orc[i].bp_offset));
+		print_reg(orc[i].bp_reg, bswap_if_needed(&dummy_elf, orc[i].bp_offset));
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dd3c64af9db2..1f22b7ebae58 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -97,8 +97,8 @@ static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	/* populate ORC data */
 	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
-	orc->sp_offset = bswap_if_needed(orc->sp_offset);
-	orc->bp_offset = bswap_if_needed(orc->bp_offset);
+	orc->sp_offset = bswap_if_needed(elf, orc->sp_offset);
+	orc->bp_offset = bswap_if_needed(elf, orc->bp_offset);
 
 	/* populate reloc for ip */
 	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_X86_64_PC32,
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e2223dd91c37..9c8d827f69af 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -87,7 +87,8 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 	if (entry->feature) {
 		unsigned short feature;
 
-		feature = bswap_if_needed(*(unsigned short *)(sec->data->d_buf +
+		feature = bswap_if_needed(elf,
+					  *(unsigned short *)(sec->data->d_buf +
 							      offset +
 							      entry->feature));
 		arch_handle_alternative(feature, alt);
-- 
2.31.1

