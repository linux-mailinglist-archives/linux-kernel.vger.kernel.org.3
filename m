Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44A4501FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348077AbiDOAfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbiDOAfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:35:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F363B0A4B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:58 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q19so6147498pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jkz+K46qtkIknicoqbLXEwCJgWhY8AVoAaPBkdZve2U=;
        b=UGyg9hR+s/RnQZqDAT16Gq3HREy8egyTdio40vc9b2DXdzEhoR+syVUHMO6ACrN4si
         o5m2LO78SdlXKcFz2Y0unk1Rz3+ZYTNxIHyrEe7jYqw6KMm3qFBqzIGFfHfUbweV5EJK
         gYd2QE8lr4c2DhEP5HnJxUIOQSOD9VOv1Wm0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jkz+K46qtkIknicoqbLXEwCJgWhY8AVoAaPBkdZve2U=;
        b=734Cpvpd/5hlQn3/HpOCBPQxTMjhbBrLaR4Lwx8EaE/dk5EsxTu5pncBggblVUoj2x
         hNsdl5NFqEd/0sisxIPLgwhsvStb/Az/B1Y2Rm/OEDGtMgvw6005jJQR5ldJiPScfCsP
         7VurY9urfU5Kch/37d7RA2U+Hd+as2An6V2/eUuInx9blww009LMmQjeE4np6HJku/Ea
         7EBIRJAhIfQ1CYa2JEdjZf9SpinmRO4O1fvoYBYbkuLfn86RP0g9FVTDFCT7es6cftmN
         9I9Ain6vrdIrFZT0GuOaRKI7Ls+vPcTXX5T2XhoQPZew7M2doC1WMe2Ilb37hEQ29ldH
         PimA==
X-Gm-Message-State: AOAM533yL+XMcBlDREDL4LwQrfZPYG2RQ03lDAbRQ0U9mURszho0aBVU
        Q5egGkhMvapiadU8znlQmWVpMw==
X-Google-Smtp-Source: ABdhPJxvYhjYZJVkJb/YqcuxXe04uZW1OYgYUoLiRnxUGlY1oCtRAnvQQVyvmC3kzKaWPTQk6Qd8GA==
X-Received: by 2002:a05:6a00:cc3:b0:505:c82b:f4f8 with SMTP id b3-20020a056a000cc300b00505c82bf4f8mr6363580pfv.59.1649982777538;
        Thu, 14 Apr 2022 17:32:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e3e0:734:f81a:d2c1])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm2830187pgf.17.2022.04.14.17.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:32:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH 2/3] mfd: cros_ec_dev: Only register PCHG device if present
Date:   Thu, 14 Apr 2022 17:32:52 -0700
Message-Id: <20220415003253.1973106-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220415003253.1973106-1-swboyd@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't create a device for the peripheral charger (PCHG) if there aren't
any peripheral charger ports. This removes a device on most ChromeOS
systems, because the peripheral charger functionality isn't always
present.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daisuke Nojiri <dnojiri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: <chrome-platform@lists.linux.dev>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 546feef851ab..d2ba6a1fbc1d 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -114,6 +114,9 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-chardev", },
 	{ .name = "cros-ec-debugfs", },
 	{ .name = "cros-ec-sysfs", },
+};
+
+static const struct mfd_cell cros_ec_pchg_cells[] = {
 	{ .name = "cros-ec-pchg", },
 };
 
@@ -242,6 +245,19 @@ static int ec_device_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * The PCHG device cannot be detected by sending EC_FEATURE_GET_CMD, but
+	 * it can be detected by querying the number of peripheral chargers.
+	 */
+	if (cros_ec_pchg_port_count(ec)) {
+		retval = mfd_add_hotplug_devices(ec->dev,
+					cros_ec_pchg_cells,
+					ARRAY_SIZE(cros_ec_pchg_cells));
+		if (retval)
+			dev_warn(ec->dev, "failed to add pchg: %d\n",
+				 retval);
+	}
+
 	/*
 	 * The following subdevices cannot be detected by sending the
 	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
-- 
https://chromeos.dev

