Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DCE49BCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiAYUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiAYUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:14:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365B0C06173B;
        Tue, 25 Jan 2022 12:14:06 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l25so21928210wrb.13;
        Tue, 25 Jan 2022 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um8d9+s1XSjgsk+lNomKxkc38qhFGc/J9+962ua/YsM=;
        b=gMwIXMDWIXfGlmOLKGK2+LXWO5JTVPu1p+Jzn3NMkNe/piruZKacx3Vj5nfFiB+yVM
         8GcJS47eozMSgtAXPpt4TFH17PSUOJdezOCG9+M0GQPPJlIpuhdh9xytNRxXWHwehTNJ
         eYqehwaFOiDqfxLABuQoG4UiIs5ci2+a2YW9LorrpASuzneEdRRClO082vfY69O88QS1
         11VLbN8vSEs6fV+mhPVxIC05yX8kc9LZpniet7E6EBboAPXLUmRU6EdFadsJCE7ZPaFI
         Ut35de3ZF+sR9GmgAGHJzJ5lbUNau47x7vQB5ctD855WoqvYYEBF9gvTmKRtJ1g2+SF2
         BfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um8d9+s1XSjgsk+lNomKxkc38qhFGc/J9+962ua/YsM=;
        b=cBp8JGeD6QGj33zUC8zolE7nsL9NHUQ+Wy6jegveULrIFn1N2qUupqIDsJ7+fzZ+5Q
         KYO5xZerLTjIFXol5cmn+SB29L/fZ+FFJJPteoUsJtcZra3Ud4we74UWpMsd2MdhSz4m
         pcQm+pT34IegLLvf35JG+Db7oyVjD6vzhNy6PAWQK8LCpvrsQkzkWCEHF3KrNNSTU5ae
         qs9A61jhEelM+gImCp0Kib+LL3qHqAUW22I8MYnJZcAENT7JC97KWwaNMAeBjqyaIdwJ
         E2Xw1iIRLKYn+94NomrhSUBqkQzUxBkAhaxyXXUzZ87w6OhqxOdRBIO25orsfsrErAwR
         FSNg==
X-Gm-Message-State: AOAM532ShPzGi0i9VX/SUMXyyozU/GaoVioYrrjIJ8KM6TDA7a9EGYd1
        M74zFoxkaWbFFtfnchK8634=
X-Google-Smtp-Source: ABdhPJzCUMy77BVhpMrOx4JvikcWFix1WLk8dZ8XA44Xl5jwxS2LoKOO8sEUb8FTj22K/dkjKbQVTA==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr10744414wru.613.1643141644669;
        Tue, 25 Jan 2022 12:14:04 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v5sm1166257wmh.19.2022.01.25.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:14:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf/x86/rapl: replace 0 with NULL to initialize pointers
Date:   Tue, 25 Jan 2022 20:14:03 +0000
Message-Id: <20220125201403.670011-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be initialized with NULL rather than zero. Fix these.
Cleans up sparse warning:

arch/x86/events/rapl.c:540:59: warning: Using plain integer as NULL pointer

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/events/rapl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5ad..7d70690fded5 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -537,11 +537,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
  * - want to use same event codes across both architectures
  */
 static struct perf_msr amd_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
+	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
-	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
-	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
+	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
+	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL, false, 0 },
+	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
 static int rapl_cpu_offline(unsigned int cpu)
-- 
2.33.1

