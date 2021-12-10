Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB6470C34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbhLJVHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbhLJVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B1BC061D7E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so18529467ybj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a2FWhAR05Q4upf5E/uEcKeeUrMyzI2IUHXvOSbNraEc=;
        b=eM5cI49lfRsMYof51Mauq7bJYJtDZLHADNjcc+y++IaCSAlJIKttgW1Ne8KiK40usu
         IyaWhjqg3sM8PFMFl5GqwHZPd7GZeCdIdo9yEJRPrsMayrvb7Mmhba5RPtsYrhp+6exD
         bn3uO3gyoOGRKtoIhX8ExCt4UYeD3lKGCzoWv9NnTEpcUh3gKtqVprcQJa5aKk+UCWFj
         qe/5VYtHwJOWygz/YV9FNCuMZS6lGRZWD85GVHdBoPOCzq9kq0c1CKuGMjumAr91xBEc
         2l9xc2Bul1C4CNEewQLET8YEEuPvzo+DCsj278ourXDZ+3a81IpE1jdEXqAcrAwoGj9Q
         PRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a2FWhAR05Q4upf5E/uEcKeeUrMyzI2IUHXvOSbNraEc=;
        b=xiffRhE5lReUTuIFNKynSNKZyDljtGfhDn0Py2ISAV0MI1b4m06jsWDXpK74jis2eI
         tIRL9Ogoh4k31UdFt/ZxGT2EDYHO7UyIxa33HG9oTw5rbRMG0X1N8O7tZSMvCxt0AIv5
         9ces+9P0U8E8Mcd35lQHOdmA3VQW2wa79vKCaWFxxWLy+YOOmIXOpkb7pQRWS+s2CS36
         zhZnCFsKNz62Cvz0vcJU5BhZUFxLKcrLn2vie61kVvWQ3975ubNYldQWPEd+UTuDEcKn
         sLZYM58yLezTFhuxiFrO9wo76EDggHb1NVQYIyba38B6iE2Qk2VjecZ7ASoSO5Yg6fRD
         /b5g==
X-Gm-Message-State: AOAM532iGdNKFMxFhEie2CwBmSIfZQHmqzUMH6HpissfPTCWXdhWsp5d
        wWKoRkJvW4HKQa5Q19N+TOTeIhpYQtn+f1Au+TKOqqMouawoA+oj8PohOE3JgYuVVLRn1cQzZNo
        6XpZsepiqqwd0zr3IwJLQmLxnVGkUGWOB9TO1KA8v0/doAHbcc7YENXE2HFblGLVoa093+hOH
X-Google-Smtp-Source: ABdhPJyoHYYp3cQIlFjPaNf54C5yfdliWD2pnXZTb7szMngtHXvqDWhrIPX9qnBI12jOxT4UuxBIE2gTTXKl
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a05:6902:120a:: with SMTP id
 s10mr18476451ybu.265.1639170198236; Fri, 10 Dec 2021 13:03:18 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:28 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-14-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 13/14] perf tools: Improve error handling of AMD Branch Sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
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
index ff9a755b869f..20c970d0862b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2862,6 +2862,12 @@ static bool is_amd_ibs(struct evsel *evsel)
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
@@ -2972,6 +2978,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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
2.34.1.173.g76aa8bc2d0-goog

