Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652DF476118
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbhLOSwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbhLOSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:52:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB00C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:52:05 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id o4so21449543pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1WPEmR1sEOp0zeMUyXARV/HVQt4jiuKOO4s7xu6v28=;
        b=A0xaTiKazcnyTUWtYVxHbPnA/vLgBwhGD8gJfRoFs3f0yKrlMuKA6bBSpQXmbxNMn2
         oewv8DrHrpsZxuoGnarbV7qnJ0LjXZlCYCURsRPrKAeXuZODTrdjl0TCIeUXOaZtXNZl
         0nvHGJiMU5yr5uRMrZINVYplQye+RqTUCZMkbYM4svJCDPvIejOvjXkFr0ojja1RZIko
         WL1DJ19QCJWbgqU0hzG9bxIY8268J+XoyS6U86BAUDXlPuxQQPBTjvKTuzjQlBVoGBRX
         tlDdrQCwJ4V1xOKyoSlcmy4B65hBu4fLlznfgcRPTK1k7aaaLpkUtvxsoYzvubIQUAHb
         Wo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=A1WPEmR1sEOp0zeMUyXARV/HVQt4jiuKOO4s7xu6v28=;
        b=7L7sHKuSfbqQxyvZ/KRBMqN93jWgmdtRsaXe3gVxdOjMfSofyundp+2Qz/qRWj34rE
         +9tCtJYI8Be1IUSA+B/zFnDLtLK5mL3JOQsdUSXP4T2DFIO6MkjmMf5kLRToV4uJBDVW
         lyNgr9yNZt7in8Ix2q6QIqIh30aQPHji9niaUye5DQ4NTaaS2vP1Te/WOzC9v8CRQ4VS
         PKktxT9orXfrAdbU7lFld/JWyY/n/tbxJeRhhL34VaUrRjo1HZoWJhv3oBL/WvDX3bYj
         XC678m6AOhJOoX3fRA0HeIcT4Ov7R8Lpv8mhsJS5mkdqR1pVAlvOlg9lYPDHlKT5N40/
         l6Ag==
X-Gm-Message-State: AOAM530fTVmCFaeiDUidBBSDdC7MKTOlrMITH+Ath9AdRa+/4SVs3EeI
        9ypZ81vhTUWSVnYwlMRsuCI=
X-Google-Smtp-Source: ABdhPJwAyajT03W3oUyFtUYuwpiBgOd9/+yk2D7NROjNhcE1rewXyMb2FLZwmDujnvWS7IUP+UDESQ==
X-Received: by 2002:a63:a705:: with SMTP id d5mr8917279pgf.556.1639594325288;
        Wed, 15 Dec 2021 10:52:05 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b969:356c:bdef:8748])
        by smtp.gmail.com with ESMTPSA id f2sm3646428pfe.132.2021.12.15.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:52:04 -0800 (PST)
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
Subject: [PATCH 5/5] perf ftrace: Implement cpu and task filters in BPF
Date:   Wed, 15 Dec 2021 10:51:54 -0800
Message-Id: <20211215185154.360314-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211215185154.360314-1-namhyung@kernel.org>
References: <20211215185154.360314-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honor cpu and task options to set up filters (by pid or tid) in the
BPF program.  For example, the following command will show latency of
the mutex_lock for process 2570.

  # perf ftrace latency -b -T mutex_lock -p 2570 sleep 3
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |        675 | ############################## |
       1 - 2    us |          9 |                                |
       2 - 4    us |          0 |                                |
       4 - 8    us |          0 |                                |
       8 - 16   us |          0 |                                |
      16 - 32   us |          0 |                                |
      32 - 64   us |          0 |                                |
      64 - 128  us |          0 |                                |
     128 - 256  us |          0 |                                |
     256 - 512  us |          0 |                                |
     512 - 1024 us |          0 |                                |
       1 - 2    ms |          0 |                                |
       2 - 4    ms |          0 |                                |
       4 - 8    ms |          0 |                                |
       8 - 16   ms |          0 |                                |
      16 - 32   ms |          0 |                                |
      32 - 64   ms |          0 |                                |
      64 - 128  ms |          0 |                                |
     128 - 256  ms |          0 |                                |
     256 - 512  ms |          0 |                                |
     512 - 1024 ms |          0 |                                |
       1 - ...   s |          0 |                                |

Committer testing:

