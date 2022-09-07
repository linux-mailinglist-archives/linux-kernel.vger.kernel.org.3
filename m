Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6575AFCC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIGGqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIGGqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:46:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7884EE9;
        Tue,  6 Sep 2022 23:46:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 145so13684256pfw.4;
        Tue, 06 Sep 2022 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=JiVPHTiTIaV4jbYQT/3jXTPG0Eo6ESZv0pSGYJq5hmM=;
        b=XzeuYD0WSv7y8BB86oFRFOzgh7/G6HVkyMdQapT67l5mMzYcluHCeR5OUMy7NoPmRu
         rLuy46HjLgm8OdCIFflMamvdjOjhUtCKM0p6ZkYriIL15vUTRHmctZAyI1MTq3oFaqkJ
         qiuvCIG9VE88/mOPianchRdvUs07qUk64LxwqITW04m8bM6B+rz5Y6MErFw97JEpjSkA
         b7yKR27GG6c423o4Y4WODDg2L+7C0qJxwjOc79s3V87GgntMthGwky8xQ8qyhq+yxCKY
         58BJ/tyJRaJD7mzExNBZ/ae2nNYmO5bZdAxYhLOXx3WKC+M+gr8S3R8nFYzM2dnM3hTS
         vdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=JiVPHTiTIaV4jbYQT/3jXTPG0Eo6ESZv0pSGYJq5hmM=;
        b=Dwg6iIsxD8ma0fbmXRhherDOwShdaDeFCzw0W5KtkVXCASzzwbpHjAwU8P3dFySWzb
         odkUqE0aO1nvpMY8s/JOfqzrgTdOCz+3ULG9zsN0q6P9S+ZCGB6oEJsFQspCO46h8kvP
         w7vLtP05Ka9uxfh++WllUMHwf+AkgWiNdIx7CvwmxPiAt8toIBFsxA4KzIe/BVlDHXrQ
         qSBrRTzxfjz0JNMXgtqy+8MOggTZA7HJkILIpTrlDi7Z9A3dPxQBMDEbbIA2MgH67mGg
         pwjlUAm6noQGWz9zVET3+pc1ArpdBECBD3rDc06aNifu9+DCcpBkV2EEekwRGK/DGZQQ
         ZdqA==
X-Gm-Message-State: ACgBeo2AKt2bS39T1TZ42FtBIX4hX0/8KkEKKCIrShzk1hjYNaHtJJf0
        2ulzQTG3ElXBaducvj/r2dU=
X-Google-Smtp-Source: AA6agR5XlquuA3p6kawjor0rnGgc0btvwEbZzaPXQggRsR/PG42wmhRF3DT7Kr7XwmZj0I+dKhdy7w==
X-Received: by 2002:a63:e306:0:b0:42c:414a:95e9 with SMTP id f6-20020a63e306000000b0042c414a95e9mr2207730pgh.139.1662533207789;
        Tue, 06 Sep 2022 23:46:47 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:f249:9066:7da7:4a37])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm11192192ple.48.2022.09.06.23.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:46:47 -0700 (PDT)
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
Subject: [PATCHSET 0/6] perf test: Improve perf record tests (v1)
Date:   Tue,  6 Sep 2022 23:46:39 -0700
Message-Id: <20220907064645.1197894-1-namhyung@kernel.org>
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

This patchset improves the perf record tests to check more cases so
that it can find problems early.  The motivation is a failure in
per-thread mmap with multi-threaded targets which Adrian is working on
the fix.

I added a custom test program and more combinations like system-wide
and command line workload (in per-process mode) testing with
multi-threaded recording mode.

Currently it fails on per-thread and register capture tests.  The
system-wide test was skipped since I ran it as a normal user.  We can
use this to verify Adirian's fix and future works.

  $ ./perf test -v 86
   86: perf record tests                                               :
  --- start ---
  test child forked, pid 1190747
  Build a test program
  Basic --per-thread mode test
  Per-thread record [Failed record]
  Register capture test
  Register capture test [Failed missing output]
  Basic --system-wide mode test
  System-wide record [Skipped not supported]
  Basic target workload test
  Basic target workload test [Success]
  test child finished with -1
  ---- end ----
  perf record tests: FAILED!


You can find it in 'perf/record-test-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf test: Do not use instructions:u explicitly
  perf test: Use a test program in perf record tests
  perf test: Test record with --threads option
  perf test: Add system-wide mode in perf record tests
  perf test: Add target workload test in perf record tests
  perf test: Do not set TEST_SKIP for record subtests

 tools/perf/tests/shell/record.sh | 150 +++++++++++++++++++++++++++----
 1 file changed, 133 insertions(+), 17 deletions(-)


base-commit: 6c3bd8d3e01d9014312caa52e4ef1c29d5249648
-- 
2.37.2.789.g6183377224-goog

