Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A5B487C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiAGSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiAGSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:21:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06456C061574;
        Fri,  7 Jan 2022 10:21:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso3390427wme.1;
        Fri, 07 Jan 2022 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwa9uE6ZhRvKn/5ifefhl4Wng1mfi5OItnJ1XlTD2Ao=;
        b=iuQW6XDdKDpsQz3v4ckCVSdX/H1O3bBGYf+/ZhZwRAhM0sBKM4roGkN2F5xhfP6BUq
         8yzYG7w3UY7dffHH6qHkN6TNskcYnYDn07ng5yFvCDMqIm6yjRn1NYcA2NrsCnxWVeBt
         LDNN0goSylsoTE6Nt2/4mSwIrOGwmGFFNHpjPjk0v7JT+WDNMMCjKGrtUvhlV3+XBU/o
         2Ew2RrqdsZBuZs4xlJE1XKCmcz58YwuO6VSZ4UKZ283PsofZe2lnkJe6NoIxJMOkd8gx
         K80onguNe+gp2dDS5e8DNYhmSjNg7VEDWcwi4sBm2QXNIvI5tYZSG1vKGuo/rnsfHVYz
         0dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwa9uE6ZhRvKn/5ifefhl4Wng1mfi5OItnJ1XlTD2Ao=;
        b=eLQhOuvMMTEeDw1SbKw/nmng8RGEWMDOdaEV44y3Pz1LaP3ea4a1AS1XCk/B4L8SSp
         rL/63Hozmu6Pv4/fP15UlZQJ0Xh4f2AFWL9VsXCJWF5W1mbQbmYslvTO7BCC+d9TMwTX
         VhIV61CpSjWqcCYKwoTP+7/M2itpr59YFuKpvbEuLtM6i1NZyuYgddkurwI2UOcmagbL
         7fC51+RjYopGm2MGt1Ic28Qti6TjdOiG8672tmozkIYWPdu0HUsO51jeExkjqgE4FBJK
         L0gO0Hno6MvPughhZXEaM3isa6eNdED04K2vA4oKVPFTz3LoPF6dMQRuF3hlsGB9bTZa
         7kAg==
X-Gm-Message-State: AOAM532kJyeU3SiqRRqm9dq+7V72fZgzelE3/Otzm3VKMBzwckJ1sNGY
        +XrRBAe+99NR9GIfpW+B6f7BtZyEzRRuPw==
X-Google-Smtp-Source: ABdhPJxSqwF8Sp8XP2GqtjyRbE5SLGcO0yfmEeSq2XD1jE6RZa+OZVGcPfZ5qHlhCinCaL13Ra4ZSA==
X-Received: by 2002:a7b:c745:: with SMTP id w5mr11729176wmk.167.1641579670587;
        Fri, 07 Jan 2022 10:21:10 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id c12sm5402612wrr.7.2022.01.07.10.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:21:10 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, ak@linux.intel.com,
        john.garry@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3] perf util: Fix use after free in metric__new
Date:   Fri,  7 Jan 2022 19:21:06 +0100
Message-Id: <20220107182106.138418-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a use after free on the error branch accessing the "metric" struct.

Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)
Addresses-Coverity-ID: 1494000
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Add Fixes and Acked-by tags (thanks to Ian Rogers)
v3: Add Reviewed-by tag (thanks to John Garry)
    Improve patch description
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fffe02aae3ed..4d2fed3aefd1 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -209,8 +209,8 @@ static struct metric *metric__new(const struct pmu_event *pe,
 	m->metric_name = pe->metric_name;
 	m->modifier = modifier ? strdup(modifier) : NULL;
 	if (modifier && !m->modifier) {
-		free(m);
 		expr__ctx_free(m->pctx);
+		free(m);
 		return NULL;
 	}
 	m->metric_expr = pe->metric_expr;
-- 
2.25.1

