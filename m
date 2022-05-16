Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15F527D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiEPGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiEPGZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:25:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD0F252AF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:25:06 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L1q362pTCzhZGv;
        Mon, 16 May 2022 14:24:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 14:25:04 +0800
From:   Lu Wei <luwei32@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] ALSA: ice1724: return void from snd_vt1724_chip_init()
Date:   Mon, 16 May 2022 14:25:46 +0800
Message-ID: <20220516062546.253656-1-luwei32@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return int in snd_vt1724_chip_init() is useless since it always
returns 0.

Signed-off-by: Lu Wei <luwei32@huawei.com>
---
 sound/pci/ice1712/ice1724.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 6fab2ad85bbe..dfef468ad6dc 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2347,7 +2347,7 @@ static void snd_vt1724_chip_reset(struct snd_ice1712 *ice)
 	msleep(10);
 }
 
-static int snd_vt1724_chip_init(struct snd_ice1712 *ice)
+static void snd_vt1724_chip_init(struct snd_ice1712 *ice)
 {
 	outb(ice->eeprom.data[ICE_EEP2_SYSCONF], ICEREG1724(ice, SYS_CFG));
 	outb(ice->eeprom.data[ICE_EEP2_ACLINK], ICEREG1724(ice, AC97_CFG));
@@ -2369,8 +2369,6 @@ static int snd_vt1724_chip_init(struct snd_ice1712 *ice)
 	 * since they cause machine lockups
 	 */
 	outb(VT1724_MULTI_FIFO_ERR, ICEMT1724(ice, DMA_INT_MASK));
-
-	return 0;
 }
 
 static int snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
@@ -2506,8 +2504,8 @@ static int snd_vt1724_create(struct snd_card *card,
 	snd_vt1724_chip_reset(ice);
 	if (snd_vt1724_read_eeprom(ice, modelname) < 0)
 		return -EIO;
-	if (snd_vt1724_chip_init(ice) < 0)
-		return -EIO;
+
+	snd_vt1724_chip_init(ice);
 
 	return 0;
 }
@@ -2702,11 +2700,7 @@ static int snd_vt1724_resume(struct device *dev)
 		return 0;
 
 	snd_vt1724_chip_reset(ice);
-
-	if (snd_vt1724_chip_init(ice) < 0) {
-		snd_card_disconnect(card);
-		return -EIO;
-	}
+	snd_vt1724_chip_init(ice);
 
 	if (ice->pm_resume)
 		ice->pm_resume(ice);
-- 
2.17.1

