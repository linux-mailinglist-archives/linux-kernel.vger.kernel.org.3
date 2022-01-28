Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890C44A0233
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351567AbiA1Ukr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351288AbiA1Ujx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F4C061751
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o64so7467793pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtMqs+0t0LNCgzeXJAek0TSVqeINn0O3hd/R613R5/8=;
        b=kArmkAHUM6o9YQWhMV6kun53D3KQpvPbMcXVFT/oWTdI3HcDAWQUKgPF0IUUsNYY2u
         k1rK1neycm85tlbqWRty+PCsp+k+jlLOluLwUlvFHXyt0wCCkBDeZfQqch4RLi2pAL8w
         pJflfNg6dHzmlmyJwWGI57FV0JcjVU5yEZ6RYAFYT/oprGioSPSicRB4EPhOKoeu1ASU
         X03BnrsoG5wZZzDomyAFXrKPg5AOSvmmopI7ij1fR9cfTcJxCsB0Cu+jFWUcdVk5A7CI
         RHCiWWD9ZvIzL1+vxID0hol+ohZJnKsJaOxkQ27zSZllFH/Rwn3eGoyVyQTATs9SJb7P
         Zhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rtMqs+0t0LNCgzeXJAek0TSVqeINn0O3hd/R613R5/8=;
        b=sm+qLJp+4lb6KwLxnp4nnUvdeWfWEKX3YgMWH5nhewMv6G6OyBJCG4PSdVYHZToYuE
         9t3v+KbhG1NpafFZyPXNBEGfkXsUIwYUpP2IGcmfVTIisxb2M2ZGni50Kxc+4yYF55qS
         ndrh9ZrLz3XjK/IMrgPeDABq9aOLY8HdIdrx6b9QSzrs5euRP3QEb5EtR58yaINqykFh
         Y4bvoUw6GASHUnI18L6BUSt3ebGeuiI0WX9FGJX2/+qFkJoHVoRWmJ6F6+i2Oq2u5EcH
         HmeRnEnhammmthfLSEXyb9bzeA8TJAytjbgRrNsKoMcyGrqz2smQHly78LfviktjdSXF
         1BWQ==
X-Gm-Message-State: AOAM531lHrJABWBsbPbcOF85rizxSi0sKGCOLAyREIXdfFlFloem7T6J
        AN52tDg7+Ou7xwN9CDpMC0Y=
X-Google-Smtp-Source: ABdhPJwzkQExiaV8hKBN6atyN/p0+WjjAHZt6sxoEei+r6kFLpww+pbe+s2nzSfor7uzZz4B3NzZHg==
X-Received: by 2002:a17:90b:380f:: with SMTP id mq15mr21778403pjb.96.1643402392696;
        Fri, 28 Jan 2022 12:39:52 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:f13b:bc2c:fac:4a86])
        by smtp.gmail.com with ESMTPSA id k3sm11235428pfu.180.2022.01.28.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:52 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 0/3] Handle chroot tasks properly (v1)
Date:   Fri, 28 Jan 2022 12:39:47 -0800
Message-Id: <20220128203950.3371061-1-namhyung@kernel.org>
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

You can get it from 'perf/dso-chroot-v1' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (3):
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

