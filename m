Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2445C548279
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbiFMIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiFMIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:47:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782B10FEF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q199-20020a25d9d0000000b00664af83bee9so2584664ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tX56IynK4g6cEhjx/px0z/IXENX17azezRVhy0kMlX8=;
        b=JsGvTqvb5lf5Hai0NPWB2/LefnN0tiOusT9QdOYy2H586IRul4QwbB//rEo0fLhAET
         kBQuGRy9iqTE1dekJFtVtKogtQAVX1FhXNu6WHDb9fVMGAsONPXLpcLkhcAzsxC3q7g7
         huvou6PuJAVM7jYG/uNQozO5VB7My5Wpd03QYyAf5ZQrSnIE/SCP1h4/kLVT6Tjqcjmm
         +9g1ZG+Fh1JQjp3Jwo3evVt4P3RqWxQIzhManAcOdTd3kybodORKyl6RD3LVcLTtKpUQ
         cpJCqjz22l2ECiRVCixQjLWVvNvhQyh2ksRnQgZ1Ne2mulWLgcRCkR5WlltO3bVJap5Z
         x7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tX56IynK4g6cEhjx/px0z/IXENX17azezRVhy0kMlX8=;
        b=pEIRE+aHGIYQq5vsF5CjaF3rRlL4+2CQ5giSuLhHvCaEy19hRzJfNgFygnQdrrbhnU
         SRNBue/uzvJtZIe5rJlyM6XbAYBMLZeswDg2QM0hCHW6NhgOSfrddOQoV9R09gkBqY29
         9wqARM5u/G9NY3VLHIazUyRN/dp8LFbk2PM+dNYpgscYVRfbm2K8EAWSkCTuqLpIUVD4
         n8E8CQojsg2CKESbjF1qqmc5dlnhJ+OA3CoLblwrZUi8YY8Z/WGSytjlwcjovZxPUl4B
         d9HKr3FdBKJ8QawxJUz0EaxR91c9pCfmQ5NbLjegq+j2uPuf7iiqYLEI3D8rnbrqjo2d
         8hqw==
X-Gm-Message-State: AOAM531ij/7iSxLfiROlbgO3D3CQXYy9hVCgOk+PskcMZANFNrLLHKo6
        DkhkwNlL3uzyf4vIGKKfAHU0IJonBJRY
X-Google-Smtp-Source: ABdhPJxPj43DFMO/GRe77cIEw3Nkmq4yWBlr8ADVGE2jEF1zGv/zKXDaB3UAmL9GK1oDUZV3H2jHG60HJ2XN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1256:a8b4:594a:9164])
 (user=irogers job=sendgmr) by 2002:a5b:dcf:0:b0:64a:6923:bbba with SMTP id
 t15-20020a5b0dcf000000b0064a6923bbbamr60889716ybr.398.1655110063699; Mon, 13
 Jun 2022 01:47:43 -0700 (PDT)
Date:   Mon, 13 Jun 2022 01:47:33 -0700
Message-Id: <20220613084739.1159111-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 0/6] Corrections to cpu map event encoding
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mask encoding of a cpu map is laid out as:
  u16 nr
  u16 long_size
  unsigned long mask[];
However, the mask may be 8-byte aligned meaning there is a 4-byte pad
after long_size. This means 32-bit and 64-bit builds see the mask as
being at different offsets. On top of this the structure is in the byte
data[] encoded as:
  u16 type
  char data[]
This means the mask's struct isn't the required 4 or 8 byte aligned, but
is offset by 2. Consequently the long reads and writes are causing
undefined behavior as the alignment is broken.

These changes do minor clean up with const, visibility of functions
and using the constant time max function. It then adds 32 and 64-bit
mask encoding variants, packed to match current alignment. Taking the
address of a packed struct leads to unaligned data, so function
arguments are altered to be passed the packed struct. To compact the
mask encoding further and drop the padding, the 4-byte variant is
preferred. Finally a new range encoding is added, that reduces the
size of the common case of a range of CPUs to a single u64.

On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
0x9a98 [0x28]: event: 74
.
. ... raw event: size 40 bytes
.  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
.  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
.  0020:  00 00 00 00 00 00 00 00                          ........        

0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP

Using the 4-byte encoding it is:
0x9a98@pipe [0x20]: event: 74
.
. ... raw event: size 32 bytes
.  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
.  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................

0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP

Finally, with the range encoding it is:
0x9ab8@pipe [0x10]: event: 74
.
. ... raw event: size 16 bytes
.  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.

0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP


Ian Rogers (6):
  perf cpumap: Const map for max
  perf cpumap: Synthetic events and const/static
  perf cpumap: Compute mask size in constant time
  perf cpumap: Fix alignment for masks in event encoding
  perf events: Prefer union over variable length array
  perf cpumap: Add range data encoding

 tools/lib/perf/cpumap.c              |   2 +-
 tools/lib/perf/include/perf/cpumap.h |   2 +-
 tools/lib/perf/include/perf/event.h  |  61 ++++++++-
 tools/perf/tests/cpumap.c            |  71 ++++++++---
 tools/perf/tests/event_update.c      |  14 +--
 tools/perf/util/cpumap.c             | 111 +++++++++++++---
 tools/perf/util/cpumap.h             |   4 +-
 tools/perf/util/event.h              |   4 -
 tools/perf/util/header.c             |  24 ++--
 tools/perf/util/session.c            |  35 +++---
 tools/perf/util/synthetic-events.c   | 182 +++++++++++++--------------
 tools/perf/util/synthetic-events.h   |   2 +-
 12 files changed, 327 insertions(+), 185 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

