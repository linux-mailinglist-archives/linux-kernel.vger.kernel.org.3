Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE7D5855E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiG2UIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiG2UIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:08:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E50477A56;
        Fri, 29 Jul 2022 13:07:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so6254286pjk.1;
        Fri, 29 Jul 2022 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=EO1naJ16wN7LCmaw9KyJCfOudBruUaIQkcfDLaHmn24=;
        b=q3VNK866KXB7ahPSd+RHLE0TztjvGV9omqoW4YrBI8Q9L5YmskX9nxHj8F9D9qLYZ2
         l8brridihQfnDCwyL93RMs84yByHDiKOkkROdLU7/3b+6ks9syJFgt8GTET3EteOxaeh
         39qX8rZobHXLd35a2wrOGaGxpIHPYzvAMcxqTm8Q8Sgb3MaUT3dKU7mYnvqc9ZB8Mzpv
         2SMIbxICHNp5APaI92MfoMNDc+5ph5QJ3/Ke0KsRHM4ehAhrprbZqyhC/bNc/knx8/CB
         uiglXCQHkfrlu/j/lkUABiTnQG1Dc0ueTrptO/kFukDLqL7zix+Aj+iZuccgTkavMWOB
         i1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=EO1naJ16wN7LCmaw9KyJCfOudBruUaIQkcfDLaHmn24=;
        b=W1BbTIujy4gTuhjUIFyE/zFv+1FvswmhwxQkckisx60a4Dzb/oB2m2L6QHweKztcef
         CoVFyiZgrX7FWqK8cLL1VW/eTxeeF4e2/bUJHTShzs4P+F4SDKxWmkJnfG6gYYPPm3S7
         uylnN/jqd1BtBljjIS4+5OA/lIPhbj2eaoAxTKPdS8XN6c7nlgtMZ7QopKUPPXPszHEQ
         o8hulQRQkvaU8FS/IvaQjbCOlviZ83qhmqaYQtXnTj9reoVwpFrmTanA0NHOmz/BTPWX
         vR2FVKi2estuj/fsAFjQwLFdqbLhU6pnsTCLjIICJNVYrj7G3M+0K0ZiI+tuADPSaBSl
         ykRw==
X-Gm-Message-State: ACgBeo0w+f4Oycqv6TAD5mg23N4ghiK7MF2C+ZIf5XAbNvED75z+iC+1
        IffsuueEdEJjz4fKbRhyi/g=
X-Google-Smtp-Source: AA6agR4NciUJLGE9XfOVwi3Cbx7kcPbSKkoRGsKfkoycJF88BFPTLlyizV7GaaO9tCN7skfwXGzToA==
X-Received: by 2002:a17:90b:1054:b0:1f4:cebc:f65 with SMTP id gq20-20020a17090b105400b001f4cebc0f65mr723492pjb.116.1659125278716;
        Fri, 29 Jul 2022 13:07:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:c01e:2ed5:25ca:3acb])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b0016be14a776asm3929823ple.286.2022.07.29.13.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:07:58 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Stephane Eranian <eranian@google.com>,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 0/3] perf lock contention: Add BPF support (v1)
Date:   Fri, 29 Jul 2022 13:07:53 -0700
Message-Id: <20220729200756.666106-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds -b/--use-bpf option and others to use BPF to
collect kernel lock contention stats.  With this option it doesn't
require a separate `perf lock record` step.  Basic filtering on cpu
(with -a or -C option) and on task (with -p and --tid option) is
supported as usual.

  $ sudo perf lock con -a -b sleep 1
     contended   total wait     max wait     avg wait         type   caller

            42    192.67 us     13.64 us      4.59 us     spinlock   queue_work_on+0x20
            23     85.54 us     10.28 us      3.72 us     spinlock   worker_thread+0x14a
             6     13.92 us      6.51 us      2.32 us        mutex   kernfs_iop_permission+0x30
             3     11.59 us     10.04 us      3.86 us        mutex   kernfs_dop_revalidate+0x3c
             1      7.52 us      7.52 us      7.52 us     spinlock   kthread+0x115
             1      7.24 us      7.24 us      7.24 us     rwlock:W   sys_epoll_wait+0x148
             2      7.08 us      3.99 us      3.54 us     spinlock   delayed_work_timer_fn+0x1b
             1      6.41 us      6.41 us      6.41 us     spinlock   idle_balance+0xa06
             2      2.50 us      1.83 us      1.25 us        mutex   kernfs_iop_lookup+0x2f
             1      1.71 us      1.71 us      1.71 us        mutex   kernfs_iop_getattr+0x2c

It seems my system had some contentions on the workqueue spinlock and
the kernfs mutex.

The code is available at perf/lock-bpf-v1 branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (3):
  perf lock: Pass machine pointer to is_lock_function()
  perf lock: Use BPF for lock contention analysis
  perf lock: Implement cpu and task filters for BPF

 tools/perf/Documentation/perf-lock.txt        |  22 ++
 tools/perf/Makefile.perf                      |   2 +-
 tools/perf/builtin-lock.c                     | 226 ++++++++----------
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_lock_contention.c         | 181 ++++++++++++++
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 170 +++++++++++++
 tools/perf/util/lock-contention.h             | 140 +++++++++++
 7 files changed, 614 insertions(+), 128 deletions(-)
 create mode 100644 tools/perf/util/bpf_lock_contention.c
 create mode 100644 tools/perf/util/bpf_skel/lock_contention.bpf.c
 create mode 100644 tools/perf/util/lock-contention.h

-- 
2.37.1.455.g008518b4e5-goog

