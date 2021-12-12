Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1597D4719EC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhLLL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLLL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:58:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FFC061714;
        Sun, 12 Dec 2021 03:58:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso12228187wml.1;
        Sun, 12 Dec 2021 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gI5AbykJRB0TFFUKnulBm0TsiZ6k0flpyMLKZYV3MWM=;
        b=QGkqCB+8A2egwxvZKgrW8cFjmg/VzHoqEKinykjTNTzrkjhdSK3qm6hT3ZMgsGss0V
         CD0Da3yqZtLleRF9xouH/PUl2SvrIwL/3izKEKeEwJmgSYSwsTPUviudUUU+b343mXXk
         7XA1CvWGNYnkEZaWIjwD4BpzsHE3gkIKSMfoOchlnhA5QCCaIjdGEpEFko1xU0bsA+I7
         OyNL+nDTa31k7o0Z5Ko0HTyIdqKdz5qBcq+rLfl+6uTxzbhS371p0+dn2L7bZfZHUwSu
         uTLWOp9gEuup87jjr83yV7xTTtklqf4x3J7PjxNvOgjhdZwWDTurdMyZ32/k1Tp8ITtU
         N0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gI5AbykJRB0TFFUKnulBm0TsiZ6k0flpyMLKZYV3MWM=;
        b=5MGP5e6Dc6g39MchYN4x03ygyjTWrhK7z+DC/MgEESDiJdmlZ40hK16h8xFqfaadnw
         KwG29war8rkVgkuvjvzskGlyQf8A/QvXnrchc1oXXsf/9+saWjMVODKh2BTM98Umy7Lf
         CO4dU7BUB1LWs+Oi/RUXYTbvhyAdPPoYlEOuoS0jK2d2fftqMwrt9a9raLTBo9mBBNzQ
         elRtP/W0NPUXqrGe/e4z+RAEHWoS8zNuRgOHHikQ1AcaxEqUZlqJUuXshrZ9KYknjIa5
         YQGTtrxKk+6PZCG6BD5g/HS2a65MDkgsegm3dPzLsOA6Dy5uJA2R34elgXbcEvkSpNak
         zg/A==
X-Gm-Message-State: AOAM531bEG6aAoJD88/cW9dqkLBVTiBb+MG6BLpx/l3VfUrZ7v+JeI3A
        kROgu2ZbUkdXJfenAHcorFY=
X-Google-Smtp-Source: ABdhPJxSbkcxibd4xOWVVCaCAn2gFxnO0aXCLeT43nuse8WMMyfU8U6tYdTfGbfwdSS9xswRRD2pVw==
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr8049662wmp.52.1639310334627;
        Sun, 12 Dec 2021 03:58:54 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g124sm3789045wme.28.2021.12.12.03.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 03:58:54 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, ak@linux.intel.com,
        john.garry@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2] perf util: Fix use after free in metric__new
Date:   Sun, 12 Dec 2021 12:58:19 +0100
Message-Id: <20211212115818.267011-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)
Addresses-Coverity-ID: 1494000
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Add Fixes and Acked-by tags
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

