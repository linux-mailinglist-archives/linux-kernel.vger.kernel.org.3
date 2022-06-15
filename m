Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6AD54C5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbiFOKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFOKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:19:05 -0400
X-Greylist: delayed 1841 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 03:19:03 PDT
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DECE53C72D;
        Wed, 15 Jun 2022 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5F7kf
        wbdaKQzAx1CeFIWQhfk0x5hvs0Zur6uvxwjE1g=; b=CpMMRuH4+q/UCuKjyMMQS
        W9tDJ3ONBTARgU8mYo9e40Rr63yd41yhI6HIPu5wOABnC9fsQ7UjuKxLmy23GUR2
        xU/9cZNxbRdBL+BvSmO8EhfHlg2eIqCKux2HKgx5g3xm7ahGVD17M4ged01IDEWG
        168lpIyAZNaVvm4Q01eInc=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgCHdZrZqqliYE4hEw--.44531S2;
        Wed, 15 Jun 2022 17:48:10 +0800 (CST)
From:   heliang <windhl@126.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] drivers: cpufreq: Add missing of_node_put() in qoriq-cpufreq.c
Date:   Wed, 15 Jun 2022 17:48:07 +0800
Message-Id: <20220615094807.3962918-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgCHdZrZqqliYE4hEw--.44531S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy3Gr1kAr47CFWDXw43Wrg_yoW3Crc_ur
        y3WrW7Wr4UC3ZFqw13Cr1Sy34Svw13WFsYqF18t398J34UAryYg3yvqr9rZ3yruw4UGFZx
        A3WqgF47ur4UJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtRRRJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BohF1pEDuW8kAAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qoriq_cpufreq_probe(), of_find_matching_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 6b6b20da2bcf..573b417e1483 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -275,6 +275,7 @@ static int qoriq_cpufreq_probe(struct platform_device *pdev)
 
 	np = of_find_matching_node(NULL, qoriq_cpufreq_blacklist);
 	if (np) {
+		of_node_put(np);
 		dev_info(&pdev->dev, "Disabling due to erratum A-008083");
 		return -ENODEV;
 	}
-- 
2.25.1

