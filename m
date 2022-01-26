Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C64E49D232
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbiAZTCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAZTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:02:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA50C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:02:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso5226580pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSWaa136uNPsj+g5us2/d5ZsueLesJ/JipX1ew8npy4=;
        b=houkxmz5jw2oKJfEMxk0xeHsYc+3Vbw9wZ9JESaux1d7Ub5Duj47FaJcgJ2wwS0ZmH
         WbN3jhtT2VfQIse5dxVWpz3r4YDuxJZxxv3Xri33vrXETR3Ffxg6RRsCBsk1tn2VCxcv
         YXjNiFUPT4yI+AjQPwO3yUUEKxNMA4xw5N0gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSWaa136uNPsj+g5us2/d5ZsueLesJ/JipX1ew8npy4=;
        b=uJ1r1bFtPFDSKY4mJpUGfoaSFylpIEWDlFsxpA6IiU9ATTbMQhuv8NFRuU7xhbJipV
         0LnbFSXQLcLmALjW1Z/QNfa9Z3Uai3JlfFjllbn7rdhrBfG8WZ6MKCTGnpC1kjg/H4kR
         fF6u9C41hh682atR1Rd7b+r8n54BS7YTW/gdhE/dOFNHZH70zwLFY/Ij0TQ4x8k78l16
         bKJhLpNqSGn0AnwNEDBozkxXm22VjraR/5CcQ8ly6V/0YN0WZQ4ffhs5fzKHAOjFOeRH
         HMGYEaLW6nVRkoXq/By/KkHZClMojdE6DmRJY8rh1TH7A7HjC6GnZ4xSIUnJ0uzyr//v
         zcgw==
X-Gm-Message-State: AOAM531U1AVeibDYvBEpJUJ6h1pugSSz70/Dz7EVSXJFPZI9XP4jt091
        HviCz5IQpV1KYvdDQphvEqa5q7jaKR+12w==
X-Google-Smtp-Source: ABdhPJzLNrEvSsE09REExB0nFTbttHQ+U0crBTyhi5axNQKOsGg95lYKmaTVAI5oP7qBiB/Ey/nHEg==
X-Received: by 2002:a17:90a:e7d1:: with SMTP id kb17mr307930pjb.1.1643223758090;
        Wed, 26 Jan 2022 11:02:38 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s15sm3030998pfg.145.2022.01.26.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:02:37 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>, Alyssa Ross <hi@alyssa.is>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2] platform/chrome: cros_ec_typec: Check for EC device
Date:   Wed, 26 Jan 2022 19:02:20 +0000
Message-Id: <20220126190219.3095419-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Type C ACPI device on older Chromebooks is not generated correctly
(since their EC firmware doesn't support the new commands required). In
such cases, the crafted ACPI device doesn't have an EC parent, and it is
therefore not useful (it shouldn't be generated in the first place since
the EC firmware doesn't support any of the Type C commands).

To handle devices which use these older firmware revisions, check for
the parent EC device handle, and fail the probe if it's not found.

Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
Reported-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
Hi Alyssa, could you kindly test this with your existing setup? Thanks!

Changes in v2:
- Added newlines as suggested by reviewers.
- Added Reviewed-by tag from Tzung-Bi.

 drivers/platform/chrome/cros_ec_typec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5de0bfb0bc4d..952c1756f59e 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1075,7 +1075,13 @@ static int cros_typec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	typec->dev = dev;
+
 	typec->ec = dev_get_drvdata(pdev->dev.parent);
+	if (!typec->ec) {
+		dev_err(dev, "couldn't find parent EC device\n");
+		return -ENODEV;
+	}
+
 	platform_set_drvdata(pdev, typec);
 
 	ret = cros_typec_get_cmd_version(typec);
-- 
2.35.0.rc0.227.g00780c9af4-goog

