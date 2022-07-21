Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43757CADE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiGUMph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiGUMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:45:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E60140ED;
        Thu, 21 Jul 2022 05:45:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b26so2120471wrc.2;
        Thu, 21 Jul 2022 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEE23Ffl66jlKawsz8Lt2xbxy7aIM0Re5Y0itgAR920=;
        b=AwSCYCzOBisSI7akiJEWycZrHuaw2XAUfZrkaCcyvF5/VGTCU/FDE6s1V3ZUlfTdFb
         OmXUbX3zMuitWZTy5VrQAQxeFRf3ONtrycA86cDM+26g6lvE2Tx2V/xyQDT/KFEBl+JL
         0iLHx7nuCTEuARDT942jfqQQxU3eGUvfHkMoOAMgA/rOSACfF8Y0eXsOHTE0dRvPB/T/
         nLk4jDblPQuUFlVt/cxRQn67Trvmmu9Xtodv/zk+gbHPcaGuiPVEqAv1+2DvV/YNqMrA
         QROC53hCxA5ilCsCeJzpMg5eabq4UKN5xCcVDBEq3Bw9C5mRmwNdcqGgMyNPrthmgL3S
         QunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEE23Ffl66jlKawsz8Lt2xbxy7aIM0Re5Y0itgAR920=;
        b=j0TuP6tfiUyCKGVQXwBmZ6Mjt9MHXg0uY+se/CWC2HOzFnWvcyXGeMq0+/VKcn2TZ5
         0qUMFniPByqEsEhargDwODYFn0TjaJwyRWmVEBKVVTWEwMzin9LzjMLCl5wFMyl5cYPm
         k2EyM8+tA4pCKGI33u7QGBHkoKjwwRh2E0ldVhFI0ZSVvA6Vj5AwUq4nqvLC6dpokcyK
         NxTIxuUnB+HPLx82QKJtUr92Cdpe1ZbouSJNXhpPFtFrqCw+rXA2B7YzQOeXe0mlq55B
         Tdg6W4vbFlP2R0zVViRNPADhzW/kJPwUzOQeqtF6yK/9kXJlwqnEgfJDEV62ZhO0wbi3
         aYnA==
X-Gm-Message-State: AJIora9/Br5fssqvqSYAfapkaXz6Lrb3W1JzP7a02v7Vy5Bij9HAdqVs
        gm0CMXWWKOzkwlOFHz85U9uHhrhmB9gQXES+
X-Google-Smtp-Source: AGRyM1uES1/MR//RJlDUIzwksSk3qWZqD7Ib00un75cM4tfawRdYRUWOri948ZKagYOBgG7cS7Drxw==
X-Received: by 2002:a5d:6b89:0:b0:21e:3ad6:832e with SMTP id n9-20020a5d6b89000000b0021e3ad6832emr10562270wrx.536.1658407529287;
        Thu, 21 Jul 2022 05:45:29 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c268900b003a31ca9dfb6sm2163305wmt.32.2022.07.21.05.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:45:28 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf inject: Fix spelling mistake "theads" -> "threads"
Date:   Thu, 21 Jul 2022 13:45:28 +0100
Message-Id: <20220721124528.20997-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/builtin-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index fd4547bb75f7..2a0f992ca0be 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1501,7 +1501,7 @@ static int host__finished_init(struct perf_session *session, union perf_event *e
 		return ret;
 
 	if (!gs->vcpu_cnt) {
-		pr_err("No VCPU theads found for pid %u\n", gs->machine_pid);
+		pr_err("No VCPU threads found for pid %u\n", gs->machine_pid);
 		return -EINVAL;
 	}
 
-- 
2.35.3

