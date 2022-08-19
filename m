Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5305991CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbiHSAgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbiHSAgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:36:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D7FDEA78;
        Thu, 18 Aug 2022 17:36:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jm11so2831855plb.13;
        Thu, 18 Aug 2022 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=pp/XSSy5OE6phmxdJXvlm4Vb1JMIb27/OWFRn//wD5k=;
        b=LbpnLZb0udj4bL0F73AZ4ywXnPCA/ooyyznzjWvZbNoPKA5S67IN5LcXr5Y1wVZm0D
         yGUq/JH8Xw3TqB++UybXdJexlBIieRS9TtR2XbVi+tnlHc7o6pslxPDC6Beczj4yRBQo
         BGP+vn7hyKQvJY3u+94M9LkUtDGuwT0gpEK2ss3Fwyo7jRQUlMnwUyNiN58y9Nmt/djf
         5E4QZR1m3rHxk1Plel21M1xLfCLuEXGGRS6ZlaaX8RK3AMVvdrtDxknT53ccrvlmOx/4
         DrKHgxopREyKKX/2GnFybnqeGpBH7lKXO/bHfJHZMgFLcpg69L41SbjX3B+y4PPjS6bf
         WCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=pp/XSSy5OE6phmxdJXvlm4Vb1JMIb27/OWFRn//wD5k=;
        b=ITrKrh3yu5irsRDk4Ak/P7z4G0Ygv0mLlA1JHPcOumt6kwb1mwZYDxE1F6sA84PrlG
         nrFTnOl3od4ZXAnBNslunDlDzDTxeNW76fcwDLZe0Urrtt6IUpn2Z8yKMmsIP4eN0DZ9
         I8f+TBlzrMg0WX2TGKPQO4frjvYgsRJeGe4liO/HayqFdPR/IV5wHz6Q1IPyTUwDzxjp
         mOSbbDE/I4dH0v8s56hZ73F7mn0kXDOvfIu6CjNxOwNP8BPlzWwAd5hjlM8P/xfHy00Z
         WhVRaAuI9vRjIp4uyog1jZKxbo0NktKsnVm6lilHnCwP8PVMhLZOmXWGzdI24fLBrzWv
         MA+w==
X-Gm-Message-State: ACgBeo2NhyCECcGKejQd52NnEYmmv+7/gkUrMzFOfGYrSgBJMgO/9ne2
        npkFJImXl4eISltvtsbyddiUo9D8uhmOkQ==
X-Google-Smtp-Source: AA6agR4aEl0z5yJsxY1hhPGTnG06y1kUOQXo7IBwmPGEwx6RHZiehfHAAJb9mwd2/5+rUeDcxMBo6w==
X-Received: by 2002:a17:90b:33c4:b0:1f5:8428:beb9 with SMTP id lk4-20020a17090b33c400b001f58428beb9mr11233991pjb.95.1660869406848;
        Thu, 18 Aug 2022 17:36:46 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:436c:3fa9:2b77:a856])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b001f303d149casm2057567pjh.50.2022.08.18.17.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:36:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf tools: Support reading PERF_FORMAT_LOST (v3)
Date:   Thu, 18 Aug 2022 17:36:40 -0700
Message-Id: <20220819003644.508916-1-namhyung@kernel.org>
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

Changes in v3)
 * add sample_read_group__for_each()  (Jiri)

Changes in v2)
 * add a comment in perf_evsel__read_group()  (Jiri)
 * simplify perf_evsel__adjust_values()  (Jiri)


You can get the code from 'perf/read-lost-v3' brach on

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
 tools/perf/util/event.h                       |  21 ++-
 tools/perf/util/evsel.c                       |  29 ++--
 .../scripting-engines/trace-event-python.c    |  19 ++-
 tools/perf/util/session.c                     |  35 ++--
 tools/perf/util/synthetic-events.c            |  32 +++-
 11 files changed, 356 insertions(+), 46 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1.595.g718a3a8f04-goog

