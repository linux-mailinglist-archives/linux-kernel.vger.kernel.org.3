Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A350558B0F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiHEUzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiHEUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:55:36 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125013E35
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:55:36 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id K4M1oAZJDoEdDK4M1o1VPQ; Fri, 05 Aug 2022 22:55:34 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 05 Aug 2022 22:55:34 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] perf/arm_pmu_platform: Fix an error message related to dev_err_probe() usage
Date:   Fri,  5 Aug 2022 22:55:30 +0200
Message-Id: <aaeba9c12ccdb29f48fe19137cb5abeea85fbb24.1659732652.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err() is a macro that expand dev_fmt, but dev_err_probe() is a
function and cannot perform this macro expansion.

So hard code the "hw perfevents: " prefix and dd a comment explaining why.

Fixes: 11fa1dc8020a ("perf/arm_pmu_platform: Use dev_err_probe() for IRQ errors")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Untested, but I can't see how it could work.

v1 --> v2
  - fix a typo in the comment
---
 drivers/perf/arm_pmu_platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 513de1f54e2d..02cca4b8f0fd 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -101,8 +101,11 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	struct device *dev = &pdev->dev;
 
 	num_irqs = platform_irq_count(pdev);
-	if (num_irqs < 0)
-		return dev_err_probe(dev, num_irqs, "unable to count PMU IRQs\n");
+	if (num_irqs < 0) {
+		/* dev_err_probe() does not handle dev_fmt, so hard-code the prefix */
+		return dev_err_probe(dev, num_irqs,
+				     "hw perfevents: unable to count PMU IRQs\n");
+	}
 
 	/*
 	 * In this case we have no idea which CPUs are covered by the PMU.
-- 
2.34.1

