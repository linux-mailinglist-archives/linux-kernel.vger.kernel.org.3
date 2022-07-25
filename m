Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25EA580405
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbiGYSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiGYSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:31:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756313D1F;
        Mon, 25 Jul 2022 11:31:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gn24so11289867pjb.3;
        Mon, 25 Jul 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djzhhHEqgdvzWuulygSwSZDVp86S86Xwi0f7w/Lqt4k=;
        b=eGzQAo2rdMmIlyCYh/9CvD1x/k+wwZvJ7eNn2o2qUrmUEvVLpyZE/FzifHlIjzsumb
         E3LnuEoTFaL2TkqXOw2blh4bJ9icsH+k0CZCUCji3MZkziI1yvDAHSNc2wFP5KE6dtFs
         Jr96AVxXfS++kVCGKwW297HHI4P2isW8BuVlvsmDnRSRXoDc0HvX3FbBl5ZOQtX+e5vR
         UMa3hiUdMgPR3L/IybTWB6gXfGXE6Ls3BJQKxbETUvq8myuLguGt7luvWxPDtCU9alvl
         u2BgccUC47Cp6eue4epR+gIuPzufXZaQK2vCRYdJIUaSxpzL/TsrKRUCk/clADU3LqIO
         aoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=djzhhHEqgdvzWuulygSwSZDVp86S86Xwi0f7w/Lqt4k=;
        b=QSt9KCjOQ2HjRsIJg7o25KiGKjSbXFBUTnp6DzPerYeZzPYxpkNcfGqyn/Llhm1nSM
         Iio3309wjxQHGcmVXqgnF2WmuA5iY2yNkER3KsKITWRQHbUcA5bkAXLhynM6P31DptL7
         J1DslBX6Q3c6cbzti1uf+7SPxY+pPVSptqL1H9In3PoHALEpFDRtuLY0rzERGZh3XRBb
         7gNItMoBRF6J3zDbkyvm/nup7apLKuoi0flw88L3o/blF5bWwOGQ0yiNv9oKiaXDVF9s
         wsEodQFdFRbaWrEr0JD6IqLWzGV0DqmIh8qkWc9jG6+OAtSSdSUErRXPr1CJ5i+vQYtQ
         BQHw==
X-Gm-Message-State: AJIora8KQVyQrCjUDtXIOy4jekuLs3vD5uPu5xadKN8WCQueUfj8ABDT
        96IZ7g73g4YpR2shbGqvKeQ=
X-Google-Smtp-Source: AGRyM1tFXseV5ZpHJfxTal7MZxvm2fJ7QFw6kaBZfnbizk/jAne1Fc3eLBQlwp8OAeA3Lf5Gmt4ESw==
X-Received: by 2002:a17:90a:6404:b0:1f1:f935:7878 with SMTP id g4-20020a17090a640400b001f1f9357878mr15542921pjj.218.1658773886870;
        Mon, 25 Jul 2022 11:31:26 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:2c4d:e9cd:d086:4d46])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016be9d498d0sm9740556plh.211.2022.07.25.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:31:26 -0700 (PDT)
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
Subject: [PATCHSET 0/5] perf lock: Add contention subcommand (v2)
Date:   Mon, 25 Jul 2022 11:31:19 -0700
Message-Id: <20220725183124.368304-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
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

Changes in v2)
* bugfix is merged already
* fix build error in patch 2

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

You can get this from 'perf/lock-subcmd-v2' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (5):
  perf lock: Add flags field in the lock_stat
  perf lock: Add lock aggregation enum
  perf lock: Add 'contention' subcommand
  perf lock: Add -k and -F options to 'contention' subcommand
  perf lock: Support -t option for 'contention' subcommand

 tools/perf/Documentation/perf-lock.txt |  23 +-
 tools/perf/builtin-lock.c              | 401 +++++++++++++++++++++++--
 2 files changed, 390 insertions(+), 34 deletions(-)


base-commit: 9fe9b252c7c022df8e503435e778f15c04dfa3bf
-- 
2.37.1.359.gd136c6c3e2-goog

