Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D458C7EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbiHHLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiHHLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:51:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC53E13E93
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:51:10 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278Aobb0007118;
        Mon, 8 Aug 2022 11:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tlJ54rN8XosLJ/pwrKv1a5Oi8KsyGN5VxbsCHl8kbpw=;
 b=sdJz1AO6HRkKf69fzRTzAv6xB67BfSmUJA6hNlDI2h332HfxYNsLLc6mydn5WJ25XQPl
 r+y2nkK8RspNCW4iCso4LhjUUTlLEK/iGjPRPzFmE80zECPg2cqSu49UpRVx4GDwh+JC
 FZrdVq7dTZyQgkRrt96zCQ8uGCA1fv+iYaJjOVf6B8YV0nqbKiJw1ymzthtgKqIDcsGD
 QCU17vCt/dTWoHRhUVpZ+pxvLLdLlk0Fatcqb/KHFeZHuSxGZbnlziavLsW+WDMRPVV/
 T3wXR4SPGl6L5zkQvN617PRSqWTrl1xCRgb+BpUJLv9lMZtKjXaz97isZLTCHUI0nQaF qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu13dhk3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:49 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 278B8Noa029610;
        Mon, 8 Aug 2022 11:50:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu13dhk28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278Boea6030790;
        Mon, 8 Aug 2022 11:50:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3hsfx8t49y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278Bp0OI28836214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 11:51:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03E6E11C050;
        Mon,  8 Aug 2022 11:50:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E003111C04A;
        Mon,  8 Aug 2022 11:50:39 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.59.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 11:50:39 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH 16/16] objtool/powerpc: Add --mcount specific implementation
Date:   Mon,  8 Aug 2022 17:19:08 +0530
Message-Id: <20220808114908.240813-17-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220808114908.240813-1-sv@linux.ibm.com>
References: <20220808114908.240813-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -uey69D3eB4e6H9ohm8lNLWo7NSsLgZ8
X-Proofpoint-ORIG-GUID: FHoCih-1vJkhqTWTTex5sJaRXsph5-PA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_07,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables objtool --mcount on powerpc, and
adds implementation specific to powerpc.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 arch/powerpc/Kconfig                          |  1 +
 tools/objtool/arch/powerpc/decode.c           | 22 +++++++++++++++++++
 tools/objtool/arch/powerpc/include/arch/elf.h |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dc05cd23c233..6be2e68fa9eb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -238,6 +238,7 @@ config PPC
 	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
 	select HAVE_OPTPROBES
 	select HAVE_OBJTOOL			if PPC32 || MPROFILE_KERNEL
+	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 8b6a14680da7..b71c265ed503 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -9,6 +9,14 @@
 #include <objtool/builtin.h>
 #include <objtool/endianness.h>
 
+bool arch_ftrace_match(char *name)
+{
+	if (!strcmp(name, "_mcount"))
+		return true;
+
+	return false;
+}
+
 unsigned long arch_dest_reloc_offset(int addend)
 {
 	return addend;
@@ -41,12 +49,26 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			    struct list_head *ops_list)
 {
 	u32 insn;
+	unsigned int opcode;
 
 	*immediate = 0;
 	insn = bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
 	*len = 4;
 	*type = INSN_OTHER;
 
+	opcode = insn >> 26;
+
+	switch (opcode) {
+	case 18: /* bl */
+		if ((insn & 3) == 1) {
+			*type = INSN_CALL;
+			*immediate = insn & 0x3fffffc;
+			if (*immediate & 0x2000000)
+				*immediate -= 0x4000000;
+		}
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
index 3c8ebb7d2a6b..73f9ae172fe5 100644
--- a/tools/objtool/arch/powerpc/include/arch/elf.h
+++ b/tools/objtool/arch/powerpc/include/arch/elf.h
@@ -4,5 +4,7 @@
 #define _OBJTOOL_ARCH_ELF
 
 #define R_NONE R_PPC_NONE
+#define R_ABS64 R_PPC64_ADDR64
+#define R_ABS32 R_PPC_ADDR32
 
 #endif /* _OBJTOOL_ARCH_ELF */
-- 
2.31.1

