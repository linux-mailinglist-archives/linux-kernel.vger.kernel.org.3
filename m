Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3DA550AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiFSNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiFSNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:12:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC63E1168
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:12:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655644357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nyISx9IVm0jNpApGwb32at4wOseRuI6uIpmm7wxu+5k=;
        b=CMCKDefbGxMHvuy0w7pmSbavKOFoEHQm4pUHIYVVMVpWk9uw63VZm5hSSQOisNiWlR0GjN
        PjPhO1tvIwnTqPIyTZTLRUs51io4leykqNNhOsMb2l5mEAmUbLRf4lYi9KTl3T3zqKEwsK
        EeRlJU5u83da93VQGIgZcUnEFyQeQ1pkwvvf3GW+OJzk0ndfWlGGgO3gQLyFMyZubbVbMh
        cmdXc62HBpu3UJ3evS/3xfMmEJEpoerPrmyRzlQa2nKG/Qk0R55ifxjondbPhi1fvONEA5
        oBwwlCSt7aN5RjYdF6nYkHrCVh89d5v52SxnBM+UFCuoxHvmbvWNWamZ8CvGgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655644357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nyISx9IVm0jNpApGwb32at4wOseRuI6uIpmm7wxu+5k=;
        b=SyU+3LXbegeE3KQQfLLSek802W7Di5ECh9cCBfmH5Qa8l+hefZDzWfZKBPTHiiqn82fHDB
        jAkxSTzWFywTHKAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/urgent for 5.19-rc3
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
Message-ID: <165564430032.1413209.11657608098401674700.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Jun 2022 15:12:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest objtool/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2=
022-06-19

up to:  7b6c7a877cc6: x86/ftrace: Remove OBJECT_FILES_NON_STANDARD usage


Build tool updates:

 - Remove obsolete CONFIG_X86_SMAP reference from objtool

 - Fix overlapping text section failures in faddr2line for real

 - Remove OBJECT_FILES_NON_STANDARD usage from x86 ftrace and replace it
   with finegrained annotations so objtool can validate that code
   correctly.


Thanks,

	tglx

------------------>
Josh Poimboeuf (3):
      objtool: Fix obsolete reference to CONFIG_X86_SMAP
      faddr2line: Fix overlapping text section failures, the sequel
      x86/ftrace: Remove OBJECT_FILES_NON_STANDARD usage


 arch/x86/kernel/Makefile      |  4 ----
 arch/x86/kernel/ftrace_64.S   | 11 ++++++++---
 include/linux/objtool.h       |  6 ++++++
 lib/Kconfig.ubsan             |  2 +-
 scripts/faddr2line            | 45 ++++++++++++++++++++++++++++++++---------=
--
 tools/include/linux/objtool.h |  6 ++++++
 6 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 03364dc40d8d..4c8b6ae802ac 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -36,10 +36,6 @@ KCSAN_SANITIZE :=3D n
=20
 OBJECT_FILES_NON_STANDARD_test_nx.o			:=3D y
=20
-ifdef CONFIG_FRAME_POINTER
-OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:=3D y
-endif
-
 # If instrumentation of this dir is enabled, boot hangs during first second.
 # Probably could be more selective here, but note that files related to irqs,
 # boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 4ec13608d3c6..dfeb227de561 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -175,6 +175,7 @@ SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
=20
 	jmp ftrace_epilogue
 SYM_FUNC_END(ftrace_caller);
+STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
=20
 SYM_FUNC_START(ftrace_epilogue)
 /*
@@ -282,6 +283,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	jmp	ftrace_epilogue
=20
 SYM_FUNC_END(ftrace_regs_caller)
+STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
=20
=20
 #else /* ! CONFIG_DYNAMIC_FTRACE */
@@ -311,10 +313,14 @@ trace:
 	jmp ftrace_stub
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
+STACK_FRAME_NON_STANDARD_FP(__fentry__)
+
 #endif /* CONFIG_DYNAMIC_FTRACE */
=20
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_FUNC_START(return_to_handler)
+SYM_CODE_START(return_to_handler)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	subq  $16, %rsp
=20
 	/* Save the return values */
@@ -339,7 +345,6 @@ SYM_FUNC_START(return_to_handler)
 	int3
 .Ldo_rop:
 	mov %rdi, (%rsp)
-	UNWIND_HINT_FUNC
 	RET
-SYM_FUNC_END(return_to_handler)
+SYM_CODE_END(return_to_handler)
 #endif
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 6491fa8fba6d..15b940ec1eac 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -143,6 +143,12 @@ struct unwind_hint {
 	.popsection
 .endm
=20
+.macro STACK_FRAME_NON_STANDARD_FP func:req
+#ifdef CONFIG_FRAME_POINTER
+	STACK_FRAME_NON_STANDARD \func
+#endif
+.endm
+
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index c4fe15d38b60..a9f7eb047768 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -94,7 +94,7 @@ config UBSAN_UNREACHABLE
 	bool "Perform checking for unreachable code"
 	# objtool already handles unreachable checking and gets angry about
 	# seeing UBSan instrumentation located in unreachable places.
-	depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || X86_SMAP))
+	depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || HAVE_UACCESS_V=
ALIDATION))
 	depends on $(cc-option,-fsanitize=3Dunreachable)
 	help
 	  This option enables -fsanitize=3Dunreachable which checks for control
