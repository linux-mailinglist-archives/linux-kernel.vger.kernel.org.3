Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D169590C08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiHLGkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLGkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:40:04 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8859C218;
        Thu, 11 Aug 2022 23:39:56 -0700 (PDT)
X-QQ-mid: bizesmtp84t1660286371t6z6a0wm
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 12 Aug 2022 14:39:29 +0800 (CST)
X-QQ-SSF: 01400000002000D0T000B00A0000000
X-QQ-FEAT: ALw5QuVtm4Wbl5eB3SFm9PpWuGQ3MocdyQreJyY80BQcn6hBdDEsUfKfOwVZb
        Mx9l/KtOx0t8f5oqJ5uWmmG9QxZzLGutfze3geRuOzpFWt3qjXEvROY0raNPPdQMeOAcY7P
        pmyKnjV3saGfnXHRaph22MJG145LbWRRmXfQCQIS71iMKR6TtRK/YK7PNBlW1ZG6LLEd6tm
        W60Ctvngp7W2uxVZ4lDvFfz0/AAa3yUOL2jEQtsXkMznLSwo0RH+RDd9RGrxsSoaI5iQPuX
        hQFxOfo/ISrjf+pUPM/e9WlcC3MpLHuStjYxjF/maz5JL2CoTdsUeEIEpRo4OpTv55wbzrH
        2M9OPkianqZOXdgrOyXje2iwdRMzzLfQgZsh/vCQL+aVF8WlXlxXNOE4dEeI/9yVr23QfHx
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     support.opensource@diasemi.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] thermal/drivers/da9062: Remove unnecessary print function dev_err()
Date:   Fri, 12 Aug 2022 14:39:26 +0800
Message-Id: <20220812063926.12924-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/thermal/da9062-thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 180edec34e07..7dcfde7a9f2c 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -248,10 +248,9 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
+	if (ret < 0)
 		goto err_zone;
-	}
+
 	thermal->irq = ret;
 
 	ret = request_threaded_irq(thermal->irq, NULL,
-- 
2.20.1

