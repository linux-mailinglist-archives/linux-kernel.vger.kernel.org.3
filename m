Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5758C534
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiHHI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiHHI7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:59:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C503DFEB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:59:36 -0700 (PDT)
Received: from zn.tnic (p200300ea971b985f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:985f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF7CE1EC054E;
        Mon,  8 Aug 2022 10:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659949175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=K2UC/ghuT1+RSdji34RWcrKHweP0vnvdqgl/deQdbMg=;
        b=ejKykcH8FzpR/7SlgzFCUiF89QDtuLcLe9dhX/X2rr8J2R1J/gyJmL0X1xoa6RnmGDMrP3
        vuEgflmQWBQeAgZrnvSToesMCiRMSCsTB4Vz8FlGu5Zz7TxTvNVLjZIyYyqh9Vy4MfHnVl
        iIs0MlStR/PXw6vOQd20eMVtV2dPBCk=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH] scripts/decodecode: Improve faulting line determination
Date:   Mon,  8 Aug 2022 10:59:28 +0200
Message-Id: <20220808085928.29840-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There are cases where the IP pointer in a Code: line in an oops doesn't
point at the beginning of an instruction:

Code: 0f bd c2 e9 a0 cd b5 e4 48 0f bd c2 e9 97 cd b5 e4 0f 1f 80 00 00 00 00 \
	  e9 8b cd b5 e4 0f 1f 00 66 0f a3 d0 e9 7f cd b5 e4 0f 1f <80> 00 00 00 \
	  00 0f a3 d0 e9 70 cd b5 e4 48 0f a3 d0 e9 67 cd b5

  e9 7f cd b5 e4          jmp    0xffffffffe4b5cda8
  0f 1f 80 00 00 00 00    nopl   0x0(%rax)
	^^

and the current way of determining the faulting instruction line doesn't
work because disassembled instructions are counted from the IP byte to
the end and when that thing points in the middle, the trailing bytes can
be interpreted as different insns:

  Code starting with the faulting instruction
  ===========================================
     0:   80 00 00                addb   $0x0,(%rax)
     3:   00 00                   add    %al,(%rax)

whereas, this is part of

0f 1f 80 00 00 00 00    nopl   0x0(%rax)

     5:   0f a3 d0                bt     %edx,%eax
     ...

leading to:

  1d:   0f 1f 00                nopl   (%rax)
  20:   66 0f a3 d0             bt     %dx,%ax
  24:*  e9 7f cd b5 e4          jmp    0xffffffffe4b5cda8               <-- trapping instruction
  29:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)
  30:   0f a3 d0                bt     %edx,%eax

which is the wrong faulting instruction.

Change the way the faulting line number is determined by matching the
opcode bytes from the beginning, leading to correct output:

  1d:   0f 1f 00                nopl   (%rax)
  20:   66 0f a3 d0             bt     %dx,%ax
  24:   e9 7f cd b5 e4          jmp    0xffffffffe4b5cda8
  29:*  0f 1f 80 00 00 00 00    nopl   0x0(%rax)                <-- trapping instruction
  30:   0f a3 d0                bt     %edx,%eax

