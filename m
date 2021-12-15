Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DC476117
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbhLOSwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbhLOSwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:52:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A024C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:52:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x131so21454533pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFjKLFuX4uaDelvgrdJKxyIkgdk1dtjYVwEUL39uS94=;
        b=cszCY2gqs7nCcyOKNKlcPEDyJn0HhKeCHDHbD1hIRRKlYZrH15E7q9+aryJ4YT25aG
         QLk8KTW9C4GoKTlNkM0JmSYiqUEDOknSQA/WcCCTszN/zI3HrANSV7UI5SVeHbooYUw6
         sECk0T3BR1okobepObuD4Ch6499EJcVwyhWVu814eWyoTD+IkfvT5qwEaDtIujRBfDiZ
         1NEfoV5JD+5TeMRf5FHpI9rHk7LV6OT7diYHYvcJiuUBY8TLfaSnQIjqegXeMKHawAxl
         OFBqebYciN8DP6f1bp7Q60gGTRw3tbd2YDPNvPQfDOgj1xSy5rnfOSQ1Pf6K3rFFZuNn
         WM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tFjKLFuX4uaDelvgrdJKxyIkgdk1dtjYVwEUL39uS94=;
        b=Kz3MCwWaoGq6UIOlz14/O1Gow61M6TsLQp4n0gtyNrQbriEUpJ2t0vKHRhLFW6TrMy
         cIkt0CwtH7bwGrWD0SnNkE9F656q3RhTL2l5PeJTcebpcIituNvBiFVtFEIXwspIyE3b
         dPNzMQWzc6nnlFb423MIGii84B+CO60Q2LWEaVNYDrpHQo6osjUToQ/eDhQHIsxp4+uJ
         gquZhUvT5Pw6Xre0iLf8jKW701JpzpWeRi5G9juIDyv6ntREW7GhBZIM/i8pXNTYPoJJ
         Gn/I1yMAZLsqIehSAofOR5+dxI/uGYi2vOVv8ol82FsC4YG98dQszaio6YbogVIDGL2H
         Zy9A==
X-Gm-Message-State: AOAM532TRI2VWG21k4GAJ/rchvHbEOW/StDw4GCSBwhUYnJJ7SlnuHYE
        juFc4pPEA/ew47La58v03DE=
X-Google-Smtp-Source: ABdhPJzeARkqxdEVFA8gQLu7eEwgECIytGIBDu2YcGD7WygEUKua/l0arrwAqqQHScatr9uioEU1cw==
X-Received: by 2002:a05:6a00:c95:b0:49f:c8de:9ae7 with SMTP id a21-20020a056a000c9500b0049fc8de9ae7mr10262303pfv.30.1639594323550;
        Wed, 15 Dec 2021 10:52:03 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b969:356c:bdef:8748])
        by smtp.gmail.com with ESMTPSA id f2sm3646428pfe.132.2021.12.15.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:52:03 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Changbin Du <changbin.du@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency subcommand
Date:   Wed, 15 Dec 2021 10:51:53 -0800
Message-Id: <20211215185154.360314-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211215185154.360314-1-namhyung@kernel.org>
References: <20211215185154.360314-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -b/--use-bpf option is to use BPF to get latency info of kernel
functions.  It'd have better performance impact and I observed that
latency of same function is smaller than before when using BPF.

