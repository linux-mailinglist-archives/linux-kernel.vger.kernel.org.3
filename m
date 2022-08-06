Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E3C58B388
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 05:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbiHFDeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 23:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiHFDem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 23:34:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0540D1A044
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 20:34:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso1472345pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+hrmdEAmwTGkEMDWBMXJiZSEXBkeTQ+/+EoUioJM3U=;
        b=mqAOQmzcb9wJFWUxgqeyhQaX659m3/RPcVAs2RjJr1dLGpkVTlbDV8wCbnbrpFdr3+
         8Z/cVyaItHnEFaMYY9rqMfql61BaeGKWOkkNZMdFQLNrwZgRgH+tcLJAvKDby+r178Yk
         V/tcnOagRrnvGVAFlglNttt4wM1umnqdMJoB7XTHMFPnt1+zGphCOoPlIqj7EUjvjxH/
         YWgoJV4Xjqkw6ZpWLDglL9dl3esyn3XhLpKe66hfR0f1REQavi2Ni/FjzIjmKXmy+HBw
         3UF1hYLVpqW3nv/wbqXfXzsPM5JEvE8FwPOpGr0ou4maYWJBECx6vAAyR0cPRQJiqGMu
         WRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+hrmdEAmwTGkEMDWBMXJiZSEXBkeTQ+/+EoUioJM3U=;
        b=MLxJrOwtqpstNVBKar/tyiTpZOYhuo/obttGbvykJfCjUn6uw/9LmrHiv3CpY2J8lu
         wu6q27AGfk6H8GoiCZySd4KP8j7FdBiB5C8TDFUzKgE0JrT7zhl5FUR0Y8w0ILGcQWaa
         /BPUm0+DIcY2njRNmE80IzWTMi3sGdbI7rD4V05Gx21vm0Xp3JGJ4+PwyiAet6+uhzGa
         oyPqmwV5u+o5h38vRujqgCzAWqn3ndtu8oFdCAOIV8iMQnmawVwvxxZulL+JtP6YCh3H
         NbA6u+kl4OZN8MYagfaCF1jY5xoV1q5vkkSpxZtFCCynr9E8xqOcL5NQjCQZqQ76YQMZ
         zgAg==
X-Gm-Message-State: ACgBeo3kiY+C1hsOPjYRMBI4fmZ6RjUxl+9xqOyonVpQawWI8yWBdO6h
        Zi5W4eRBCvo7MLiwpETxSAULQw==
X-Google-Smtp-Source: AA6agR77xQPUr1ibDY28USqNXT0ehsNzUDHGC/TVV0pGo6GzePAbxNw4umUsnFLfxBtw6HUrkB0hrg==
X-Received: by 2002:a17:902:f54b:b0:16e:f07b:46d0 with SMTP id h11-20020a170902f54b00b0016ef07b46d0mr9632990plf.77.1659756881331;
        Fri, 05 Aug 2022 20:34:41 -0700 (PDT)
Received: from localhost (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7970e000000b0052e82671a57sm3842614pfg.73.2022.08.05.20.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 20:34:40 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/2] perf test: Add test for java symbol
Date:   Sat,  6 Aug 2022 11:34:32 +0800
Message-Id: <20220806033434.121908-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add a test for java symbol.

To allow a shell script to know the installed lib path, we need to
export the environment variable "PREFIX" in the C code.  We use the
first patch for this purpose.  The second patch introduces the java
symbol testing.

The test has been verified on my x86_64 machine with mainline kernel.


Leo Yan (2):
  perf subcmd: Set environment variable "PREFIX"
  perf test: Introduce script for java symbol testing

 tools/lib/subcmd/exec-cmd.c                |  3 +
 tools/perf/tests/shell/test_java_symbol.sh | 66 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

-- 
2.25.1

