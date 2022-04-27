Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3248B51248C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiD0Vck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiD0Vcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:32:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC1E88
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:29:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m62so1845700wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZHhhV6+pmb1UT1g76oOP71UxtrLj2KipdoqAHTDk7Q=;
        b=Hd/l4vsy96c0wGx7hXoS15x91RIAemfs0fcqL3+m3VYf3uWEAWKyHYJptgmja3wZN6
         G/b2WNBliCbvsv8gAkK+zbdr5jzW8bxzCJufUcJ7gWS6eMLq58gPdWPOgro+434aCRTr
         XFuv8KvqmLOqhZK5zR8A6DwMGl8xKeZOZC4iAFBHAnlQJCbk+sqrlgWzALVmSEyamC66
         7On7Yakr9cbad53INk/xo7Jr+2Lm6CDbkF+zYsmB2LQWQQh7CgsN5Q2337Ty/C5kuU4c
         9VeXYd41hKKcEK7uVluapP5lYgsADhreNLtoCzHbyFBWTdz4kgL2K5ud4xjNUh1FXhK3
         G+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZHhhV6+pmb1UT1g76oOP71UxtrLj2KipdoqAHTDk7Q=;
        b=71lMlbVVoIw1niyufyTNZxpWQ9IRqi6MF9iX8WPbabS91k+b459NNTSSaz2llw6Sp8
         gwPYM5lbsZCdU7ieY4SMsuvsc/5uT4nu4jtfL9AHxpdcHmtzxMZpR6Hkniy3WMLHTRRm
         lndF6oCt02yBFCsRRkx3hww/SXygv+5b0L1P+jfQMygs59pFB0w0MxXw1gsSHH9+0SK6
         sioOnZhUWZIiYtk7fCwBgxgaGwbowhyzH/PHIIWe+YaGh1C8xTw0pXAgVjtmD0d0r6GZ
         aEFmpXraoTawbKDdnLz5/91ycP1z1X3uaiH62RBO2AgZEba4VEGeV8v+8LtISMtxKO61
         2exQ==
X-Gm-Message-State: AOAM531a0vtw4dtqm9TYSZ0prqOzQygzJPvosjTwfyYdpxaE+xdq7yQQ
        Wf/bYA9GEuWUW/aeSA0c7mCsPSStoO4=
X-Google-Smtp-Source: ABdhPJxLAwFJSbQVPJuobxF9Wtn91U1YeaAUvntI7e21Tsbdh55uAGKn9OfI3Gl7DQGwkqa7i7j0cg==
X-Received: by 2002:a1c:f604:0:b0:38c:8ffd:dbb6 with SMTP id w4-20020a1cf604000000b0038c8ffddbb6mr37125539wmc.43.1651094960712;
        Wed, 27 Apr 2022 14:29:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:255a:b400:fcdb:a3fa:2e97:71c3])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00393ed334220sm2599664wmq.42.2022.04.27.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:29:20 -0700 (PDT)
From:   Nicola Lunghi <nick83ola@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nicola Lunghi <nick83ola@gmail.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8960: Add ACPI support
Date:   Wed, 27 Apr 2022 22:29:16 +0100
Message-Id: <20220427212916.40145-1-nick83ola@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HID made of either Wolfson/CirrusLogic PCI ID + 8960 identifier

This helps enumerate the Waveshare WM8960 WM8960 Hi-Fi Sound
Card HAT on the Up2 platform.

The scripts at https://github.com/thesofproject/acpi-scripts
can be used to add the ACPI initrd overlay.

This commit is similar to the commit:
960cdd50ca9f ("ASoC: wm8804: Add ACPI support")

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
---
 sound/soc/codecs/wm8960.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ca7660f4bb05..08c87ac16137 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -14,6 +14,7 @@
 #include <linux/pm.h>
 #include <linux/clk.h>
 #include <linux/i2c.h>
+#include <linux/acpi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1498,16 +1499,28 @@ static const struct i2c_device_id wm8960_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8960_i2c_id);
 
+#if defined(CONFIG_OF)
 static const struct of_device_id wm8960_of_match[] = {
        { .compatible = "wlf,wm8960", },
        { }
 };
 MODULE_DEVICE_TABLE(of, wm8960_of_match);
+#endif
+
+#if defined(CONFIG_ACPI)
+static const struct acpi_device_id wm8960_acpi_match[] = {
+	{ "1AEC8960", 0 }, /* Wolfson PCI ID + part ID */
+	{ "10138960", 0 }, /* Cirrus Logic PCI ID + part ID */
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, wm8960_acpi_match);
+#endif
 
 static struct i2c_driver wm8960_i2c_driver = {
 	.driver = {
 		.name = "wm8960",
-		.of_match_table = wm8960_of_match,
+		.of_match_table = of_match_ptr(wm8960_of_match),
+		.acpi_match_table = ACPI_PTR(wm8960_acpi_match),
 	},
 	.probe =    wm8960_i2c_probe,
 	.remove =   wm8960_i2c_remove,
-- 
2.34.1