Committer testing:

  # strace -e bpf perf ftrace latency -b -T __handle_mm_fault -a sleep 1
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7fff51914e00, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\20\0\0\0\20\0\0\0\5\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=45, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\08\0\0\08\0\0\0\t\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=89, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\f\0\0\0\f\0\0\0\7\0\0\0\1\0\0\0\0\0\0\20"..., btf_log_buf=NULL, btf_size=43, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\5\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=77, btf_log_size=0, btf_log_level=0}, 128) = -1 EINVAL (Invalid argument)
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\350\2\0\0\350\2\0\0\353\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1515, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=32, max_entries=1, map_flags=0, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 4
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=5, insns=0x7fff51914c30, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 5
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 4
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7fff51914a80, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="test", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 4
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=8, value_size=8, max_entries=10000, map_flags=0, inner_map_fd=0, map_name="functime", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 4
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=1, max_entries=1, map_flags=0, inner_map_fd=0, map_name="cpu_filter", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 5
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=1, max_entries=1, map_flags=0, inner_map_fd=0, map_name="task_filter", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 7
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=8, max_entries=22, map_flags=0, inner_map_fd=0, map_name="latency", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 8
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="func_lat.bss", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=30, btf_vmlinux_value_type_id=0}, 128) = 9
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=9, key=0x7fff51914c40, value=0x7f6e99be2000, flags=BPF_ANY}, 128) = 0
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_KPROBE, insn_cnt=18, insns=0x11e4160, license="", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 14, 16), prog_flags=0, prog_name="func_begin", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=3, func_info_rec_size=8, func_info=0x11dfc50, func_info_cnt=1, line_info_rec_size=16, line_info=0x11e04c0, line_info_cnt=9, attach_btf_id=0, attach_prog_fd=0}, 128) = 10
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_KPROBE, insn_cnt=99, insns=0x11ded70, license="", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 14, 16), prog_flags=0, prog_name="func_end", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=3, func_info_rec_size=8, func_info=0x11dfc70, func_info_cnt=1, line_info_rec_size=16, line_info=0x11f6e10, line_info_cnt=20, attach_btf_id=0, attach_prog_fd=0}, 128) = 11
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=2, insns=0x7fff51914a80, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 13
  bpf(BPF_LINK_CREATE, {link_create={prog_fd=13, target_fd=-1, attach_type=0x29 /* BPF_??? */, flags=0}}, 128) = -1 EINVAL (Invalid argument)
  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=1699992, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=8, key=0x7fff51914f84, value=0x11f6fa0, flags=BPF_ANY}, 128) = 0
  #   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |         52 | ###################                            |
       1 - 2    us |         36 | #############                                  |
       2 - 4    us |         24 | #########                                      |
       4 - 8    us |          7 | ##                                             |
       8 - 16   us |          1 |                                                |
      16 - 32   us |          0 |                                                |
      32 - 64   us |          0 |                                                |
      64 - 128  us |          0 |                                                |
     128 - 256  us |          0 |                                                |
     256 - 512  us |          0 |                                                |
     512 - 1024 us |          0 |                                                |
       1 - 2    ms |          0 |                                                |
       2 - 4    ms |          0 |                                                |
       4 - 8    ms |          0 |                                                |
       8 - 16   ms |          0 |                                                |
      16 - 32   ms |          0 |                                                |
      32 - 64   ms |          0 |                                                |
      64 - 128  ms |          0 |                                                |
     128 - 256  ms |          0 |                                                |
     256 - 512  ms |          0 |                                                |
     512 - 1024 ms |          0 |                                                |
       1 - ...   s |          0 |                                                |
  +++ exited with 0 +++
  #

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/r/20211129231830.1117781-5-namhyung@kernel.org
[ Add missing util/cpumap.h include and removed unused 'fd' variable ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                    |   2 +-
 tools/perf/builtin-ftrace.c                 | 158 ++++++++++++--------
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_ftrace.c                | 112 ++++++++++++++
 tools/perf/util/bpf_skel/func_latency.bpf.c |  93 ++++++++++++
 tools/perf/util/ftrace.h                    |  81 ++++++++++
 6 files changed, 380 insertions(+), 67 deletions(-)
 create mode 100644 tools/perf/util/bpf_ftrace.c
 create mode 100644 tools/perf/util/bpf_skel/func_latency.bpf.c
 create mode 100644 tools/perf/util/ftrace.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 164a37523781..ac861e42c8f7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1041,7 +1041,7 @@ SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
 SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
-SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h
+SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 
 $(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8fd3c9c44c69..2b54e2ddc80a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -30,36 +30,12 @@
 #include "strfilter.h"
 #include "util/cap.h"
 #include "util/config.h"
+#include "util/ftrace.h"
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
 
 #define DEFAULT_TRACER  "function_graph"
 
-struct perf_ftrace {
-	struct evlist		*evlist;
-	struct target		target;
-	const char		*tracer;
-	struct list_head	filters;
-	struct list_head	notrace;
-	struct list_head	graph_funcs;
-	struct list_head	nograph_funcs;
-	int			graph_depth;
-	unsigned long		percpu_buffer_size;
-	bool			inherit;
-	int			func_stack_trace;
-	int			func_irq_info;
-	int			graph_nosleep_time;
-	int			graph_noirqs;
-	int			graph_verbose;
-	int			graph_thresh;
-	unsigned int		initial_delay;
-};
-
-struct filter_entry {
-	struct list_head	list;
-	char			name[];
-};
-
 static volatile int workload_exec_errno;
 static bool done;
 
@@ -704,8 +680,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
-#define NUM_BUCKET  22  /* 20 + 2 (for outliers in both direction) */
-
 static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf)
 {
 	char *p, *q;
@@ -816,69 +790,116 @@ static void display_histogram(int buckets[])
 
 }
 
-static int __cmd_latency(struct perf_ftrace *ftrace)
+static int prepare_func_latency(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
-	int trace_fd;
-	char buf[4096];
-	char line[256];
-	struct pollfd pollfd = {
-		.events = POLLIN,
-	};
-	int buckets[NUM_BUCKET] = { };
+	int fd;
 
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_prepare_bpf(ftrace);
 
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
-		goto out;
+		return -1;
 	}
 
 	/* reset ftrace buffer */
 	if (write_tracing_file("trace", "0") < 0)
-		goto out;
+		return -1;
 
 	if (set_tracing_options(ftrace) < 0)
-		goto out_reset;
+		return -1;
 
 	/* force to use the function_graph tracer to track duration */
 	if (write_tracing_file("current_tracer", "function_graph") < 0) {
 		pr_err("failed to set current_tracer to function_graph\n");
-		goto out_reset;
+		return -1;
 	}
 
 	trace_file = get_tracing_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		return -1;
 	}
 
