Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E23158A2E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiHDVuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiHDVt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:49:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3C15FE2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:49:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so1011590pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dl/uHM3ElAstTQym1tPaU6HlUkSxu4TZoxj+JcHh5cM=;
        b=XXQLcHDA7ou9WhstO5NgKbt0J9MmZ5W5B98Fph/5trVWhiz+O2BrHX3FvNaHm6evTr
         i4/j5Dctb46nenaVTSpKb47jKptM+f71llV/XNjqMmqez2zVEgDyXJ+rv5Axwyaqb4R7
         fWb0aq2IwuIbKCQhiaatyYHCZnneK16bze2jGE4uRoNZffc4su1QdWXd5T/n+laWlbod
         cZX3tGTwY26uuL+JzmCv7wGBHQoxk/ILM6GZxEP9xuVwddwI7QjCRi/t0Mlpya+/4Dhx
         Kms0Cm4DaIwt5a0EvtEMC42Jehzya3dKObo2Kb7b+v1ULjrd9VhtBpacUkKXiIgFl0GM
         V40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dl/uHM3ElAstTQym1tPaU6HlUkSxu4TZoxj+JcHh5cM=;
        b=hmwSgSzMtJXrK6oMonPWNFDCESmv/Xr0Hc4D/reX6myFjod/xe9DsTOh2XKs+nhXF4
         jdj2tq3MEp0jwmBIjutFxxBT6IsDW7+s5LRA+OWzZckBubzGxXZaSzn9IfCMK/cRpq8T
         hb7RgSuq6cM0Aytyv7SAoryDMjYbjoIbQHJsVKjfTtIkJdXZ5H4AeNVbELUbsw59bsof
         TnZPRZbQzpIzZZuTXZ7P4yrBff6Ld0grCr2DSto57qQQ5xpk+rEAWxUYiMPczh9zTqt7
         mt0cnAgFiSZoC1Rp2Kuoish1MeRuvKu1hnuoymIeoyCcmfkRymLnwMm+4NypnvAvuWUM
         rFJA==
X-Gm-Message-State: ACgBeo1JWm0powiUPO2TilQPV7/EgM98bUUMslfSeCZrcTAiPrcfHHpz
        g2H5r3GvVIzZlzlXjYgQ0b9mpA==
X-Google-Smtp-Source: AA6agR6h1hti1B5h8Sk8eXHa0fWzVoEs/saDAq1BdHhwzvm6D48FdyR3OFWNnHx7vC3XLBv+/sPJ4A==
X-Received: by 2002:a17:902:d492:b0:16f:8583:9473 with SMTP id c18-20020a170902d49200b0016f85839473mr3168331plg.103.1659649796895;
        Thu, 04 Aug 2022 14:49:56 -0700 (PDT)
Received: from cansun.aristanetworks.com (2603-8081-76f0-8280-243b-9040-c149-8c1c.res6.spectrum.com. [2603:8081:76f0:8280:243b:9040:c149:8c1c])
        by smtp.gmail.com with ESMTPSA id r15-20020aa7988f000000b0052d481032a7sm1511018pfl.26.2022.08.04.14.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 14:49:56 -0700 (PDT)
From:   Can Sun <cansun@arista.com>
Cc:     Can Sun <cansun@arista.com>, Kevin Mitchell <kevmitch@arista.com>,
        Ivan Delalande <colona@arista.com>,
        weidonghui <weidonghui@allwinnertech.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/decodecode: add the ability to find code sequence
