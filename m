Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF247183A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 05:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhLLEXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 23:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhLLEXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 23:23:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2258BC061714;
        Sat, 11 Dec 2021 20:23:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id m15so11485593pgu.11;
        Sat, 11 Dec 2021 20:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=MjGexAc/ud9Dqu0t2aWNPXdYMBoR95/keIm6CI6GLNk=;
        b=aJ10pRFl8dsuUvzVwh2YrZME8VqQPvjDyaRnNuSqrAJtu7/Q3Wsu5DOS959BCIvw8t
         POlZ5EX6tlCQfDujQrA/Lm86BpXc+CwVPWUtdGotM/iRLHVOpbUFFZviryf7XDcxB1+V
         R0jHLIaqipvhmX1C5bWJTt2r2QfU1sc/wkLyi+p7S/wn82xqRsFW/dK0r/vFudDvUA4s
         8/WkYaTVnY7Am1mvYzo9+fZZJQ3TCnnPXd584Vo0LIrOJxRsTPQjwgiiAlbilxr6DXUK
         k0Vx/0MmDCu2JikElVm4sl+CugmbOlKGXmy4BPz9nIKKyEXIRNS6gj+SW11lObXmMQwc
         VZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MjGexAc/ud9Dqu0t2aWNPXdYMBoR95/keIm6CI6GLNk=;
        b=ASsRtDAKSk+DZriddqnDvD1EkqIz8XcsJZ67Zn1atD+QqMnzEfdB0TMPZf88Ns/cNs
         SkGAvLj1EUPtWIk3uUihlfrFE2QVKrSkghXCe+sS8JnYyhBd84Q/UY3hpFv83mqkwkaT
         R4/5kfI9l8ZW9xh61xonIV3fDXCGhnnP4WSB/pRcbx1hyNKCBJL6d/0hgZIb8Ahowkng
         cNPNLGTrddk61X8I/e67q1jnbCMJbic4P4Fo9HNVd4Xf3zx1wwQ9cojxMvUYU1vIsxwD
         Vbtm8m/ruaS/BV22bHqNXQIxsnonDgaR4dv0VdEwIxxbbMalL5SKyT6i77mdjozNryUp
         S4OA==
X-Gm-Message-State: AOAM531q3A2xe00OglbKPtrlAHKJp0Pgxy934zJHqpYLb+v1wpeXGosb
        uONLSBsvvLAhJDUUWmnav5E=
X-Google-Smtp-Source: ABdhPJw2ex+IY8mqXukKhHb0PseMEOlTJo0J/mLc+xjY3QpPza8ApoH8vevgaEfdQAOI07a6tfvY1g==
X-Received: by 2002:a63:ef44:: with SMTP id c4mr45904825pgk.146.1639283011696;
        Sat, 11 Dec 2021 20:23:31 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w19sm3045869pjh.10.2021.12.11.20.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 20:23:31 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf stat: Fix NULL vs IS_ERR() checking in check_per_pkg
Date:   Sun, 12 Dec 2021 04:23:21 +0000
Message-Id: <20211212042325.9751-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hashmap__new() function does not return NULL on errors. It returns
ERR_PTR(-ENOMEM). Using IS_ERR() to check the return value
to fix this.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 09ea334586f2..a77052680087 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -311,8 +311,8 @@ static int check_per_pkg(struct evsel *counter,
 
 	if (!mask) {
 		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
-		if (!mask)
-			return -ENOMEM;
+		if (IS_ERR(mask))
+			return PTR_ERR(mask);
 
 		counter->per_pkg_mask = mask;
 	}
-- 
2.17.1