Looking at faults on a firefox process:

  # strace -e bpf perf ftrace latency -b -p 1674378 -T __handle_mm_fault
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffee1fee740, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\20\0\0\0\20\0\0\0\5\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=45, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\08\0\0\08\0\0\0\t\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=89, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\f\0\0\0\f\0\0\0\7\0\0\0\1\0\0\0\0\0\0\20"..., btf_log_buf=NULL, btf_size=43, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\5\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=77, btf_log_size=0, btf_log_level=0}, 128) = -1 EINVAL (Invalid argument)
  bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0 \3\0\0 \3\0\0\306\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1790, btf_log_size=0, btf_log_level=0}, 128) = 3
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=32, max_entries=1, map_flags=0, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 4
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=5, insns=0x7ffee1fee570, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 5
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 4
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffee1fee3c0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="test", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 4
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=8, value_size=8, max_entries=10000, map_flags=0, inner_map_fd=0, map_name="functime", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 4
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=1, max_entries=1, map_flags=0, inner_map_fd=0, map_name="cpu_filter", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 5
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=1, max_entries=36, map_flags=0, inner_map_fd=0, map_name="task_filter", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 6
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=8, max_entries=22, map_flags=0, inner_map_fd=0, map_name="latency", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 128) = 7
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=12, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="func_lat.bss", map_ifindex=0, btf_fd=3, btf_key_type_id=0, btf_value_type_id=32, btf_vmlinux_value_type_id=0}, 128) = 8
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=8, key=0x7ffee1fee580, value=0x7f01d940a000, flags=BPF_ANY}, 128) = 0
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_KPROBE, insn_cnt=42, insns=0x1871f30, license="", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 14, 16), prog_flags=0, prog_name="func_begin", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=3, func_info_rec_size=8, func_info=0x18746a0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1874550, line_info_cnt=20, attach_btf_id=0, attach_prog_fd=0}, 128) = 9
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_KPROBE, insn_cnt=99, insns=0x18769b0, license="", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 14, 16), prog_flags=0, prog_name="func_end", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=3, func_info_rec_size=8, func_info=0x188a640, func_info_cnt=1, line_info_rec_size=16, line_info=0x188a660, line_info_cnt=20, attach_btf_id=0, attach_prog_fd=0}, 128) = 10
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0x7ffee1fee8e0, value=0x7ffee1fee8df, flags=BPF_ANY}, 128) = 0
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=2, insns=0x7ffee1fee3c0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 128) = 12
  bpf(BPF_LINK_CREATE, {link_create={prog_fd=12, target_fd=-1, attach_type=0x29 /* BPF_??? */, flags=0}}, 128) = -1 EINVAL (Invalid argument)
  ^Cstrace: Process 1702285 detached
  #   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |        109 | #################                              |
       1 - 2    us |        127 | ###################                            |
       2 - 4    us |         36 | #####                                          |
       4 - 8    us |         20 | ###                                            |
       8 - 16   us |          2 |                                                |
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
Link: https://lore.kernel.org/r/20211129231830.1117781-6-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_ftrace.c                | 42 ++++++++++++++++++++-
 tools/perf/util/bpf_skel/func_latency.bpf.c | 21 +++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index ec4e2f5a2fc4..f00a2de6778c 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -7,7 +7,9 @@
 
 #include "util/ftrace.h"
 #include "util/cpumap.h"
+#include "util/thread_map.h"
 #include "util/debug.h"
+#include "util/evlist.h"
 #include "util/bpf_counter.h"
 
 #include "util/bpf_skel/func_latency.skel.h"
@@ -16,7 +18,8 @@ static struct func_latency_bpf *skel;
 
 int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 {
-	int err;
+	int fd, err;
+	int i, ncpus = 1, ntasks = 1;
 	struct filter_entry *func;
 
 	if (!list_is_singular(&ftrace->filters)) {
@@ -33,6 +36,17 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
+	/* don't need to set cpu filter for system-wide mode */
+	if (ftrace->target.cpu_list) {
+		ncpus = perf_cpu_map__nr(ftrace->evlist->core.cpus);
+		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+	}
+
+	if (target__has_task(&ftrace->target) || target__none(&ftrace->target)) {
+		ntasks = perf_thread_map__nr(ftrace->evlist->core.threads);
+		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+	}
+
 	set_max_rlimit();
 
 	err = func_latency_bpf__load(skel);
@@ -41,6 +55,32 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		goto out;
 	}
 
+	if (ftrace->target.cpu_list) {
+		u32 cpu;
+		u8 val = 1;
+
+		skel->bss->has_cpu = 1;
+		fd = bpf_map__fd(skel->maps.cpu_filter);
+
+		for (i = 0; i < ncpus; i++) {
+			cpu = cpu_map__cpu(ftrace->evlist->core.cpus, i);
+			bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
+		}
+	}
+
+	if (target__has_task(&ftrace->target) || target__none(&ftrace->target)) {
+		u32 pid;
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+
+		for (i = 0; i < ntasks; i++) {
+			pid = perf_thread_map__pid(ftrace->evlist->core.threads, i);
+			bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
+		}
+	}
+
 	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
 							    false, func->name);
 	if (IS_ERR(skel->links.func_begin)) {
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index ccd96b09fc42..ea94187fe443 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -37,6 +37,8 @@ struct {
 
 
 int enabled = 0;
+int has_cpu = 0;
+int has_task = 0;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -47,6 +49,25 @@ int BPF_PROG(func_begin)
 		return 0;
 
 	key = bpf_get_current_pid_tgid();
+
+	if (has_cpu) {
+		__u32 cpu = bpf_get_smp_processor_id();
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+	}
+
+	if (has_task) {
+		__u32 pid = key & 0xffffffff;
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+	}
+
 	now = bpf_ktime_get_ns();
 
 	// overwrite timestamp for nested functions
-- 
2.34.1.173.g76aa8bc2d0-goog