Date:   Thu,  4 Aug 2022 16:46:16 -0500
Message-Id: <20220804214616.71419-1-cansun@arista.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 It adds a tool to search code sequence from vmlinux. If additional
 parameters (vmlinux and kernel build path) are provided to decodecode
 command, it will try to search the code sequence in the binary, and
 provide a code block surrounding the target.
 
 An example:
  $ ARCH=x86 PC=0xffffffff8141642f ./decodecode <vmlinux> <kernel build path> < test.oops
  Code: 04 25 28 00 00 00 74 05 e8 54 85 c5 ff c9 c3 0f 1f 44 00 00 55 48 89 e5 e8 07 31 cb ff c7 05 27 3f ee 00 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 5
  d c3 0f 1f 44 00 00 55 48 89 e5 fb 66 0f
  All code
  ========
  ffffffff81416405:       04 25                   add    $0x25,%al
  ...
  Code starting with the faulting instruction
  ===========================================
  ffffffff81416405:       c6 04 25 00 00 00 00    movb   $0x1,0x0
  ...
  Finding code sequences from /home/cansun/src/vmlinux
  Failed to find full Code segment, but did find a subsegment.
  Surrounding code may have changed.
  Warning: PC provided does not match calculated binary offset.
  Found code string:  00 00 00 74 05 e8 54 85 c5 ff c9 c3 e8 __ __ __ __ 55 48 89 e5 e8 07 31 cb ff c7 05 27 3f ee 00 01 00 00 00 0f ae f8 c6 04 25 00 00 00 00 0
  1 5d c3 e8 __ __ __ __ 55 48 89 e5
  ============================================================
  ffffffff814163dd:       75 0c                   jne    ffffffff814163eb <moom_callback+0x62>
                  pr_info("OOM request ignored. No task eligible\n");
  ffffffff814163df:       48 c7 c7 45 e3 dc 81    mov    $0xffffffff81dce345,%rdi
  ...
  ffffffff81416425:       0f ae f8                sfence
          *killer = 1;
  ffffffff81416428:*      c6 04 25 00 00 00 00    movb   $0x1,0x0         <-- trapping instruction
  ffffffff8141642f:       01
  ...

