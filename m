Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC93488E12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiAJBaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiAJBaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:30:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE82C06173F;
        Sun,  9 Jan 2022 17:30:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so14323191pjp.0;
        Sun, 09 Jan 2022 17:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ahpX94c8GUmfMJh8inkb4fyYhi5rbgrtZUmtlm080A=;
        b=AMdHRjEu3M3oKR3yjUIESyRG3UvvqvBAJ7DvqBXZDISAN0v+P/+JTHBh6oNPYoqDGt
         HQ+eFIS19fCTk6gQiCa7FrVjv6UwrVyVF5tv1Esab7KoIDf2GE7feL7vHTmIzrnKpzGZ
         +E786/7Y3PCTejwLnubmdfyeYc6+LhdRFAfDJf4dO7nQMIF1EbDlOjcgVOKpTbNcjz3z
         JM1W7awIiV3V4SCE16ibbmQHilc+RozkLTUGS2BXe1xIujiCHYsR82q2TA4XjBKzMo8z
         eEdYhiWSVV9kbtg4BpTwvPB56mifFozQ/LAgXMk/07gAZNn6JgYePMw8Sf4h+UK2eXyT
         oU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ahpX94c8GUmfMJh8inkb4fyYhi5rbgrtZUmtlm080A=;
        b=YeV6N56Sk0Xld1yzT7B7AEVLXSGKYpOmBTsx0rVCOuzIpyJmiRlVjsqXPzmJ60m0LC
         NzURoMgz3YupPtGVo3vwPV80kDZTrwGxsjV2aoRNVH7i6E3//T2Himq4K6LeurunTmEc
         GsGQe7I3HZlWelG2FQ2zDcLNDQlqcCyHYBRQkI88Oufl2+bSJhpXUzWiv0ZUFiL3BZXM
         TuIrm+1vXywxb0nBfPDyoyhTaLOVxHZyS6shP3i6ceZ58zaN3TKaUihrH2yZ9zJW19kK
         1Ta651gNDxIOpbGgo7/Ax/oLjkR9CHt9cGddW1y9EiP0fDWNm4JalTyY5H56SQdQK/jv
         8afQ==
X-Gm-Message-State: AOAM533OKnjCc1wccVkYsuRUmPjIu2rlbWIY/5BxzRPSwzLTqKBoyZ+w
        RthkvIGGuNwflIH1O70Lnq4=
X-Google-Smtp-Source: ABdhPJy3Mlq1d/NTsid1Ukt/xM9HSX6ibBd7vEZvSdfVDq5PEaWwUiBkPsNGpy4IFQZevQSeNoshZQ==
X-Received: by 2002:a17:90b:1c86:: with SMTP id oo6mr27430393pjb.165.1641778204509;
        Sun, 09 Jan 2022 17:30:04 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n26sm3731057pgb.91.2022.01.09.17.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:30:04 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] arch/alpha/kernel: remove redundant err variable
Date:   Mon, 10 Jan 2022 01:29:54 +0000
Message-Id: <20220110012954.644059-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from __hw_perf_event_init() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index efcf7321701b..ccdb508c1516 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -689,8 +689,6 @@ static int __hw_perf_event_init(struct perf_event *event)
  */
 static int alpha_pmu_event_init(struct perf_event *event)
 {
-	int err;
-
 	/* does not support taken branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
@@ -709,9 +707,7 @@ static int alpha_pmu_event_init(struct perf_event *event)
 		return -ENODEV;
 
 	/* Do the real initialisation work. */
-	err = __hw_perf_event_init(event);
-
-	return err;
+	return __hw_perf_event_init(event);
 }
 
 /*
-- 
2.25.1

