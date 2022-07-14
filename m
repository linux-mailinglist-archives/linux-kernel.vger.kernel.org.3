Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D23575275
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiGNQJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiGNQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:09:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A452FD7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:09:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r2so2171387wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/feeXuDF17U3RBhITfW4b8xd6jPaKrhz4mQZDocXnE=;
        b=qstB9JUwN0WNwR+RZEXK8uXWjBMHCoNZLWyXVtp2NScFXwB2tMJ2AA/eSIZWPKSLY2
         88iD23awwtBYX/Ip7FxVW6GpTRnbF+3npCqPksCBtK8s2GiqPQfyVZtuZLwTPSccDl3t
         jwTLFXRmMZvXeEnwxwdYZSLD15CHU9HC2M3sC9NxLvIslLwpJZSIk1yDvSPh6HYdirRQ
         c4otksAWqzzA54BEYImE1T0rOhRNtJApq+KbbqgilXbhY5dwrg1HVEmx/dnPEstD8y7l
         mLZr9WElpoCMJoxhLs7v0VmQ2L/NsFGCDa0SaTXf4op+ZhckSdp1oS+HRjFfcNFjMTkt
         ZbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/feeXuDF17U3RBhITfW4b8xd6jPaKrhz4mQZDocXnE=;
        b=UFZlwWL9r7Ge8uJxer17b3XKx6qkM2DE2Qq2PLZ/xv8Kbt8OvIeLOteXJRMJOfNk28
         fal0kfMfmXmU3GNl/1ymZowL935OarQ7NeAEQb2zBjc/Z4zMfCuFXhSq4W1dYIqAj47d
         ME36hQeLg65BRAvZaIHJ0aZFERQ9uNIN9nJYu0HZx0psNDuGhBzA8rjOSgc2moc7w3rZ
         ouGDeHPraP6mOHThRQMcpLg+K83iPor8zvZj76vl6izrMq+65OdRFmaE7f3tBUUPjX4O
         hmntKT8niGOlHTtj41We6D7qBQCHS4WNe3ETjNda7ysJ01JCEcWhwcgMC12chdRc7/W4
         dH2g==
X-Gm-Message-State: AJIora/9qnU42BtMFJoYfYpHCqKh92GkyNzsYlZ/4meCBC+i/kdwjghT
        fFBBRKNRza/ZUO9NrwBhtkI3lQ==
X-Google-Smtp-Source: AGRyM1thQHR7ljDVhTjy0f1PoC9fRTmLcI9qSF5de9HubbXG6CSsf9gMmgud55PZb4IwR9+1Aobk1w==
X-Received: by 2002:a5d:5451:0:b0:21d:2295:6a05 with SMTP id w17-20020a5d5451000000b0021d22956a05mr8796856wrv.302.1657814987995;
        Thu, 14 Jul 2022 09:09:47 -0700 (PDT)
Received: from localhost.localdomain (91-123-191-107.gigainternet.pl. [91.123.191.107])
        by smtp.gmail.com with ESMTPSA id p13-20020adff20d000000b0020e6ce4dabdsm1846289wro.103.2022.07.14.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:09:46 -0700 (PDT)
From:   Patryk Duda <pdk@semihalf.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Patryk Duda <pdk@semihalf.com>
Subject: [PATCH] platform/chrome: cros_ec_proto: Update version on GET_NEXT_EVENT failure
Date:   Thu, 14 Jul 2022 18:09:51 +0200
Message-Id: <20220714160951.9364-1-pdk@semihalf.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some EC based devices (e.g. Fingerpint MCU) can jump to RO part of the
firmware (intentionally or due to device reboot). The RO part doesn't
change during the device lifecycle, so it won't support newer version
of EC_CMD_GET_NEXT_EVENT command.

Function cros_ec_query_all() is responsible for finding maximum
supported MKBP event version. It's usually called when the device is
running RW part of the firmware, so the command version can be
potentially higher than version supported by the RO.

The problem was fixed by updating maximum supported version when the
device returns EC_RES_INVALID_VERSION (mapped to -ENOPROTOOPT). That way
the kernel will use highest common version supported by RO and RW.

Fixes: 3300fdd630d4 ("platform/chrome: cros_ec: handle MKBP more events flag")
Cc: <stable@vger.kernel.org> # 5.10+
Signed-off-by: Patryk Duda <pdk@semihalf.com>
---
When Fingerprint MCU is rebooted (e.g. as a part of tests) it jumps to
the RO image and performs RW image signature check. If kernel calls
EC_CMD_GET_NEXT_EVENT FPMCU RO will respond with EC_RES_INVALID_VERSION
because it's older than RW and supports up to version 1 of the command.
As a result kernel keeps trying to get MKBP events and effectively
blocks FPMCU from jumping to RW image.

Before patch 3300fdd630d4 the driver called version 1 of the command.
If the device responded with EC_RES_INVALID_VERSION, the driver would
use version 0 of the command.

Best regards,
Patryk

 drivers/platform/chrome/cros_ec_proto.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ff767dccdf0f6..0a131045d50a9 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -750,6 +750,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 	u8 event_type;
 	u32 host_event;
 	int ret;
+	u32 ver_mask = 0;
 
 	/*
 	 * Default value for wake_event.
@@ -771,6 +772,37 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 		return get_keyboard_state_event(ec_dev);
 
 	ret = get_next_event(ec_dev);
+	/*
+	 * -ENOPROTOOPT is returned when EC returns EC_RES_INVALID_VERSION.
+	 * This can occur when EC based device (e.g. Fingerprint MCU) jumps to
+	 * the RO image which doesn't support newer version of the command. In
+	 * this case we will attempt to update maximum supported version of the
+	 * EC_CMD_GET_NEXT_EVENT.
+	 */
+	if (ret == -ENOPROTOOPT) {
+		dev_dbg(ec_dev->dev,
+			"GET_NEXT_EVENT returned invalid version error.\n");
+		ret = cros_ec_get_host_command_version_mask(ec_dev,
+							EC_CMD_GET_NEXT_EVENT,
+							&ver_mask);
+		if (ret < 0 || ver_mask == 0)
+			/*
+			 * Do not change the MKBP supported version if we can't
+			 * obtain supported version correctly. Please note that
+			 * calling EC_CMD_GET_NEXT_EVENT returned
+			 * EC_RES_INVALID_VERSION which means that the command
+			 * is present.
+			 */
+			return -ENOPROTOOPT;
+
+		ec_dev->mkbp_event_supported = fls(ver_mask);
+		dev_dbg(ec_dev->dev, "MKBP support version changed to %u\n",
+			ec_dev->mkbp_event_supported - 1);
+
+		/* Try to get next event with new MKBP support version set. */
+		ret = get_next_event(ec_dev);
+	}
+
 	if (ret <= 0)
 		return ret;
 
-- 
2.31.0

