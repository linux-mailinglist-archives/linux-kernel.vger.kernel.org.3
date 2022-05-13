Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288A8525A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376934AbiEMEFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376924AbiEMEF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:05:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E929B01E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4e17a5809so62564927b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AT5fEYFiJn9Jy20X399vb4DWFUsA86uVN0Y/NmGabp4=;
        b=YpXQcS5bTswt/iCpkTv5EYf8NbQ15MTR7Xt3cq+CElJxozPM+HirOd52+6OwCLzSCC
         1I+zfaO/CmNEthc9KIlw/wZKYDkXB2lw3r6WEl3xWKDrGiKzZRK7SK6/E6uvQGEkrLLl
         /do8wk2CTE+rVLj7171SDsRLovVFfsEYo0IQd5ERYYCNSiMChQmH46MTyXCPpNKJZ8Rr
         /s6oYwozGhzXW5y7I5+OxXnHoORGS5cXhv+/1m72T7JJCVhMr/jLO3R8FY+AHQW51KcU
         w6pidlwoFTpnDxXxiR2LAPeNjhHPMBWALKFqJrZ/M3I+OVPG9LYbLCR/RsQ+e98W8qHo
         CRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AT5fEYFiJn9Jy20X399vb4DWFUsA86uVN0Y/NmGabp4=;
        b=Bbv++9v+1cQeOY3cfKoOo3wMphZ/tTLaICqnMumNdv6rT4xjcBcFS3TmvnYCv49Sn5
         5qNopjkCnJXujhIFASf0ZHBxeRWbNVIyenzl47nWpzsrUoZdVF62J2o4N6n67FjRmPZy
         Ff0m99wx5JQcOVxGhbX7OKu1Y2qTwuc686JliUCzNRSZ6PRyS7Lr7QkPjLl92Gew3kUK
         o60HQGmsKj5QXCsk87cJP2i7bKdN6fB7Iqpj8M1xpBp3rQsNHx322vTe9QFpMdG9oTbX
         +Ej8CpFy82K1aewR19W32X1l5R+CrDZXsvkWtEea/KzTT/er0+s8MZ5cz5sqR2F4EyIh
         0JoQ==
X-Gm-Message-State: AOAM532iJDsPI3Tr1HGq+pEgAhVffUVyIo7cGlIK9c7BZznthWcVQdd9
        EF0HSEtcOY1ztnfU71rdQpPREuzTToJN
X-Google-Smtp-Source: ABdhPJyFab55ch05scwSx2EefnFRCnaVxXApk1fXpoFK6eRWmzRWgp6y/KUVI4p7SIp2l4Nb1+yNpJLTFk1H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a05:6902:102a:b0:649:4564:5407 with SMTP
 id x10-20020a056902102a00b0064945645407mr3095918ybt.565.1652414725674; Thu,
 12 May 2022 21:05:25 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:12 -0700
Message-Id: <20220513040519.1499333-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 0/7] Make more tests skip rather than fail
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
        autolearn=ham autolearn_force=no version=3.4.6
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

Ian Rogers (7):
  perf test: Skip reason for suites with 1 test
  perf test: Use skip in vmlinux kallsyms
  perf test: Use skip in openat syscall
  perf test: Basic mmap use skip
  perf test: Parse events tidy terms_test
  perf test: Parse events tidy evlist_test
  perf test: Parse events break apart tests

 tools/perf/tests/builtin-test.c            |   6 +-
 tools/perf/tests/mmap-basic.c              |  22 +-
 tools/perf/tests/openat-syscall-all-cpus.c |  23 +-
 tools/perf/tests/openat-syscall.c          |  20 +-
 tools/perf/tests/parse-events.c            | 492 +++++++++++----------
 tools/perf/tests/vmlinux-kallsyms.c        |  12 +-
 6 files changed, 329 insertions(+), 246 deletions(-)

-- 
2.36.0.550.gb090851708-goog

