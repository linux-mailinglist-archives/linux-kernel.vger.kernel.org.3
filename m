Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327B457C385
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiGUEgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGUEgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:36:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF74201AA;
        Wed, 20 Jul 2022 21:36:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 70so707033pfx.1;
        Wed, 20 Jul 2022 21:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4NTWGXxo8g+KNPo4Ft3fUbFupiF219bG5Z9P6EjVAM=;
        b=hfT2qHeqiG5Kb4oOr3IXP0rT+7Jq7+ug3X1cfRlbTDp8lLzP9ICRuyg8d8KQk7UQ6q
         AyvXG54Ls++Q2MRGUbt2gDnaq+Wr66OdD9WkDNY+SgtXJkU6zvj2HeaXJmLwseSu9+2k
         INOUNECQgzct0BgJ8u+BMyFjF6ZOtA1YdSQjwPSDrGXomeJao3YJLS8t/mdpt2SZICVY
         cVfiklkY2fruiYqYZB4FmN2nbpIt40O3O0kMxQmAowVr2726cqDOgAf0D04RvKiFAVUs
         oAfWsJqpMquQU95NIU0MIibyUtVhO+kSrQUNWJq6AuKXahUbQ3bQ2vhFxPmeX3E6Kyjh
         9F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=v4NTWGXxo8g+KNPo4Ft3fUbFupiF219bG5Z9P6EjVAM=;
        b=Mm4E0n/S0hdieItJVs9WEpGd/h6xP3yTJzJ3NQ+D2uU5/FufFgYRxwl3dsAHV1z1yk
         md9wxMCcYKhIrVMpad7aPpNUkiMbTUDCrXewLk2xyukpp/xgt/IrAm7sBE3ASCrUz6zQ
         J3tDeVA2szBBAfLudke3/L0RNXXsfM0XhSnTAVqfxIwYgvEWCnshwLBN6eFK3jKJzoPg
         Bfa9Qgefm3RqAb04/OQFYKhvRMcLeQw4SbU6oRGKnN7fJ9VvnvUYulehnxaa87oGal62
         wXJE+6j7at1gxc8jUrPs2MNwIS3iZ9qGjJED6iFhSPar3jfRBiE3aLXjgs//h0fYlogC
         g3TQ==
X-Gm-Message-State: AJIora+qrTQVX75zBDLkk8OXRgR3/N7+N0ZqSa0uFQXNZ28DNeS5Be19
        Kv6OdfLOevSftZnKGFEoteM=
X-Google-Smtp-Source: AGRyM1v+L7N/IiaW2G+4lAwBELZV+Ka4l+68Jga7iZ0BvKg0esOYp6vOWbraKtfsi1zj5atku0oilw==
X-Received: by 2002:a63:4042:0:b0:411:bbfe:e736 with SMTP id n63-20020a634042000000b00411bbfee736mr36804892pga.1.1658378208053;
        Wed, 20 Jul 2022 21:36:48 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:467:a1e4:c167:53fd:8047:7f62])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0016bea2a0a8dsm450824pla.91.2022.07.20.21.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:36:47 -0700 (PDT)
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCHSET 0/6] perf lock: Add contention subcommand (v1)
Date:   Wed, 20 Jul 2022 21:36:38 -0700
Message-Id: <20220721043644.153718-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
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

It's to add a new subcommand 'contention' (shortly 'con') to perf lock.

The new subcommand is to handle the new lock:contention_{begin,end}
tracepoints and shows lock type and caller address like below:

  $ perf lock contention
   contended   total wait     max wait     avg wait         type   caller

         238      1.41 ms     29.20 us      5.94 us     spinlock   update_blocked_averages+0x4c
           1    902.08 us    902.08 us    902.08 us      rwsem:R   do_user_addr_fault+0x1dd
          81    330.30 us     17.24 us      4.08 us     spinlock   _nohz_idle_balance+0x172
           2     89.54 us     61.26 us     44.77 us     spinlock   do_anonymous_page+0x16d
          24     78.36 us     12.27 us      3.27 us        mutex   pipe_read+0x56
           2     71.58 us     59.56 us     35.79 us     spinlock   __handle_mm_fault+0x6aa
           6     25.68 us      6.89 us      4.28 us     spinlock   do_idle+0x28d
           1     18.46 us     18.46 us     18.46 us      rtmutex   exec_fw_cmd+0x21b
           3     15.25 us      6.26 us      5.08 us     spinlock   tick_do_update_jiffies64+0x2c
   ...

where rwsem:R stands for read access (down_read) for a rw-semaphore.
Other types of lock access is obvious and it doesn't detect optimistic
spinning on mutex yet.  This is just a base work for lock contention
analysis and more will come later.

You can get this from 'perf/lock-subcmd-v1' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf lock: Fix a copy-n-paste bug
  perf lock: Add flags field in the lock_stat
  perf lock: Add lock aggregation enum
  perf lock: Add 'contention' subcommand
  perf lock: Add -k and -F options to 'contention' subcommand
  perf lock: Support -t option for 'contention' subcommand

 tools/perf/Documentation/perf-lock.txt |  23 +-
 tools/perf/builtin-lock.c              | 403 ++++++++++++++++++++++---
 2 files changed, 391 insertions(+), 35 deletions(-)


base-commit: 41d0914d861e82b4eeec16dd0f6109c311cf4c7e
-- 
2.37.0.170.g444d1eabd0-goog

