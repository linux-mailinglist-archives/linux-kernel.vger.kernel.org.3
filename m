Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1E5232AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbiEKMID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbiEKMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:05:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455F65D9;
        Wed, 11 May 2022 05:05:44 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B9JCbn021679;
        Wed, 11 May 2022 12:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KOdHhVzC7807ASOkeE3uZMBygvZQo4qdP6Nlttop9Pc=;
 b=HH5u+1te6q+L0E4EuZSljB/pd4giI11HXkthD1B42om1LUvvfK5xOAHrWNCluVtB/kuz
 xbWmfFojFNmI/nECEJ3zVbm2RIyAHx3dnMiCXkdhsI+uLjMAjBvbcgv0jxeS1ByzVl9O
 Ikm7tXsCaBUQE57VW8hURdGNCZ+fGriaTTcpu27GqSruNesD96kG8zZLru0gHKxo7so8
 qiyHTyYXcz7d2WjOgINL0QeT+jG8PwRwgbDF9FpXqZrcZ2PxXsxOOCPdwaqkMkf6bHxX
 SqQUhwT0maG8ww93ZUhpiXcnG3H+ZBGSdtXo9Tk4oOo/lyeW3nudXoMtOuIQjHA/sNi2 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0adkjvum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:42 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BBvtRU003851;
        Wed, 11 May 2022 12:05:41 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0adkjvtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BC3G1M031836;
        Wed, 11 May 2022 12:05:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk1awm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:05:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BC5YYL44695864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:05:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35BA5A404D;
        Wed, 11 May 2022 12:05:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE848A4051;
        Wed, 11 May 2022 12:05:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 12:05:33 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/8] s390/alternatives: remove padding generation code
Date:   Wed, 11 May 2022 14:05:26 +0200
Message-Id: <20220511120532.2228616-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
References: <20220511120532.2228616-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3CJIO_DSCUSsh4dcWAnXqXelB7zsUKH7
X-Proofpoint-GUID: XzxfI7wLfTp1opoRDlxdL-d6xF8NKVC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang fails to handle ".if" statements in inline assembly which are heavily
used in the alternatives code.

To work around this remove this code, and enforce that users of
alternatives must specify original and alternative instruction sequences
which have identical sizes. Add a compile time check with two ".org"
statements similar to arm64.

In result not only clang can handle this, but also quite a lot of code can
be removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/alternative-asm.h | 76 +++-----------------
 arch/s390/include/asm/alternative.h     | 93 ++++++-------------------
 arch/s390/kernel/alternative.c          | 61 +---------------
 3 files changed, 31 insertions(+), 199 deletions(-)

diff --git a/arch/s390/include/asm/alternative-asm.h b/arch/s390/include/asm/alternative-asm.h
index bb3837d7387c..7db046596b93 100644
--- a/arch/s390/include/asm/alternative-asm.h
+++ b/arch/s390/include/asm/alternative-asm.h
@@ -4,19 +4,6 @@
 
 #ifdef __ASSEMBLY__
 
-/*
- * Check the length of an instruction sequence. The length may not be larger
- * than 254 bytes and it has to be divisible by 2.
- */
-.macro alt_len_check start,end
-	.if ( \end - \start ) > 254
-	.error "cpu alternatives does not support instructions blocks > 254 bytes\n"
-	.endif
-	.if ( \end - \start ) % 2
-	.error "cpu alternatives instructions length is odd\n"
-	.endif
-.endm
-
 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
  * the section .altinstructions, see below). This entry contains
@@ -28,66 +15,29 @@
 	.long	\alt_start - .
 	.word	\feature
 	.byte	\orig_end - \orig_start
