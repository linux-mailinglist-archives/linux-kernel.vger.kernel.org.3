Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D3354AE79
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiFNKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFNKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:38:09 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E62ED53;
        Tue, 14 Jun 2022 03:38:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655203086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h30HHa9jF+uZdIEOGOAgUHK0WvfWButVsj8i2bL6Vio=;
        b=Sh8gtiA1sKFv8/Ql9eFUL/Ok8GiV66l69lGl/WsbFhcgfTSJfEF3pdAfC9Z58sulDCO6nM
        p+t8pBlPRjZbRB9r689/7AwZHFTl2quBZBTHXx/rKSoHDnpdcazCvIHL8zRcZT2w8kOKhT
        sAAdyLrQyOBMOnUnKVSE1V2AnEyrGvg=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] perf/core: fix perf_event_mux_interval_ms when set zero
Date:   Tue, 14 Jun 2022 18:37:51 +0800
Message-Id: <20220614103751.1395645-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_event_mux_interval_ms is set to zero or one by default.
It can't change back when someone changes it from zero to another
value.

Make perf_event_mux_interval_ms to PERF_CPU_HRTIMER when set zero.

Fixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interval per PMU")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 61ad10862c21..73c8c7462bbf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10954,9 +10954,12 @@ perf_event_mux_interval_ms_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (timer < 1)
+	if (timer < 0)
 		return -EINVAL;
 
+	if (timer < 1)
+		timer = PERF_CPU_HRTIMER;
+
 	/* same value, noting to do */
 	if (timer == pmu->hrtimer_interval_ms)
 		return count;
-- 
2.25.1

