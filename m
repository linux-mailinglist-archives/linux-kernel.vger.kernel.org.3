Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8628652AE05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiEQWWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiEQWV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:21:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3828E38;
        Tue, 17 May 2022 15:21:57 -0700 (PDT)
Date:   Tue, 17 May 2022 22:21:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652826115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iafCGWGYKhqIDvXoUGN2B3JUN4kPCTFp4xJXTmnDBJs=;
        b=FkDz7Wpq+DKmFInfUYslEDHQcX0cOMkN1hGABY7hH8w/DqOrUJXwfFg0p6HCTuavKfA0ag
        +FvAhaYa3LqQNzyiledQHyfwtUxSJmgpJGbviqqSyRt1jVRReBj+JU9PeEX54KJ7gc/l/D
        /opts3U/XXd6mcYXwIlulnd3INfR1tiDL74a4lzrEUtMNiuVC/iiiknzmBUNjk//8Xlksi
        0jQUsq9iQypZKq6NK9yq3xPfAET2OKR1GVXLtilUM1Lb6W3wkFbq700bxOIWq5/vbrN7Fr
        ACGlMG7Ji6DAx354wAZRzyXhDKlP5fJlRvzimHZIKni6siHvfqh040qAuQYb9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652826115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iafCGWGYKhqIDvXoUGN2B3JUN4kPCTFp4xJXTmnDBJs=;
        b=xcCVuzz/VSchmSjpGO7y41gfjCNHpFxx/dyF32Rz+IefzFJWttSzF9r52AhzWjPPhocYOi
        xP65Zv2HB+FWPECA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Fix overlapping text section failures
Cc:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <29ff99f86e3da965b6e46c1cc2d72ce6528c17c3.1652382321.git.jpoimboe@kernel.org>
References: <29ff99f86e3da965b6e46c1cc2d72ce6528c17c3.1652382321.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165282611421.4207.7170580893951495841.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1d1a0e7c5100d332583e20b40aa8c0a8ed3d7849
Gitweb:        https://git.kernel.org/tip/1d1a0e7c5100d332583e20b40aa8c0a8ed3d7849
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 12 May 2022 12:05:27 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 12 May 2022 12:07:11 -07:00

scripts/faddr2line: Fix overlapping text section failures

There have been some recent reports of faddr2line failures:

  $ scripts/faddr2line sound/soundcore.ko sound_devnode+0x5/0x35
  bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000

  $ ./scripts/faddr2line vmlinux.o enter_from_user_mode+0x24
  bad symbol size: base: 0x0000000000005fe0 end: 0x0000000000005fe0

The problem is that faddr2line is based on 'nm', which has a major
limitation: it doesn't know how to distinguish between different text
sections.  So if an offset exists in multiple text sections in the
object, it may fail.

Rewrite faddr2line to be section-aware, by basing it on readelf.

Fixes: 67326666e2d4 ("scripts: add script for translating stack dump function offsets")
Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/29ff99f86e3da965b6e46c1cc2d72ce6528c17c3.1652382321.git.jpoimboe@kernel.org
---
 scripts/faddr2line | 150 ++++++++++++++++++++++++++++----------------
 1 file changed, 97 insertions(+), 53 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6c6439f..0e6268d 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -44,17 +44,6 @@
 set -o errexit
 set -o nounset
 
