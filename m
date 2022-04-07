Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2AD4F8B29
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiDGXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiDGXHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2ABCB5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:05:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p15-20020a25818f000000b0063daf5f7957so5326692ybk.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3CKrl89DJ1eArw5yXg6yQJm2IzsI3jJzLx/oCvEr+S8=;
        b=BrjbOvi97KBq0KuSeXgzYX1tREisnvDljjjcM8IUk4AN53vhK1IvuAn3yRruMRrqYy
         3g8tROUFXw9m0hTNvLJgzpFLCUBAAclCy6ML8mp2d4I3f2V3AkAKvIrivoX00+2ccvQ4
         NheSFFgmOa9YkswoPimT0npsnm69YRnvSitFxxI3b87Bgc6cjDJXSIeeDqcTlpAJiCXM
         4QNjCI923pPwOOSmLgwM5PoDvfz0glZLUfsCI6mGrPb+03igLIrtnlPgu/s79iH3uUrD
         ikA6M5hHtPnWc9IU+8E2hvIk8kWHeKU7xJ/39JkP077VMCe1sfdxRgHGYBdWa0bYXiTh
         Mptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3CKrl89DJ1eArw5yXg6yQJm2IzsI3jJzLx/oCvEr+S8=;
        b=cV2hLi7+Q6bxzhmQMrOAqDmFDV0UlQ9iC21D1udEa+CnicsVNruJX3qIGTGR+p1RUu
         MlrGiCOfgc14mf57llyYp2pY+BdBvIUcjm/ge5mSyg6RPF1T4a/8xqvLKyTIXj3O+wxM
         5uybQ6PbiFSYb34JPGVw6+EcyIY3oeKvmHYnSYtByzrpHFlkBCFz4Z6TXx6l//5rzuZc
         hfkgk6KU9Ou5xUvLW2trz47XkUhtBBjI+V9uNGHvWqOGJbAaBK/IDQWFRDGZRxB0EhcD
         Q6aQ54X6THvqLIzc8m3Dzvv4ckOldLf7UUIKvMux6/KK9TERjVeddSx+KyeS9NNkLbS7
         nQ1Q==
X-Gm-Message-State: AOAM532rCxzWa7rIgFOmDu8L7kcs7IYKiojRY34tnZPvTLkP5QBJLxKt
        uBonPNbGGLAwWi3OdlGSbxUNbVe2Q9Ex
X-Google-Smtp-Source: ABdhPJwy48FFOFhpFYLNupwB82gwpEN1VzGfu5MwTQeS3yqZlG6h0C+aNVT5PctDKFdcGIY5pViLbIEd3Eer
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1107:b0:63d:e354:c541 with SMTP
 id o7-20020a056902110700b0063de354c541mr13119837ybu.346.1649372711827; Thu,
 07 Apr 2022 16:05:11 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:04:58 -0700
Message-Id: <20220407230503.1265036-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 0/5] Tidy up symbol end fixup
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Minor fix to perf annotate to not stall when stderr is full.

Ian Rogers (5):
  perf annotate: Drop objdump stderr
  perf symbols: Always do architecture specific fixups
  perf symbols: Add is_kernel argument to fixup end
  perf symbol: By default only fix zero length symbols
  perf symbols: More specific architecture end fixing

 tools/perf/arch/arm64/util/machine.c   | 14 +++++++++-----
 tools/perf/arch/powerpc/util/machine.c | 10 +++++++---
 tools/perf/arch/s390/util/machine.c    | 12 ++++++++----
 tools/perf/util/annotate.c             |  1 +
 tools/perf/util/symbol-elf.c           |  2 +-
 tools/perf/util/symbol.c               | 14 ++++++++------
 tools/perf/util/symbol.h               |  4 ++--
 7 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.35.1.1178.g4f1659d476-goog