Signed-off-by: Can Sun <cansun@arista.com>
Cc: Kevin Mitchell <kevmitch@arista.com>
Cc: Ivan Delalande <colona@arista.com>
Cc: weidonghui <weidonghui@allwinnertech.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 scripts/decodecode | 143 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 3 deletions(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index c711a196511c..2c848ded85cd 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -7,9 +7,11 @@
 # e.g., to decode an i386 oops on an x86_64 system, use:
 # AFLAGS=--32 decodecode < 386.oops
 # PC=hex - the PC (program counter) the oops points to
+# To search code sequences from vmlinux:
+# ARCH=x86 decodecode [vmlinux] [kernel build path] < oops.file
 
 cleanup() {
-	rm -f $T $T.s $T.o $T.oo $T.aa $T.dis
+	rm -f $T $T.s $T.o $T.oo $T.aa $T.ad $T.dis
 	exit 1
 }
 
@@ -51,8 +53,20 @@ if [ -z "$code" ]; then
 fi
 
 echo $code
+
+# Backup OBJDUMPFLAGS to dump vmlinux later
+objdumpflagsbackup=$OBJDUMPFLAGS
+
+# Encode Code: to \xff\xff format to search in vmlinux
+rawcode=`echo $code | sed -e 's/.*Code://; s/\s//g'`
+
 code=`echo $code | sed -e 's/.*Code: //'`
 
+# Get offset of faulting instruction
+pcoffset=${rawcode%%<*}
+pcoffset=$(( ${#pcoffset} / 2 ))
+rawcode=`echo $rawcode | sed -e 's/[<>()]//g; s/.\{2\}/\\\x&/g'`
+
 width=`expr index "$code" ' '`
 width=$((($width-1)/2))
 case $width in
@@ -62,10 +76,11 @@ case $width in
 esac
 
 if [ -z "$ARCH" ]; then
-    case `uname -m` in
+	case `uname -m` in
 	aarch64*) ARCH=arm64 ;;
 	arm*) ARCH=arm ;;
-    esac
+	x86*) ARCH=x86 ;;
+	esac
 fi
 
 # Params: (tmp_file, pc_sub)
@@ -144,4 +159,126 @@ faultline=`echo "$faultline" | sed -e 's/\[/\\\[/g; s/\]/\\\]/g'`
 cat $T.oo | sed -e "${faultlinenum}s/^\([^:]*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
 echo
 cat $T.aa
+
+# If a vmlinux binary is provided, try to search code sequences from it
+# It is an x86-specific tool.
+if [ "$ARCH" = "x86" ] && ! [ -z "$1" ] && [ -f "$1" ]; then
+	if [ -z "$2" ] || ! [ -d "$2" ]; then
+		echo
+		echo "Usage:"
+		echo "	$0 [vmlinux] [kernel build path]"
+		echo "	To find code sequences from vmlinux"
+		exit 1
+	fi
+
+	echo > $T.ad
+	echo "Finding code sequences from $1" >> $T.ad
+	vmlinux=$1
+	kernelpath=`readlink -f $2`
+	kernelpathdepth=`echo $kernelpath | grep -o '/' | wc -l`
+	minmatchlen=$(( 10 * 4 ))
+	partialmatch=0
+	removefromstart=1
+else
+	exit
+fi
+
+# __fentry__ (e8 + 4 bytes) is patched by nop ( 0f 1f 44 + 2 bytes ) at runtime
+restoredcode="$(echo $rawcode | \
+		sed -e 's/\\x0f\\x1f\\x44.\{8\}/\\xe8\.\{4\}/g')"
+addressresult=`LANG=C grep -boP --binary --text $restoredcode $vmlinux | \
+	       LANG=C sed 's/:.*$//'`
+
+# Try to find binary sequence, while reducing the length of the pattern
+while [ -z "$addressresult" ] && [ "${#restoredcode}" -gt "$minmatchlen" ]; do
+	partialmatch=1
+	if [ "$removefromstart" -eq 1 ]; then
+		restoredcode=${restoredcode#????}
+		if [ "$pcoffset" -gt 0 ]; then
+			pcoffset=$(( pcoffset - 1 ))
+		fi
+	else
+		restoredcode=${restoredcode%????}
+	fi
+	removefromstart=$((1-removefromstart))
+	addressresult=`LANG=C grep -boP --binary --text $restoredcode $vmlinux | \
+		       LANG=C sed 's/:.*$//' | tr '\n' ' '`
+done
+
+if [ -z "$addressresult" ]; then
+	cat $T.ad
+	echo "No matching code sequences found."
+	echo "================================="
+
+	exit
+fi
+
+minoffset=
+maxoffset=
+regex=
+trappingregex=
+# 0x200000 to cancel the offset in the vmlinux file
+# 0xffffffff81000000 to add the offset into memory of the kernel
+offsetadjust=`echo "ibase=16;FFFFFFFF81000000 - 200000" | bc`
+for address in $addressresult; do
+	offset=$(( address + pcoffset ))
+	if [ -z "$minoffset" ]; then
+		minoffset=$offset
+		maxoffset=$offset
+	else
+		if [ "$minoffset" -gt "$offset" ]; then
+			minoffset=$offset
+		fi
+		if [ "$maxoffset" -lt "$offset" ]; then
+			maxoffset=$offset
+		fi
+	fi
+
+	offset=`echo "obase=16;$offset + $offsetadjust" | bc`
+	fulloffset=$offset
+
+	# Truncate LSB to match any nearby addresses
+	offset=`echo $offset | sed 's/.$//'`
+	if [ -z "$regex" ]; then
+		regex="($offset.:"
+		trappingregex="$fulloffset:"
+	else
+		regex="$regex|$offset.:"
+		trappingregex="$trappingregex|$fulloffset:"
+	fi
+done
+
+regex="$regex)"
+minoffset=`echo "obase=16;$minoffset + $offsetadjust - 4096" | bc`
+maxoffset=`echo "obase=16;$maxoffset + $offsetadjust + 4096" | bc`
+display=
+if [ "$pcoffset" -eq -1 ]; then
+	# No current instruction found, so display the objdump from the beginning
+	# of the code block
+	display='-A 60'
+else
+	# Display around the current instruction
+	display='-C 30'
+fi
+
+OBJDUMPFLAGS="$objdumpflagsbackup -dS --start-address=0x$minoffset --stop-address=0x$maxoffset \
+	      --prefix=$kernelpath --prefix-strip=$kernelpathdepth $vmlinux"
+if [ "$partialmatch" -eq 1 ]; then
+	echo "Failed to find full Code segment, but did find a subsegment." >> $T.ad
+	echo "Surrounding code may have changed." >> $T.ad
+fi
+
+if [ "$PC" ]; then
+	( echo $PC | grep -Eqi $regex ) || echo "Warning: PC provided does not match \
+calculated binary offset." >> $T.ad
+fi
+
+restoredcode=`echo $restoredcode | sed 's/\\\\\x/ /g; s/.{4}/ __ __ __ __/g'`
+echo "Found code string: $restoredcode" >> $T.ad
+echo "============================================================" >> $T.ad
+
+${CROSS_COMPILE}objdump $OBJDUMPFLAGS | grep -Ei $display $regex >> $T.ad
+
+cat $T.ad | sed -e "s/^\(${trappingregex}\)\(.*\)/\1\*\2\t\t<-- trapping instruction/gI"
+
 cleanup
-- 
2.32.1 (Apple Git-133)

