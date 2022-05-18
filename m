Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3C52B16C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiEREUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiEREUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA76393
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fb7bf98f1aso10564887b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ud9QzbIsCb5APT2y97Edpxaxa+OkwW1AX4JBgjdYyqw=;
        b=ktS1a4chIOxiRYGlAbnl4hJ7+f4on9RqrrtLmCCSodmdkFq3XAFzIdr8PBWDBamj23
         9xic/o495qLyAi8eHdAplNEadZu+jd1bUT9LeBUpHRJ6fX/akKIqZ7THje4ej7QSzJ8X
         AhGQriUKKK7bAXF8F0WPMiDPSFcpRdAEvy/sicJgjiqgNtlVahdgz69IgSv5QNNXGygA
         6sIIKjbfjqCniay96RgSZbx9KJNgV1Ggm43noXPrBzvp4z72wCTBj3EuYgRbsxCCJYUp
         eT9MC312QwDc1m+tRZSjZIxBZn9aa1Isjom4TAutC5QedjbH1d57mnOJf7UnDB+J0HcQ
         Xqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ud9QzbIsCb5APT2y97Edpxaxa+OkwW1AX4JBgjdYyqw=;
        b=wH696xiLzRHzC0K/JMIoKHunj9P1myICKflCxT4CB+2LbhNkdbrOHJQsj+z+Bd3NnG
         ZJslnZttYCtd9QG5fyR6olZ7rUEDLYoLyAk6WUw50Dfx8Aa92dod+qNwoXlGMAWdTB3q
         4Fhv7xzlE02NxJRJ3bryI9u7tAF/My8ZkB4SeDtpUAlvhcMGVU0UFYIQjMs09QKfijYV
         aD+OUvzP6jaCF4k3h2FxKmWJjOO9B/Jo1SAmWqvHFcDdaQDBBGdr7CNgqFtjJm0PcFz9
         GWTWenr+41+fjMhyJQpWRJBUJW91J8XOO1lnDDnpjpklck6u7zUBQD23EFIupCSWTPhQ
         ACnA==
X-Gm-Message-State: AOAM533XlRxRC96qJP53c2NPvcVzp6Jl9LaUOkhhMNgkj0RzGZX0ygrc
        jHU393pK1n9OKEn7YVviHi7t0sc+5fJp
X-Google-Smtp-Source: ABdhPJxbk/iG19iu/TMh87CdvQmpnxmoXa2dXZ21datK80WssvHarwN0ufAmeh0tBgq0XaQ3hcJfZh1zUJTY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a5b:101:0:b0:64d:ae10:3d26 with SMTP id
 1-20020a5b0101000000b0064dae103d26mr13128289ybx.103.1652847633483; Tue, 17
 May 2022 21:20:33 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:19 -0700
Message-Id: <20220518042027.836799-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 0/8] Make more tests skip rather than fail
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A long standing niggle has been that tests that cannot pass are marked
as failing rather than skip.  John Garry mentioned a similar concern
in [1]. These changes fix this behavior so that as root, or not, at
least the first 10 tests are passing or skipping.

[1] https://lore.kernel.org/lkml/d32376b5-5538-ff00-6620-e74ad4b4abf2@huawei.com/

v2. Updates reviewed-by and acked-by. It addresses review comments
    from Namhyung Kim <namhyung@kernel.org>. An extra fix is now
    included for PERF_RECORD_* which can fail as a user because of
    perf_event_paranoid.

Ian Rogers (8):
  perf test: Skip reason for suites with 1 test
  perf test: Use skip in vmlinux kallsyms
  perf test: Use skip in openat syscall
  perf test: Basic mmap use skip
  perf test: Parse events tidy terms_test
  perf test: Parse events tidy evlist_test
  perf test: Parse events break apart tests
  perf test: Use skip in PERF_RECORD_*

 tools/perf/tests/builtin-test.c            |   6 +-
 tools/perf/tests/mmap-basic.c              |  18 +-
 tools/perf/tests/openat-syscall-all-cpus.c |  23 +-
 tools/perf/tests/openat-syscall.c          |  20 +-
 tools/perf/tests/parse-events.c            | 492 +++++++++++----------
 tools/perf/tests/perf-record.c             |  18 +-
 tools/perf/tests/vmlinux-kallsyms.c        |  12 +-
 7 files changed, 341 insertions(+), 248 deletions(-)

-- 
2.36.0.550.gb090851708-goog

