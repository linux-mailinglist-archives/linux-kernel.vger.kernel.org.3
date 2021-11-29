Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B74462826
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhK2XVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhK2XVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:21:51 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AF1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 8so18564215pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+uR2HHqWw2zxt6EFtlx4KZ9cOz9+dmrG6vRUgKtbvHY=;
        b=QgR/kpWalsPXEJCq3vuiTpY1GwWJ0/slXRM/nmvrSqgIkD0QKVoib3Luds+cEc2hpT
         1or1f78CudHFZsQKB6HQb54Olp0wjGnnIFvvcZLemz1Uc7rYh2BQhaNzavT7SkQ6c45+
         Mqj37L6l1XeoGva7wz40NkyG5lK5iB4XEIQkHao690XTYAMBeyyYenehlMSZV0vN2WJZ
         NUu4ZoXmXe0+R7DAZPlWhODgwfs+nUZbM3Lfb1Ws0x0amnj8k17NZ4gvLvxW7eJHL55L
         cAKutkjHHUOfQL3YoFDje0Gy1+KB7NN+mNv1EYsEfcXF1lOvecVy+tOMtX8ydTyNdQti
         uHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+uR2HHqWw2zxt6EFtlx4KZ9cOz9+dmrG6vRUgKtbvHY=;
        b=GqY5GgnoNL6XdsZD2ye8rcg0LrHhUSamlPmyYx6eu9Wdm6yJ9b2GkTGElrbuLjepgE
         Osa6anAAKK5dtmm1ocvbSZ0pEDS5wW1oltwQHRgF9nLTVNgsjtyUR8cfwb8EOsxzVsLN
         Rw/wsrndhXUBIldXWiKxAXa/fWaGcmdiv9jcz4gNuGbbGOOXtLSoZOcfx1kx3qxaxeJD
         g1ADawHPWQbsEL01e2j7MWMSUoJy78gRhrB+0GkM85dpu9KolYZ+TBeHsQt2H5mLRqCq
         4GH5Ixdo7BXoLUWwFtuDKjRrxQGwzpRNTOz0+2o5WQuDu2cjTcArEVWubs9P6igM3Y2P
         NMEQ==
X-Gm-Message-State: AOAM530oSwVIgj6ATbMZ2q32s4VBtfoC2iUBxvyVt/bbJ66cuZqHFId/
        wONZeuMqlgXn3RbRl2kb080=
X-Google-Smtp-Source: ABdhPJzykeR1spiez7xS7BaUP6XytU4fLObih8ReLcdfwUykJi5AqwaiQ3Rtnp6EYyejDV9gf6u36Q==
X-Received: by 2002:a63:84c3:: with SMTP id k186mr37600569pgd.390.1638227912636;
        Mon, 29 Nov 2021 15:18:32 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:7f54:1f52:ae81:8c78])
        by smtp.gmail.com with ESMTPSA id j7sm18334762pfu.164.2021.11.29.15.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:18:32 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency histogram (v1)
Date:   Mon, 29 Nov 2021 15:18:25 -0800
Message-Id: <20211129231830.1117781-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've implemented 'latency' subcommand in the perf ftrace command to
show a histogram of function latency.

To handle new subcommands, the existing functionality is moved to
'trace' subcommand while preserving backward compatibility of not
having a subcommand at all (defaults to 'trace').

The latency subcommand accepts a target (kernel, for now) function
with -T option and shows a histogram like below:

  $ sudo ./perf ftrace latency -a -T mutex_lock sleep 1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |       2686 | ######################                         |
       1 - 2    us |        976 | ########                                       |
       2 - 4    us |        879 | #######                                        |
       4 - 8    us |        481 | ####                                           |
       8 - 16   us |        445 | ###                                            |
      16 - 32   us |          1 |                                                |
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
  
It basically use the function graph tracer to extract the duration of
the function.  But with -b/--use-bpf option, it can use BPF to save
the histogram in the kernel.  For the same function, it gets:

  $ sudo ./perf ftrace latency -a -b -T mutex_lock sleep 1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |       4682 | #############################################  |
       1 - 2    us |         11 |                                                |
       2 - 4    us |          0 |                                                |
       4 - 8    us |          0 |                                                |
       8 - 16   us |          7 |                                                |
      16 - 32   us |          6 |                                                |
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


You can get the patches at 'perf/ftrace-latency-v1' branch on

  https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (5):
  perf ftrace: Add 'trace' subcommand
  perf ftrace: Move out common code from __cmd_ftrace
  perf ftrace: Add 'latency' subcommand
  perf ftrace: Add -b/--use-bpf option for latency subcommand
  perf ftrace: Implement cpu and task filters in BPF

 tools/perf/Makefile.perf                    |   2 +-
 tools/perf/builtin-ftrace.c                 | 443 +++++++++++++++++---
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_ftrace.c                | 154 +++++++
 tools/perf/util/bpf_skel/func_latency.bpf.c | 113 +++++
 tools/perf/util/ftrace.h                    |  81 ++++
 6 files changed, 724 insertions(+), 70 deletions(-)
 create mode 100644 tools/perf/util/bpf_ftrace.c
 create mode 100644 tools/perf/util/bpf_skel/func_latency.bpf.c
 create mode 100644 tools/perf/util/ftrace.h


base-commit: 8ab774587903771821b59471cc723bba6d893942
-- 
2.34.0.rc2.393.gf8c9666880-goog

