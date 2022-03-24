Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1604E60E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349086AbiCXJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiCXJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:13:57 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 865E09D0ED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Y63xt4boxyExZq6hhV
        N4HB4jAAAEHQlGefrZDnFYgGg=; b=A9epg5pGbMDc3HSK9XABSIllTpHrUkBJsS
        FXVkVLZ4uTM2wB+GzQtLn4uVvXdZrSd3Cwnog29OycmaHCY0HWDgKppeD39hlHmX
        SNGqilINnEfPkkQwb+7jYjfL2Dnv2utnOwVTe51kEOZwzbPUQLVvAcuCiTnY4IkV
        mMJfpcDEU=
Received: from localhost (unknown [159.226.95.33])
        by smtp7 (Coremail) with SMTP id C8CowADXcrjqNTxieYAGEA--.7423S2;
        Thu, 24 Mar 2022 17:12:10 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     tomba@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] drm: omapdrm: Check for NULL return of kzalloc()
Date:   Thu, 24 Mar 2022 17:12:07 +0800
Message-Id: <1648113127-8020-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowADXcrjqNTxieYAGEA--.7423S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry3JFy5urWxtw47Zw43KFg_yoW8GFy8pF
        WDta4jkr18AF42grnrA3WqyFy5Ga13CF1Sgr9ruwna9w4rArW7Xwn8JFy3Arykuws3Ar42
        gF4kt3WfGrn8Cr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUO18gUUUUU=
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/xtbCbgrNH2BbCZwkzwAAsz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() is a memory allocation function which may return NULL.
It is better to check the return value of it to catch the error in time.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 3 +++
 drivers/gpu/drm/omapdrm/omap_irq.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 06a719c..fcd76ea 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -166,6 +166,9 @@ void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
 	dispc_mgr_enable(priv->dispc, channel, enable);
 	omap_crtc->enabled = enable;
 
+	if (!wait)
+		return ;
+
 	ret = omap_irq_wait(dev, wait, msecs_to_jiffies(100));
 	if (ret) {
 		dev_err(dev->dev, "%s: timeout waiting for %s\n",
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 4aca14d..a234462 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -45,6 +45,9 @@ struct omap_irq_wait * omap_irq_wait_init(struct drm_device *dev,
 	struct omap_irq_wait *wait = kzalloc(sizeof(*wait), GFP_KERNEL);
 	unsigned long flags;
 
+	if (!wait)
+		return NULL;
+
 	init_waitqueue_head(&wait->wq);
 	wait->irqmask = irqmask;
 	wait->count = count;
-- 
2.7.4

