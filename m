Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4894A042C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbiA1XSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiA1XSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:18:31 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7F9C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:18:31 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c188so9669378iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6cdWTX0fTztDk7sNHpbStMD6mG5WFsGQ8QDer77Pb0=;
        b=h7+vqPEdBQ7mU9VOhb9N+iZlgyvoQhKzs1j0N8GiKInwDJUSVJGc02M91Qu9O8Ly3e
         mlbbtR3ZW2aKMmBipRnwu7AS3WxnQwOReRWcVQ1k2+1f/moOr/AYfsMv4A33fIgCw8tQ
         G2VwV0HkBKvA7Kt41wDuhrnhX0b8zKtjm9s4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6cdWTX0fTztDk7sNHpbStMD6mG5WFsGQ8QDer77Pb0=;
        b=gXJhGs9St8tqWP8UMjpSgH/gIb9LyUSpSyv3R5rQC6+AiQ0ao0CyY+sBY0ZEa1YjAj
         PMUAoumbXOXMJYy5w6IUC5Fg6O1tmx3TtW3sDtTfBAqZmSrHsvJicE2/XiRNUljjNa1K
         rIjqm5fexSjBQmKTcjWkxjfahn/f0Ft/s9Wkui2nOK73J1icc057yHIxvPGalTmvqUoD
         4YDCZD9Hn0ctft57f0tdUx8v7yRgYztaPX2nreTaOfwoxgx/cUA0iD3BBQC7KfCnCuDI
         eciTzbEYHgFwHaok/3IxIm2oxQ3ma4Bicl2BbLtD/U6CEC5Eh09mNOUQyfIPKlzzglQL
         a1kw==
X-Gm-Message-State: AOAM5307YaJ4OGtCBSHk6Pv1YoZ3bjbSMesGubSnt+Ug++lDpgaURbMY
        lF0/0pUbx0wuPZ0nb/PzN6dhlFvdoVO+GQ==
X-Google-Smtp-Source: ABdhPJwTm5NQDIQ+uwtHguD39Ar8yotzhW0cn0C71sspho9MgLv4NDJQZCz7llFkZppRTYXfVbiJbQ==
X-Received: by 2002:a05:6602:2c44:: with SMTP id x4mr6510760iov.196.1643411910485;
        Fri, 28 Jan 2022 15:18:30 -0800 (PST)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id 193sm8685356iob.17.2022.01.28.15.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 15:18:29 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tom Rini <trini@konsulko.com>, Joe Perches <joe@perches.com>,
        Simon Glass <sjg@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] checkpatch: Add checks for U-Boot
Date:   Fri, 28 Jan 2022 16:18:23 -0700
Message-Id: <20220128161802.1.Iea256111132262fc2b3e58f14a62d410b92f4831@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-Boot has built up a small number of checks specific to that code
base. Although it is very similar to Linux, it has some other
requirements specific to its driver model, etc.

It is convenient to upstream these to keep the versions in sync.

Add a new function to handle the U-Boot checks and an option to enable
them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/checkpatch.pl | 112 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9dd0..c3090d2e653013 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -65,6 +65,7 @@ my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $user_codespellfile = "";
 my $conststructsfile = "$D/const_structs.checkpatch";
+my $u_boot = 0;
 my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
 my $typedefsfile;
 my $color = "auto";
@@ -136,6 +137,7 @@ Options:
   --typedefsfile             Read additional types from this file
   --color[=WHEN]             Use colors 'always', 'never', or only when output
                              is a terminal ('auto'). Default is 'auto'.
+  --u-boot                   Run additional checks for U-Boot
   --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
                              ${CONFIG_})
   -h, --help, --version      display this help and exit
