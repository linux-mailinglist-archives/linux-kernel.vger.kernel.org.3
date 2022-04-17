Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB01E5047CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiDQM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDQM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 08:59:01 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC9A024959
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2CJdp
        WYp1Jwg5xWMnBstOcpyeej46BkVdxvxaprz1DA=; b=PPhC6zU1c4GjGLPH+RA32
        WEW+loKPbMM04b3BO/yk/IJUHlQycc24DQtM7sCHG+03JvhEXCeuxau9VvdieKd8
        O0LuzjUP9F5b4yY9yn1NMhzTqLeCu8Io2LCPzirA+U9V+TPCIF1EkIJUrjYSEy1q
        U1KF71c1d9WbXbaDqbR00A=
Received: from localhost (unknown [223.74.153.137])
        by smtp10 (Coremail) with SMTP id DsCowAC3B2NoDlxiFQrHBg--.13975S2;
        Sun, 17 Apr 2022 20:56:10 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Junwen Wu <wudaemon@163.com>
Subject: [PATCH v1] thermal/core: change mm alloc method to avoid kernel warning
Date:   Sun, 17 Apr 2022 12:56:01 +0000
Message-Id: <20220417125601.18535-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAC3B2NoDlxiFQrHBg--.13975S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4rKr45CFyfZrW5Xr4xJFb_yoW8Ww4Dpa
        15W3W5AFZ8XF4UGayUAr48WrZ0y3Z8ta47uFyIkas8ua13JrW3JFyDAry7XrWkGrW8CFW3
        AF1qqr1F9rs8ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pioUDdUUUUU=
X-Originating-IP: [223.74.153.137]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbiLArlbVspdouOVAAAs7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very high cooling device max state value makes cooling device stats
buffer allocation fails,like below.Using kzvalloc instead of kzalloc
can avoid this issue.

[    7.392644]WARNING: CPU: 7 PID: 1747 at mm/page_alloc.c:5090 __alloc_pages_nodemask+0x1c0/0x3dc
[    7.392989]Call trace:
[    7.392992]__alloc_pages_nodemask+0x1c0/0x3dc
[    7.392995]kmalloc_order+0x54/0x358
[    7.392997]kmalloc_order_trace+0x34/0x1bc
[    7.393001]__kmalloc+0x5cc/0x9c8
[    7.393005]thermal_cooling_device_setup_sysfs+0x90/0x218
[    7.393008]__thermal_cooling_device_register+0x160/0x7a4
[    7.393012]thermal_of_cooling_device_register+0x14/0x24
[    7.393140]backlight_cdev_register+0x88/0x100 [msm_drm]

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 drivers/thermal/thermal_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f154bada2906..361e0d0c241b 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -829,7 +829,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
 
-	stats = kzalloc(var, GFP_KERNEL);
+	stats = kvzalloc(var, GFP_KERNEL);
 	if (!stats)
 		return;
 
@@ -848,7 +848,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
-	kfree(cdev->stats);
+	kvfree(cdev->stats);
 	cdev->stats = NULL;
 }
 
-- 
2.25.1

