Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA749D63B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiAZXf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiAZXft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF3AC061751
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 4-20020a250304000000b006137f4a9920so2444136ybd.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XDVnWNv62PSs0ranIGJi93XvsfRe2VvQf+dpGBw9RJU=;
        b=NIt9zJax3FBFSD8Uc0N6AUdcqm/jqMvFaJ1LzFMkzuBDYzxg2kiKGn5h3bCRvcJdJl
         QKIRt6h4OC6M5A+JMFyOaLC2WGPN+n7Q+Cn4v1enhAzwhV4RAtbjw4Z9+xeleQzvOmPL
         tjeTw/VESgGivA30Ig3G8H3PWPhSH15/ZKd4xFqnFOB7N6V5R5XN0FkOSbGVILgtLYzo
         X//690tmnW11cJiX7D4t78feLWgk+EFcNOvrvmXZlLugKcz3CVxGu7qL070hujLDP9AM
         al7SqKjsIKU/WWZdLQNt3Waq24/7fLThmOlyF/zs0OUYT91eDGyeRa6G9XLBxAtpkcI3
         vnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XDVnWNv62PSs0ranIGJi93XvsfRe2VvQf+dpGBw9RJU=;
        b=E/9Lic7sg/zzE+gQDo26OMjBDiBNKIsjT1soUaB3WnVc/wdgY5DuVAJWFInksCGWOi
         79fp4m29e0o6hKuxwL4htrm5QClkxFcw/kGc45nU+9r635MnPVFzlkspobNV8TLvQ+P6
         HOn4TU1p6f83dSrHiSirXoJJUvY6tL4sp1Us79qwLvnpxC6S+iC846ORtcja2jjrHbbH
         sxFZ6HzayKUeOWdFGobETAPnMtUCWA1RuwirMhh4AFzLQg17tDlkKQGuxhMGQAB4NNHU
         bvjRcamlxQhoB5jQqiBCnSVVdBVI6tt4Ki2krdA9Gd6FvqhQwY+txw0Ccem/TksTd5Fa
         Mcow==
X-Gm-Message-State: AOAM532sBLnB/F2GWYz3EDkm2P+pFlSB8O1baVxI4/qXZ2gIB2zpY0lG
        BVkqyemroFNM1vOsAb4mKjRGKHSt6TldvRsrKaDcg6t+qBa/hcoWpaNUWEtTLJ8E6OvhtLjeDSr
        NTDtIeYsIPkGVe1bTp+nwOSZma2CUufZhgHBHKJArHt8o3SOLVbIXoA+QrZtV9RjsO6tok9md
X-Google-Smtp-Source: ABdhPJxTmgsTrKL96k7aj0L1tKZRV18IGvI1UhfKdwKIB0LTvziTinIkmCr/+L4/dPbnA/WtOBegGP5ZUcmK
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a25:600a:: with SMTP id
 u10mr1830232ybb.215.1643240143562; Wed, 26 Jan 2022 15:35:43 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:53 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-13-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 12/13] perf tools: Improve error handling of AMD Branch Sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the error message printed by perf when
perf_event_open() fails on AMD Zen3 when using the branch sampling
feature. In the case of EINVAL, there are two main reasons: frequency
mode or period is smaller than the depth of the branch sampling
buffer (16). The patch checks the parameters of the call and tries
to print a relevant message to explain the error:

$ perf record -b -e cpu/branch-brs/ -c 10 ls
Error:
AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.

$ perf record -b -e cpu/branch-brs/ ls
Error:
AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.

Signed-off-by: Stephane Eranian <eranian@google.com>
[Rebased on commit 9fe8895a27a84 ("perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings")]
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 tools/perf/util/evsel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a9d506ec3ab9..808c1916a2aa 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2857,6 +2857,12 @@ static bool is_amd_ibs(struct evsel *evsel)
 	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
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
@@ -2971,6 +2977,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 					return scnprintf(msg, size,
 	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
 			}
+			if (is_amd_brs(evsel)) {
+				if (evsel->core.attr.freq)
+					return scnprintf(msg, size,
+	"AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.");
+				/* another reason is that the period is too small */
+				return scnprintf(msg, size,
+	"AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.");
+			}
 		}
 
 		break;
-- 
2.35.0.rc0.227.g00780c9af4-goog

