Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480858C7E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbiHHLvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbiHHLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:50:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53715FCD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:50:30 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278Bnv1j009086;
        Mon, 8 Aug 2022 11:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a7cEoTbOu0JTUEWLhtHgpJ4DrItaVLbtLYOz2EfzIi4=;
 b=kEKZ90u8gu9yNg7b497uay0rlVy9nHSJQW9Lmavzmk5bKjN387S4XeHx4MYO/oqUdbiz
 k0iNtVeYmFYzRh5byPQyES7fjEFeRchTrn1ww2MYz1Ty+jn6MEo0DQZlZ01AtShBuj6c
 2JFrn90YmGn4gLa5XsJ+jw6mtwMBnx1WQrOurufHFBbslYn+pTDo2jo7NZ1ypa+8e57a
 8xM0keqwYEnXnkkF5SuDhrhR1GGl5yDK5wxTOZjy/i+IUie9WGnZd6potAKeA2vKlSV8
 KbolIAYAl0Np3jNI7bLv6idC6AIQLtmfzmJcj8nxNLHZrNYRa4+CwXRLXyuOUbL/VMr3 fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu1y680d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:12 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 278BoBn9010040;
        Mon, 8 Aug 2022 11:50:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu1y680c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278BbuKo001203;
        Mon, 8 Aug 2022 11:50:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3hsfjj24w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278Bo68O31130056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 11:50:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF4FB11C052;
        Mon,  8 Aug 2022 11:50:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84B4811C04C;
        Mon,  8 Aug 2022 11:50:02 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.59.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 11:50:02 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH 09/16] objtool: Use target file endianness instead of a compiled constant
Date:   Mon,  8 Aug 2022 17:19:01 +0530
Message-Id: <20220808114908.240813-10-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220808114908.240813-1-sv@linux.ibm.com>
References: <20220808114908.240813-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ROag19vFso8PycMf8EPw33bwHYEea737
X-Proofpoint-ORIG-GUID: 8nIOoe38EDMxzQzhFlcJgYy7yBYcQp2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080057
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
index 0ef805843d4f..45fbc80ea7f9 100644
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