-	.byte	\alt_end - \alt_start
-.endm
-
-/*
- * Fill up @bytes with nops. The macro emits 6-byte nop instructions
- * for the bulk of the area, possibly followed by a 4-byte and/or
- * a 2-byte nop if the size of the area is not divisible by 6.
- */
-.macro alt_pad_fill bytes
-	.rept	( \bytes ) / 6
-	brcl	0,0
-	.endr
-	.rept	( \bytes ) % 6 / 4
-	nop
-	.endr
-	.rept	( \bytes ) % 6 % 4 / 2
-	nopr
-	.endr
-.endm
-
-/*
- * Fill up @bytes with nops. If the number of bytes is larger
- * than 6, emit a jg instruction to branch over all nops, then
- * fill an area of size (@bytes - 6) with nop instructions.
- */
-.macro alt_pad bytes
-	.if ( \bytes > 0 )
-	.if ( \bytes > 6 )
-	jg	. + \bytes
-	alt_pad_fill \bytes - 6
-	.else
-	alt_pad_fill \bytes
-	.endif
-	.endif
+	.org	. - ( \orig_end - \orig_start ) + ( \alt_end - \alt_start )
+	.org	. - ( \alt_end - \alt_start ) + ( \orig_end - \orig_start )
 .endm
 
 /*
  * Define an alternative between two instructions. If @feature is
  * present, early code in apply_alternatives() replaces @oldinstr with
- * @newinstr. ".skip" directive takes care of proper instruction padding
- * in case @newinstr is longer than @oldinstr.
+ * @newinstr.
  */
 .macro ALTERNATIVE oldinstr, newinstr, feature
 	.pushsection .altinstr_replacement,"ax"
 770:	\newinstr
 771:	.popsection
 772:	\oldinstr
-773:	alt_len_check 770b, 771b
-	alt_len_check 772b, 773b
-	alt_pad ( ( 771b - 770b ) - ( 773b - 772b ) )
-774:	.pushsection .altinstructions,"a"
-	alt_entry 772b, 774b, 770b, 771b, \feature
+773:	.pushsection .altinstructions,"a"
+	alt_entry 772b, 773b, 770b, 771b, \feature
 	.popsection
 .endm
 
 /*
  * Define an alternative between two instructions. If @feature is
  * present, early code in apply_alternatives() replaces @oldinstr with
- * @newinstr. ".skip" directive takes care of proper instruction padding
- * in case @newinstr is longer than @oldinstr.
+ * @newinstr.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
 	.pushsection .altinstr_replacement,"ax"
@@ -95,17 +45,9 @@
 771:	\newinstr2
 772:	.popsection
 773:	\oldinstr
-774:	alt_len_check 770b, 771b
-	alt_len_check 771b, 772b
-	alt_len_check 773b, 774b
-	.if ( 771b - 770b > 772b - 771b )
-	alt_pad ( ( 771b - 770b ) - ( 774b - 773b ) )
-	.else
-	alt_pad ( ( 772b - 771b ) - ( 774b - 773b ) )
-	.endif
-775:	.pushsection .altinstructions,"a"
-	alt_entry 773b, 775b, 770b, 771b,\feature1
-	alt_entry 773b, 775b, 771b, 772b,\feature2
+774:	.pushsection .altinstructions,"a"
+	alt_entry 773b, 774b, 770b, 771b,\feature1
+	alt_entry 773b, 774b, 771b, 772b,\feature2
 	.popsection
 .endm
 
diff --git a/arch/s390/include/asm/alternative.h b/arch/s390/include/asm/alternative.h
index 3f2856ed6808..904dd049f954 100644
--- a/arch/s390/include/asm/alternative.h
+++ b/arch/s390/include/asm/alternative.h
@@ -13,32 +13,25 @@ struct alt_instr {
 	s32 repl_offset;	/* offset to replacement instruction */
 	u16 facility;		/* facility bit set for replacement */
 	u8  instrlen;		/* length of original instruction */
-	u8  replacementlen;	/* length of new instruction */
 } __packed;
 
 void apply_alternative_instructions(void);
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 
 /*
- * |661:       |662:	  |6620      |663:
- * +-----------+---------------------+
- * | oldinstr  | oldinstr_padding    |
- * |	       +----------+----------+
- * |	       |	  |	     |
- * |	       | >6 bytes |6/4/2 nops|
- * |	       |6 bytes jg----------->
- * +-----------+---------------------+
- *		 ^^ static padding ^^
+ * +---------------------------------+
+ * |661:			     |662:
+ * | oldinstr			     |
+ * +---------------------------------+
  *
  * .altinstr_replacement section
- * +---------------------+-----------+
+ * +---------------------------------+
  * |6641:			     |6651:
  * | alternative instr 1	     |
- * +-----------+---------+- - - - - -+
- * |6642:		 |6652:      |
- * | alternative instr 2 | padding
- * +---------------------+- - - - - -+
- *			  ^ runtime ^
+ * +---------------------------------+
+ * |6642:			     |6652:
+ * | alternative instr 2	     |
+ * +---------------------------------+
  *
  * .altinstructions section
  * +---------------------------------+
@@ -47,77 +40,31 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
  * +---------------------------------+
  */
 
