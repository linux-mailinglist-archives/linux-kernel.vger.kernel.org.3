Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9152C4E6205
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349619AbiCXLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbiCXLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:01:40 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C2E85BC7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648119601;
        bh=MiK7sEzGBHCdbf5gWTcvE8l+cSUdFAE938ETs/tbpfg=;
        h=From:To:Cc:Subject:Date;
        b=mjfoAi4UL19Pd+YTBM8ygiYiy0C8+5VciCNN+RXKaGbV+J0imRFjJJ1fRPvvQUePl
         ZdxbjgQo+QSN0y47V5hswtjFXvs5ruFus/19fqIcbO/+zbW3MQ6dbVQ4q7xM9nnNLa
         NkNBSElrbJbD3f90dvu3fEVd4VYqLGtEFP1YCHmg=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id EAF35228; Thu, 24 Mar 2022 18:58:47 +0800
X-QQ-mid: xmsmtpt1648119527t812l750o
Message-ID: <tencent_E01412E12D4A66FFB02064CC9CB9141CDE08@qq.com>
X-QQ-XMAILINFO: M7dxyDFn9MPmPxEIf5rL3xQJmuzpC42ZBVPiLrqnw6oyG9TiSExtqoS7YccQ3A
         Lv7wv+VILkMCbjfrV788WJs/9vbr+/0zYxuplSuXeceGKI5IO1AQVPbzQEAMgYZ+t0Pyp0KtZSDW
         CVPkINWkLS6GI8NQqk3rm1nuFV6H8NSFFLF8yiBb4FJwMs5vdz/s8UEUsz9truS+SsEDpsTlEmBs
         NyYHqLxe89RuI2O+hF5d2C54TCTqWUpp5La1BgMB58ZM/CZY4nJcvbXBAQ7DmO7+HP5ZgffLkzeN
         Mv7FTzNmzOHEcNasq0fTIsxPm84s/iTYUjxCR2ubVRoxFhlb4M/E923aF4eM6yYo8ZAGlTHRVLCB
         hkKgY18m9Evy5IgjZOAnlwxGlyLfIA1AA0hBhEfBFeL+0or+c2JQNg9/f3O/mQygUG+ZzYHgYpus
         C+RkuH+cL7pUhtEuJhbEeOr15J+CM00Aw7LjkuhHXNbLhcv7tiymjVb2Z6P/ehy+Lwgn94fEPNCj
         pnTkmrBZxBtiTbT5LkrIY3c6tN3AkjKpg+11a8C+z4+yuq/dbKP8hH3fI61hdFj6nZhwCwWmQ3ap
         jTQD2uvIxoyVLiB7dM7Upx3otN/f1/mPxt9qoDLlzK07EpLPsMcUR+W19qzMzDPhoYsA6RZNrrln
         NA3qREI6nckAZ7+rx6fIai+J9XXwIFqryb0ziejKdGyN3H7msidcVAX2DgMAvtGPiL683Fr3/pID
         3mc70c5n6ZVC+hciZ9YgdmFRFSIFtXce3bq+vNCavgszvlUyVEIoKEWBGhrcWENjSeaCTVHYKyPe
         fHn4IkCE32/998gu1o3Uco3BL54VFX9s9NbuWcQzhfXgsaN2WGstodSZCGlh56lUv6EUpO0zBOjr
         uXmAgbYty6ph3UgWGP9BMFdwTydSrhfN0APs+vSdKGcF0TE0Xn2gtjp5lFLUoJDaxlbQsTaVxlr1
         zQ1FtSp4g=
From:   xkernel.wang@foxmail.com
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] drm/omapdrm: check the return value of kzalloc()
Date:   Thu, 24 Mar 2022 18:58:04 +0800
X-OQ-MSGID: <20220324105804.3088-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it.
Besides, to properly handle the error, another check is added for the
return of omap_irq_wait_init().

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 12 ++++++++----
 drivers/gpu/drm/omapdrm/omap_irq.c  |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 06a719c..12c0008 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -166,10 +166,14 @@ void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
 	dispc_mgr_enable(priv->dispc, channel, enable);
 	omap_crtc->enabled = enable;
 
-	ret = omap_irq_wait(dev, wait, msecs_to_jiffies(100));
-	if (ret) {
-		dev_err(dev->dev, "%s: timeout waiting for %s\n",
-				omap_crtc->name, enable ? "enable" : "disable");
+	if (!wait) {
+		dev_err(dev->dev, "%s: out of memory\n", omap_crtc->name);
+	} else {
+		ret = omap_irq_wait(dev, wait, msecs_to_jiffies(100));
+		if (ret) {
+			dev_err(dev->dev, "%s: timeout waiting for %s\n",
+					omap_crtc->name, enable ? "enable" : "disable");
+		}
 	}
 
 	if (omap_crtc->channel == OMAP_DSS_CHANNEL_DIGIT) {
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
