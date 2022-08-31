Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24905A87DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiHaVEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHaVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:03:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD415EC4FC;
        Wed, 31 Aug 2022 14:03:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso4405196pjv.0;
        Wed, 31 Aug 2022 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=+k9PKYV37HdBoa0ru3ipdSwSlY99M5IwVy3/cgyTvZE=;
        b=Vk30L9r82bSVM85CW3EBAWzoe0Dn+qPjJzw/Re99EZjRc/fpfaAUwIkADseQFFNHKB
         rMuU9ux9XXtxXPAdoGqe7Oak82NOJClJyn2C17DFwrI/Ag4RmNHmp7oJoRVNAqp5tQSR
         KhH4QeFdALJh+XFjZ9L9Aeqi98z+at4ad2JfZn1r35pW2Q9Kt6vBLKB9sMLztm712fEk
         8mlfEp2e2riA6lEgqhiyIXCeZWlAMGGtAODiAKPA4EMX/4DfJMLHkgEGXQOx8/V3wsOV
         ZLgQp/FEeUnvtnhbYHMxw/rHfNK93zoNqxjX9sRp3htWLdyW+WzLMKypzspuu+BpO8dM
         tcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=+k9PKYV37HdBoa0ru3ipdSwSlY99M5IwVy3/cgyTvZE=;
        b=S5HKQGMGkvlxTiXBDpWa2Oep1tlIvvmf9LUs+JO6maUGhLdAw1jzHDkbs+FEEDR1F7
         dhBtFUbEwgXa1y5vKts/HS8KZYucl6pFd96cCZJmUreJxkTRPodFPezeW+cjDgqaxh2E
         qYjxCQQHyfF586rlyBi43qcRm0s/KFU8hqz4Q+c3oB5pjAS+G1rj7RZUMNEwaLqCbcpf
         Mo+YUwgpyytxupsUoBXb/lgj/ji9iij5Kl4WfF+21hBw8k75E6WU6ZTBDZ6FnUjsC+BF
         +513u5UtyRq31vE3DH6a8imjhNsejqGfAh0BYeKX0rGOJd/b7ZFoWauhXtsgPqmN3cZ3
         Ah4Q==
X-Gm-Message-State: ACgBeo3NNp8kSpyU4Kw7tzQyXZsuKoo9CXZ5claljWhfY+aNLzkIPFGI
        Py1gdArVgz/FBPbLg+Relc4=
X-Google-Smtp-Source: AA6agR7gLHIavinDS7rbV1jmFJ16cc7JyDggKel336cAqm8DxZ18I1/nfOLgQGCjKG+NA31qrSP5fQ==
X-Received: by 2002:a17:902:e945:b0:16a:1c41:f66 with SMTP id b5-20020a170902e94500b0016a1c410f66mr26908520pll.129.1661979837198;
        Wed, 31 Aug 2022 14:03:57 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b0053ae6a3c51asm528931pfj.186.2022.08.31.14.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:03:55 -0700 (PDT)
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
Subject: [PATCHSET 0/5] perf tools: Show per-event lost sample count (v1)
Date:   Wed, 31 Aug 2022 14:03:47 -0700
Message-Id: <20220831210352.145753-1-namhyung@kernel.org>
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

Currently it adds PERF_RECORD_LOST_SAMPLES at the end of perf data after reading
event values by read(2).  The perf record unconditionally sets the lost bit if
the kernel supports it.  Users can see the number with `perf report --stat`.

You can get the code from 'perf/report-lost-v1' brach on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (5):
  perf tools: Print LOST read format in the verbose mode
  perf record: Set PERF_FORMAT_LOST by default
  perf record: Read and inject LOST_SAMPLES events
  perf hist: Add nr_lost_samples to hist_stats
  perf report: Show per-event LOST SAMPLES stat

 tools/perf/builtin-record.c               | 60 +++++++++++++++++++++++
 tools/perf/builtin-report.c               | 17 +++++++
 tools/perf/util/events_stats.h            |  1 +
 tools/perf/util/evsel.c                   | 10 +++-
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/hist.c                    |  8 +++
 tools/perf/util/hist.h                    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 8 files changed, 98 insertions(+), 2 deletions(-)


base-commit: 2f4c2fbd2ff5e3176b0121443f995808ee498bd0
-- 
2.37.2.789.g6183377224-goog