-#define b_altinstr(num)	"664"#num
-#define e_altinstr(num)	"665"#num
-
-#define e_oldinstr_pad_end	"663"
+#define b_altinstr(num)		"664"#num
+#define e_altinstr(num)		"665"#num
 #define oldinstr_len		"662b-661b"
-#define oldinstr_total_len	e_oldinstr_pad_end"b-661b"
 #define altinstr_len(num)	e_altinstr(num)"b-"b_altinstr(num)"b"
-#define oldinstr_pad_len(num) \
-	"-(((" altinstr_len(num) ")-(" oldinstr_len ")) > 0) * " \
-	"((" altinstr_len(num) ")-(" oldinstr_len "))"
-
-#define INSTR_LEN_SANITY_CHECK(len)					\
-	".if " len " > 254\n"						\
-	"\t.error \"cpu alternatives does not support instructions "	\
-		"blocks > 254 bytes\"\n"				\
-	".endif\n"							\
-	".if (" len ") %% 2\n"						\
-	"\t.error \"cpu alternatives instructions length is odd\"\n"	\
-	".endif\n"
-
-#define OLDINSTR_PADDING(oldinstr, num)					\
-	".if " oldinstr_pad_len(num) " > 6\n"				\
-	"\tjg " e_oldinstr_pad_end "f\n"				\
-	"6620:\n"							\
-	"\t.rept (" oldinstr_pad_len(num) " - (6620b-662b)) / 2\n"	\
-	"\tnopr\n"							\
-	".else\n"							\
-	"\t.rept " oldinstr_pad_len(num) " / 6\n"			\
-	"\t.brcl 0,0\n"							\
-	"\t.endr\n"							\
-	"\t.rept " oldinstr_pad_len(num) " %% 6 / 4\n"			\
-	"\tnop\n"							\
-	"\t.endr\n"							\
-	"\t.rept " oldinstr_pad_len(num) " %% 6 %% 4 / 2\n"		\
-	"\tnopr\n"							\
-	".endr\n"							\
-	".endif\n"
-
-#define OLDINSTR(oldinstr, num)						\
-	"661:\n\t" oldinstr "\n662:\n"					\
-	OLDINSTR_PADDING(oldinstr, num)					\
-	e_oldinstr_pad_end ":\n"					\
-	INSTR_LEN_SANITY_CHECK(oldinstr_len)
-
-#define OLDINSTR_2(oldinstr, num1, num2)				\
-	"661:\n\t" oldinstr "\n662:\n"					\
-	".if " altinstr_len(num1) " < " altinstr_len(num2) "\n"		\
-	OLDINSTR_PADDING(oldinstr, num2)				\
-	".else\n"							\
-	OLDINSTR_PADDING(oldinstr, num1)				\
-	".endif\n"							\
-	e_oldinstr_pad_end ":\n"					\
-	INSTR_LEN_SANITY_CHECK(oldinstr_len)
+
+#define OLDINSTR(oldinstr) \
+	"661:\n\t" oldinstr "\n662:\n"
 
 #define ALTINSTR_ENTRY(facility, num)					\
 	"\t.long 661b - .\n"			/* old instruction */	\
 	"\t.long " b_altinstr(num)"b - .\n"	/* alt instruction */	\
 	"\t.word " __stringify(facility) "\n"	/* facility bit    */	\
-	"\t.byte " oldinstr_total_len "\n"	/* source len	   */	\
-	"\t.byte " altinstr_len(num) "\n"	/* alt instruction len */
+	"\t.byte " oldinstr_len "\n"		/* instruction len */	\
+	"\t.org . - (" oldinstr_len ") + (" altinstr_len(num) ")\n"	\
+	"\t.org . - (" altinstr_len(num) ") + (" oldinstr_len ")\n"
 
 #define ALTINSTR_REPLACEMENT(altinstr, num)	/* replacement */	\
