Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6761B58563B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiG2Umd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiG2Umb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:42:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD995A8A5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:42:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4e870a17so49184907b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rKpsJkAvhpK46Oj026Hnlt3lw23B8Cir0Qd7OTp8i94=;
        b=dss7HY6AV15fZ2XVOxvesgo5Sb3jz0aFRmH+hnMlXqSzfuD+WfMczxtF7b51UR+JGR
         bqMVPJUdIjCNjGjapGnP29VAASb528hSsSUDRiR7R3vmJB4PYH/jjFTLK/0K1fGYVaHl
         YHlGBAxkkkwhp8Z2vwDzB3XAB8xaUIE0wqIBTZaOdrqYUACzJrcc3OMuLGle5j5EYvls
         0PqBkgTGwB5xFUBEekhdjbPQQ3ZBZId3h4FnsnGoYf3Kjl5p4RdYu/B55aTARyiiObYx
         HYSPEEw4idJ704KeZSjcb9KxXwEzVCEVa3laqZBLAlmrxXmDymAf2reDnRIwjt1fEUHv
         OYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rKpsJkAvhpK46Oj026Hnlt3lw23B8Cir0Qd7OTp8i94=;
        b=Z9oMXWXSc1b71FCze5d7WcHxJbSNIiofszWB0nickGpjolXj1/RW+N/SvJNvQWD6Rz
         xho/Xlr/ENh0oN3fOeu1wp85hYlh/x+03+fGM38dzL3F/j+ZquKVywQme+d9/h1hTBDz
         R3BXxU5G617Lb1rt6Db36jxeUvX7zpYhkEUq2F0OxlpZo9142a8R7sqPM9aLhAbEkkaZ
         RtNgJ+42Zn6PiS28NIcTkT03zG774o00b8AomrfQf6itZmS/Mt60N1/ZEmb2c+WaBuX9
         W+IqrxYQVs/jA7UfT4tdAanOP7wfiGzypOrwt86Qzs+3stG1w2Gge9UxM7uqJ5pxpZAL
         L4wQ==
X-Gm-Message-State: ACgBeo2aZrqm5khRxZiboLiUhiYDPZHC+yTOzUZTAphZ05FgZU09I+0J
        SgfobLk7QlkuJeHX7waMWJQ8gt2K58Rd
X-Google-Smtp-Source: AA6agR4ZZ4/L/oV7IUKIC48Wz9Yb4rYjAYbL1P2OxP2WEskCqZufqLL2yZR+AapD+iMe9y2Gco2or6qcmyuL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:230e:0:b0:676:a887:3006 with SMTP id
 j14-20020a25230e000000b00676a8873006mr4122720ybj.558.1659127348323; Fri, 29
 Jul 2022 13:42:28 -0700 (PDT)
Date:   Fri, 29 Jul 2022 13:42:15 -0700
Message-Id: <20220729204217.250166-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 0/2] perf parse-events: Break out tracepoint and printing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parse-events.c is a large piece of code that doesn't need to contain the
printing (perf list) and tracepoint functionality. Split apart.

v3. Split removal of #define to its own change as suggested by Jiri
    Olsa <jolsa@kernel.org>.
v2. Rebase in particular after hybrid PMU changes.


Ian Rogers (2):
  perf parse-events: Don't #define YY_EXTRA_TYPE
  perf parse-events: Break out tracepoint and printing.

 tools/perf/builtin-list.c          |   2 +-
 tools/perf/builtin-lock.c          |   1 +
 tools/perf/builtin-timechart.c     |   1 +
 tools/perf/builtin-trace.c         |   1 +
 tools/perf/util/Build              |   2 +
 tools/perf/util/parse-events.c     | 714 +----------------------------
 tools/perf/util/parse-events.h     |  31 --
 tools/perf/util/print-events.c     | 571 +++++++++++++++++++++++
 tools/perf/util/print-events.h     |  22 +
 tools/perf/util/trace-event-info.c |  96 ++++
 tools/perf/util/tracepoint.c       |  63 +++
 tools/perf/util/tracepoint.h       |  25 +
 12 files changed, 790 insertions(+), 739 deletions(-)
 create mode 100644 tools/perf/util/print-events.c
 create mode 100644 tools/perf/util/print-events.h
 create mode 100644 tools/perf/util/tracepoint.c
 create mode 100644 tools/perf/util/tracepoint.h

-- 
2.37.1.455.g008518b4e5-goog

