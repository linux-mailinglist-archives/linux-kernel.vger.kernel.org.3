Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590484FE518
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353624AbiDLPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiDLPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:50:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C225FF33
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b65-20020a25e444000000b0063dd00480f8so15033782ybh.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8IZz/gMylCpP1gVOy3Mzg8c3y39Rz/6oTdnON/BPbbo=;
        b=nozrEXfagyw88Rss5WjQoaW+QrAP05xY/u0NdTER42+HrNPzXBnVSeJMVV1t4f1tuk
         blSVnwX63Ntsee0BrggFx1BX7hqrWUE+/lheMmBq4lLmaGVbOnNzrH3RMNh/aYIYEC7m
         gkyaLUH7heh/Bagv6Tc7TIuyIYrzP9V8RZn/U4DS5KheteWxYjSJ7u/6J0we0EIJ0NC9
         AsCP7aaf3Kb42hs6Lw2WxNxA8rsk6dSAiF1hRAoqmSeTeb13PJFeWlHtOGKWUJ5C2+Ue
         xLJls2OFlXo9elbttQXMs1LNWl87IVZaVxDY+tNaz/W/C6bgwKop6uSP1HPb7zpVPwZ0
         gtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8IZz/gMylCpP1gVOy3Mzg8c3y39Rz/6oTdnON/BPbbo=;
        b=DVJOK7YYIFwT16Pz7yderCYPZxbWrmxy+aJfIHOcMuqjdC/FercnyKsk1ONwFghatx
         R/kEjFejYBfoLIsmVHzJmToPKK1yxiiqfb5hBzUf3a6V/npKir+gw6Yd6P4R0HZCMkVa
         0MA6157xLPpXi34rVMF//FvJ6PyOCr57tPJnS78jMz1VHH98Ph9Dk4AwUvEv1Dypm4HE
         /EAfl0r6BmUOwhJTdIPXzQbTL7jNhBjFj7t9GYakW7cghZzKE0Wf16ezTvF+lfhAkA1z
         Fp7eZuiLseyM/KkbAmeqOQxzXMZcl7SJx4hDulz0FaRXsr5Jz8uCEurxiAkjqrRCs3ah
         fMgQ==
X-Gm-Message-State: AOAM532OtN+qMQlSDt2dL/4nNYqUQw4vUau9wlx7rXooE3422kZCys1x
        icH8CQ7vsT8xSR6OaX1OJQK28RD1hPEX
X-Google-Smtp-Source: ABdhPJy450ML0VeLyDFpbPqaekYj5Wh+ytMVAvRr1v5nwfqBAHYtbYtXW7oIiYzIflTqKubXTCVh9Baufz9i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5f6f:a698:92a:5d45])
 (user=irogers job=sendgmr) by 2002:a5b:cc:0:b0:63d:897a:ddab with SMTP id
 d12-20020a5b00cc000000b0063d897addabmr25252581ybp.110.1649778502201; Tue, 12
 Apr 2022 08:48:22 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:48:13 -0700
Message-Id: <20220412154817.2728324-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 0/4] Tidy up symbol end fixup
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

Fixing up more symbol ends as introduced in:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
caused perf annotate to run into memory limits - every symbol holds
all the disassembled code in the annotation, and so making symbols
ends further away dramatically increased memory usage (40MB to
 >1GB). Modify the symbol end logic so that special kernel cases aren't
applied in the common case.

v2. Drops a merged patch. Fixes a build issue with libbfd enabled.

Ian Rogers (4):
  perf symbols: Always do architecture specific fixups
  perf symbols: Add is_kernel argument to fixup end
  perf symbol: By default only fix zero length symbols
  perf symbols: More specific architecture end fixing

 tools/perf/arch/arm64/util/machine.c   | 14 +++++++++-----
 tools/perf/arch/powerpc/util/machine.c | 10 +++++++---
 tools/perf/arch/s390/util/machine.c    | 12 ++++++++----
 tools/perf/util/symbol-elf.c           |  2 +-
 tools/perf/util/symbol.c               | 16 +++++++++-------
 tools/perf/util/symbol.h               |  4 ++--
 6 files changed, 36 insertions(+), 22 deletions(-)

-- 
2.35.1.1178.g4f1659d476-goog

