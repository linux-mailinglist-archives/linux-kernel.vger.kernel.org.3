Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D0464466
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbhLABG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbhLABGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:06:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A9C06175E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:47 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m17-20020a170902db1100b001421cb34857so9232682plx.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cRr2bFk/yezo9ObMzhVmLZr/3+gVMpF/MptINrWiJkM=;
        b=gBjzqv7cL6Lu43ljt/aE05eHGjb8xF77C0+Sj2LvC5C9YOm8SSgNZ0moYtK7lUi1XC
         jOGfHecgi8h/T5Bfix8pegfh+LbsqUIxDNid4OIaaBtEkWImUc+oPAmGAUatmIFEj9Od
         ELNjOotPf51Klkqj1mWXs6hRXO4+gu1hDha2FFTEE5RJAffZEqBTW5Szjk1613qF0AbB
         iLY9Yd4OhNtTSq4vtmHih0I4Ij2w/H84nvO3ML7Ydkc5iwO2PUokjuTwpZHl/hpsdhOF
         CJbdWMgC0bRC2/lQ/NOHy/or5nK8fn9t/3FjAFS7FdL+K16c4zhRST9h17gWoHcTWMti
         CLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cRr2bFk/yezo9ObMzhVmLZr/3+gVMpF/MptINrWiJkM=;
        b=pP3gJpDaXqdy9AG1CJ8g7h1+sJbseggsB9GDSPcJqIeaPQtqb803Pivpi2s7sYvnFs
         aY0MAEo3Z2DxSWBXUwvg8499AhfWi/c4dYhAvTutIF6eZ1Uq7b9hMOy8LSciSIEqS4Aj
         OtcnI+JRwTbEnxpx0qLDMaM/+ylyPgjYNnTZoZf59nJpdOTRLF2X7LJy/9jHwes3ABMG
         m2LtO2n/369BJMjPeg+TJfPGqgfxfXuXOae5+KXJ72cLJpzLdaoH8nmeEM76z1qP68Pz
         WmI+aKpiRXnoRLO+oVjNAXxyx4nZR/PdkjHNobOZn4ArmzEqU1vrcGdTev3Da3990ijl
         D0ug==
X-Gm-Message-State: AOAM5316lxLr8PEV41riG856t0RSrwk0RMaO0s+6VHAs2erBY0rbNT8f
        kKWHriXlKolZUsHPK6Qnd6MvHQSGER+Mwa0pT6ClZOWHoyProAKyr3GTK4fwJIBRQOX6I5Zhu7w
        tCLiE9zvIkwuWmdVx7t9TT87rm865UzczOL5Lw2/iRyJGsyLAzZcJuWM4TU/bfaDR66vP0C6V
X-Google-Smtp-Source: ABdhPJx/+l1kCsUZ4dO9q3m1+XezE9U3c2Cm9nUtz5RhY8uVmkro0fv4FB52yAs8A/cgc72GgpqzBRUT8bsp
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr230790pjf.1.1638320566860; Tue, 30 Nov 2021 17:02:46 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:16 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-13-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 12/13] perf tools: improve error handling of AMD Branch Sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the error message printed by perf when perf_event_open()
fails on AMD Zen3 when using the branch sampling feature. In the case of
EINVAL, there are two main reasons: frequency mode or period is smaller than
the depth of the branch sampling buffer (16). The patch checks the parameters
of the call and tries to print a relevant message to explain the error:

$ perf record -b -e cpu/branch-brs/ -c 10 ls Error: AMD Branch Sampling does
not support sampling period smaller than what is reported in
/sys/devices/cpu/caps/branches.

$ perf record -b -e cpu/branch-brs/ ls Error: AMD Branch Sampling does not
support frequency mode sampling, must pass a fixed sampling period via -c
option or cpu/branch-brs,period=xxxx/.

Improved by Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 39e9063c0a80..af0bedbffff5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2890,6 +2890,12 @@ static void detect_amd(void)
 	fclose(inf);
 }
 
+static bool is_amd_brs(struct evsel *evsel)
+{
+	return ((evsel->core.attr.config & 0xff) == 0xc4) &&
+	       (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK);
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
@@ -2992,6 +2998,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
 			return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
+
+		if (is_amd && is_amd_brs(evsel)) {
+			if (evsel->core.attr.freq)
+				return scnprintf(msg, size, "AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.");
+			/* another reason is that the period is too small */
+			return scnprintf(msg, size, "AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.");
+		}
+
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.34.0.rc2.393.gf8c9666880-goog

