Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D535B5736B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiGMM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiGMM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591C7392A;
        Wed, 13 Jul 2022 05:56:52 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DCoNmb012533;
        Wed, 13 Jul 2022 12:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FTytwjZTdiaF/D668qt2J6gGiiT4MnF8yoJabkixZ74=;
 b=WN1I36a89h8SEkChGiF52CP+5Zr9+4Cp1LoaqVrpIt5Vx0LYap5uiOunKRu3bQbmI0DQ
 rVkOvvWJ6gzeuciK0KO+haVIGHaJgpHRXu1gpSXPTKZjBpunnRQZQAmr2V36cziuIqJa
 Lbi94TpbO89qKHBYZL+4RS17XcZ/iszdheMmdx5O8Jlseec0zJy1LxxzqKeryOI9zbck
 LEsMxPLFGJDO8f0neUxGV9cSxfHYzWFoGZHKqowHmj86JlixWYg5nSeJleBonf5v8KmP
 Aboqx5D7vllhRI0njFhULb0rPD3rHboNoExl6hWuKU5ixNSxv6fWvUrbhrrgb3yUswo0 XA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9xdk05ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DCntqm010122;
        Wed, 13 Jul 2022 12:56:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn2kps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DCutlM23724342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 12:56:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0882DA405C;
        Wed, 13 Jul 2022 12:56:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A66F2A4062;
        Wed, 13 Jul 2022 12:56:44 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 12:56:44 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH v2 1/3] s390/cpufeature: rework to allow more than only hwcap bits
Date:   Wed, 13 Jul 2022 14:56:42 +0200
Message-Id: <20220713125644.16121-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220713125644.16121-1-seiden@linux.ibm.com>
References: <20220713125644.16121-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wsRHIipnxvA3EXH3kcK-xiyfXLeh2STC
X-Proofpoint-GUID: wsRHIipnxvA3EXH3kcK-xiyfXLeh2STC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_01,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207130049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

Rework cpufeature implementation to allow for various cpu feature
indications, which is not only limited to hwcap bits. This is achieved
by adding a sequential list of cpu feature numbers, where each of them
is mapped to an entry which indicates what this number is about.

Each entry contains a type member, which indicates what feature
name space to look into (e.g. hwcap, or cpu facility). If wanted this
allows also to automatically load modules only in e.g. z/VM
configurations.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/crypto/aes_s390.c        |  2 +-
 arch/s390/crypto/chacha-glue.c     |  2 +-
 arch/s390/crypto/crc32-vx.c        |  2 +-
 arch/s390/crypto/des_s390.c        |  2 +-
 arch/s390/crypto/ghash_s390.c      |  2 +-
 arch/s390/crypto/prng.c            |  2 +-
 arch/s390/crypto/sha1_s390.c       |  2 +-
 arch/s390/crypto/sha256_s390.c     |  2 +-
 arch/s390/crypto/sha3_256_s390.c   |  2 +-
 arch/s390/crypto/sha3_512_s390.c   |  2 +-
 arch/s390/crypto/sha512_s390.c     |  2 +-
 arch/s390/include/asm/cpufeature.h | 22 +++++-----------
 arch/s390/kernel/Makefile          |  2 +-
 arch/s390/kernel/cpufeature.c      | 42 ++++++++++++++++++++++++++++++
 arch/s390/kernel/processor.c       | 10 -------
 drivers/char/hw_random/s390-trng.c |  2 +-
 drivers/s390/crypto/pkey_api.c     |  2 +-
 17 files changed, 63 insertions(+), 39 deletions(-)
 create mode 100644 arch/s390/kernel/cpufeature.c

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 1023e9d43d44..526c3f40f6a2 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -1049,7 +1049,7 @@ static int __init aes_s390_init(void)
 	return ret;
 }
 
-module_cpu_feature_match(MSA, aes_s390_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, aes_s390_init);
 module_exit(aes_s390_fini);
 
 MODULE_ALIAS_CRYPTO("aes-all");
diff --git a/arch/s390/crypto/chacha-glue.c b/arch/s390/crypto/chacha-glue.c
index 2ec51f339cec..7752bd314558 100644
--- a/arch/s390/crypto/chacha-glue.c
+++ b/arch/s390/crypto/chacha-glue.c
@@ -121,7 +121,7 @@ static void __exit chacha_mod_fini(void)
 		crypto_unregister_skciphers(chacha_algs, ARRAY_SIZE(chacha_algs));
 }
 
-module_cpu_feature_match(VXRS, chacha_mod_init);
+module_cpu_feature_match(S390_CPU_FEATURE_VXRS, chacha_mod_init);
 module_exit(chacha_mod_fini);
 
 MODULE_DESCRIPTION("ChaCha20 stream cipher");
