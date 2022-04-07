Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78D4F7AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbiDGJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiDGJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:00:37 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107E22229E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:58:37 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i15so4520317qvh.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q8e6XxMP1O+ZGeFqgGhcMctHwiGO0fBPY6X3hC/BVg=;
        b=hmbvr9DWzT6zlFqxQW8VVfwhnQoRbIWMczAwEsFo7jkYdziGIr4AJnnBn+xK5czmsW
         h2qMfABv8pEZrISXIOPxW70Cj1Dqw/gj17iByJ0DgbVlxw05W5/umNzgYkEtp8XLQKAD
         3+kMwes3WgOP0ndyudMXNACpP6u9jT/vY8Ng2AJJKl2KjhOFrXEeAtCr0yJxpB6DAo1E
         kMJ38GMUrF9JWd21N6yJ9o2BcJnLKi5vPp0oCRe3ZS9tyWenjVhVVfejfHZCJD9Fy7E6
         ePr1w7yH8VD7xxxbK7EOwvIJ1gR6M1y9BoyGKXKdyspnyC2lHnE//MiwYNAdGutD/yPz
         ub9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q8e6XxMP1O+ZGeFqgGhcMctHwiGO0fBPY6X3hC/BVg=;
        b=pHAd17snG6ixRycyjadDRILiDvRjaaR+RkE0sDvosBbvVV7mVkiEplfuVWFatoLYmn
         o9BvKCPmtEvvc8p3sp0i9SvTFWaRKvyk1bNy+X1jFb0OOGHCqncjmMEJkSPpdbuoq1pl
         zmPjRgOSHhdZaFX/P6omHb5f3HOjlwb/HyPwyaDVBd4u5HCtTIu662XrrNPpqru6rKO8
         lPAqm+7bCGOXLHm1elZ40tnPKD7XU5/Xouv48jsIFanmE3WW+sUuR1uZBlOqjXsoSvAn
         bj6kZQnbX+broJYxcb1v0D6SVJYHTj05TTV8RJEe1vjD/a9dtwdjMAHE/SZJdxilZAAl
         rxqQ==
X-Gm-Message-State: AOAM533H1wQSL7SJqKgtCkq1HaskG/ajdgXDpSFVv/xE2vra9/JjHUxj
        EWXqFmsMxAEu0ozaF3yTxAiPuo9fmSc=
X-Google-Smtp-Source: ABdhPJwjJIS1cgmsxd1nt3tv416VuFqE22d1BwQDlq2EBl7KnCUyX7xM89R++RLf/vhRbK5r3pFs/Q==
X-Received: by 2002:a05:6214:1bcb:b0:441:759e:84b9 with SMTP id m11-20020a0562141bcb00b00441759e84b9mr10815383qvc.19.1649321916264;
        Thu, 07 Apr 2022 01:58:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm15878977qtx.89.2022.04.07.01.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:58:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clocksource/drivers/timer-ti-dm: fix missing of_node_put
Date:   Thu,  7 Apr 2022 08:58:29 +0000
Message-Id: <20220407085829.2491655-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

of_find_compatible_node returns node pointer with refcount incremented,
use of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 2737407ff069..a58df7749db3 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -691,9 +691,11 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
+		of_node_put(arm_timer);
 		return 0;
 	}
 
+	of_node_put(arm_timer);
 	if (pa == 0x4882c000)           /* dra7 dmtimer15 */
 		return dmtimer_percpu_timer_init(np, 0);
 	else if (pa == 0x4882e000)      /* dra7 dmtimer16 */
-- 
2.25.1

