Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B938464464
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346116AbhLABGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346041AbhLABGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:06:08 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3CEC061759
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:45 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x23-20020a634a17000000b003252e908ce3so7582379pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tuZL6CO7J44mTWa02gr6lNmwM0VERDE2+TatCNk6+f4=;
        b=mpJZmgT8zPFVdHqkcCGuoRZyLvV4kTixBl17MKfj+ClIlc+ILmIAZ6vvnkKCI01Tte
         +lXgrJi8rrFxa56+Zibk0zG9QI5uQ23Mn4k0DI587/WtT0UTIWGWkp6NeZ4RrdByzohB
         awEoj9Yjp922lRMC4ncngxBuOkoZ/aNZbMDEhk1CQsyHuUfKiK5xtjrjJjRNuIweVO2o
         /AB7aWwufyx81iICqZQDwCOvueg4Kb4dgrC3MN/iNRqPS4ef0KHxqno0ExjXsnTHHVf4
         t+oTHT54upjl2JpY/BO9SRbUUogILxNpZH+GJnFj6WgTnoDxLU/OzFOYbaNCx6GNUlky
         i0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tuZL6CO7J44mTWa02gr6lNmwM0VERDE2+TatCNk6+f4=;
        b=Jy8ApIC9yrldx7gJYQybZIwigRsBTl7JgdkIpj/lSx9hnikr86IInLp7K6uoLKoEOa
         /3uz4kEf26lm3DWxTdiwBgrmN3PJGvkQPbhbxlWQN88JqjniTU6iXfx5Ay3dMFQOFPcl
         DPEZ8P9e0w6/RBdUa0ye25+yEAHGVlmZmulFl9Z2TOzanHaqIjSs5jiJjY57j/SxqOI5
         t1JUgm8FeqfcROfwOTf8mVze8K5y4abjQq/SMfSDYmB005EKskRdrV6Ntb5VUXmETrN0
         6XtnfHwJAaRQY0k5ub8Go9pfuv2AQVSILsnVS4hqNpuaw6x3gWaXCVKDSSVsW6yrIywn
         ytbQ==
X-Gm-Message-State: AOAM533KdSKVW920Zi5GvIDO5rrf0cj47gbueEuuxRTCqom8FWE4E9bO
        8IvVujq3vzqx76WbXhQFk8qSINS5/nNPbmVEmaRd0VqSYW3Q0IgWkKR5oNm5xcT2FPYS6M1oNwC
        1ibXkApoPRSUrFZU6X5gU887qUzP4+iGqjqsw95+u9RpJvYLtklH7lVaR4cEoeAimOHfmlERN
X-Google-Smtp-Source: ABdhPJwhCTGRglcY5O1mf5R4DRjsHOQc7oadlDK7nupjNNRurKl73LnUVrwRK7UkC9z83g2R0q1ABNoLyEkr
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a63:c142:: with SMTP id
 p2mr2188163pgi.576.1638320564782; Tue, 30 Nov 2021 17:02:44 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:15 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-12-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 11/13] perf tools: improve IBS error handling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

This patch improves the error message returned on failed perf_event_open() on
AMD when using IBS.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 tools/perf/util/evsel.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac0127be0459..39e9063c0a80 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2852,12 +2852,52 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
+static bool is_amd;
+
+static char *fgrep(FILE *inf, const char *str)
+{
+	char line[256];
+	int slen = strlen(str);
+
+	while (!feof(inf)) {
+		if (!fgets(line, 256, inf))
+			break;
+		if (strncmp(line, str, slen))
+			continue;
+
+		return strdup(line);
+	}
+
+	return NULL;
+}
+
+static void detect_amd(void)
+{
+	FILE *inf = fopen("/proc/cpuinfo", "r");
+	char *res;
+
+	if (!inf)
+		return;
+
+	res = fgrep(inf, "vendor_id");
+
+	if (res) {
+		char *s = strchr(res, ':');
+
+		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
+		free(res);
+	}
+	fclose(inf);
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0, enforced = 0;
 
+	detect_amd();
+
 	switch (err) {
 	case EPERM:
 	case EACCES:
@@ -2950,6 +2990,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
+		if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
+			return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.34.0.rc2.393.gf8c9666880-goog

