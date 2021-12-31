Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C65548227A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 07:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbhLaGZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 01:25:07 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31126 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhLaGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:25:05 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JQFRt0pF1z8w3x;
        Fri, 31 Dec 2021 14:22:34 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 14:25:03 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
Subject: [PATCH 1/2] perf string: Add strcmp_prefix()
Date:   Fri, 31 Dec 2021 14:30:43 +0800
Message-ID: <20211231063044.2405691-2-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211231063044.2405691-1-liwei391@huawei.com>
References: <20211231063044.2405691-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to check whether a string has the given prefix.
This function is stolen from fs/xattr.c

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/util/string.c  | 17 +++++++++++++++++
 tools/perf/util/string2.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index f6d90cdd9225..0ed3e2d0b70f 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -209,6 +209,23 @@ int strtailcmp(const char *s1, const char *s2)
 	return 0;
 }
 
+/**
+ * strcmp_prefix - check string for given prefix
+ * @str: the target string to check
+ * @prefix: the given prefix to match
+ *
+ * Return the rest string in @str if @str has the given @prefix, return NULL
+ * otherwise.
+ */
+const char *strcmp_prefix(const char *str, const char *prefix)
+{
+	while (*prefix && *str == *prefix) {
+		str++;
+		prefix++;
+	}
+	return *prefix ? NULL : str;
+}
+
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
 {
 	/*
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 56c30fef9682..58929ad928f7 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -20,6 +20,7 @@ static inline bool strisglob(const char *str)
 	return strpbrk(str, "*?[") != NULL;
 }
 int strtailcmp(const char *s1, const char *s2);
+const char *strcmp_prefix(const char *str, const char *prefix);
 
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
-- 
2.25.1

