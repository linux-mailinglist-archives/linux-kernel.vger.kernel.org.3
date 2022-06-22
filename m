Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0B5541BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356895AbiFVE3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347603AbiFVE3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:29:30 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E02C53526A;
        Tue, 21 Jun 2022 21:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZYSkR
        3rG7wH/nIec2T2jB4hBZSj2bBCch1p+p9iuRxI=; b=OEsas6SQ0mmnZYcP1FE41
        8YXLBWa2d4s9Hm0MUH1Ss6InD0oXQuKQygu/6JwEBf6Zw+6E0ccqyEeOIlrnBJJ4
        R8m1q6aK8I2wXKM6P0H6SmULfQ2GKwvvQ3UokzDgFDOKhoyuxIWDwkh3NkgwCIma
        QKF4iWjUsUUpOC24RmDLW0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowABnB5lpmrJiaxZMDw--.63268S2;
        Wed, 22 Jun 2022 12:28:26 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     windhl@126.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] memory/tegra: Add missing of_node_get() in tegra_emc_find_node_by_ram_code
Date:   Wed, 22 Jun 2022 12:28:24 +0800
Message-Id: <20220622042824.4094625-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowABnB5lpmrJiaxZMDw--.63268S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxWr4rJr1UCryUWr47twb_yoW8Gw1rpF
        WDCrWYkrykW3yfWry8t34UCryfta48GFW7K3yfCas5Zwn8Jas0yr1YgFW5uFn8tFZ2ya13
        Ja1jvF13Xa10qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pENtxnUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gooF1uwMQfyWAAAsY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_name() will decrease the refcount of its first arg and
we need to add a of_node_put() to keep refcount balance.

Besides, during the 'for' loop execution, the refcount of 'np' will be
automatically increased and decreased. There is no need to call
of_node_put() again.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/memory/tegra/tegra20-emc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 25ba3c5e4ad6..e43a5f8e188e 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -477,6 +477,7 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 
 	ram_code = tegra_read_ram_code();
 
+	of_get_node(dev->of_node);
 	for (np = of_find_node_by_name(dev->of_node, "emc-tables"); np;
 	     np = of_find_node_by_name(np, "emc-tables")) {
 		err = of_property_read_u32(np, "nvidia,ram-code", &value);
@@ -484,6 +485,7 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 			struct device_node *lpddr2_np;
 			bool cfg_mismatches = false;
 
+			of_node_get(np);
 			lpddr2_np = of_find_node_by_name(np, "lpddr2");
 			if (lpddr2_np) {
 				const struct lpddr2_info *info;
@@ -521,7 +523,6 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 			}
 
 			if (cfg_mismatches) {
-				of_node_put(np);
 				continue;
 			}
 		}
-- 
2.25.1

