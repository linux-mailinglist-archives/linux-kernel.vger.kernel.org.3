Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611EE587F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiHBPlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiHBPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:41:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A172713
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:41:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z20so8917714ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3lh5+NDK8urhSXXnABP31QYe2HngTKZ+2NZLHLYtY/E=;
        b=VBlTac0+eLNkOx8fS58zP9Gq+9N19XfcbKIcwUGy1r6R//BvK+/12ohliAH9/U7su+
         axV5laSlVYkKOuorL0lNAjkj87Wwm0T+OdWdmCjbhKNh9sI5+eocDQSfmWP1JGqOH9mW
         XbiU+kukMK2x/p0auilmuEN2nWoqt1Zcriq0OUYnD33TtkwnWBF8FSGd4f8ZWg71NMSS
         d7cyejhTVYsBVly1SyQ17qdpU9e7ZtKNyIrKPVNIqs+bJU+UZoTa8Ob+UFgHoME9ddoG
         1VJKd9Hs8DbvAFjxutvDkdyXGa0s2nlziYRr0VaswnhiPy1V2FoH5ulw9y403y+Vcp0I
         08ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lh5+NDK8urhSXXnABP31QYe2HngTKZ+2NZLHLYtY/E=;
        b=WGjTmbp7FEVaDScfEH/voD5iq2A2DTHY5pBdwpZaQcb5gtlkngi5GRL7B3toGGYVag
         czk/LpN53Vw4yKsrW7WZpBNzaduJuIe7HYN4cEt6GrrvarfVcGgJebbvJbcgOk1pD01o
         ofsUeXjkuRsaB1gXHqiJ82HMwTaeZdzDb/Ow0ZNynHwk8xJoqkhqeZwwC8b904pn6W0Y
         cBtCzGXTZJZBRUlvx9nYuLQ3xgZ0V1dxn37fKNJz7SBJ1t/GPWxH58R8Ek3j7v1k8wWG
         VJNq/YOHmZeZCTLeL3EDRUs3TGAgdYmYHgLEiD9p32KresX1QP6fGjWCQOwTFj5IjjvM
         TkIg==
X-Gm-Message-State: ACgBeo1dKCvzGfjv6Duk10nCCbPYnoJR/yn6vg4YMYsJrr+bvLn44iu7
        7Y0NMGjrqVjzgagOUF792+iACA==
X-Google-Smtp-Source: AA6agR50fbfMJUJUAtcQ10ZD7qqE7NmwLXsIJJMFNvEZ9pCPJGb97G2qFcUkuhmUdZR/nH/XunNUGQ==
X-Received: by 2002:a2e:a168:0:b0:25e:4dbc:2ac0 with SMTP id u8-20020a2ea168000000b0025e4dbc2ac0mr3437928ljl.187.1659454894796;
        Tue, 02 Aug 2022 08:41:34 -0700 (PDT)
Received: from pdkmachine.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id p3-20020a2e7403000000b0025e0b9ea91csm1932193ljc.84.2022.08.02.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:41:34 -0700 (PDT)
From:   Patryk Duda <pdk@semihalf.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@google.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Patryk Duda <pdk@semihalf.com>
Subject: [PATCH v1] platform/chrome: cros_ec_proto: Update version on GET_NEXT_EVENT failure
Date:   Tue,  2 Aug 2022 17:41:28 +0200
Message-Id: <20220802154128.21175-1-pdk@semihalf.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714160951.9364-1-pdk@semihalf.com>
References: <20220714160951.9364-1-pdk@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v0 -> v1
- Dropped `ver_mask` initialization.

 drivers/platform/chrome/cros_ec_proto.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ff767dccdf0f..c1df8e7e48af 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -750,6 +750,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 	u8 event_type;
 	u32 host_event;
 	int ret;
+	u32 ver_mask;
 
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
2.35.1

