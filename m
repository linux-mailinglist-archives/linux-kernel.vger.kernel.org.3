Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A85490C23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiAQQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:10:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50790 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbiAQQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:09:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1404FB810F8;
        Mon, 17 Jan 2022 16:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14861C36AEC;
        Mon, 17 Jan 2022 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642435789;
        bh=TNg8IZ8rkhC/yp1VTmeue3vqYFJfk93+PZ5cIltGfWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7HOIOLwOJ19xfXpnk/nBlOW79lKeHoFTEtvCEGzu79CgMwyyqUeC8YHH26dr6ZLB
         Ox13/Lxw+AqNW3IR5XNj56DmCOV2EfYN+869K4t5LWOpb2HumpCbCYWQmm3K5LgyHM
         D2c/AkdAkX5quNjZl5SS4eyLATNyGtW+zHP8gF9VkJuknSG4QCVZI1ZX35vPD+u9VA
         AMPhSchEy8w0eAO0QcpGtEXdXswnpt4hLtgcQaUpA0Z52eCroIiIqYnHYJ/I5FkZDY
         UsGwk8/d0X3mNdaUGzDKzR+4msayD7bZWbJJoBLPTQBeaNMiXOeSxQfHN8xi34r//T
         h2LwnYbIV9Wqg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/4] perf affinity: Allow passing a NULL arg to affinity__cleanup()
Date:   Mon, 17 Jan 2022 13:09:28 -0300
Message-Id: <20220117160931.1191712-2-acme@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160931.1191712-1-acme@kernel.org>
References: <20220117160931.1191712-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like with free(), NULL is checked to avoid having all callers do
it.

Its convenient for when not using affinity setup/cleanup for dummy CPU
maps, i.e. CPU maps for pid targets.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/affinity.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
index f1e30d566db3c835..4d216c0dc4259b9e 100644
--- a/tools/perf/util/affinity.c
+++ b/tools/perf/util/affinity.c
@@ -62,7 +62,7 @@ void affinity__set(struct affinity *a, int cpu)
 	clear_bit(cpu, a->sched_cpus);
 }
 
-void affinity__cleanup(struct affinity *a)
+static void __affinity__cleanup(struct affinity *a)
 {
 	int cpu_set_size = get_cpu_set_size();
 
@@ -71,3 +71,9 @@ void affinity__cleanup(struct affinity *a)
 	zfree(&a->sched_cpus);
 	zfree(&a->orig_cpus);
 }
+
+void affinity__cleanup(struct affinity *a)
+{
+	if (a != NULL)
+		__affinity__cleanup(a);
+}
-- 
2.34.1

