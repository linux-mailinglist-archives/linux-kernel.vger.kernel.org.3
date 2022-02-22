Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117964BF777
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiBVLyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiBVLyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:54:35 -0500
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907EC11476F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645530845;
        bh=5Rr06d3Yrk3kLF8gXcrflHOop0uoK/3urOWvnEtWmH4=;
        h=From:To:Cc:Subject:Date;
        b=wom2MThnW5HiF1vkfswGwEK+O/3fYEULtzLy4T+FcYODeqDZXCuIwtRYwNKhcYE2y
         cXmKRwntBz6WQdgQFfx4WtavIrIZ9W1UdzUz8aEFJe8cVzvdLK6FnVTKlX4NLQUdPd
         CDwnEX+SPmDIsIJFuPDqWClx6pGJngbACN2ijIqg=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id D828323E; Tue, 22 Feb 2022 19:54:02 +0800
X-QQ-mid: xmsmtpt1645530842thq7la2s8
Message-ID: <tencent_5F9F4223DC44A9ECBF02649AF934F786E305@qq.com>
X-QQ-XMAILINFO: NO7nxmS7l766leqfrpUZ5sDiiO2Ci+eePA+fHyfgbhMFEv3iJBETm3aqlE5TeR
         k+vLbLRC0hPGfKZLatOPMfn83VBHBl0Crmu/Xwx/QzxAYxtqLCSFJnpdSGDAXy47GKgA3CmNPSTR
         jWDwQGvJXJodVs4cCc5lSwoaWwn66NXtHZkL/2dDmHaXMfS+5QeVbnkNIu9Qr1fALG/20oefUhXY
         LcJeFwX5x0U0TwExSqzaP9K7J7rhZJelir2YEf3wPxIv+PZan+RvMXc6XcspHQBV+GyXslg5B35/
         oFlz64F3CxpaprsuTZzgpAr3z1vsh9oqjJWk7sUNzGTO5iofsodVn86MXw/w9Y/+nbVANdKkGr5/
         aJSv23JTq9wtwPiw4Vj3TCmlnLrQdJx+SKoJwvwb3aPbak55Uu9kGlIR24p+AFVSikYAFCNzRvce
         4xu2n5XHxjjFTAqcKOUOOiv9FDysjcVVSFL7EUIxvyzvVLu7ZoUp2GMS24kSi6Wy93KviJItfOYE
         Z+O9t1kiXVxydSbLzyOUWly8jzHNHT26Yifdb+UVPVfUpjS9t6D2670A17Hyr7GeZTaaHLzsduyk
         r336mDqgZJnOBrlU8W6he9+zhp0CMjtkbudzyo87cRsBwBfNu8BIaDmSNyW3fyNk4R5sdRsPBXAn
         FUTqHyotwoEvoRqdSafpX7wVn3JlDfwIBjboRSVlHrVUzqhtwEyw2SeDp8To8s91LmECDlI5NqTy
         qPignu+D4kAzsbSiS0ziCzooKrKv27aaU+MMsLZNjiaPjLbX2dxbZ2Y1+uKuDb+9Du+HF8ADa/gX
         Z4+PvR+N7YMnRc15TVDzLp1wzhiCJwa3XWoRpwkxzr4Mke4wX7qruA3Zpb5X6mNjzG8IKcMs3dFN
         C9UYJ815cC95aRU9mXnSMXJO6kHBw/xsMcC3tVY0sMmCECxYpABfs=
From:   xkernel.wang@foxmail.com
To:     tiwai@suse.com, perex@perex.cz
Cc:     krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] ASoC: samsung: i2s: check the return value of kstrdup()
Date:   Tue, 22 Feb 2022 19:53:32 +0800
X-OQ-MSGID: <20220222115332.4084-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() is a memory allocation function which can return NULL when
some internal memory errors happen. It is better to check the return
value of it to catch the error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 sound/soc/samsung/i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 309badc..70c8271 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1349,6 +1349,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 		return -ENOMEM;
 
 	pdev_sec->driver_override = kstrdup("samsung-i2s", GFP_KERNEL);
+	if (!pdev_sec->driver_override) {
+		platform_device_put(pdev_sec);
+		return -ENOMEM;
+	}
 
 	ret = platform_device_add(pdev_sec);
 	if (ret < 0) {
-- 