-	b_altinstr(num)":\n\t" altinstr "\n" e_altinstr(num) ":\n"	\
-	INSTR_LEN_SANITY_CHECK(altinstr_len(num))
+	b_altinstr(num)":\n\t" altinstr "\n" e_altinstr(num) ":\n"
 
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, altinstr, facility) \
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	ALTINSTR_REPLACEMENT(altinstr, 1)				\
 	".popsection\n"							\
-	OLDINSTR(oldinstr, 1)						\
+	OLDINSTR(oldinstr)						\
 	".pushsection .altinstructions,\"a\"\n"				\
 	ALTINSTR_ENTRY(facility, 1)					\
 	".popsection\n"
@@ -127,7 +74,7 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 	ALTINSTR_REPLACEMENT(altinstr1, 1)				\
 	ALTINSTR_REPLACEMENT(altinstr2, 2)				\
 	".popsection\n"							\
-	OLDINSTR_2(oldinstr, 1, 2)					\
+	OLDINSTR(oldinstr)						\
 	".pushsection .altinstructions,\"a\"\n"				\
 	ALTINSTR_ENTRY(facility1, 1)					\
 	ALTINSTR_ENTRY(facility2, 2)					\
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index cce0ddee2d02..e7bca29f9c34 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -7,8 +7,6 @@
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 
-#define MAX_PATCH_LEN (255 - 1)
-
 static int __initdata_or_module alt_instr_disabled;
 
 static int __init disable_alternative_instructions(char *str)
@@ -19,85 +17,30 @@ static int __init disable_alternative_instructions(char *str)
 
 early_param("noaltinstr", disable_alternative_instructions);
 
-struct brcl_insn {
-	u16 opc;
-	s32 disp;
-} __packed;
-
-static u16 __initdata_or_module nop16 = 0x0700;
-static u32 __initdata_or_module nop32 = 0x47000000;
-static struct brcl_insn __initdata_or_module nop48 = {
-	0xc004, 0
-};
-
-static const void *nops[] __initdata_or_module = {
-	&nop16,
-	&nop32,
-	&nop48
-};
-
-static void __init_or_module add_jump_padding(void *insns, unsigned int len)
-{
-	struct brcl_insn brcl = {
-		0xc0f4,
-		len / 2
-	};
-
-	memcpy(insns, &brcl, sizeof(brcl));
-	insns += sizeof(brcl);
-	len -= sizeof(brcl);
-
-	while (len > 0) {
-		memcpy(insns, &nop16, 2);
-		insns += 2;
-		len -= 2;
-	}
-}
-
-static void __init_or_module add_padding(void *insns, unsigned int len)
-{
-	if (len > 6)
-		add_jump_padding(insns, len);
-	else if (len >= 2)
-		memcpy(insns, nops[len / 2 - 1], len);
-}
-
 static void __init_or_module __apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
 	struct alt_instr *a;
 	u8 *instr, *replacement;
-	u8 insnbuf[MAX_PATCH_LEN];
 
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
 	 */
 	for (a = start; a < end; a++) {
-		int insnbuf_sz = 0;
-
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 
 		if (!__test_facility(a->facility, alt_stfle_fac_list))
 			continue;
 
-		if (unlikely(a->instrlen % 2 || a->replacementlen % 2)) {
+		if (unlikely(a->instrlen % 2)) {
 			WARN_ONCE(1, "cpu alternatives instructions length is "
 				     "odd, skipping patching\n");
 			continue;
 		}
 
-		memcpy(insnbuf, replacement, a->replacementlen);
-		insnbuf_sz = a->replacementlen;
-
-		if (a->instrlen > a->replacementlen) {
-			add_padding(insnbuf + a->replacementlen,
-				    a->instrlen - a->replacementlen);
-			insnbuf_sz += a->instrlen - a->replacementlen;
-		}
-
-		s390_kernel_write(instr, insnbuf, insnbuf_sz);
+		s390_kernel_write(instr, replacement, a->instrlen);
 	}
 }
 
-- 
2.32.0

