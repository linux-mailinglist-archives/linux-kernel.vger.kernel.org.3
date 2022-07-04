Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0556595B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiGDPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiGDPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:06:18 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286DD10FF6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:06:11 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id w12-20020adf8bcc000000b0021d20a5b24fso1472971wra.22
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mWoq8j7y43ZVuqvviGPucxALD5XppzdZ4sJTYXDQo5I=;
        b=o4x3EbC/WAMFSmZyAzqqhwT+64uLX2fQw1Za1JHbjGeLpl9EgocgpuxhCPwG5hBzx1
         2QRLsPA/B2Xwl2elPFL5fiKctWvCDba3AYkvDgIvHHXQ4Dv89PBxneEJN5lCr7u2PJyg
         D3HCwrGwVa93+LaNNU0WxUbUfgEBQzxaWSKWj3qVtM2RVP0LD8CnC/B2GiHRK03A36UP
         gFjrt0HcwWZrBpqDMtWotwxwsiY/j9M0ytl6MoTuuuzma087NAbWH5QjOSfKtA2kaLPs
         TNz5C+HGwJxtOmizKAxCxdLI8LUymzEvIqkYP7AMYke92ZW7S6jNGjd27Hml4yQiN5GV
         sAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mWoq8j7y43ZVuqvviGPucxALD5XppzdZ4sJTYXDQo5I=;
        b=mHyvo4YOIkefw+mpwSmzgnkAlUDhjDqJLqVJirSJY2FpzMSwxqhrcATmjboufFWpFQ
         4ZWAE8sRytmW5ge4bI4Vig6rcDxoEtc7efGXY0+oa6aDHQclKh0dDRXYyAxIO3i7uAwy
         VJqdRiR8wC7igs+dO4Ab2SKxh4V6DhXAMhdMFXWNt+YtEbHw4+lcGBgwlx07RNm4hq7W
         aGyPI6geXZX3wKyzTqBfQq2lUh3CcYEpZKFaf8lz86DdlijFhLvC17WNd6cvEPRQY6un
         F1FBp5HewQNDa1Xt9amQ07E1wz+TlMLNH3l+X9h7r0XXju4DCWA62MRDgPx7X5ERK2WC
         6Aqg==
X-Gm-Message-State: AJIora+amIwqTCFcoZtwzAThtp3hqEtGinRAzRXRgGDatlXJeMFzEqfm
        hlfbCkp3vGMz6zmemrJTEcGuof+xRw==
X-Google-Smtp-Source: AGRyM1tcdZ9jN6MWKmmKZRKv/z//DHI4PTni9uMfGZdA/k4tObVoHQhXgYZke3bw6qoxPycrNOI32MK5SA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:a5d:47aa:0:b0:21b:ad9a:d48c with SMTP id
 10-20020a5d47aa000000b0021bad9ad48cmr29662846wrb.610.1656947169805; Mon, 04
 Jul 2022 08:06:09 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:05 +0200
In-Reply-To: <20220704150514.48816-1-elver@google.com>
Message-Id: <20220704150514.48816-6-elver@google.com>
Mime-Version: 1.0
References: <20220704150514.48816-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 05/14] perf/hw_breakpoint: Mark data __ro_after_init
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

Mark read-only data after initialization as __ro_after_init.

While we are here, turn 'constraints_initialized' into a bool.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/events/hw_breakpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6d09edc80d19..7df46b276452 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -46,7 +46,7 @@ struct bp_cpuinfo {
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
-static int nr_slots[TYPE_MAX];
+static int nr_slots[TYPE_MAX] __ro_after_init;
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 {
@@ -62,7 +62,7 @@ static const struct rhashtable_params task_bps_ht_params = {
 	.automatic_shrinking = true,
 };
 
-static int constraints_initialized;
+static bool constraints_initialized __ro_after_init;
 
 /* Gather the number of total pinned and un-pinned bp in a cpuset */
 struct bp_busy_slots {
@@ -739,7 +739,7 @@ int __init init_hw_breakpoint(void)
 	if (ret)
 		goto err;
 
-	constraints_initialized = 1;
+	constraints_initialized = true;
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