-	trace_fd = open(trace_file, O_RDONLY);
+	fd = open(trace_file, O_RDONLY);
+	if (fd < 0)
+		pr_err("failed to open trace_pipe\n");
 
 	put_tracing_file(trace_file);
+	return fd;
+}
 
-	if (trace_fd < 0) {
-		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+static int start_func_latency(struct perf_ftrace *ftrace)
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_start_bpf(ftrace);
+
+	if (write_tracing_file("tracing_on", "1") < 0) {
+		pr_err("can't enable tracing\n");
+		return -1;
 	}
 
+	return 0;
+}
+
+static int stop_func_latency(struct perf_ftrace *ftrace)
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_stop_bpf(ftrace);
+
+	write_tracing_file("tracing_on", "0");
+	return 0;
+}
+
+static int read_func_latency(struct perf_ftrace *ftrace, int buckets[])
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_read_bpf(ftrace, buckets);
+
+	return 0;
+}
+
+static int cleanup_func_latency(struct perf_ftrace *ftrace)
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_cleanup_bpf(ftrace);
+
+	reset_tracing_files(ftrace);
+	return 0;
+}
+
+static int __cmd_latency(struct perf_ftrace *ftrace)
+{
+	int trace_fd;
+	char buf[4096];
+	char line[256];
+	struct pollfd pollfd = {
+		.events = POLLIN,
+	};
+	int buckets[NUM_BUCKET] = { };
+
+	if (!(perf_cap__capable(CAP_PERFMON) ||
+	      perf_cap__capable(CAP_SYS_ADMIN))) {
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
+		return -1;
+	}
+
+	trace_fd = prepare_func_latency(ftrace);
+	if (trace_fd < 0)
+		goto out;
+
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
 	pollfd.fd = trace_fd;
 
-	if (write_tracing_file("tracing_on", "1") < 0) {
-		pr_err("can't enable tracing\n");
-		goto out_close_fd;
-	}
+	if (start_func_latency(ftrace) < 0)
+		goto out;
 
 	evlist__start_workload(ftrace->evlist);
 
@@ -896,29 +917,30 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 		}
 	}
 