While at it, make decodecode use bash as the interpreter - that thing
should be present on everything by now. It simplifies the code a lot
too.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 scripts/decodecode | 120 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 105 insertions(+), 15 deletions(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index c711a196511c..b28fd2686561 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # Disassemble the Code: line in Linux oopses
 # usage: decodecode < oops.file
@@ -8,6 +8,8 @@
 # AFLAGS=--32 decodecode < 386.oops
 # PC=hex - the PC (program counter) the oops points to
 
+faultlinenum=1
+
 cleanup() {
 	rm -f $T $T.s $T.o $T.oo $T.aa $T.dis
 	exit 1
@@ -102,28 +104,125 @@ disas() {
 		grep -v "/tmp\|Disassembly\|\.text\|^$" > $t.dis 2>&1
 }
 
+# Match the maximum number of opcode bytes from @op_bytes contained within
+# @opline
+#
+# Params:
+# @op_bytes: The string of bytes from the Code: line
+# @opline: The disassembled line coming from objdump
+#
+# Returns:
+# The max number of opcode bytes from the beginning of @op_bytes which match
+# the opcode bytes in the objdump line.
+get_substr_opcode_bytes_num()
+{
+	local op_bytes=$1
+	local opline=$2
+
+	local retval=0
+	substr=""
+
+	for opc in $op_bytes;
+	do
+		substr+="$opc"
+
+		# return if opcode bytes do not match @opline anymore
+		if ! echo $opline | grep -q "$substr";
+		then
+			break
+		fi
+
+		# add trailing space
+		substr+=" "
+		retval=$((retval+1))
+	done
+
+	return $retval
+}
+
+# Return the line number in objdump output to where the IP marker in the Code:
+# line points to
+#
+# Params:
+# @all_code: code in bytes without the marker
+# @dis_file: disassembled file
+# @ip_byte: The byte to which the IP points to
+get_faultlinenum()
+{
+	local all_code="$1"
+	local dis_file="$2"
+
+	# num bytes including IP byte
+	local num_bytes_ip=$(( $3 + 1 * $width ))
+
+	# Add the two header lines (we're counting from 1).
+	local retval=3
+
+	# remove marker
+	all_code=$(echo $all_code | sed -e 's/[<>()]//g')
+
+	while read line
+	do
+		get_substr_opcode_bytes_num "$all_code" "$line"
+		ate_opcodes=$?
+
+		if ! (( $ate_opcodes )); then
+			continue
+		fi
+
+		num_bytes_ip=$((num_bytes_ip - ($ate_opcodes * $width) ))
+		if (( $num_bytes_ip <= 0 )); then
+			break
+		fi
+
+		# Delete matched opcode bytes from all_code. For that, compute
+		# how many chars those opcodes are represented by and include
+		# trailing space.
+		#
+		# a byte is 2 chars, ate_opcodes is also the number of trailing
+		# spaces
+		del_chars=$(( ($ate_opcodes * $width * 2) + $ate_opcodes ))
+
+		all_code=$(echo $all_code | sed -e "s!^.\{$del_chars\}!!")
+
+		let "retval+=1"
+
+	done < $dis_file
+
+	return $retval
+}
+
 marker=`expr index "$code" "\<"`
 if [ $marker -eq 0 ]; then
 	marker=`expr index "$code" "\("`
 fi
 
-
 touch $T.oo
 if [ $marker -ne 0 ]; then
-	# 2 opcode bytes and a single space
-	pc_sub=$(( $marker / 3 ))
+	# How many bytes to subtract from the program counter
+	# in order to get to the beginning virtual address of the
+	# Code:
+	pc_sub=$(( (($marker - 1) / (2 * $width + 1)) * $width ))
 	echo All code >> $T.oo
 	echo ======== >> $T.oo
 	beforemark=`echo "$code"`
 	echo -n "	.$type 0x" > $T.s
+
 	echo $beforemark | sed -e 's/ /,0x/g; s/[<>()]//g' >> $T.s
+
 	disas $T $pc_sub
+
 	cat $T.dis >> $T.oo
-	rm -f $T.o $T.s $T.dis
 
-# and fix code at-and-after marker
+	get_faultlinenum "$code" "$T.dis" $pc_sub
+	faultlinenum=$?
+
+	# and fix code at-and-after marker
 	code=`echo "$code" | cut -c$((${marker} + 1))-`
+
+	rm -f $T.o $T.s $T.dis
 fi
+
 echo Code starting with the faulting instruction  > $T.aa
 echo =========================================== >> $T.aa
 code=`echo $code | sed -e 's/\r//;s/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
@@ -132,15 +231,6 @@ echo $code >> $T.s
 disas $T 0
 cat $T.dis >> $T.aa
 
-# (lines of whole $T.oo) - (lines of $T.aa, i.e. "Code starting") + 3,
-# i.e. the title + the "===..=" line (sed is counting from 1, 0 address is
-# special)
-faultlinenum=$(( $(wc -l $T.oo  | cut -d" " -f1) - \
-		 $(wc -l $T.aa  | cut -d" " -f1) + 3))
-
-faultline=`cat $T.dis | head -1 | cut -d":" -f2-`
-faultline=`echo "$faultline" | sed -e 's/\[/\\\[/g; s/\]/\\\]/g'`
-
 cat $T.oo | sed -e "${faultlinenum}s/^\([^:]*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
 echo
 cat $T.aa
-- 
2.35.1

