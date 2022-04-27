Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949DF511A71
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiD0OXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiD0OXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:23:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67431A921A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651069189; x=1682605189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pIWY/z+Ufq043o7X2cdcCRk/WmAfJMJxxbg5nxLDFP8=;
  b=R24P7DmgeCH+6m363k9+a672wncm0S+FktbJBYDFgxC4sSjdhVQucP55
   ikBMIyudd26ku04lNt9ED6h/K5eiBX4fcw0zFMr7n0jjKLRXbuwv5Y3/9
   o362CSPhtkBuVGonIWX9eg6ZzW0cuaY/JwUCiJ1DxlCs3WYvHj74bfDBX
   IcIcbPnh26H2a/mspnh+Z3vPncwWvGogBDtD7ebvEW5vXP/OzSjRGRRIs
   4LKtBPBXfatWclJtweVVNlWhllnDXqVjLSbgotsYYhK3tAoGf/miuYkYU
   MW+YkIKQ5e9GBEjBUrlmf4En1uU8XNtmjqOOr09Y9AubBWaM0F5B7kkcR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245862715"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="245862715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 07:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="650721408"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2022 07:19:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Delete perf-with-kcore.sh script
Date:   Wed, 27 Apr 2022 17:19:46 +0300
Message-Id: <20220427141946.269523-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been obsolete since the introduction of the perf record --kcore
option.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/.gitignore         |   1 -
 tools/perf/Makefile.perf      |   5 +-
 tools/perf/perf-with-kcore.sh | 247 ----------------------------------
 3 files changed, 1 insertion(+), 252 deletions(-)
 delete mode 100644 tools/perf/perf-with-kcore.sh

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 20b8ab984d5f..4b9c71faa01a 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -19,7 +19,6 @@ perf.data
 perf.data.old
 output.svg
 perf-archive
-perf-with-kcore
 perf-iostat
 tags
 TAGS
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 69473a836bae..6e5aded855cc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -286,7 +286,6 @@ PYRF_OBJS =
 SCRIPT_SH =
 
 SCRIPT_SH += perf-archive.sh
-SCRIPT_SH += perf-with-kcore.sh
 SCRIPT_SH += perf-iostat.sh
 
 grep-libs = $(filter -l%,$(1))
@@ -973,8 +972,6 @@ ifndef NO_LIBBPF
 endif
 	$(call QUIET_INSTALL, perf-archive) \
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
-	$(call QUIET_INSTALL, perf-with-kcore) \
-		$(INSTALL) $(OUTPUT)perf-with-kcore -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-iostat) \
 		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBAUDIT
@@ -1088,7 +1085,7 @@ bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
 clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
