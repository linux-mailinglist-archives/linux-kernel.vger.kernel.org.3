Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8767B4A6C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiBBHIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBBHIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:08:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C3C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 23:08:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so5915759pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3JQTLsN4TUWXq+11AQA6HaRBL7yUQ8UUNf/bjPP2sw=;
        b=gBooyEowC9KX+DVIUdtnfC1zaMjq2bIY6R6DnGobUlUZ37R+D2UNCiqp6HkmLQ7qf3
         rnevRMKeSIs/Dr9uVXqn/UJ0yPcWA2Bwc5Oul0c+fTntBcX4700jji9hoN/pODPhJdyE
         d/CLo7g+NwrK87pj/NR1dI7h3bc9pB7Zn29Kd9nmGnaXezFqFkYjM56YVTNVxLMYN2H9
         yOt5E5MHUnD7FmGrlVopGEfCJIP6JGTOl5w7/VN2lkuYc5ljRMRIV5Gp51/l7jSd3T17
         rtK6j05fzaOxOSEsWyq/yLK9yhqbGxM1rCGOxxMaRVoLYMFJ15vQOT1KYy6r9QD3ciUr
         3MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=J3JQTLsN4TUWXq+11AQA6HaRBL7yUQ8UUNf/bjPP2sw=;
        b=vjx6zv52ikRpj418oXFv2zKohIiyQtJK4IlIxN/2MiW5QTgzkCh/tgt0kjJ08QspQX
         TMS5DXM1SYl5sb2COG8LE0t8BUwE4N6KTZ7uD2zwIubzMwJSKJQctc4l5T8/YcAVmJQF
         KHG9cXMimBW17KdkKzNzC3yNJAOgmhL2bji7xCdrUMoiYegofL9JhgyDlO4i/ds/TzP/
         xHxFmxaKd0F3csR7cYt1RSo7s0hDqz+ioHLpsWd6iafeJih+wyFUcZ7oYq+ACweZgclT
         rgsWY6xvgON+F1TVxgsksoLMYySMGxfiMeoW9J9Vy+NVRZ8kPYvYrOD4i6uTrQRznn0D
         0Fug==
X-Gm-Message-State: AOAM5325NWEzH5WcBt4810PQP63/1ieqpj6+7eOkX9V14PPeqquMgtfC
        8Hwd5QHrF9Vx8+i96ZqDFMc=
X-Google-Smtp-Source: ABdhPJx/pntocgiCGlqF+6TiXN9dvs0T5AZf4M/lkOBaHxCSc+Uu1Rfsj45QOD/7pui5KCKip9qoAQ==
X-Received: by 2002:a17:903:234c:: with SMTP id c12mr28356589plh.55.1643785710896;
        Tue, 01 Feb 2022 23:08:30 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:9c9f:e426:5704:d42b])
        by smtp.gmail.com with ESMTPSA id e15sm4936879pjd.52.2022.02.01.23.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:08:30 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 0/4] Handle chroot tasks properly (v2)
Date:   Tue,  1 Feb 2022 23:08:24 -0800
Message-Id: <20220202070828.143303-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found that perf tools don't work well with tasks in a chroot.  The
filenames in MMAP record are from the root directory of the task so
it's different than what it sees from outside.

 * changes in v2)
  - add Jiri's Acked-by
  - split stderr setup for objdump

I've tested it with a simple program (myprog - statically built) which
just consumes cpu cycles in a loop for a while (default 1 sec, can by
overridden by a command-line argument).

  # cd $HOME
  # mkdir -p myroot/bin
  # cp myprog myroot/bin

  # perf record chroot myroot myprog
  # perf report -D | grep MMAP | grep myprog
  2084916774977911 0xa2e4 [0x70]: PERF_RECORD_MMAP2 3363818/3363818: \
  [0x401000(0x80000) @ 0x1000 fe:01 4346398 2543719070]: r-xp /bin/myprog

So it's reported as /bin/myprog and then it's unable to symbolize the
samples.  It seems hard to fix it for the above use case as the record
ended after the task exited.  It cannot know the root directory of the
task anymore.  But we can fix it for real-time use cases like perf top
or pipe-mode at least.

I tested it again with the following command.

  # perf record -o- chroot myroot myprog | perf report -i-
  ...
  #
  # Overhead  Command  Shared Object      Symbol                          
  # ........  .......  .................  ................................
  #
      46.02%  myprog   myprog             [.] 0x000000000000178a
      36.71%  myprog   myprog             [.] 0x0000000000001792
      17.12%  myprog   myprog             [.] 0x000000000000178e
       0.05%  myprog   myprog             [.] 0x0000000000001796
       0.05%  chroot   ld-2.33.so         [.] intel_check_word.constprop.0

The symbols are not resolved because it failed to load the symbol
table as it didn't find the file in the given path.

So I modified the code to try a new name prepended with the task's
root directory when it's not "/".  With this change, I can see the
symbols of myprog.  In fact, it depends on timing if perf report hits
the file before the task is gone.  Increasing the loop time to 3 sec
helped it to get symbols reliably.

  # perf record -o- chroot myroot myprog 3 | perf report -i-
  ...
  #
  # Overhead  Command  Shared Object      Symbol                       
  # ........  .......  .................  .............................
  #
      99.83%  myprog   myprog             [.] loop
       0.04%  chroot   [kernel.kallsyms]  [k] fxregs_fixup
       0.04%  chroot   [kernel.kallsyms]  [k] rsm_load_seg_32
       0.03%  chroot   [kernel.kallsyms]  [k] show_cpuinfo_cur_freq
       0.01%  myprog   [kernel.kallsyms]  [k] alarmtimer_fired


I also found that perf inject and perf annotate need the similar changes.

You can get it from 'perf/dso-chroot-v2' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (4):
  perf annotate: Set error stream of objdump process for TUI
  perf tools: Try chroot'ed filename when opening dso/symbol
  perf inject: Try chroot directory when reading build-id
  perf annotate: Try chroot filename for objdump

 tools/perf/builtin-inject.c | 10 ++++++++++
 tools/perf/util/annotate.c  | 11 +++++++++++
 tools/perf/util/dso.c       | 15 +++++++++++++--
 tools/perf/util/dsos.c      | 13 +++++++++++++
 tools/perf/util/symbol.c    | 10 ++++++++++
 tools/perf/util/util.c      | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/util.h      |  2 ++
 7 files changed, 90 insertions(+), 2 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.35.0.rc2.247.g8bbb082509-goog

