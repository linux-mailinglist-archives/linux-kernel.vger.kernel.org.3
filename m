Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334755C49D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiF0Quk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiF0Qug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:50:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6214F5B6;
        Mon, 27 Jun 2022 09:50:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n185so5790060wmn.4;
        Mon, 27 Jun 2022 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7Hsl2uga4BWww01zjD1ZVcBEkd3C0wHhuB0PJts4bs=;
        b=IbCtxMYCu6wVWLe8i1R3rYHrDbf1VZ9aB73YiFVzrgh+s25sFQRZbULnvc4iTvSSC4
         Sq1dTWSoqrCgY+o8GvImKin6irgPGSDDWAPoOTkTWTmpMuLfSy3OASFh+HS/eYnpwuSA
         CxCeefhSLV2K/4xhP43xmM44EvHOErrXr7J0Dl6OyjTffoAFJXRCDPhp/Vytc9+WvoGf
         8v9PQv1jpLEI2UAp7B1wUhrdZHUyzILov+/wmFfCiFPaXDu+IfFYIGJWkBhKdHr+Q/Ib
         EpR6mQt/GPspuVinXL/EgyUBg5AHnj7Rznmp238rKUy+8ULHX6fyUpoekCuuER9KTYng
         3F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7Hsl2uga4BWww01zjD1ZVcBEkd3C0wHhuB0PJts4bs=;
        b=Cvq0Mlmm7tb45oWdHkte8R5gu641huJLnJ2l7/eKJLadGjtsCYvMURsZ9/c4/r/fba
         5Th6N5u1/PSTsuRuR0VCfziRbHP3g5Bxp3hih9t02oYGc5oOFZV/F3nCxV5Bphb8Y9EE
         IuAv6frpavso8ZGlaWr9XUZYTdc1WZXUmmGrsnK8OyqusbAFCG6YvIP17/VBOfFVZ4hP
         2hWto660sWRQTp/DxdAXMuhlwcne9kCXVB6r00yCUiE4p5uOUIF/XDoUGfUQlJwxZMbK
         x7HXloFfcjDW1tBJnDKfPrhpFhMOpDfN/m8HC55Sup8evxFuU/PHwPHfjLn28UyjZQf+
         QPxw==
X-Gm-Message-State: AJIora9XxZO5ACV6SQkcyUjk9t9amLqFky3sTwSg98VUWERch0hnl/5S
        R2sRrXRZL5IcodmD7p0QgDY=
X-Google-Smtp-Source: AGRyM1sHOzOAcWp6o5ZNecGHwGQkgkiAE8rSfAgKatCNrhLyyd7RLh99kLZ0pXmAnhtxZ/nnEj+XFg==
X-Received: by 2002:a1c:4d10:0:b0:3a0:4697:4f5c with SMTP id o16-20020a1c4d10000000b003a046974f5cmr11202064wmh.22.1656348632327;
        Mon, 27 Jun 2022 09:50:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b003a03185231bsm13542332wmk.31.2022.06.27.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:50:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/rapl: use NULL for a null pointer rather than zero
Date:   Mon, 27 Jun 2022 17:50:30 +0100
Message-Id: <20220627165030.146986-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are pointers being initialized with a zero, use NULL instead.

Cleans up sparse warnings:
arch/x86/events/rapl.c:540:59: warning: Using plain integer as NULL pointer
arch/x86/events/rapl.c:542:59: warning: Using plain integer as NULL pointer
arch/x86/events/rapl.c:543:59: warning: Using plain integer as NULL pointer
arch/x86/events/rapl.c:544:59: warning: Using plain integer as NULL pointer

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
2.35.3

