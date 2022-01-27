Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1636F49D678
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiA0AA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiA0AAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:00:54 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F03C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:54 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q75so746378pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukC9JWwYdJ1xBJrCXHc/X7oHrRuyFj4FwK9ABYn20tU=;
        b=jLynsdArWMeWSIVBinDqHBOaXHYxdpM5XsQit9+yz8ZsKGy1oLkzM3JZMyONbzl11N
         ZsdjL3NfFP228tUeBTtY0N2ZsNGdvGaOgpK+cNC64CEJguyBI9blSw8lSAFAOhXOpBq2
         SSTdQtMTS7evRZGtBr7GRO5qYWb3i/5JS4KV30Gv5NZwgqd3rVtDu+wLgsxcb5dTp2PY
         mRpi+kT5wHcVL/XfWjqWYXnSTsXdpfT8XXbh2zASSqoiSjSb5ib7aOuYPvqmVIkUV4q5
         LD8gUZ+0RQK1qaVvTjFDM1g1cUEzLxDwU89HuAFb+LnEPt16mB/xQtOGIxq8GJ8glcFo
         5Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ukC9JWwYdJ1xBJrCXHc/X7oHrRuyFj4FwK9ABYn20tU=;
        b=eUjMvboaJEh00R7gmi4PU4MI1EjlbtYWzdy9dJis7UfbMV/XO2v8oFNILEuTayUa79
         2xYu9OHglpdDKdHTPhbk+OK0hLyDrc2AtfzBXjinA8Ai3/lAoHSIMZWQOEYiUXx0a7ci
         c5cJmRCHFrpezhEOIu/qGszwPzRwcSxLOSuKHD5pfQSfO3/yAsUBrsv35W3NjTkKlzoU
         ytdFss0aZXQcXsVg45bOJg91szoa5mKY4AIIaG0UYCgs5H78JduDv9iBSUpUDGp85g9y
         +QyoLqjvID2OCuCBQts8KXM8SNbNLu1zH+QpQfHBaY+uXLL5zb664vfrsvuWhoiuLGkl
         cXgw==
X-Gm-Message-State: AOAM531UnzssFGErUSyUCLHIRXvsliExzbMQ/f/Sqw5ocW/SxM5nTa00
        Ujwlz3rG2ra4cm3bPsYQA/A=
X-Google-Smtp-Source: ABdhPJxhYxfxcK6wQ51MblyDWAnVhcMj9cYRDssmOpyr3yuBSR88NpmYoIVE8CplioJlZL3TkmThrw==
X-Received: by 2002:a65:6492:: with SMTP id e18mr861359pgv.329.1643241653609;
        Wed, 26 Jan 2022 16:00:53 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e94:fba2:6768:ac75])
        by smtp.gmail.com with ESMTPSA id t24sm3545546pfg.92.2022.01.26.16.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:00:52 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET 0/6] perf lock: Random updates for the locking analysis (v2)
Date:   Wed, 26 Jan 2022 16:00:44 -0800
Message-Id: <20220127000050.3011493-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some updates in the perf lock command (focused on 'report').
The main change is to add -c (or --combine-locks) option to aggregate
results based on lock class name.

 * changes from v1)
  - rebased onto recent acme/perf/core
  - add Jiri's Acked-by

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

You can get it from 'perf/lock-combine-v2' branch at

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


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.35.0.rc0.227.g00780c9af4-goog