-READELF="${CROSS_COMPILE:-}readelf"
-ADDR2LINE="${CROSS_COMPILE:-}addr2line"
-SIZE="${CROSS_COMPILE:-}size"
-NM="${CROSS_COMPILE:-}nm"
-
-command -v awk >/dev/null 2>&1 || die "awk isn't installed"
-command -v ${READELF} >/dev/null 2>&1 || die "readelf isn't installed"
-command -v ${ADDR2LINE} >/dev/null 2>&1 || die "addr2line isn't installed"
-command -v ${SIZE} >/dev/null 2>&1 || die "size isn't installed"
-command -v ${NM} >/dev/null 2>&1 || die "nm isn't installed"
-
 usage() {
 	echo "usage: faddr2line [--list] <object file> <func+offset> <func+offset>..." >&2
 	exit 1
@@ -69,6 +58,14 @@ die() {
 	exit 1
 }
 
+READELF="${CROSS_COMPILE:-}readelf"
+ADDR2LINE="${CROSS_COMPILE:-}addr2line"
+AWK="awk"
+
+command -v ${AWK} >/dev/null 2>&1 || die "${AWK} isn't installed"
+command -v ${READELF} >/dev/null 2>&1 || die "${READELF} isn't installed"
+command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
+
 # Try to figure out the source directory prefix so we can remove it from the
 # addr2line output.  HACK ALERT: This assumes that start_kernel() is in
 # init/main.c!  This only works for vmlinux.  Otherwise it falls back to
@@ -76,7 +73,7 @@ die() {
 find_dir_prefix() {
 	local objfile=$1
 
-	local start_kernel_addr=$(${READELF} -sW $objfile | awk '$8 == "start_kernel" {printf "0x%s", $2}')
+	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | ${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
 	local file_line=$(${ADDR2LINE} -e $objfile $start_kernel_addr)
@@ -97,86 +94,133 @@ __faddr2line() {
 	local dir_prefix=$3
 	local print_warnings=$4
 
-	local func=${func_addr%+*}
+	local sym_name=${func_addr%+*}
 	local offset=${func_addr#*+}
 	offset=${offset%/*}
-	local size=
-	[[ $func_addr =~ "/" ]] && size=${func_addr#*/}
+	local user_size=
+	[[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
 
-	if [[ -z $func ]] || [[ -z $offset ]] || [[ $func = $func_addr ]]; then
+	if [[ -z $sym_name ]] || [[ -z $offset ]] || [[ $sym_name = $func_addr ]]; then
 		warn "bad func+offset $func_addr"
 		DONE=1
 		return
 	fi
 
 	# Go through each of the object's symbols which match the func name.
-	# In rare cases there might be duplicates.
-	file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
-	while read symbol; do
-		local fields=($symbol)
-		local sym_base=0x${fields[0]}
-		local sym_type=${fields[1]}
-		local sym_end=${fields[3]}
-
-		# calculate the size
-		local sym_size=$(($sym_end - $sym_base))
+	# In rare cases there might be duplicates, in which case we print all
+	# matches.
+	while read line; do
+		local fields=($line)
+		local sym_addr=0x${fields[1]}
+		local sym_elf_size=${fields[2]}
+		local sym_sec=${fields[6]}
+
+		# Get the section size:
+		local sec_size=$(${READELF} --section-headers --wide $objfile |
+			sed 's/\[ /\[/' |
+			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print "0x" $6; exit }')
+
+		if [[ -z $sec_size ]]; then
+			warn "bad section size: section: $sym_sec"
+			DONE=1
+			return
+		fi
+
+		# Calculate the symbol size.
+		#
+		# Unfortunately we can't use the ELF size, because kallsyms
+		# also includes the padding bytes in its size calculation.  For
+		# kallsyms, the size calculation is the distance between the
+		# symbol and the next symbol in a sorted list.
+		local sym_size
+		local cur_sym_addr
+		local found=0
+		while read line; do
+			local fields=($line)
+			cur_sym_addr=0x${fields[1]}
+			local cur_sym_elf_size=${fields[2]}
+			local cur_sym_name=${fields[7]:-}
+
+			if [[ $cur_sym_addr = $sym_addr ]] &&
+			   [[ $cur_sym_elf_size = $sym_elf_size ]] &&
+			   [[ $cur_sym_name = $sym_name ]]; then
+				found=1
+				continue
+			fi
+
+			if [[ $found = 1 ]]; then
+				sym_size=$(($cur_sym_addr - $sym_addr))
+				[[ $sym_size -lt $sym_elf_size ]] && continue;
+				found=2
+				break
+			fi
+		done < <(${READELF} --symbols --wide $objfile | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+
+		if [[ $found = 0 ]]; then
+			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
+			DONE=1
+			return
+		fi
+
+		# If nothing was found after the symbol, assume it's the last
+		# symbol in the section.
+		[[ $found = 1 ]] && sym_size=$(($sec_size - $sym_addr))
+
 		if [[ -z $sym_size ]] || [[ $sym_size -le 0 ]]; then
-			warn "bad symbol size: base: $sym_base end: $sym_end"
+			warn "bad symbol size: sym_addr: $sym_addr cur_sym_addr: $cur_sym_addr"
 			DONE=1
 			return
 		fi
+
 		sym_size=0x$(printf %x $sym_size)
 
-		# calculate the address
-		local addr=$(($sym_base + $offset))
+		# Calculate the section address from user-supplied offset:
+		local addr=$(($sym_addr + $offset))
 		if [[ -z $addr ]] || [[ $addr = 0 ]]; then
-			warn "bad address: $sym_base + $offset"
+			warn "bad address: $sym_addr + $offset"
 			DONE=1
 			return
 		fi
 		addr=0x$(printf %x $addr)
 
-		# weed out non-function symbols
-		if [[ $sym_type != t ]] && [[ $sym_type != T ]]; then
-			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to non-function symbol of type '$sym_type'"
-			continue
-		fi
-
-		# if the user provided a size, make sure it matches the symbol's size
-		if [[ -n $size ]] && [[ $size -ne $sym_size ]]; then
+		# If the user provided a size, make sure it matches the symbol's size:
+		if [[ -n $user_size ]] && [[ $user_size -ne $sym_size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($size != $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($user_size != $sym_size)"
 			continue;
 		fi
 
-		# make sure the provided offset is within the symbol's range
+		# Make sure the provided offset is within the symbol's range:
 		if [[ $offset -gt $sym_size ]]; then
 			[[ $print_warnings = 1 ]] &&
-				echo "skipping $func address at $addr due to size mismatch ($offset > $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($offset > $sym_size)"
 			continue
 		fi
 
-		# separate multiple entries with a blank line
+		# In case of duplicates or multiple addresses specified on the
+		# cmdline, separate multiple entries with a blank line:
 		[[ $FIRST = 0 ]] && echo
 		FIRST=0
 
-		# pass real address to addr2line
-		echo "$func+$offset/$sym_size:"
-		local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
-		[[ -z $file_lines ]] && return
+		echo "$sym_name+$offset/$sym_size:"
 
+		# Pass section address to addr2line and strip absolute paths
+		# from the output:
+		local output=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		[[ -z $output ]] && continue
+
+		# Default output (non --list):
 		if [[ $LIST = 0 ]]; then
-			echo "$file_lines" | while read -r line
+			echo "$output" | while read -r line
 			do
 				echo $line
 			done
 			DONE=1;
-			return
+			continue
 		fi
 
-		# show each line with context
-		echo "$file_lines" | while read -r line
+		# For --list, show each line with its corresponding source code:
+		echo "$output" | while read -r line
 		do
 			echo
 			echo $line
@@ -184,12 +228,12 @@ __faddr2line() {
 			n1=$[$n-5]
 			n2=$[$n+5]
 			f=$(echo $line | sed 's/.*at \(.\+\):.*/\1/g')
-			awk 'NR>=strtonum("'$n1'") && NR<=strtonum("'$n2'") { if (NR=='$n') printf(">%d<", NR); else printf(" %d ", NR); printf("\t%s\n", $0)}' $f
+			${AWK} 'NR>=strtonum("'$n1'") && NR<=strtonum("'$n2'") { if (NR=='$n') printf(">%d<", NR); else printf(" %d ", NR); printf("\t%s\n", $0)}' $f
 		done
 
 		DONE=1
 
-	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
+	done < <(${READELF} --symbols --wide $objfile | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage
