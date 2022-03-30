Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8494EBF39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbiC3KzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiC3Ky7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:54:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F124EA10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:53:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c11so17298478pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=09LiY6XuBkhT7pabOtfcUnjYwotME+n6Ic9O13LnSSA=;
        b=YVcf70VGphWsI/5biiq1XHZ2pbFA79z1X1ISPB7HVxClJ1DTfdktvBdsuBEh41nt/T
         fXyFFu+jysgu+abv/RqgPyBi7t7ZjVa0eLu5LSwHwmKeh83/vd/rv8UIm7z8T9U2nmjZ
         wVv0SO4Od6P9tVsBsfVr1xQFwK8h2e7jzAwQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=09LiY6XuBkhT7pabOtfcUnjYwotME+n6Ic9O13LnSSA=;
        b=sY/FLYRq5gVIH5rYCB6PnphuZrtFVdm6Lhlgt6xMckfreAAgflp1s3CZU+1/ID3459
         CqAE4Bh+3oc3H66SycYpbbGIhOeZMaVs6WdRpoO8cf/qtNkoCYfKAIszepFsc+8rdEUT
         myXVJm/diy/KI99t9XEULMzfCkJqbm4+kOjqvDSSDn4g2crhobJK5XuHY3Lh2oiE1Nsb
         mnyk2Gu0Q636XWUHD/XxoHS8uRFbM96qc6IAcaGfryr4wJPyTmQ1r1e8SkktHNbGz4/o
         +ga/bqw288K8ialKay6Kegu8mB73bzVLgMxyHe80qki/d1NvPMAVHTtwIe5X+tVQc4bs
         5nyA==
X-Gm-Message-State: AOAM532nLjIL5FWrVFcUBFlxPft658SIrtRfkmRMgjrcuzLoij7yLX/C
        SYIMoIGyHBJ1/G1GzR3lF5ls5Q==
X-Google-Smtp-Source: ABdhPJyFVgfcMCHcqtfZCNB0z/EGqFUB/eVb7kFxzaNAfKtXvkx/kpQBdPGb6Y6QUVuVfK4opXM6NA==
X-Received: by 2002:a63:78ca:0:b0:398:ae5:6515 with SMTP id t193-20020a6378ca000000b003980ae56515mr5763459pgc.345.1648637592923;
        Wed, 30 Mar 2022 03:53:12 -0700 (PDT)
Received: from localhost.localdomain ([210.107.197.32])
        by smtp.googlemail.com with ESMTPSA id ij17-20020a17090af81100b001c67c964d93sm7373967pjb.2.2022.03.30.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:53:12 -0700 (PDT)
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [PATCH] mm/damon: prevent activated scheme from sleeping by deactivated schemes
Date:   Wed, 30 Mar 2022 19:53:02 +0900
Message-Id: <20220330105302.32114-1-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the DAMON, the minimum wait time of the schemes decides whether the
kernel wakes up 'kdamon_fn()'. But since the minimum wait time is
initialized to zero, there are corner cases against the original objective.

For example, if we have several schemes for one target, and if the wait
time of the first scheme is zero, the minimum wait time will set zero,
which means 'kdamond_fn()' should wake up to apply this scheme. However,
in the following scheme, wait time can be set to non-zero. Thus, the
mininum wait time will be set to non-zero, which can cause sleeping this
interval for 'kdamon_fn()' due to one deactivated last scheme.

This commit prevents making DAMON monitoring inactive state due to other
deactivated schemes.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 mm/damon/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c1e0fed4e877..5ce8d7c867f0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1019,12 +1019,15 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	struct damos *s;
 	unsigned long wait_time;
 	unsigned long min_wait_time = 0;
+	bool init_wait_time = false;
 
 	while (!kdamond_need_stop(ctx)) {
 		damon_for_each_scheme(s, ctx) {
 			wait_time = damos_wmark_wait_us(s);
-			if (!min_wait_time || wait_time < min_wait_time)
+			if (!init_wait_time || wait_time < min_wait_time) {
+				init_wait_time = true;
 				min_wait_time = wait_time;
+			}
 		}
 		if (!min_wait_time)
 			return 0;
-- 
2.17.1

