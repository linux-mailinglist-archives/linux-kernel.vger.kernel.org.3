Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DCA476113
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbhLOSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbhLOSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:51:57 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:51:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n8so17289181plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOdsFjL1I0j9Ydntnm5JuGDKpYSeJY/sKkejAilI0O4=;
        b=W0PdHJAD/nvmbhiEPxQwewW42CEdhOQeCnNV7FNMjRdCvzy3//bRmf3/1DQZ+jMo75
         D0bcmL1+8PjDS7RVuf3baX7hUCZBLKYS3wDyNtdmafXownq3lOZraGeAuVOJpTfrpehX
         eAhyoiXWH3LB9LzdggFNs1hPX8caiJJt9HFq+td0+o9dJllDqq5Ds5bo7nh5Kz5dI37O
         jmkvP86ecWv+/1Ph/MOxCTT4lavKGbFBf8b2ZMegXrvKy2IDCxBXwMlipK2Wrd321BlZ
         tLOSoY3DcCLep1bC22J6Ttld5h0ebFuaNBxwtZ1sW/NjBOADufD1DcMwG17k1dDqJM2U
         fdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nOdsFjL1I0j9Ydntnm5JuGDKpYSeJY/sKkejAilI0O4=;
        b=8CKuKcWRuCQ0wAwOHolGW8JiKzf/qLZg0ZidMN06ZdlroXOF++8BWHDbrTDaMmAZPR
         E0CVBY5ffU4P8Hq0MERBCiyEsz8HP02woBS0wNZW59ZWd3hJvAveUAcV4vVHsyfh5+KG
         0V3feoE8Yx2y3v7flmjW2WWJwwXShenacgavbTkVQDWwkf1gLLzHG040ywJltD5W1N7j
         BX3zr4Vl3AVHRFliJ1G7JRlcb3a8+2+kCRhN8eIL5Ti/thKdjOdNY2iS3jsIyazqQINZ
         QHfIRzToOV1KSjJ3a7B6Q4PSdb406eQj3pDQWpEyTJRNJojFvBvzfGS0RFzJPeYefXvg
         5cuQ==
X-Gm-Message-State: AOAM530e7ZzXo5Lz4n8O28z6qiOZkgEFskLr5Pybmey8DMfVElIh/T99
        H6UsJRL+2tGSmUukh3cunRc=
X-Google-Smtp-Source: ABdhPJxrE/OlTApROKBRNAXRZ5qb8V3rD64iWxCwv5clCUJR/VHr7O8S/hOR0LmM/QSoFQUeO+JZcQ==
X-Received: by 2002:a17:902:7d96:b0:142:87dc:7dd3 with SMTP id a22-20020a1709027d9600b0014287dc7dd3mr12202042plm.11.1639594316687;
        Wed, 15 Dec 2021 10:51:56 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b969:356c:bdef:8748])
        by smtp.gmail.com with ESMTPSA id f2sm3646428pfe.132.2021.12.15.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:51:56 -0800 (PST)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCHSET 0/5] perf ftrace: Implement function latency histogram (v2)
Date:   Wed, 15 Dec 2021 10:51:49 -0800
Message-Id: <20211215185154.360314-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've implemented 'latency' subcommand in the perf ftrace command to
show a histogram of function latency.

v2 changes)
 * fix build errors  (Arnaldo)
 * add Arnaldo's test results in the commit message
 * show warning when -b is used and BPF support is not enabled  (Athira)
 * use skel->links to save bpf links  (Song)

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


You can get the patches at 'perf/ftrace-latency-v2' branch on

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
 tools/perf/builtin-ftrace.c                 | 445 +++++++++++++++++---
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_ftrace.c                | 152 +++++++
 tools/perf/util/bpf_skel/func_latency.bpf.c | 114 +++++
 tools/perf/util/ftrace.h                    |  81 ++++
 6 files changed, 725 insertions(+), 70 deletions(-)
 create mode 100644 tools/perf/util/bpf_ftrace.c
 create mode 100644 tools/perf/util/bpf_skel/func_latency.bpf.c
 create mode 100644 tools/perf/util/ftrace.h


base-commit: 8ff4f20f3eb55dea0dbbe5e32043ab6b7427882f
-- 
2.34.1.173.g76aa8bc2d0-goog

