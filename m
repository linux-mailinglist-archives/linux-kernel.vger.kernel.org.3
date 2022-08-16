Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187C5596560
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiHPWSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbiHPWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:17:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A987901A9;
        Tue, 16 Aug 2022 15:17:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d16so10428868pll.11;
        Tue, 16 Aug 2022 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=OB8RDF87cTmELNf7aw7q4YYpUSHmX8OtlvjYs3kFhr0=;
        b=cLdY1RNjmC1OlOQ58Aj1kl0m1QGT70JSthx1sOxB6PLSZLnXytfnW7KVUyJrw4ILU6
         n7N6DPzadmTiMz5IL6S4fdu0FVkq+/FJ2HdYvMLYEC4zRwa67JbF6Sny9B40YcBLn4fg
         ohnYCLh5WtAvF0bc9dFPHItMkPxb4pdO5J++g2APvYqVgvfENoNCY4RB7pbrrF1BVIT3
         anw7II4R90l1B63xdm3wVCCeULjT7spaLcd0hocWNQiWzNqZzoMwzIGMKJzrFDWYFbhR
         8R8zZxwu8MzQFDVdNetpC4RnPL6bFFcmoP3td/QP09ra2EXEQbwt1mSk2feHRb/+qz0y
         h4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=OB8RDF87cTmELNf7aw7q4YYpUSHmX8OtlvjYs3kFhr0=;
        b=SBoXTAh11+kwBOAJlPUbvXrycTb9IVbWcRckf73AimqJOFPbxnRu8vdZlGrIR/0QPs
         SQkFVCBcXzrepXOZqzi24yocLtnkxd7wkRAzVqt1iNRQaVVkS+GbbKq6G8yDU3D1qtA9
         QAPqUXa40P3/8uxFCyoDcqWUowu/K6rdU/DBV5YywdVG/4NH//MrhJ/LXg72alf+On37
         AYjvtfXCZqo/2wXopnwZqU2DkWaoRPKX1Jq3H1YbJi265kkvfTAzOFMx21Z7swI53mKg
         Y+n1wKsyJh7A2EfkTpImt8eT/OJpPWMmKoAfhdZKt5MEfcEDwrfrTMNib3M7JJm0Jjfs
         SAPw==
X-Gm-Message-State: ACgBeo3lpCnUeEJvu32jvrnZXhRmSaBHu3XRsvYA0d7bxT7OkZTfmqUc
        GXqrjPh7mGPyZM8mIb0ftPPWyN1aEzI=
X-Google-Smtp-Source: AA6agR7/vFKp5+pTpC3YdQO45AeYq4bPMXwFZsqW8mnAS7I6tSnHUwmI/rSTcyZmN9GCFgnup+dUDg==
X-Received: by 2002:a17:90b:17c9:b0:1f3:3a7c:a3a7 with SMTP id me9-20020a17090b17c900b001f33a7ca3a7mr734547pjb.76.1660688269758;
        Tue, 16 Aug 2022 15:17:49 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:d539:e967:9fd8:5c81])
        by smtp.gmail.com with ESMTPSA id 3-20020a620603000000b0052b7f0ff197sm8965943pfg.49.2022.08.16.15.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:17:49 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf tools: Support reading PERF_FORMAT_LOST (v2)
Date:   Tue, 16 Aug 2022 15:17:43 -0700
Message-Id: <20220816221747.275828-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
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

The kernel v6.0 added PERF_FORMAT_LOST which can read a number of lost
samples for the given event.  As it can change the output format of
read(2) and perf sample data, it needs to access them carefully.

Changes in v2)
 * add a comment in perf_evsel__read_group()  (Jiri)
 * simplify perf_evsel__adjust_values()  (Jiri)


You can get the code from 'perf/read-lost-v2' brach on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  tools headers UAPI: Sync linux/perf_event.h with the kernel sources
  tools lib perf: Handle read format in perf_evsel__read()
  tools lib perf: Add a test case for read formats
  perf tools: Support reading PERF_FORMAT_LOST

 tools/include/uapi/linux/perf_event.h         |   5 +-
 tools/lib/perf/evsel.c                        |  79 ++++++++-
 tools/lib/perf/include/perf/event.h           |   3 +-
 tools/lib/perf/include/perf/evsel.h           |   4 +-
 tools/lib/perf/tests/test-evsel.c             | 161 ++++++++++++++++++
 tools/perf/tests/sample-parsing.c             |  14 +-
 tools/perf/util/event.h                       |  18 +-
 tools/perf/util/evsel.c                       |  33 +++-
 .../scripting-engines/trace-event-python.c    |  16 +-
 tools/perf/util/session.c                     |  32 ++--
 tools/perf/util/synthetic-events.c            |  34 +++-
 11 files changed, 360 insertions(+), 39 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1.595.g718a3a8f04-goog

