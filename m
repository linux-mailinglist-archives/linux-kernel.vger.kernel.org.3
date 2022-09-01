Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307555AA084
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiIAT5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiIAT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:57:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251F883E0;
        Thu,  1 Sep 2022 12:57:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso3456301pjd.2;
        Thu, 01 Sep 2022 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=Bd+rXb3069I5Z5vldvEZpgf/hYsFoBoCUXm5L5yp/BY=;
        b=jcht6nBIKryIds7W6HMSeIt+XUi9hXl2sA8c0gFTbSRjKEGRI2US6JQfwMff5avJRs
         cUP8kUhK99YSAkyEXoSjizcSJdU+/Fi+P/jt3wFhShMNwFZyzufJcmfL9bBlHEJHvgJP
         vpWdGRqgDX4Ae+0rhAXQSB691cHvXNxR6tuwnZ3J1goer/jceohRv528INPgwe1VvDF5
         o2Ngu5bXOrCYYh9f6WLi/++INlhYB1/0veeT/+WIYbDo95NDcPVBKqBvw0RDmwJ5M0Tp
         e0Rc1pCa1tnA5FRmPe4+yBetAF71YUl0HsfG8NHzLtgN4pLeozftaXnq02UJ2tcTr6a1
         3YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=Bd+rXb3069I5Z5vldvEZpgf/hYsFoBoCUXm5L5yp/BY=;
        b=B8Yy496r5C219m1Q7q0Eet/bZGvSnFY3haOV0sgtuQLEepNPEwPHkwLkV/Dsfe6oUx
         JF+IUWHdzpehZIQ1Ax/b9RjlMYIHnqTRnWPp2k+EP2AkDMYvRBn83Dzj6frJGQ7JP97w
         Ed0lY5P+uqLeczAqq0hM3ap5KLqghgNWno9gxVQABzXNzCVxRN91Wi7fuV1uiUZcn7VN
         0TIaYdDYcNr6qdQFxcKn63u1SpzQ/p/EpE7sUzBfLQeLq/f6uRWHtuNcX/jCL2jwibYD
         uhFmz2yWAPR2KNJyGZYTnrPcY65a5UjaEeJ6Syw6r+ezys1yAQpnr9JAGrlS9IeHVxfp
         WHDg==
X-Gm-Message-State: ACgBeo21uu6jI/nw/XpT8KP7XTChgQG/ab8vvE9e9JOplqzLDjdEJxQc
        xnongjcWNAZVdjyviVpppJY=
X-Google-Smtp-Source: AA6agR5WgfOwMQzuWcuYT0sAq4P/AdNPcYqQfh15cyWdgzC/xe7q8/dgNRK1kVZLe6YkaHKMSEH7qA==
X-Received: by 2002:a17:902:bd48:b0:172:bb9d:d6d5 with SMTP id b8-20020a170902bd4800b00172bb9dd6d5mr31869287plx.59.1662062262410;
        Thu, 01 Sep 2022 12:57:42 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:87ff:65c0:eb6a:d2b3])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fb23c28e9asm3728500pjz.2.2022.09.01.12.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:57:41 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCHSET 0/5] perf tools: Show per-event lost sample count (v2)
Date:   Thu,  1 Sep 2022 12:57:34 -0700
Message-Id: <20220901195739.668604-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now we have PERF_FORMAT_LOST support, add it to perf record and report so that
it can show number of lost samples per event.  This can be useful if you want
to reconstruct number of events from the samples like when using -c option.

Changes in v2)
 * fix id_hdr_size calculation  (Adrian)
 * fix a memory leak
 * display lost samples even if no samples
 
 
Currently it adds PERF_RECORD_LOST_SAMPLES at the end of perf data after reading
event values by read(2).  The perf record unconditionally sets the lost bit if
the kernel supports it.  Users can see the number with `perf report --stat`.

You can get the code from 'perf/report-lost-v2' brach on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (5):
  perf tools: Print LOST read format in the verbose mode
  perf record: Set PERF_FORMAT_LOST by default
  perf record: Read and inject LOST_SAMPLES events
  perf hist: Add nr_lost_samples to hist_stats
  perf report: Show per-event LOST SAMPLES stat

 tools/perf/builtin-record.c               | 64 +++++++++++++++++++++++
 tools/perf/builtin-report.c               | 17 ++++++
 tools/perf/util/events_stats.h            |  1 +
 tools/perf/util/evsel.c                   | 10 +++-
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/hist.c                    | 15 ++++--
 tools/perf/util/hist.h                    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 8 files changed, 106 insertions(+), 5 deletions(-)


base-commit: 6c3bd8d3e01d9014312caa52e4ef1c29d5249648
-- 
2.37.2.789.g6183377224-goog

