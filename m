Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8642749747A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbiAWSks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbiAWSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AEDC061755;
        Sun, 23 Jan 2022 10:40:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l16so14125208pjl.4;
        Sun, 23 Jan 2022 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Py1zW0ltpfyG7bmubSMBgFb3G+l3kBPmKZQHawk6878=;
        b=CSMBNJKY7dSpNlaAbMhxTV+T2YjWtTQxwONPqJ5KEFjCKKirqqwS/89tqsFoGH32ii
         sEZ1vNlsMZDixP+/ayAqyxiMC0i3u6z782a+Bo3DVmTaJnex3SXZYysIB8m+Wo4zOH3Z
         V6AmmUD+GrHiRD0/5XduLjLKdkrvqoN+cVkHe6GviOXtOT6ZWinK+V8y+XCROtaacI42
         ZyUIuJu9taT5JU8l0oCznzFzit73pFBAmuv4ctUPVPPyN6bBCMMFFNYnqZfOflbYW8em
         pGMq4L1CIsiqfN/H0fvW8a4LgeBwbfJ7dYIn6rD0cLuyv6NDFlXm2PDjtu35I8dlUSE7
         yUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Py1zW0ltpfyG7bmubSMBgFb3G+l3kBPmKZQHawk6878=;
        b=IXtKXQ/j9Uo6CPmK/nbCml1Bbq2whYfII6Io9U4jhztFG9+4P0rTmrWPecmOOwdL+k
         YAtevm5oAObjBdiNuJ1AI2H6JhOg2Ns/RSxzbnuIOgegBpeSYp23IYzyntY5iMLMmMUW
         Ymu6Luv+swR6B8MBavpwBWCgrR7nC4iAaCpvWFz34dXWRVcx3shuHNosA+uJX13k7qZW
         N5IImWGWPcauHBEBCR+oFgPKQMlHBFYUckxSYoH4Ln0BwhZu1ctN4lVEJ6OnXxhk2nm+
         Q5CmMoFIJuhIoS6yYV/zdUrJIjaD43WKyq89Yv4Rs4iMUJnu/5pP3JS9JbpA8MySg0wU
         S5cQ==
X-Gm-Message-State: AOAM533oiyf43Qt3b4/lgCghbQL9rvbi6b1SNA12NDkOb0urQOZWXfNj
        8SP6RwHs0tYPZpJteitTGWg=
X-Google-Smtp-Source: ABdhPJw5u6/fkWBS7kc1sVnKC3utz4uerUZu9lGVkpSGNbzYVEKRH8JYJRwOLnk66EHUmGBuzA7QSg==
X-Received: by 2002:a17:902:a417:b0:14b:1f32:e926 with SMTP id p23-20020a170902a41700b0014b1f32e926mr10664339plq.170.1642963226087;
        Sun, 23 Jan 2022 10:40:26 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id om12sm5090050pjb.48.2022.01.23.10.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:25 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 12/54] tools/perf: replace bitmap_weight with bitmap_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:43 -0800
Message-Id: <20220123183925.1052919-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code in builtin-c2c.c calls bitmap_weight() to check if any bit of
a given bitmap is set. It's better to use bitmap_empty() in that case
because bitmap_empty() stops traversing the bitmap as soon as it finds
first set bit, while bitmap_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/perf/builtin-c2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 77dd4afacca4..14f787c67140 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1080,7 +1080,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 		bitmap_zero(set, c2c.cpus_cnt);
 		bitmap_and(set, c2c_he->cpuset, c2c.nodes[node], c2c.cpus_cnt);
 
-		if (!bitmap_weight(set, c2c.cpus_cnt)) {
+		if (bitmap_empty(set, c2c.cpus_cnt)) {
 			if (c2c.node_info == 1) {
 				ret = scnprintf(hpp->buf, hpp->size, "%21s", " ");
 				advance_hpp(hpp, ret);
@@ -1944,7 +1944,7 @@ static int set_nodestr(struct c2c_hist_entry *c2c_he)
 	if (c2c_he->nodestr)
 		return 0;
 
-	if (bitmap_weight(c2c_he->nodeset, c2c.nodes_cnt)) {
+	if (!bitmap_empty(c2c_he->nodeset, c2c.nodes_cnt)) {
 		len = bitmap_scnprintf(c2c_he->nodeset, c2c.nodes_cnt,
 				      buf, sizeof(buf));
 	} else {
-- 
2.30.2

