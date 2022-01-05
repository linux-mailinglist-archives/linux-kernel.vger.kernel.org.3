Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726384858C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbiAES5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiAES5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:57:14 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDB8C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:57:13 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id bl6-20020a05620a1a8600b0046803c08cccso274970qkb.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JUqJv5lRVzTBWkZTFA3tvsg/sllAzwrzwk7g0zegheY=;
        b=TQz0ZKzqQP0Ow48pyHYYEOx1YBnrjV9M3rupZhoCgHcQUcnm+GxAiYy0zIVwZ1t4iE
         ENHc0hgeBXXjYCZcJxJM6ktxvMjPOA1teG34vh+IYfs7VeR9m/7jJOyTUG3Rf06w8FuJ
         Xdbdz2QorQ+e2hv2qPZaFl54rkeS82tgI/WiipwlatdMYuMo/3DVBsB2LgRruUQXE8Z7
         0oDmCr1Ez3GhYfSZWjWYIe1VQKHK4Bds4n58BQkNwi2sLccuM1HTQJ4B4U5gV0uVJOq+
         XFw97IQpOhuRZtOlPNMOwkIy9eBOCoUMu2JuE6RS2GWZNxMiIRIzARiOpQsHaZB1MVPf
         KIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JUqJv5lRVzTBWkZTFA3tvsg/sllAzwrzwk7g0zegheY=;
        b=ni0jTQazeydx2d7rqD2znrlCx9u2MiNBmLokS6TjoPXnYEV7iFhAOhrimm1vuE9Jez
         ZUmJ9iUeMjhZkX8JXjp1FUl8f4UX/KagyrcafNuWGkjmjUjeXufiAsQXkHfT/WZ82va/
         w53tjU3J3ax5u047U+eGCDfL51k48ke9J1GVq0CG+1H/RkA0hU1Qd6YBpxRTNjjTDzkV
         n7ymda9/F/Iys5YlM9qS9H0stnmQXMxSA2tJaBPV8MqzFadDdSJR/26dOxJ6kpU4QvS8
         NgwBTkVSZu0r6yX4TK188BeJJ4xP5RwQcVjKdPQe03iSS2DyHnbV+rpwZ1GUYLTBQspR
         dBMg==
X-Gm-Message-State: AOAM531qaLlKnQk1u3YZV6tm3ZgOWTO4oLqncfPuekyPBBjKGuaGfBlq
        MCdM+Zqu+6kI8IFZOhxXCxFl5IKJD9LYQ7UxFXsVhaRiaq+gcVAT4G3aiqGKTWEtAdWgbbelnKv
        8cQVYNhDoIw5AQfDftLyVqqkthU4RZ1h/YJtJJdjIEr5RMdJwMrsW1XrwNPRCINhXgwxiWFqE
X-Google-Smtp-Source: ABdhPJxkRbHmXkG67FA9ss/JYB+bXdstIzKY23oHy3/mS4T4wm92zXqKXJJeqOSuHqQqTham7ctWQONLN17y
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:559b:36b7:c90d:3c60])
 (user=eranian job=sendgmr) by 2002:ac8:758b:: with SMTP id
 s11mr49694684qtq.51.1641409032594; Wed, 05 Jan 2022 10:57:12 -0800 (PST)
Date:   Wed,  5 Jan 2022 10:56:59 -0800
Message-Id: <20220105185659.643355-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH] perf/x86/rapl: fix AMD event handling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, jolsa@redhat.com,
        namhyung.kim@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RAPL events exposed under /sys/devices/power/events should only reflect
what the underlying hardware actually support. This is how it works on Intel
RAPL and Intel core/uncore PMUs in general.
But on AMD, this was not the case. All possible RAPL events were advertised.

This is what it showed on an AMD Fam17h:
$ ls /sys/devices/power/events/
energy-cores        energy-gpu          energy-pkg          energy-psys
energy-ram          energy-cores.scale  energy-gpu.scale    energy-pkg.scale
energy-psys.scale   energy-ram.scale    energy-cores.unit   energy-gpu.unit
energy-pkg.unit     energy-psys.unit    energy-ram.unit

Yet, on AMD Fam17h, only energy-pkg is supported.

This patch fixes the problem. Given the way perf_msr_probe() works, the
amd_rapl_msrs[] table has to have all entries filled out and in particular
the group field, otherwise perf_msr_probe() defaults to making the event
visible.

With the patch applied, the kernel now only shows was is actually supported:

$ ls /sys/devices/power/events/
energy-pkg  energy-pkg.scale  energy-pkg.unit

The patch also uses the RAPL_MSR_MASK because only the 32-bits LSB of the
RAPL counters are relevant when reading power consumption.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/rapl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 85feafacc445..77e3a47af5ad 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -536,11 +536,14 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
  * - perf_msr_probe(PERF_RAPL_MAX)
  * - want to use same event codes across both architectures
  */
-static struct perf_msr amd_rapl_msrs[PERF_RAPL_MAX] = {
-	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr },
+static struct perf_msr amd_rapl_msrs[] = {
+	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
+	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
+	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
+	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
 };
 
-
 static int rapl_cpu_offline(unsigned int cpu)
 {
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-- 
2.34.1.448.ga2b2bfdf31-goog

