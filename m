Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8868A4A60EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiBAQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:02:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38058 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiBAQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:02:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2831616FE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E930C340EB;
        Tue,  1 Feb 2022 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643731372;
        bh=kCT7QybfjrRPiV1axjPnt+wNgMzmHDrjh3ieLwp7+0I=;
        h=Date:From:To:Cc:Subject:From;
        b=V3wz/N625B5plwnCtonDEqEIB5IeGyjkPiPLh8zI4HZcCrzeaYGpWFMvh1V0het8R
         wDKfZbTsJJZmqT/5nmFeLzB90De297haywnULs6AAzLzL6DwYaGi+fEGfkXZquu6v0
         ENo6mlnsiSA1PF+JuEG8vyslOzbhnT595LwDYtNDo5Hw2hM49WvTFY7rDF7nxensQw
         i0xMSRRfqRyAXmv7QiGmMxcAdhwk+KYTBgTS1kTm8Ea283iodNsd1DK/y6omSfkxhV
         XhXn+GgX4c7C287cOf3F5umjpUtge3yKV/o2hQmonwkWGbypx6y/sDwHLePVc4Ycjj
         w/7fnnQWQ9FIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF6CB40466; Tue,  1 Feb 2022 13:02:49 -0300 (-03)
Date:   Tue, 1 Feb 2022 13:02:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Colin Cross <ccross@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf beauty: Make the prctl arg regexp more strict to
 cope with PR_SET_VMA
Message-ID: <YflZqY0rYQ3d1bKt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I'm carrying this on the perf tools tree:

---

This new PR_SET_VMA value isn't in sequence with all the other prctl
arguments and instead uses a big, 0x prefixed hex number: 0x53564d41 (S V M A).

This makes it harder to generate a string table as it would be rather
sparse, so make the regexp more stricter to avoid catching those.

A followup patch for 'perf trace' to cope with such oddities will be
needed, but then its a matter for the next merge window.

The next patch will update the prctl.h file to cope with this perf build
warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
  diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Here is the output of this script:

  $ tools/perf/trace/beauty/prctl_option.sh
  static const char *prctl_options[] = {
  	[1] = "SET_PDEATHSIG",
  	[2] = "GET_PDEATHSIG",
  	[3] = "GET_DUMPABLE",
  	[4] = "SET_DUMPABLE",
  	[5] = "GET_UNALIGN",
  	[6] = "SET_UNALIGN",
  	[7] = "GET_KEEPCAPS",
  	[8] = "SET_KEEPCAPS",
  	[9] = "GET_FPEMU",
  	[10] = "SET_FPEMU",
  	[11] = "GET_FPEXC",
  	[12] = "SET_FPEXC",
  	[13] = "GET_TIMING",
  	[14] = "SET_TIMING",
  	[15] = "SET_NAME",
  	[16] = "GET_NAME",
  	[19] = "GET_ENDIAN",
  	[20] = "SET_ENDIAN",
  	[21] = "GET_SECCOMP",
  	[22] = "SET_SECCOMP",
  	[23] = "CAPBSET_READ",
  	[24] = "CAPBSET_DROP",
  	[25] = "GET_TSC",
  	[26] = "SET_TSC",
  	[27] = "GET_SECUREBITS",
  	[28] = "SET_SECUREBITS",
  	[29] = "SET_TIMERSLACK",
  	[30] = "GET_TIMERSLACK",
  	[31] = "TASK_PERF_EVENTS_DISABLE",
  	[32] = "TASK_PERF_EVENTS_ENABLE",
  	[33] = "MCE_KILL",
  	[34] = "MCE_KILL_GET",
  	[35] = "SET_MM",
  	[36] = "SET_CHILD_SUBREAPER",
  	[37] = "GET_CHILD_SUBREAPER",
  	[38] = "SET_NO_NEW_PRIVS",
  	[39] = "GET_NO_NEW_PRIVS",
  	[40] = "GET_TID_ADDRESS",
  	[41] = "SET_THP_DISABLE",
  	[42] = "GET_THP_DISABLE",
  	[43] = "MPX_ENABLE_MANAGEMENT",
  	[44] = "MPX_DISABLE_MANAGEMENT",
  	[45] = "SET_FP_MODE",
  	[46] = "GET_FP_MODE",
  	[47] = "CAP_AMBIENT",
  	[50] = "SVE_SET_VL",
  	[51] = "SVE_GET_VL",
  	[52] = "GET_SPECULATION_CTRL",
  	[53] = "SET_SPECULATION_CTRL",
  	[54] = "PAC_RESET_KEYS",
  	[55] = "SET_TAGGED_ADDR_CTRL",
  	[56] = "GET_TAGGED_ADDR_CTRL",
  	[57] = "SET_IO_FLUSHER",
  	[58] = "GET_IO_FLUSHER",
  	[59] = "SET_SYSCALL_USER_DISPATCH",
  	[60] = "PAC_SET_ENABLED_KEYS",
  	[61] = "PAC_GET_ENABLED_KEYS",
  	[62] = "SCHED_CORE",
  };
  static const char *prctl_set_mm_options[] = {
  	[1] = "START_CODE",
  	[2] = "END_CODE",
  	[3] = "START_DATA",
  	[4] = "END_DATA",
  	[5] = "START_STACK",
  	[6] = "START_BRK",
  	[7] = "BRK",
  	[8] = "ARG_START",
  	[9] = "ARG_END",
  	[10] = "ENV_START",
  	[11] = "ENV_END",
  	[12] = "AUXV",
  	[13] = "EXE_FILE",
  	[14] = "MAP",
  	[15] = "MAP_SIZE",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Colin Cross <ccross@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl_option.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index 3109d7b05e113bb5..3d278785fe574a0e 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -4,7 +4,7 @@
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
-regex='^#define[[:space:]]+PR_(\w+)[[:space:]]*([[:xdigit:]]+).*'
+regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*\/.*)?$'
 egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
-- 
2.34.1

