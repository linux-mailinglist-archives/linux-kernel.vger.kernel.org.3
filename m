Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE44A94AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353533AbiBDHkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353265AbiBDHj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:39:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369EC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:39:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e81-20020a25d354000000b0061b1a807047so3089244ybf.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RstoDLOU8xGSgPTdarYg+ZaO1KW5kUvQHWgolszBWj0=;
        b=fATZW+zjvHfuzv98Yy9oqvUh1b2INkd9VYmyI6R/SRfDzrWdlQ3NhAQysUOmHjRWs0
         TnVkTfIo0ZlK/2zZ7uVUT7EPoPPMFTl304MyADeEUjJUgqW09ZdkPEg0nTBaOGpCZkC/
         B9SJRuCLwBUXKqYyYDZcjMA86NmMWc+YAO5ZaPrGKY7157NWKHZBFdBeMSgj5PEzmuEq
         q0ceIXTGIBxQbdTt0HyDLUkg5iclKLj/7QTeTY5G39HEjbKE1oZpYTVemZJBPqMUk4Sf
         uvZmGS2sOom8zQkmlvYAPS2s4igdrCYR+x6m90KR9fdWpz8F4nD6dbn1P7KqfmH3SshD
         22Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RstoDLOU8xGSgPTdarYg+ZaO1KW5kUvQHWgolszBWj0=;
        b=pr6GMSTyf1P1TKCNG7W8gTfRfeMMY3MKBAzqx5zg6KHp4rnHBkZJB4IkgNoIrVRLKq
         UGMB2oGCiX4LmjM46zXxqqIWlxsfo+19ybIWR1AuFPU2VB3Fy7ySWEkTNQNga8JlroCJ
         PsFQ1qCy5DYkDPj2U/9zDqN+O6zB5Gwf38+KJO3Ec2CIX+44MdO5jz0kJOhMXkNvZju3
         UXI7Cg2ibGUIKkKJPqXl4GqF9EBX6NdGN16KIysOuCa7u/7/Y3l/+SXADWNWOGqal119
         JeWE/TRG2SumVBND+Cw2HBWuJ1BKRV9FYYvKSEGuXKxYoLtqV80E52azUox0e/lzHewJ
         ITyQ==
X-Gm-Message-State: AOAM530QWctpCF8QN73Eaz/XJ62fKxmyadjhaJMSm3/npoJIQY2B5HEB
        n1a0my1sLoCtNaaUCY9K/qMp3ryqTXoMWrsznxlyhYKdvGM06Nfsr2JoYKc2RLZ8NH9qgjN5xsF
        jIDTiANnYFzRqWlgs7BHPjKfMR9Kmd6WC4RjImYwbOd1DEwozmqC4J+YlndrPB8DWRi6SD5SJ
X-Google-Smtp-Source: ABdhPJycy5ohl9mQOP26zCD7ZJsLLpKeKTRYuIz2yVe2Q1kKox2IKobeQv5QO4LMkshooFwCLcQlTl/aULzl
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6ac6:e851:689b:829e])
 (user=eranian job=sendgmr) by 2002:a25:e803:: with SMTP id
 k3mr1663615ybd.571.1643960397346; Thu, 03 Feb 2022 23:39:57 -0800 (PST)
Date:   Thu,  3 Feb 2022 23:39:40 -0800
Message-Id: <20220204073940.1258263-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH] perf/arm64: fix mapping for HW_BRANCH_INSTRUCTIONS on PMUv3
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, ashoks@broadcom.com,
        mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the existing code, the following command:

$ perf stat -e branches sleep 0
 Performance counter stats for 'sleep 0':
   <not supported>      branches

on N1 core (pmuv3).

This is due to the fact that the mapping for the generic event is wrong.
It is using ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED which is not implemented
on N1 (and most likely on any PMUv3 implementations). However, there is
another supported event ARMV8_PMUV3_PERFCTR_BR_RETIRED measuring the same
condition.

This patch switches the mapping to ARMV8_PMUV3_PERFCTR_BR_RETIRED so that
the perf stat command above works.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cab678ed6618..ec2b98343a0b 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -45,7 +45,7 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_BR_RETIRED,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
-- 
2.35.0.263.gb82422642f-goog

