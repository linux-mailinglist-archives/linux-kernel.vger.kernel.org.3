Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A74847AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiADSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiADSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:20:58 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D059C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:20:58 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so33426195pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APdRKhY194/0ZppmmPMGjoOj6qdDlgEu8ghhA97eO5w=;
        b=HI/STuDJrqu3agxZ7Go5cz0Af30AUi0D2LY7+PNsa3CqfTkuOAGagxyUtlAZ1MkImt
         x05RUN5ffPfJwd+QWtoCPw0MsG7TDxVGfQh+Lq+bHGT9zyDUAw4F87jAuyhHnnDoyFcl
         Kjr3fu3x8OlOjNpdVMnGwLy1uBtvTxWJdF2pXHVwTg97MCUFwQhE6damBBXIs4ryYhDf
         WNiQVOajw8WVqnyUiLNesoH6wvR5n8WWI1iuetHANEtvUrTF5Gtn9IOG0amoMbm05Gpw
         QI3hjrCt5bANrWwImBgS+SDXw7Dp7nzPwhbQv/SrFH4YDqtRWd78siGaeAEWgEakmA1F
         nYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=APdRKhY194/0ZppmmPMGjoOj6qdDlgEu8ghhA97eO5w=;
        b=QVREZJ/rRZ7fWoXs38Nou2dLV/DwmKLDhA8/9S4W4FqJfwNW6XBJNmVgGR4g5nF8TQ
         Fq+3AKnTCtitm1ZNrIH4tP7NyMhPuCoZ2G0E33J9U0U0pPPEUturQbx2zHyzCwCdZwla
         y8I770DOF+k2ePiWhO4m2LNbZ5B7zPR7lQae5NjT6mP3m2CNby4paK9Qy5tR/beK36uj
         LPWG7dt7zwi4jJmldFFxPSVE9nM/PykLZYjxdUy64b8zlFNvB3O+iDaV7IoIr5me3S/+
         eAIEXKKk9aNV/2tPDo+WAObSirN05gXIk6X3bAqHo1B6H7GCgE/0kgPLTU5kRmXz+RK/
         2wKA==
X-Gm-Message-State: AOAM5332NiGSd4iyQEf4DIVEFWViJVXi/icNZI+LFnkhR69oBENR/OP5
        9HuBWPnKE3mJdKqUBUOtMWw=
X-Google-Smtp-Source: ABdhPJxqQqxGbXeBX8BJXLsZVIgBBUBpZefdZq5CXcVG270y3yQWPiLua4qQboSN5tm6Lu+H4NXwwg==
X-Received: by 2002:a63:b545:: with SMTP id u5mr4074550pgo.420.1641320457697;
        Tue, 04 Jan 2022 10:20:57 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:4abf:2548:40ff:6d1])
        by smtp.gmail.com with ESMTPSA id g10sm10097684pfo.103.2022.01.04.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:20:57 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET 0/6] perf lock: Random updates for the locking analysis (v1)
Date:   Tue,  4 Jan 2022 10:20:48 -0800
Message-Id: <20220104182054.25009-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some updates in the perf lock command (focused on 'report').
The main change is to add -c (or --combine-locks) option to aggregate
results based on lock class name.

Without this option, the result deals with lock addresses so instances
in the same lock class will have separate entries like below:

  # perf lock report
                  Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns) 

         rcu_read_lock     251225          0               0               0               0               0 
   &(ei->i_block_re...       8731          0               0               0               0               0 
   &sb->s_type->i_l...       8731          0               0               0               0               0 
   hrtimer_bases.lo...       5261          0               0               0               0               0 
   hrtimer_bases.lo...       2626          0               0               0               0               0 
   hrtimer_bases.lo...       1953          0               0               0               0               0 
   hrtimer_bases.lo...       1382          0               0               0               0               0 
   cpu_hotplug_lock...       1350          0               0               0               0               0 
   hrtimer_bases.lo...       1273          0               0               0               0               0 
   hrtimer_bases.lo...       1269          0               0               0               0               0 
   hrtimer_bases.lo...       1198          0               0               0               0               0 
   hrtimer_bases.lo...       1116          0               0               0               0               0 
           &base->lock       1109          0               0               0               0               0 
   hrtimer_bases.lo...       1067          0               0               0               0               0 
   hrtimer_bases.lo...       1052          0               0               0               0               0 
   hrtimer_bases.lo...        957          0               0               0               0               0 
   hrtimer_bases.lo...        948          0               0               0               0               0 
          css_set_lock        791          0               0               0               0               0 
   hrtimer_bases.lo...        752          0               0               0               0               0 
   &lruvec->lru_loc...        747          5           11254           56272           18317            1412 
   hrtimer_bases.lo...        738          0               0               0               0               0 
   &newf->file_lock...        706         15            1025           15388            2279             618 
   hrtimer_bases.lo...        702          0               0               0               0               0 
   hrtimer_bases.lo...        694          0               0               0               0               0 
  ...

With -c option, the hrtimer_bases.lock would be combined into a single
entry.  Also note that the lock names are correctly displayed now.

  # perf lock report -c
                  Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns) 
  
         rcu_read_lock     251225          0               0               0               0               0 
    hrtimer_bases.lock      39449          0               0               0               0               0 
   &sb->s_type->i_l...      10301          1             662             662             662             662 
      ptlock_ptr(page)      10173          2             701            1402             760             642 
   &(ei->i_block_re...       8732          0               0               0               0               0 
           &base->lock       6705          0               0               0               0               0 
           &p->pi_lock       5549          0               0               0               0               0 
   &dentry->d_lockr...       5010          4            1274            5097            1844             789 
             &ep->lock       2750          0               0               0               0               0 
   &(__futex_data.q...       2331          0               0               0               0               0 
                (null)       1878          0               0               0               0               0 
      cpu_hotplug_lock       1350          0               0               0               0               0 
      &____s->seqcount       1349          0               0               0               0               0 
      &newf->file_lock       1001         15            1025           15388            2279             618 
  ...

Maybe we can make it default later (with a config and --no-combine-locks).

You can get it from 'perf/lock-combine-v1' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf lock: Convert lockhash_table to use hlist
  perf lock: Change type of lock_stat->addr to u64
  perf lock: Sort map info based on class name
  perf lock: Fix lock name length check for printing
  perf lock: Add -c/--combine-locks option
  perf lock: Carefully combine lock stats for discarded entries

 tools/perf/Documentation/perf-lock.txt |   4 +
 tools/perf/builtin-lock.c              | 155 +++++++++++++++++++------
 2 files changed, 124 insertions(+), 35 deletions(-)


base-commit: b9f6fbb3b2c29736970ae9fcc0e82b0bd459442b
-- 
2.34.1.448.ga2b2bfdf31-goog

