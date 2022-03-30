Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0B4EBC27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiC3Hxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbiC3HxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:53:24 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56154CF6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=S5Xr/+A+9DZoWIfSpuQs3qtL0ru3AVsUPP4NG1N8m/A=;
        b=mXoeRDuefGRCYjdSTUs57UnQARsMi+Oh/NK31QtBmITDl8C/y1FjMkziSdEf0dLt98dLnNs124nqT
         u+7w0gSGvKv3aMs7ZYT8O0msTck7nj3G1QvuoK90wQ+ZYbOR+i82BaEA1AyGfkbuZx3XDNbROPS/Mv
         8ZDzav316xKcHocUv08bzWiFcI1yZcDzPa8G5uWui06UV/bYlFhfqp8ZB5hULnUN8K21aIqQDaHYv5
         4TGiwV8qIgSNRSgqpGCvWFOfMoZDDgRmBJVWFIESkgPab6NMYvXMz+swpqWRT4QkJhTDeUnh1JljV3
         evxMD0fpGMDGyOzvEsLnaw96unP0ryA==
X-MSG-ID: f3f28322-affb-11ec-b450-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH 1/2] drivers: auxdisplay: ht16k33.c: Add option to refuse claiming primary fb
Date:   Wed, 30 Mar 2022 09:34:39 +0200
Message-Id: <20220330073440.3986724-2-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330073440.3986724-1-david@protonic.nl>
References: <20220330073440.3986724-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case there is also a display with a frame-buffer device, the probe
order of the auxdisplay fb and the main fb is not predictable, possibly
leading to the situation where the holtek auxdisplay becomes /dev/fb0.
This is problematic because there is currently no way to automatically
rename these devices, and too much user-space software that assumes fb0
to be the main display.
In such a situation, adding "holtek,refuse-primary-fb" to the DT, the
auxdisplay driver returns -EPROBE_DEFER to wait for the primary fb device
to get probed first.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/auxdisplay/ht16k33.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 4fab3b2c7023..e8e0c644f2e4 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -581,12 +581,20 @@ static int ht16k33_keypad_probe(struct i2c_client *client,
 	return input_register_device(keypad->dev);
 }
 
+extern int num_registered_fb;
+
 static int ht16k33_fbdev_probe(struct device *dev, struct ht16k33_priv *priv,
 			       uint32_t brightness)
 {
 	struct ht16k33_fbdev *fbdev = &priv->fbdev;
 	struct backlight_device *bl = NULL;
 	int err;
+	bool not_primary;
+
+	not_primary = device_property_read_bool(dev, "holtek,refuse-primary-fb");
+
+	if (!num_registered_fb && not_primary)
+		return -EPROBE_DEFER;
 
 	if (priv->led.dev) {
 		err = ht16k33_brightness_set(priv, brightness);
-- 
2.32.0