diff --git a/arch/s390/crypto/crc32-vx.c b/arch/s390/crypto/crc32-vx.c
index fafecad20752..017143e9cef7 100644
--- a/arch/s390/crypto/crc32-vx.c
+++ b/arch/s390/crypto/crc32-vx.c
@@ -298,7 +298,7 @@ static void __exit crc_vx_mod_exit(void)
 	crypto_unregister_shashes(crc32_vx_algs, ARRAY_SIZE(crc32_vx_algs));
 }
 
-module_cpu_feature_match(VXRS, crc_vx_mod_init);
+module_cpu_feature_match(S390_CPU_FEATURE_VXRS, crc_vx_mod_init);
 module_exit(crc_vx_mod_exit);
 
 MODULE_AUTHOR("Hendrik Brueckner <brueckner@linux.vnet.ibm.com>");
diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
index e013088b5115..8e75b83a5ddc 100644
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -492,7 +492,7 @@ static int __init des_s390_init(void)
 	return ret;
 }
 
-module_cpu_feature_match(MSA, des_s390_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, des_s390_init);
 module_exit(des_s390_exit);
 
 MODULE_ALIAS_CRYPTO("des");
diff --git a/arch/s390/crypto/ghash_s390.c b/arch/s390/crypto/ghash_s390.c
index 6b07a2f1ce8a..0800a2a5799f 100644
--- a/arch/s390/crypto/ghash_s390.c
+++ b/arch/s390/crypto/ghash_s390.c
@@ -145,7 +145,7 @@ static void __exit ghash_mod_exit(void)
 	crypto_unregister_shash(&ghash_alg);
 }
 
-module_cpu_feature_match(MSA, ghash_mod_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, ghash_mod_init);
 module_exit(ghash_mod_exit);
 
 MODULE_ALIAS_CRYPTO("ghash");
diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index ae382bafc772..a077087bc6cc 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -907,5 +907,5 @@ static void __exit prng_exit(void)
 	}
 }
 
-module_cpu_feature_match(MSA, prng_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, prng_init);
 module_exit(prng_exit);
diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
index a3fabf310a38..bc3a22704e09 100644
--- a/arch/s390/crypto/sha1_s390.c
+++ b/arch/s390/crypto/sha1_s390.c
@@ -95,7 +95,7 @@ static void __exit sha1_s390_fini(void)
 	crypto_unregister_shash(&alg);
 }
 
-module_cpu_feature_match(MSA, sha1_s390_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, sha1_s390_init);
 module_exit(sha1_s390_fini);
 
 MODULE_ALIAS_CRYPTO("sha1");
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
index 24983f175676..6f1ccdf93d3e 100644
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -134,7 +134,7 @@ static void __exit sha256_s390_fini(void)
 	crypto_unregister_shash(&sha256_alg);
 }
 
-module_cpu_feature_match(MSA, sha256_s390_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, sha256_s390_init);
 module_exit(sha256_s390_fini);
 
 MODULE_ALIAS_CRYPTO("sha256");
diff --git a/arch/s390/crypto/sha3_256_s390.c b/arch/s390/crypto/sha3_256_s390.c
index 30ac49b635bf..e1350e033a32 100644
--- a/arch/s390/crypto/sha3_256_s390.c
+++ b/arch/s390/crypto/sha3_256_s390.c
@@ -137,7 +137,7 @@ static void __exit sha3_256_s390_fini(void)
 	crypto_unregister_shash(&sha3_256_alg);
 }
 
-module_cpu_feature_match(MSA, sha3_256_s390_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, sha3_256_s390_init);
 module_exit(sha3_256_s390_fini);
 
 MODULE_ALIAS_CRYPTO("sha3-256");
diff --git a/arch/s390/crypto/sha3_512_s390.c b/arch/s390/crypto/sha3_512_s390.c
index e70d50f7620f..06c142ed9bb1 100644
--- a/arch/s390/crypto/sha3_512_s390.c
+++ b/arch/s390/crypto/sha3_512_s390.c
@@ -147,7 +147,7 @@ static void __exit fini(void)
 	crypto_unregister_shash(&sha3_384_alg);
 }
 
-module_cpu_feature_match(MSA, init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, init);
 module_exit(fini);
 
 MODULE_LICENSE("GPL");
diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
index 43ce4956df73..04f11c407763 100644
--- a/arch/s390/crypto/sha512_s390.c
+++ b/arch/s390/crypto/sha512_s390.c
@@ -142,7 +142,7 @@ static void __exit fini(void)
 	crypto_unregister_shash(&sha384_alg);
 }
 
-module_cpu_feature_match(MSA, init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, init);
 module_exit(fini);
 
 MODULE_LICENSE("GPL");