diff --git a/scripts/faddr2line b/scripts/faddr2line
index 0e6268d59883..94ed98dd899f 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -95,17 +95,25 @@ __faddr2line() {
 	local print_warnings=3D$4
=20
 	local sym_name=3D${func_addr%+*}
-	local offset=3D${func_addr#*+}
-	offset=3D${offset%/*}
+	local func_offset=3D${func_addr#*+}
+	func_offset=3D${func_offset%/*}
 	local user_size=3D
+	local file_type
+	local is_vmlinux=3D0
 	[[ $func_addr =3D~ "/" ]] && user_size=3D${func_addr#*/}
=20
-	if [[ -z $sym_name ]] || [[ -z $offset ]] || [[ $sym_name =3D $func_addr ]]=
; then
+	if [[ -z $sym_name ]] || [[ -z $func_offset ]] || [[ $sym_name =3D $func_ad=
dr ]]; then
 		warn "bad func+offset $func_addr"
 		DONE=3D1
 		return
 	fi
=20
+	# vmlinux uses absolute addresses in the section table rather than
+	# section offsets.
+	local file_type=3D$(${READELF} --file-header $objfile |
+		${AWK} '$1 =3D=3D "Type:" { print $2; exit }')
+	[[ $file_type =3D "EXEC" ]] && is_vmlinux=3D1
+
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates, in which case we print all
 	# matches.
@@ -114,9 +122,11 @@ __faddr2line() {
 		local sym_addr=3D0x${fields[1]}
 		local sym_elf_size=3D${fields[2]}
 		local sym_sec=3D${fields[6]}
+		local sec_size
+		local sec_name
=20
 		# Get the section size:
-		local sec_size=3D$(${READELF} --section-headers --wide $objfile |
+		sec_size=3D$(${READELF} --section-headers --wide $objfile |
 			sed 's/\[ /\[/' |
 			${AWK} -v sec=3D$sym_sec '$1 =3D=3D "[" sec "]" { print "0x" $6; exit }')
=20
@@ -126,6 +136,17 @@ __faddr2line() {
 			return
 		fi
=20
+		# Get the section name:
+		sec_name=3D$(${READELF} --section-headers --wide $objfile |
+			sed 's/\[ /\[/' |
+			${AWK} -v sec=3D$sym_sec '$1 =3D=3D "[" sec "]" { print $2; exit }')
+
+		if [[ -z $sec_name ]]; then
+			warn "bad section name: section: $sym_sec"
+			DONE=3D1
+			return
+		fi
+
 		# Calculate the symbol size.
 		#
 		# Unfortunately we can't use the ELF size, because kallsyms
@@ -174,10 +195,10 @@ __faddr2line() {
=20
 		sym_size=3D0x$(printf %x $sym_size)
=20
-		# Calculate the section address from user-supplied offset:
-		local addr=3D$(($sym_addr + $offset))
+		# Calculate the address from user-supplied offset:
+		local addr=3D$(($sym_addr + $func_offset))
 		if [[ -z $addr ]] || [[ $addr =3D 0 ]]; then
-			warn "bad address: $sym_addr + $offset"
+			warn "bad address: $sym_addr + $func_offset"
 			DONE=3D1
 			return
 		fi
@@ -191,9 +212,9 @@ __faddr2line() {
 		fi
=20
 		# Make sure the provided offset is within the symbol's range:
-		if [[ $offset -gt $sym_size ]]; then
+		if [[ $func_offset -gt $sym_size ]]; then
 			[[ $print_warnings =3D 1 ]] &&
-				echo "skipping $sym_name address at $addr due to size mismatch ($offset =
> $sym_size)"
+				echo "skipping $sym_name address at $addr due to size mismatch ($func_of=
fset > $sym_size)"
 			continue
 		fi
=20
@@ -202,11 +223,13 @@ __faddr2line() {
 		[[ $FIRST =3D 0 ]] && echo
 		FIRST=3D0
=20
-		echo "$sym_name+$offset/$sym_size:"
+		echo "$sym_name+$func_offset/$sym_size:"
=20
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
-		local output=3D$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(=
\./\)*; ;")
+		local args=3D"--functions --pretty-print --inlines --exe=3D$objfile"
+		[[ $is_vmlinux =3D 0 ]] && args=3D"$args --section=3D$sec_name"
+		local output=3D$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;=
")
 		[[ -z $output ]] && continue
=20
 		# Default output (non --list):
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 6491fa8fba6d..15b940ec1eac 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -143,6 +143,12 @@ struct unwind_hint {
 	.popsection
 .endm
=20
+.macro STACK_FRAME_NON_STANDARD_FP func:req
+#ifdef CONFIG_FRAME_POINTER
+	STACK_FRAME_NON_STANDARD \func
+#endif
+.endm
+
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr

