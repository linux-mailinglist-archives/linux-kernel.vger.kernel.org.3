Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302D534BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbiEZI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:29:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B387A18;
        Thu, 26 May 2022 01:29:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o9-20020a17090a0a0900b001df3fc52ea7so3810857pjo.3;
        Thu, 26 May 2022 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ta2fnNORGUsjuMjKE85VSi51HYB7+7nVCChsv1cbuY=;
        b=cKvLolcB0qKL6HE4x2ld1APfOOtnBG+zZ7xjFnuF9ASGev8did1cbzdkQMPu0wFlXt
         JsMwX1SR8ry7yEpZPkXsgp97azZxkwbA1N6vRFc5+BX732RPa25GQdT0VFH1GLgcFN47
         ORQQncZBfR4wXvwI2LpS1orjIY83/HY15ge8dktV//YIt7mu5Bog3ATngb9wkGSaGRfq
         EPUn24bG8g0d/JMDiTmttgl2ywASsE0FsoKkVhKdrtlmhrSdkHQ+lOfamnujqvffXVxH
         WOjCF86KGG/JD0WxHhdQWTOBBC83lDGB9353kEDXz5IGlVsxeDLpBi2S4OMc7mdlAc00
         GsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ta2fnNORGUsjuMjKE85VSi51HYB7+7nVCChsv1cbuY=;
        b=EwrD752GlQ3fOI9W0GAi+vapU+6pSwYxcC1ik2AIyNedXw1aP6wmH1l0zD/XraTikl
         29BHndjHbQF158sMr4fUTRutR5xknNbff/jVT0N3XVrkhPxauKRqNIw+/EPbKWnfejEE
         y+Z11lF4SLNwh6qXqBD9CKNQVt+NlL3QSP4D9WVymZ2lgG8ESkB7vQqltN8y3vnRtO6Q
         cx8qnopofcWVF2J3miO8nYKpcJigeL73u1+l28CIo0JbS1HreKWrPDPxgBBSm47/8WF1
         JdNXNzJPs4msggyQ2fGV0bASsReKcFaZDoaY0sr1I/4m4HuV4p0q+J8a28bIv8IuyQyc
         igTQ==
X-Gm-Message-State: AOAM533z4Laek/cYwXbGOupuj5oq3WJKJhc85YYT1VrWdkDSueGLW/mX
        tBpBxFUyvmojYY8VWMZq340=
X-Google-Smtp-Source: ABdhPJxcDtzIa1cpNLT0Egvkyg2gtm0014D7uRbUsAgnDGvLvuH2YfJNpFLGDUJ0jEUFxz/6zQdYeg==
X-Received: by 2002:a17:902:c402:b0:163:5b99:8efb with SMTP id k2-20020a170902c40200b001635b998efbmr6962403plk.4.1653553745828;
        Thu, 26 May 2022 01:29:05 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 71-20020a17090a09cd00b001e25e3ba05csm251685pjo.2.2022.05.26.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:29:05 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] devfreq: exynos-ppmu: Fix refcount leak in of_get_devfreq_events
Date:   Thu, 26 May 2022 12:28:56 +0400
Message-Id: <20220526082856.37594-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
This function only calls of_node_put() in normal path,
missing it in error paths.
Add missing of_node_put() to avoid refcount leak.

Fixes: f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 9b849d781116..a443e7c42daf 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -519,15 +519,19 @@ static int of_get_devfreq_events(struct device_node *np,
 
 	count = of_get_child_count(events_np);
 	desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
-	if (!desc)
+	if (!desc) {
+		of_node_put(events_np);
 		return -ENOMEM;
+	}
 	info->num_events = count;
 
 	of_id = of_match_device(exynos_ppmu_id_match, dev);
 	if (of_id)
 		info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
-	else
+	else {
+		of_node_put(events_np);
 		return -EINVAL;
+	}
 
 	j = 0;
 	for_each_child_of_node(events_np, node) {
-- 
2.25.1