@@ -320,6 +322,7 @@ GetOptions(
 	'codespell!'	=> \$codespell,
 	'codespellfile=s'	=> \$user_codespellfile,
 	'typedefsfile=s'	=> \$typedefsfile,
+	'u-boot'	=> \$u_boot,
 	'color=s'	=> \$color,
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
 	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
@@ -2572,6 +2575,111 @@ sub get_raw_comment {
 	return $comment;
 }
 
+# Checks specific to U-Boot
+# Args:
+#   line: Patch line to check
+#   auto: Auto variable name, e.g. "per_child_auto"
+#   suffix: Suffix to expect on member, e.g. "_priv"
+#   warning: Warning name, e.g. "PRIV_AUTO"
+sub u_boot_struct_name {
+	my ($line, $auto, $suffix, $warning, $herecurr) = @_;
+
+	# Use _priv as a suffix for the device-private data struct
+	if ($line =~ /^\+\s*\.${auto}\s*=\s*sizeof\(struct\((\w+)\).*/) {
+		my $struct_name = $1;
+		if ($struct_name !~ /^\w+${suffix}/) {
+			WARN($warning,
+				 "struct \'$struct_name\' should have a ${suffix} suffix\n"
+				 . $herecurr);
+		}
+	}
+}
+
+sub u_boot_line {
+	my ($realfile, $line, $rawline, $herecurr) = @_;
+
+	# ask for a test if a new uclass ID is added
+	if ($realfile =~ /uclass-id.h/ && $line =~ /^\+/) {
+		WARN("NEW_UCLASS",
+		     "Possible new uclass - make sure to add a sandbox driver, plus a test in test/dm/<name>.c\n" . $herecurr);
+	}
+
+	# try to get people to use the livetree API
+	if ($line =~ /^\+.*fdtdec_/) {
+		WARN("LIVETREE",
+		     "Use the livetree API (dev_read_...)\n" . $herecurr);
+	}
+
+	# add tests for new commands
+	if ($line =~ /^\+.*do_($Ident)\(struct cmd_tbl.*/) {
+		WARN("CMD_TEST",
+		     "Possible new command - make sure you add a test\n" . $herecurr);
+	}
+
+	# use if instead of #if
+	if ($realfile =~ /\.c$/ && $line =~ /^\+#if.*CONFIG.*/) {
+		WARN("PREFER_IF",
+		     "Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible\n" . $herecurr);
+	}
+
+	# prefer strl(cpy|cat) over strn(cpy|cat)
+	if ($line =~ /\bstrn(cpy|cat)\s*\(/) {
+		WARN("STRL",
+		     "strl$1 is preferred over strn$1 because it always produces a nul-terminated string\n" . $herecurr);
+	}
+
+	# use defconfig to manage CONFIG_CMD options
+	if ($line =~ /\+\s*#\s*(define|undef)\s+(CONFIG_CMD\w*)\b/) {
+		ERROR("DEFINE_CONFIG_CMD",
+		      "All commands are managed by Kconfig\n" . $herecurr);
+	}
+
+	# Don't put common.h and dm.h in header files
+	if ($realfile =~ /\.h$/ && $rawline =~ /^\+#include\s*<(common|dm)\.h>*/) {
+		ERROR("BARRED_INCLUDE_IN_HDR",
+		      "Avoid including common.h and dm.h in header files\n" . $herecurr);
+	}
+
+	# Do not disable fdt / initrd relocation
+	if ($rawline =~ /^\+.*(fdt|initrd)_high=0xffffffff/) {
+		ERROR("DISABLE_FDT_OR_INITRD_RELOC",
+		     "fdt or initrd relocation disabled at boot time\n" . $herecurr);
+	}
+
+	# make sure 'skip_board_fixup' is not
+	if ($rawline =~ /.*skip_board_fixup.*/) {
+		ERROR("SKIP_BOARD_FIXUP",
+		     "Avoid setting skip_board_fixup env variable\n" . $herecurr);
+	}
+
+	# Do not use CONFIG_ prefix in CONFIG_IS_ENABLED() calls
+	if ($line =~ /^\+.*CONFIG_IS_ENABLED\(CONFIG_\w*\).*/) {
+		ERROR("CONFIG_IS_ENABLED_CONFIG",
+		      "CONFIG_IS_ENABLED() takes values without the CONFIG_ prefix\n" . $herecurr);
+	}
+
+	# Use _priv as a suffix for the device-private data struct
+	if ($line =~ /^\+\s*\.priv_auto\s*=\s*sizeof\(struct\((\w+)\).*/) {
+		my $struct_name = $1;
+		if ($struct_name !~ /^\w+_priv/) {
+			WARN("PRIV_AUTO", "struct \'$struct_name\' should have a _priv suffix");
+		}
+	}
+
+	# Check struct names for the 'auto' members of struct driver
+	u_boot_struct_name($line, "priv_auto", "_priv", "PRIV_AUTO", $herecurr);
+	u_boot_struct_name($line, "plat_auto", "_plat", "PLAT_AUTO", $herecurr);
+	u_boot_struct_name($line, "per_child_auto", "_priv", "CHILD_PRIV_AUTO", $herecurr);
+	u_boot_struct_name($line, "per_child_plat_auto", "_plat",
+		"CHILD_PLAT_AUTO", $herecurr);
+
+	# Now the ones for struct uclass, skipping those in common with above
+	u_boot_struct_name($line, "per_device_auto", "_priv",
+		"DEVICE_PRIV_AUTO", $herecurr);
+	u_boot_struct_name($line, "per_device_plat_auto", "_plat",
+		"DEVICE_PLAT_AUTO", $herecurr);
+}
+
 sub exclude_global_initialisers {
 	my ($realfile) = @_;
 
@@ -3753,6 +3861,10 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
 		}
 
+		if ($u_boot) {
+			u_boot_line($realfile, $line, $rawline, $herecurr);
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

