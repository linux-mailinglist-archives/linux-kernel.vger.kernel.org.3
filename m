Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED73E50B338
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445610AbiDVIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356251AbiDVIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:51:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C2532F5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:48:23 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh4so5040727qtb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGUVx3hgdajCW+976w4lkM3ey7YR4mBSOm5v5Cgd+YI=;
        b=Rt87t1uaEXp6dP43WH9rOSdXW/DJt3HVbEypwIK8wxvEwNmg9+YFwY3OQWYQ1qZLIW
         05oQy+OZqSW/Apkh8GwKMxaBYoBNJl3rxegXLo18/Ggr3eiFTBIAPwRSiKdY0TQ4vyZ6
         0G9HVgV0Dxc+HEg6hkSq7uuLUB3gczox1hntyexXANkioahiZM+JXMxRysPkHxswqwDH
         RTGaWTzZ0hwHFOYGRtsD6q4I2C324EykgJtnvE2RmlWyncWQxH6ua3CzHMDFzd4w14K/
         eQsBxft4GB1V4Bzkk1G/V7mui4Bq6Wv/mYHcvLkfGRJYF7Kr9Zzjxgv6cqYK9Znw/afn
         CPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGUVx3hgdajCW+976w4lkM3ey7YR4mBSOm5v5Cgd+YI=;
        b=qU/8AwNHU2j7JGmkwCaNM9wJpvuNnSHmy/m6nV/DMYAc4AEaIRvpOP8TecQZ5Gglpq
         eK4WXEt92mXzbR1IzHyB2knFpDeTCcYiBnNOvdYtfBtJM99kFTGmLXMk8m9sarZ5GJXw
         U3bE02hshBvwYapFnFCAysMoIh3fLaY+e8Q2XwLpnwngyY8TXMr5BXC2cIkImRyh9nUL
         XqhWQAAgPmtk9STKrGPdpMXf3uSGmuJSTOG3CgkBXDH9Uta2drlms9BdShv0VxGezl7/
         81Q4NFv/epTrM11+98MBhIgvBbHkdDCQoG7Z2n1yOhS8vBWuRoG3ZpJCI3zuRKhaFDKO
         1LNQ==
X-Gm-Message-State: AOAM531yzXSOMIBZTdIDYWELbj3UFaeVWYepXgJ4ihUuewfr6/ob3t7l
        tqabPerljJL13SUZXWSxfYM=
X-Google-Smtp-Source: ABdhPJzr7hWYaXU0TBsPXtBLdHJFpRw1vgb1lBzpx4LE93gIKwhC25ta1cHvcJ7LYNlXAssxB6i8GA==
X-Received: by 2002:ac8:5bcd:0:b0:2f3:5b70:be82 with SMTP id b13-20020ac85bcd000000b002f35b70be82mr450524qtb.227.1650617302651;
        Fri, 22 Apr 2022 01:48:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l130-20020a37a288000000b0069e8290f28asm646998qke.97.2022.04.22.01.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 01:48:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clocksource/drivers/oxnas: fix error check return value of irq_of_parse_and_map()
Date:   Fri, 22 Apr 2022 08:48:16 +0000
Message-Id: <20220422084816.2775898-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The irq_of_parse_and_map() function returns 0 on failure, and does not
return an negative value.

Fixes: 	89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/clocksource/timer-oxnas-rps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index 56c0cc32d0ac..d514b44e67dd 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -236,7 +236,7 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 	}
 
 	rps->irq = irq_of_parse_and_map(np, 0);
-	if (rps->irq < 0) {
+	if (!rps->irq) {
 		ret = -EINVAL;
 		goto err_iomap;
 	}
-- 
2.25.1