-	write_tracing_file("tracing_on", "0");
+	stop_func_latency(ftrace);
 
 	if (workload_exec_errno) {
 		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
 		pr_err("workload failed: %s\n", emsg);
-		goto out_close_fd;
+		goto out;
 	}
 
 	/* read remaining buffer contents */
-	while (true) {
+	while (!ftrace->target.use_bpf) {
 		int n = read(trace_fd, buf, sizeof(buf) - 1);
 		if (n <= 0)
 			break;
 		make_histogram(buckets, buf, n, line);
 	}
 
+	read_func_latency(ftrace, buckets);
+
 	display_histogram(buckets);
 
-out_close_fd:
-	close(trace_fd);
-out_reset:
-	reset_tracing_files(ftrace);
 out:
+	close(trace_fd);
+	cleanup_func_latency(ftrace);
+
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
@@ -1144,6 +1166,10 @@ int cmd_ftrace(int argc, const char **argv)
 	const struct option latency_options[] = {
 	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
 		     "Show latency of given function", parse_filter_func),
+#ifdef HAVE_BPF_SKEL
+	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
+		    "Use BPF to measure function latency"),
+#endif
 	OPT_PARENT(common_options),
 	};
 	const struct option *options = ftrace_options;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2e5bfbb69960..294b12430d73 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -144,6 +144,7 @@ perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
+perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
new file mode 100644
index 000000000000..ec4e2f5a2fc4
--- /dev/null
+++ b/tools/perf/util/bpf_ftrace.c
@@ -0,0 +1,112 @@
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+#include <linux/err.h>
+
+#include "util/ftrace.h"
+#include "util/cpumap.h"
+#include "util/debug.h"
+#include "util/bpf_counter.h"
+
+#include "util/bpf_skel/func_latency.skel.h"
+
+static struct func_latency_bpf *skel;
+
+int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
+{
+	int err;
+	struct filter_entry *func;
+
+	if (!list_is_singular(&ftrace->filters)) {
+		pr_err("ERROR: %s target function(s).\n",
+		       list_empty(&ftrace->filters) ? "No" : "Too many");
+		return -1;
+	}
+
+	func = list_first_entry(&ftrace->filters, struct filter_entry, list);
+
+	skel = func_latency_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open func latency skeleton\n");
+		return -1;
+	}
+
+	set_max_rlimit();
+
+	err = func_latency_bpf__load(skel);
+	if (err) {
+		pr_err("Failed to load func latency skeleton\n");
+		goto out;
+	}
+
+	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
+							    false, func->name);
+	if (IS_ERR(skel->links.func_begin)) {
+		pr_err("Failed to attach fentry program\n");
+		err = PTR_ERR(skel->links.func_begin);
+		goto out;
+	}
+
+	skel->links.func_end = bpf_program__attach_kprobe(skel->progs.func_end,
+							  true, func->name);
+	if (IS_ERR(skel->links.func_end)) {
+		pr_err("Failed to attach fexit program\n");
+		err = PTR_ERR(skel->links.func_end);
+		goto out;
+	}
+
+	/* XXX: we don't actually use this fd - just for poll() */
+	return open("/dev/null", O_RDONLY);
+
+out:
+	return err;
+}
+
+int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	skel->bss->enabled = 1;
+	return 0;
+}
+
+int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	skel->bss->enabled = 0;
+	return 0;
+}
+
+int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
+				  int buckets[])
+{
+	int i, fd, err;
+	u32 idx;
+	u64 *hist;
+	int ncpus = cpu__max_cpu();
+
+	fd = bpf_map__fd(skel->maps.latency);
+
+	hist = calloc(ncpus, sizeof(*hist));
+	if (hist == NULL)
+		return -ENOMEM;
+
+	for (idx = 0; idx < NUM_BUCKET; idx++) {
+		err = bpf_map_lookup_elem(fd, &idx, hist);
+		if (err) {
+			buckets[idx] = 0;
+			continue;
+		}
+
+		for (i = 0; i < ncpus; i++)
+			buckets[idx] += hist[i];
+	}
+
+	free(hist);
+	return 0;
+}
+
+int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	func_latency_bpf__destroy(skel);
+	return 0;
+}
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
new file mode 100644
index 000000000000..ccd96b09fc42
--- /dev/null
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2021 Google
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+// This should be in sync with "util/ftrace.h"
+#define NUM_BUCKET  22
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 10000);
+} functime SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} cpu_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} task_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, NUM_BUCKET);
+} latency SEC(".maps");
+
+
+int enabled = 0;
+
+SEC("kprobe/func")
+int BPF_PROG(func_begin)
+{
+	__u64 key, now;
+
+	if (!enabled)
+		return 0;
+
+	key = bpf_get_current_pid_tgid();
+	now = bpf_ktime_get_ns();
+
+	// overwrite timestamp for nested functions
+	bpf_map_update_elem(&functime, &key, &now, BPF_ANY);
+	return 0;
+}
+
+SEC("kretprobe/func")
+int BPF_PROG(func_end)
+{
+	__u64 tid;
+	__u64 *start;
+
+	if (!enabled)
+		return 0;
+
+	tid = bpf_get_current_pid_tgid();
+
+	start = bpf_map_lookup_elem(&functime, &tid);
+	if (start) {
+		__s64 delta = bpf_ktime_get_ns() - *start;
+		__u32 key;
+		__u64 *hist;
+
+		bpf_map_delete_elem(&functime, &tid);
+
+		if (delta < 0)
+			return 0;
+
+		// calculate index using delta in usec
+		for (key = 0; key < (NUM_BUCKET - 1); key++) {
+			if (delta < ((1000UL) << key))
+				break;
+		}
+
+		hist = bpf_map_lookup_elem(&latency, &key);
+		if (!hist)
+			return 0;
+
+		*hist += 1;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
new file mode 100644
index 000000000000..887f68a185f7
--- /dev/null
+++ b/tools/perf/util/ftrace.h
@@ -0,0 +1,81 @@
+#ifndef __PERF_FTRACE_H__
+#define __PERF_FTRACE_H__
+
+#include <linux/list.h>
+
+#include "target.h"
+
+struct evlist;
+
+struct perf_ftrace {
+	struct evlist		*evlist;
+	struct target		target;
+	const char		*tracer;
+	struct list_head	filters;
+	struct list_head	notrace;
+	struct list_head	graph_funcs;
+	struct list_head	nograph_funcs;
+	unsigned long		percpu_buffer_size;
+	bool			inherit;
+	int			graph_depth;
+	int			func_stack_trace;
+	int			func_irq_info;
+	int			graph_nosleep_time;
+	int			graph_noirqs;
+	int			graph_verbose;
+	int			graph_thresh;
+	unsigned int		initial_delay;
+};
+
+struct filter_entry {
+	struct list_head	list;
+	char			name[];
+};
+
+#define NUM_BUCKET  22  /* 20 + 2 (for outliers in both direction) */
+
+#ifdef HAVE_BPF_SKEL
+
+int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace);
+int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace);
+int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace);
+int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
+				  int buckets[]);
+int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace);
+
+#else  /* !HAVE_BPF_SKEL */
+
+static inline int
+perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
+			      int buckets[] __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+#endif  /* HAVE_BPF_SKEL */
+
+#endif  /* __PERF_FTRACE_H__ */
-- 
2.34.1.173.g76aa8bc2d0-goog

