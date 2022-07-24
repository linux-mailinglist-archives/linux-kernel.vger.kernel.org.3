Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E057F2AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 04:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiGXC3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXC3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:29:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787B16582
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:29:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i13so883256edj.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rYzJ/KBEGXFJxA0AV9DmAz0hhVRdBd/r7tm5Wxe7raI=;
        b=KFOqdLBCD8Xg81CNdH4v/1KIBTWYBuYdQumkOl0oI8pprxO0/DvtsLMACszAPZ/dkW
         kiHkYhcWhzhj1srAng1Sjn0s5Tj3HVmVVgDDmYy8pCZ9pxBN64n67ONsGRssp/agJ63z
         4sWgQ6jL+UssQ/BzfUWLBa8QWHDF3/vrkylKAginAeGboHAKipcqEW2ved7ZKDhCiIsQ
         cm3W12663uuefDhd0vxVHlCPiQa1H3+1NbOHo9mBb5wmKqRNXjnxMQQxmw7sO0dhq+nL
         A6LN6F0rYrmDfcFnCSdhnwE45x7IMR6jEGjpIecfM2pS4IORi3qFgwrzTd4jUbr/HowF
         MWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rYzJ/KBEGXFJxA0AV9DmAz0hhVRdBd/r7tm5Wxe7raI=;
        b=FbbgKCrr0b3H7Rw6fme+QjOX1AdHdamDQqXrFj7xdeaLuujXr1NxLRUsAruZKrFTMu
         S3icMcfPcVmHZfolOu8ztKJJu8uKZU/B+IZ41PrfK5AkrJPv6nvw2itFz5VsttbM1/0i
         wk4nwKQAUTE1v4uz22Oi7utMeDhNMeXunFTSQWVUMUPhMGvzHDzgnSqiEA0j45Tt4UAW
         tT75Tf/gr70PX+dwkYMGQoPpUx7EZB1jm5jLz6Tdd5lsArurgB2DOp2JZlvd1ZdYZ+e3
         dNEx7O9Y9HUVqetqebWJMtXoXR8J631d3Azyk5Wccg+9/8nmEK3/fWKLg0x3OKe/hDqO
         5pag==
X-Gm-Message-State: AJIora/E4JdehwJP+6VhJFoqqDbRuF4JgWq1CZZ+siq+jJwI6d0DR2Uf
        oPupyV3rZx9zmxOsbzYL/wu8lA==
X-Google-Smtp-Source: AGRyM1smGIjmMXKTtd7ztWaQhoMBnZtXh4WiTlkKTJwmBvaoM+ROoXUWQuKLap5Y6Gxj/KfhjajtNw==
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id d19-20020a056402001300b00439ffe8bec9mr6798189edu.297.1658629749572;
        Sat, 23 Jul 2022 19:29:09 -0700 (PDT)
Received: from leo-build-box.lan (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b0072b31307a79sm3741524ejy.60.2022.07.23.19.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 19:29:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/2] perf symbol: Minor fixing
Date:   Sun, 24 Jul 2022 10:28:55 +0800
Message-Id: <20220724022857.2621520-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains two minor fixing for parsing symbols.

The first patch changes to use program header for parsing symbols of
user space executable and shared objects.  Since kernel's symbol parsing
is more complex than userspace for support both kernel symbols and module
symbols, this is why this patch set uses conservative way and doesn't
change kernel symbols parsing.

The second patch is to detect symbols from '.gnu.warning.*' sections,
these symbols are used for linker warning, skip to record them to
avoid spurious symbols.

Changes from v1:
- Changed to use program header / PT_LOAD segments to parse symbols for
  userspace executable and shared object files (Fangrui).


Leo Yan (2):
  perf symbol: Correct address for bss symbols
  perf symbol: Skip recording symbols in '.gnu.warning.*' sections

 tools/perf/util/symbol-elf.c | 53 +++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

-- 
2.25.1

