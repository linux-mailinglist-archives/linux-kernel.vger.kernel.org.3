Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437465A3C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiH1Hq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiH1Hqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 03:46:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE3399E4;
        Sun, 28 Aug 2022 00:46:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4770332007F0;
        Sun, 28 Aug 2022 03:46:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 28 Aug 2022 03:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1661672810; x=1661759210; bh=xmumsxBjbgYu7DsPGi9nc0Yk4
        a2Zt1uVg21vHFB9wxc=; b=aXN6PLz5r7vKhbuALbBvp3rNQiRaJLQEkhzNcMLQw
        xt72NL2wUxTS+qC5lTzuPT48q2j8NEdgrJZIQEuYUCy3zznviT9ocrxNMIClT4Y8
        kZ13y3gPAUA+R73gwiTUt1U3AdUybuEO6Mg7UANQndmti/T7lMGl0ynotiUW4ZEU
        hzng5/WZUm/ypUgg33mjLUtUE9zLlJT6JVYfby43ud67lxHDWa9BJGxSmySKtYH/
        b0ucW7FCxhUzAp9yUL73Bbh7/Y2DGJvSRT23ekd0I0TKxhdrSWgYiv3E5jkmcJO8
        XfCFmzYFEx6han27GH2dQzLNlxFakKEeg8UWulyMu4I3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661672810; x=1661759210; bh=xmumsxBjbgYu7DsPGi9nc0Yk4a2Zt1uVg21
        vHFB9wxc=; b=HpkWXBIs3kUyIyJ6pxAxWmlTe/UudOs6AIY2fTyXXtfOUR/sf12
        fpUqX/Og5QswNA/lHmApML41gVcHczS4fLi++2nQIvtk+M9GIgHTiU1MTKv79dxr
        Pwqlclxjq+8n76g93H+nENe2muh+X6A996SgEGekzBYBB05dpkqieHnnUCp3VuM4
        pxYEXySr7NnZkZLrkE6wXp/H2q7ckgE0DSMMQpW+Kmvxowum+I7T1koNKgQQtJiT
        h9m/7agzqzz2+jHZWZv/POgyew7uQeMPWq0iwY5YDuiA+Tbw3eMbAvkrO6GHAx4a
        pq1+5pf7eJNi0kTy/GWLFPHK1aFApPEta4A==
X-ME-Sender: <xms:ah0LY6N8rZ8ZNSaPnQUZJRDAk7aKyrpehXzqOoqBxjknBhfgilb6wA>
    <xme:ah0LY4-fEmN7tvEGcPLzQ0aNFuC7jM2oZBisGkoyUmiTkbzP4OAJ3K3GC1sZRN3Xd
    rLI063QnIjW4fPPtjc>
X-ME-Received: <xmr:ah0LYxTCfPuBDx4QIBL2_3wfg1ErdnkxXUpNwNt4bHMqqDWurbRw2gghUm3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejkedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftd
    dtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ah0LY6sG0LFDujpETdgXNbUBEBpvgLNGaZS3YIHNSkG6b5UMZMbB2w>
    <xmx:ah0LYyc9eEcOcB1hamvngyoSB7rMURjKzmNVxn8krAfNxFhA8gaBAA>
    <xmx:ah0LY-2v_SeE_YxZfngmduuM2aq3ek_DuZCDuM9VLGhF9JKHjR-WcQ>
    <xmx:ah0LYy5G4T3LTbWDtkS01m05_IVKXPPBZP4vTh01OlGW1cIKei0X_w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Aug 2022 03:46:47 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, markgross@kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] asus-wmi: Increase FAN_CURVE_BUF_LEN to 32
Date:   Sun, 28 Aug 2022 19:46:38 +1200
Message-Id: <20220828074638.5473-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for TUF laptops returning with an -ENOSPC on calling
asus_wmi_evaluate_method_buf() when fetching default curves. The TUF method
requires at least 32 bytes space.

This also moves and changes the pr_debug() in fan_curve_check_present() to
pr_warn() in fan_curve_get_factory_default() so that there is at least some
indication in logs of why it fails.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3d9fd58573f9..11203213e00d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -108,7 +108,7 @@ module_param(fnlock_default, bool, 0444);
 #define WMI_EVENT_MASK			0xFFFF
 
 #define FAN_CURVE_POINTS		8
-#define FAN_CURVE_BUF_LEN		(FAN_CURVE_POINTS * 2)
+#define FAN_CURVE_BUF_LEN		32
 #define FAN_CURVE_DEV_CPU		0x00
 #define FAN_CURVE_DEV_GPU		0x01
 /* Mask to determine if setting temperature or percentage */
@@ -2383,8 +2383,10 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	curves = &asus->custom_fan_curves[fan_idx];
 	err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
 					   FAN_CURVE_BUF_LEN);
-	if (err)
+	if (err) {
+		pr_warn("%s (0x%08x) failed: %d\n", __func__, fan_dev, err);
 		return err;
+	}
 
 	fan_curve_copy_from_buf(curves, buf);
 	curves->device_id = fan_dev;
@@ -2402,9 +2404,6 @@ static int fan_curve_check_present(struct asus_wmi *asus, bool *available,
 
 	err = fan_curve_get_factory_default(asus, fan_dev);
 	if (err) {
-		pr_debug("fan_curve_get_factory_default(0x%08x) failed: %d\n",
-			 fan_dev, err);
-		/* Don't cause probe to fail on devices without fan-curves */
 		return 0;
 	}
 
-- 
2.37.2

