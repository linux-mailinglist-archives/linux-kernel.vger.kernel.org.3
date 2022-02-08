Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B64AE4C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388617AbiBHWdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386880AbiBHVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95AC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q199-20020a252ad0000000b0061e113c9953so257802ybq.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ohbaKv3Lg/0Da2FFFbyy5azyuFvGZukwAaGJCbUrePw=;
        b=SKx+AgJfubJcERmdfYBFsFjNIZCuy1okXaW+Upyg8n+NM6mwgA1CWsSzmFUQQ9FzFh
         Kuy+E3vvzhtZ2h3EHEMm4GwLyNy7+D4KngxLeseIQtqrxN/bIOFSuslOVxCBXAhDaAlf
         oKWiAu1FbhNW4lt7rng/y0DEuyzSe0icv7li/pEdDnhMVeV5g5QnVnxfiwRe6KY8a98c
         HnRiAlmQ1yu3BM5/iwqx5TykECDJMiQC8fJML8uDRiV7ORY+2KwfJUJ8Kq6g4IZ4QmDO
         0cB/hD3tq0X0abapCjENL2mgoEYs7IXbeoZJMthXYfc6rrlGstkypt2gT3DRUXogTh6e
         Y6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ohbaKv3Lg/0Da2FFFbyy5azyuFvGZukwAaGJCbUrePw=;
        b=Ew4/wEKVsubkrb/iRGbYag9Q/ne4Zsf0KmT9TgZdgbr+iZnJL7BaTkj96a2OLLOumv
         LKdI3wNd5srRrz2T+bo9S/4WYnDUBOsOV2eyKOCX4YXn0i7/+wwGEaDKdeCEUCx0Cm+5
         4kFVZ65P7IifDStWDpFKE5uY/xTy+1TCZhGZWTQuNZ590REYD1rYkgKCBFEQVJVFGfvr
         dhzgWOkf0tNI2H2xTeVx8vhyjRHK2BqL5m6kCDYwfPnm7EmkRcczjXKXW0+c/24B1bFE
         HhKpCybMHLcPwHIpIxGxAhwhNFokqAmc3x6eOrGPvwoN1ZFpUZPqaTBz5GvRH4Q6fhhG
         XFGw==
X-Gm-Message-State: AOAM531lVgrYtEA/Sd9r3IJOwM+Llm1rKQmJvxDG/3PnpGkkMv6rgRok
        JaVQwA5ETLKNpMn0UMMq0haHnKV8svbwiVwWjqZ3pDy5xwLN3bJtR/SZqntyLCrI7nhtDNHCA5k
        ZDybclvuKK49y7Bz4eXCmY3X3x5ufSEf/2Cv/OzQ84eUicNjBFwAc0GyQrMOABGi8spmLnB19
X-Google-Smtp-Source: ABdhPJzGaANv2LxnvqCCuYdwvnXsK2X2ChMgm2rnPY5ppU/8qM6BnNyTPK1i1ppKVA273TcfVVmOiLUZStTn
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a25:cdc1:: with SMTP id
 d184mr6229803ybf.489.1644355041791; Tue, 08 Feb 2022 13:17:21 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:36 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-12-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 11/12] perf tools: Improve error handling of AMD Branch Sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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

Improve the error message printed by perf when perf_event_open() fails on
AMD Zen3 when using the branch sampling feature. In the case of EINVAL, there
are two main reasons: frequency mode or period is smaller than the depth of
the branch sampling buffer (16). The patch checks the parameters of the call
and tries to print a relevant message to explain the error:

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
index d42f63a484df..7311e7b4d34d 100644
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
2.35.0.263.gb82422642f-goog