diff --git a/arch/s390/include/asm/cpufeature.h b/arch/s390/include/asm/cpufeature.h
index 14cfd48d598e..771caf5281e5 100644
--- a/arch/s390/include/asm/cpufeature.h
+++ b/arch/s390/include/asm/cpufeature.h
@@ -2,28 +2,20 @@
 /*
  * Module interface for CPU features
  *
- * Copyright IBM Corp. 2015
+ * Copyright IBM Corp. 2015, 2022
  * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
  */
 
 #ifndef __ASM_S390_CPUFEATURE_H
 #define __ASM_S390_CPUFEATURE_H
 
-#include <asm/elf.h>
+enum {
+	S390_CPU_FEATURE_MSA,
+	S390_CPU_FEATURE_VXRS,
+	MAX_CPU_FEATURES
+};
 
-/* Hardware features on Linux on z Systems are indicated by facility bits that
- * are mapped to the so-called machine flags.  Particular machine flags are
- * then used to define ELF hardware capabilities; most notably hardware flags
- * that are essential for user space / glibc.
- *
- * Restrict the set of exposed CPU features to ELF hardware capabilities for
- * now.  Additional machine flags can be indicated by values larger than
- * MAX_ELF_HWCAP_FEATURES.
- */
-#define MAX_ELF_HWCAP_FEATURES	(8 * sizeof(elf_hwcap))
-#define MAX_CPU_FEATURES	MAX_ELF_HWCAP_FEATURES
-
-#define cpu_feature(feat)	ilog2(HWCAP_ ## feat)
+#define cpu_feature(feature)	(feature)
 
 int cpu_have_feature(unsigned int nr);
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 27d6b3c7aa06..3cbfa9fddd9a 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -35,7 +35,7 @@ CFLAGS_unwind_bc.o	+= -fno-optimize-sibling-calls
 
 obj-y	:= traps.o time.o process.o earlypgm.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o syscall.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
-obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o
+obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o cpufeature.o
 obj-y	+= sysinfo.o lgr.o os_info.o machine_kexec.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
new file mode 100644
index 000000000000..9044c75d8b38
--- /dev/null
+++ b/arch/s390/kernel/cpufeature.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2022
+ */
+#include <linux/cpufeature.h>
+#include <linux/bug.h>
+#include <asm/elf.h>
+
+enum {
+	TYPE_HWCAP,
+};
+
+struct s390_cpu_feature {
+	unsigned int type	: 4;
+	unsigned int num	: 28;
+};
+
+static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
+	[S390_CPU_FEATURE_MSA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_MSA},
+	[S390_CPU_FEATURE_VXRS]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS},
+};
+
+/*
+ * cpu_have_feature - Test CPU features on module initialization
+ */
+int cpu_have_feature(unsigned int num)
+{
+	struct s390_cpu_feature *feature;
+
+	if (WARN_ON_ONCE(num >= MAX_CPU_FEATURES))
+		return 0;
+
+	feature = &s390_cpu_features[num];
+	switch (feature->type) {
+	case TYPE_HWCAP:
+		return !!(elf_hwcap & BIT(feature->num));
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+EXPORT_SYMBOL(cpu_have_feature);
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index aa0e0e7fc773..a194611ba88c 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -8,7 +8,6 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/stop_machine.h>
-#include <linux/cpufeature.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
@@ -96,15 +95,6 @@ void cpu_init(void)
 	enter_lazy_tlb(&init_mm, current);
 }
 
-/*
- * cpu_have_feature - Test CPU features on module initialization
- */
-int cpu_have_feature(unsigned int num)
-{
-	return elf_hwcap & (1UL << num);
-}
-EXPORT_SYMBOL(cpu_have_feature);
-
 static void show_facilities(struct seq_file *m)
 {
 	unsigned int bit;
diff --git a/drivers/char/hw_random/s390-trng.c b/drivers/char/hw_random/s390-trng.c
index 2beaa35c0d74..12fbac0ed8ca 100644
--- a/drivers/char/hw_random/s390-trng.c
+++ b/drivers/char/hw_random/s390-trng.c
@@ -261,5 +261,5 @@ static void __exit trng_exit(void)
 	trng_debug_exit();
 }
 
-module_cpu_feature_match(MSA, trng_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, trng_init);
 module_exit(trng_exit);
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 7329caa7d467..5a05d1cdfec2 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -2115,5 +2115,5 @@ static void __exit pkey_exit(void)
 	pkey_debug_exit();
 }
 
-module_cpu_feature_match(MSA, pkey_init);
+module_cpu_feature_match(S390_CPU_FEATURE_MSA, pkey_init);
 module_exit(pkey_exit);
-- 
2.35.3