-	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
+	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(OUTPUT)$(LIBJVMTI).so
diff --git a/tools/perf/perf-with-kcore.sh b/tools/perf/perf-with-kcore.sh
deleted file mode 100644
index 0b96545c8184..000000000000
--- a/tools/perf/perf-with-kcore.sh
+++ /dev/null
@@ -1,247 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0-only
-# perf-with-kcore: use perf with a copy of kcore
-# Copyright (c) 2014, Intel Corporation.
-#
-
-set -e
-
-usage()
-{
-        echo "Usage: perf-with-kcore <perf sub-command> <perf.data directory> [<sub-command options> [ -- <workload>]]" >&2
-        echo "       <perf sub-command> can be record, script, report or inject" >&2
-        echo "   or: perf-with-kcore fix_buildid_cache_permissions" >&2
-        exit 1
-}
-
-find_perf()
-{
-	if [ -n "$PERF" ] ; then
-		return
-	fi
-	PERF=`which perf || true`
-	if [ -z "$PERF" ] ; then
-		echo "Failed to find perf" >&2
-	        exit 1
-	fi
-	if [ ! -x "$PERF" ] ; then
-		echo "Failed to find perf" >&2
-	        exit 1
-	fi
-	echo "Using $PERF"
-	"$PERF" version
-}
-
-copy_kcore()
-{
-	echo "Copying kcore"
-
-	if [ $EUID -eq 0 ] ; then
-		SUDO=""
-	else
-		SUDO="sudo"
-	fi
-
-	rm -f perf.data.junk
-	("$PERF" record -o perf.data.junk "${PERF_OPTIONS[@]}" -- sleep 60) >/dev/null 2>/dev/null &
-	PERF_PID=$!
-
-	# Need to make sure that perf has started
-	sleep 1
-
-	KCORE=$(($SUDO "$PERF" buildid-cache -v -f -k /proc/kcore >/dev/null) 2>&1)
-	case "$KCORE" in
-	"kcore added to build-id cache directory "*)
-		KCORE_DIR=${KCORE#"kcore added to build-id cache directory "}
-	;;
-	*)
-		kill $PERF_PID
-		wait >/dev/null 2>/dev/null || true
-		rm perf.data.junk
-		echo "$KCORE"
-		echo "Failed to find kcore" >&2
-		exit 1
-	;;
-	esac
-
-	kill $PERF_PID
-	wait >/dev/null 2>/dev/null || true
-	rm perf.data.junk
-
-	$SUDO cp -a "$KCORE_DIR" "$(pwd)/$PERF_DATA_DIR"
-	$SUDO rm -f "$KCORE_DIR/kcore"
-	$SUDO rm -f "$KCORE_DIR/kallsyms"
-	$SUDO rm -f "$KCORE_DIR/modules"
-	$SUDO rmdir "$KCORE_DIR"
-
-	KCORE_DIR_BASENAME=$(basename "$KCORE_DIR")
-	KCORE_DIR="$(pwd)/$PERF_DATA_DIR/$KCORE_DIR_BASENAME"
-
-	$SUDO chown $UID "$KCORE_DIR"
-	$SUDO chown $UID "$KCORE_DIR/kcore"
-	$SUDO chown $UID "$KCORE_DIR/kallsyms"
-	$SUDO chown $UID "$KCORE_DIR/modules"
-
-	$SUDO chgrp $GROUPS "$KCORE_DIR"
-	$SUDO chgrp $GROUPS "$KCORE_DIR/kcore"
-	$SUDO chgrp $GROUPS "$KCORE_DIR/kallsyms"
-	$SUDO chgrp $GROUPS "$KCORE_DIR/modules"
-
-	ln -s "$KCORE_DIR_BASENAME" "$PERF_DATA_DIR/kcore_dir"
-}
-
-fix_buildid_cache_permissions()
-{
-	if [ $EUID -ne 0 ] ; then
-		echo "This script must be run as root via sudo " >&2
-		exit 1
-	fi
-
-	if [ -z "$SUDO_USER" ] ; then
-		echo "This script must be run via sudo" >&2
-		exit 1
-	fi
-
-	USER_HOME=$(bash <<< "echo ~$SUDO_USER")
-
-	echo "Fixing buildid cache permissions"
-
-	find "$USER_HOME/.debug" -xdev -type d          ! -user "$SUDO_USER" -ls -exec chown    "$SUDO_USER" \{\} \;
-	find "$USER_HOME/.debug" -xdev -type f -links 1 ! -user "$SUDO_USER" -ls -exec chown    "$SUDO_USER" \{\} \;
-	find "$USER_HOME/.debug" -xdev -type l          ! -user "$SUDO_USER" -ls -exec chown -h "$SUDO_USER" \{\} \;
-
-	if [ -n "$SUDO_GID" ] ; then
-		find "$USER_HOME/.debug" -xdev -type d          ! -group "$SUDO_GID" -ls -exec chgrp    "$SUDO_GID" \{\} \;
-		find "$USER_HOME/.debug" -xdev -type f -links 1 ! -group "$SUDO_GID" -ls -exec chgrp    "$SUDO_GID" \{\} \;
-		find "$USER_HOME/.debug" -xdev -type l          ! -group "$SUDO_GID" -ls -exec chgrp -h "$SUDO_GID" \{\} \;
-	fi
-
-	echo "Done"
-}
-
-check_buildid_cache_permissions()
-{
-	if [ $EUID -eq 0 ] ; then
-		return
-	fi
-
-	PERMISSIONS_OK+=$(find "$HOME/.debug" -xdev -type d          ! -user "$USER" -print -quit)
-	PERMISSIONS_OK+=$(find "$HOME/.debug" -xdev -type f -links 1 ! -user "$USER" -print -quit)
-	PERMISSIONS_OK+=$(find "$HOME/.debug" -xdev -type l          ! -user "$USER" -print -quit)
-
-	PERMISSIONS_OK+=$(find "$HOME/.debug" -xdev -type d          ! -group "$GROUPS" -print -quit)
-	PERMISSIONS_OK+=$(find "$HOME/.debug" -xdev -type f -links 1 ! -group "$GROUPS" -print -quit)
-	PERMISSIONS_OK+=$(find "$HOME/.debug" -xdev -type l          ! -group "$GROUPS" -print -quit)
-
-	if [ -n "$PERMISSIONS_OK" ] ; then
-		echo "*** WARNING *** buildid cache permissions may need fixing" >&2
-	fi
-}
-
-record()
-{
-	echo "Recording"
-
-	if [ $EUID -ne 0 ] ; then
-
-		if [ "$(cat /proc/sys/kernel/kptr_restrict)" -ne 0 ] ; then
-			echo "*** WARNING *** /proc/sys/kernel/kptr_restrict prevents access to kernel addresses" >&2
-		fi
-
-		if echo "${PERF_OPTIONS[@]}" | grep -q ' -a \|^-a \| -a$\|^-a$\| --all-cpus \|^--all-cpus \| --all-cpus$\|^--all-cpus$' ; then
-			echo "*** WARNING *** system-wide tracing without root access will not be able to read all necessary information from /proc" >&2
-		fi
-
-		if echo "${PERF_OPTIONS[@]}" | grep -q 'intel_pt\|intel_bts\| -I\|^-I' ; then
-			if [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt -1 ] ; then
-				echo "*** WARNING *** /proc/sys/kernel/perf_event_paranoid restricts buffer size and tracepoint (sched_switch) use" >&2
-			fi
-
-			if echo "${PERF_OPTIONS[@]}" | grep -q ' --per-thread \|^--per-thread \| --per-thread$\|^--per-thread$' ; then
-				true
-			elif echo "${PERF_OPTIONS[@]}" | grep -q ' -t \|^-t \| -t$\|^-t$' ; then
-				true
-			elif [ ! -r /sys/kernel/debug -o ! -x /sys/kernel/debug ] ; then
-				echo "*** WARNING *** /sys/kernel/debug permissions prevent tracepoint (sched_switch) use" >&2
-			fi
-		fi
-	fi
-
-	if [ -z "$1" ] ; then
-		echo "Workload is required for recording" >&2
-		usage
-	fi
-
-	if [ -e "$PERF_DATA_DIR" ] ; then
-		echo "'$PERF_DATA_DIR' exists" >&2
-		exit 1
-	fi
-
-	find_perf
-
-	mkdir "$PERF_DATA_DIR"
-
-	echo "$PERF record -o $PERF_DATA_DIR/perf.data ${PERF_OPTIONS[@]} -- $@"
-	"$PERF" record -o "$PERF_DATA_DIR/perf.data" "${PERF_OPTIONS[@]}" -- "$@" || true
-
-	if rmdir "$PERF_DATA_DIR" > /dev/null 2>/dev/null ; then
-		exit 1
-	fi
-
-	copy_kcore
-
-	echo "Done"
-}
-
-subcommand()
-{
-	find_perf
-	check_buildid_cache_permissions
-	echo "$PERF $PERF_SUB_COMMAND -i $PERF_DATA_DIR/perf.data --kallsyms=$PERF_DATA_DIR/kcore_dir/kallsyms $@"
-	"$PERF" $PERF_SUB_COMMAND -i "$PERF_DATA_DIR/perf.data" "--kallsyms=$PERF_DATA_DIR/kcore_dir/kallsyms" "$@"
-}
-
-if [ "$1" = "fix_buildid_cache_permissions" ] ; then
-	fix_buildid_cache_permissions
-	exit 0
-fi
-
-PERF_SUB_COMMAND=$1
-PERF_DATA_DIR=$2
-shift || true
-shift || true
-
-if [ -z "$PERF_SUB_COMMAND" ] ; then
-	usage
-fi
-
-if [ -z "$PERF_DATA_DIR" ] ; then
-	usage
-fi
-
-case "$PERF_SUB_COMMAND" in
-"record")
-	while [ "$1" != "--" ] ; do
-		PERF_OPTIONS+=("$1")
-		shift || break
-	done
-	if [ "$1" != "--" ] ; then
-		echo "Options and workload are required for recording" >&2
-		usage
-	fi
-	shift
-	record "$@"
-;;
-"script")
-	subcommand "$@"
-;;
-"report")
-	subcommand "$@"
-;;
-"inject")
-	subcommand "$@"
-;;
-*)
-	usage
-;;
-esac
-- 
2.25.1

