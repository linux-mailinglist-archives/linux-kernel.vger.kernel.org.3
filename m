Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD554506A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbiFIPPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbiFIPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:15:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F429C9D;
        Thu,  9 Jun 2022 08:15:40 -0700 (PDT)
Date:   Thu, 09 Jun 2022 15:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654787739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf1l+inPFPE8aFEMbzsEmC38PQqJwtvTgTZxPsRUmC0=;
        b=jl6+AwVVjWIrYLlzi60uz7OcV7FR8Ieike5QougK+7stUGFHcptiEPepXuTlr05i5Y9+sM
        lQBrLwle+eZWgoBYE2l5sdgb8QQ0x6/+OV6MIvhiYmSYmj3CcvJKWsdS3qSahsJ57UFt6G
        PoWAvvllJV++lrnLIca0LGfH7zuignT6Kkc1LMHm06Tfwyx5MkkuzAvtMcheNs8Bofnpo5
        EaMuASd9qZBe4Lly1LGdWe81mrXZpXLyBOG+K1UiPc3UFw96AbuYPELPiWY7nM4WowOKlg
        NU3u1ECZ3M1E8jlkxiat6bRtD57+3Wn9Tyt1K7xPRpjeOjAhu5e6plg4bxEsSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654787739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf1l+inPFPE8aFEMbzsEmC38PQqJwtvTgTZxPsRUmC0=;
        b=UWykuxWBbhZi9jf7KIdj82RzfKH2shhEw35sV7W5GCM26gJFNXwIPKcqbVHh2T02Es7klY
        0IRMUHGdKwlXKWBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] faddr2line: Fix overlapping text section
 failures, the sequel
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7d25bc1408bd3a750ac26e60d2f2815a5f4a8363.1654130536.git.jpoimboe@kernel.org>
References: <7d25bc1408bd3a750ac26e60d2f2815a5f4a8363.1654130536.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165478773813.4207.9225328034441998466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     dcea997beed694cbd8705100ca1a6eb0d886de69
Gitweb:        https://git.kernel.org/tip/dcea997beed694cbd8705100ca1a6eb0d886de69
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 01 Jun 2022 17:42:22 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Jun 2022 11:50:11 -07:00

faddr2line: Fix overlapping text section failures, the sequel

If a function lives in a section other than .text, but .text also exists
in the object, faddr2line may wrongly assume .text.  This can result in
comically wrong output.  For example:

  $ scripts/faddr2line vmlinux.o enter_from_user_mode+0x1c
  enter_from_user_mode+0x1c/0x30:
  find_next_bit at /home/jpoimboe/git/linux/./include/linux/find.h:40
  (inlined by) perf_clear_dirty_counters at /home/jpoimboe/git/linux/arch/x86/events/core.c:2504

Fix it by passing the section name to addr2line, unless the object file
is vmlinux, in which case the symbol table uses absolute addresses.

Fixes: 1d1a0e7c5100 ("scripts/faddr2line: Fix overlapping text section failures")
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/7d25bc1408bd3a750ac26e60d2f2815a5f4a8363.1654130536.git.jpoimboe@kernel.org
---
 scripts/faddr2line | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 0e6268d..94ed98d 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -95,17 +95,25 @@ __faddr2line() {
 	local print_warnings=$4
 
 	local sym_name=${func_addr%+*}
-	local offset=${func_addr#*+}
-	offset=${offset%/*}
+	local func_offset=${func_addr#*+}
+	func_offset=${func_offset%/*}
 	local user_size=
+	local file_type
+	local is_vmlinux=0
 	[[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
 
-	if [[ -z $sym_name ]] || [[ -z $offset ]] || [[ $sym_name = $func_addr ]]; then
+	if [[ -z $sym_name ]] || [[ -z $func_offset ]] || [[ $sym_name = $func_addr ]]; then
 		warn "bad func+offset $func_addr"
 		DONE=1
 		return
 	fi
 
+	# vmlinux uses absolute addresses in the section table rather than
+	# section offsets.
+	local file_type=$(${READELF} --file-header $objfile |
+		${AWK} '$1 == "Type:" { print $2; exit }')
+	[[ $file_type = "EXEC" ]] && is_vmlinux=1
+
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates, in which case we print all
 	# matches.
@@ -114,9 +122,11 @@ __faddr2line() {
 		local sym_addr=0x${fields[1]}
 		local sym_elf_size=${fields[2]}
 		local sym_sec=${fields[6]}
+		local sec_size
+		local sec_name
 
 		# Get the section size:
-		local sec_size=$(${READELF} --section-headers --wide $objfile |
+		sec_size=$(${READELF} --section-headers --wide $objfile |
 			sed 's/\[ /\[/' |
 			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print "0x" $6; exit }')
 
@@ -126,6 +136,17 @@ __faddr2line() {
 			return
 		fi
 
+		# Get the section name:
+		sec_name=$(${READELF} --section-headers --wide $objfile |
+			sed 's/\[ /\[/' |
+			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print $2; exit }')
+
+		if [[ -z $sec_name ]]; then
+			warn "bad section name: section: $sym_sec"
+			DONE=1
+			return
+		fi
+
 		# Calculate the symbol size.
 		#
 		# Unfortunately we can't use the ELF size, because kallsyms
@@ -174,10 +195,10 @@ __faddr2line() {
 
 		sym_size=0x$(printf %x $sym_size)
 
-		# Calculate the section address from user-supplied offset:
-		local addr=$(($sym_addr + $offset))
+		# Calculate the address from user-supplied offset:
+		local addr=$(($sym_addr + $func_offset))
 		if [[ -z $addr ]] || [[ $addr = 0 ]]; then
-			warn "bad address: $sym_addr + $offset"
+			warn "bad address: $sym_addr + $func_offset"
 			DONE=1
 			return
 		fi
@@ -191,9 +212,9 @@ __faddr2line() {
 		fi
 
 		# Make sure the provided offset is within the symbol's range:
-		if [[ $offset -gt $sym_size ]]; then
+		if [[ $func_offset -gt $sym_size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $sym_name address at $addr due to size mismatch ($offset > $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($func_offset > $sym_size)"
 			continue
 		fi
 
@@ -202,11 +223,13 @@ __faddr2line() {
 		[[ $FIRST = 0 ]] && echo
 		FIRST=0
 
-		echo "$sym_name+$offset/$sym_size:"
+		echo "$sym_name+$func_offset/$sym_size:"
 
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
-		local output=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		local args="--functions --pretty-print --inlines --exe=$objfile"
+		[[ $is_vmlinux = 0 ]] && args="$args --section=$sec_name"
+		local output=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
 		[[ -z $output ]] && continue
 
 		# Default output (non --list):
