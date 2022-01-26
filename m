Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1E49C0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiAZBWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiAZBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:22:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D771C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:22:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so4599288pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdSOUDJOxJ2WJV+wp0309W4y0HIj4q+nszAoAMP8o48=;
        b=izneacJQ48V3dSINuH1Vf8QzRnoI9JpB5B7IaiL47YZaSFllsPG6bTMyIYk8ZLeoR4
         bo1PovmM4cUmS7CEEw0mhr9GZxBKDxyKVTC1afu9SGHR64TSMFVageToFqRC0P2eb0kh
         V+/Etx0l0fEwO6PUeODM9eiE2oiox2LjEKrc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdSOUDJOxJ2WJV+wp0309W4y0HIj4q+nszAoAMP8o48=;
        b=o3T7LniULkeCuN0d6d989bh8WpJR5oELlchxNLvVm5gC+JLnKVcN1DFRXiEmYhBDjN
         tEgfOqLks7MDPAdJxe9xs5yEN+z19ru6eOTBoRcdNn2tu7WdYPKaylYYtPOlNNmWM6jm
         WjG5OjzoJFINwH6rqukC17IPmUsSjY/mlbnYEP8s1mnSKk5xNi+6CK7RVj635KFwxTuU
         0RgihZIhyq47+EGQrWDI/iHMfZsLRAmVsUiPuumZuzIyCZ3Pqo0bwQyXgGwH3nM+ZMmx
         BXXR7A9hcKYx1BwwD1qvvab9ScmJlBh5jQPmwmb6q0NmENhml9pMEcJvH2KHMLCpHXWH
         Hu7w==
X-Gm-Message-State: AOAM532K5ckICQuzoh7HWHK2hkqi3GCKatwTiX3dYbJ9irf0tOhoeYnl
        dupY5MUW6oCWJJYv4L8XEC8Gq0q545NwfA==
X-Google-Smtp-Source: ABdhPJywG65e7VwaY3TECQGCG+qp6sRfcj/9SyNh0j2d0BJju164w/jt3fmN2cBgEnXCzU6ZI6BbDg==
X-Received: by 2002:a17:90b:3b8f:: with SMTP id pc15mr625392pjb.23.1643160149756;
        Tue, 25 Jan 2022 17:22:29 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g22sm227922pfc.141.2022.01.25.17.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 17:22:29 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>, Alyssa Ross <hi@alyssa.is>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] platform/chrome: cros_ec_typec: Check for EC device
Date:   Wed, 26 Jan 2022 01:22:03 +0000
Message-Id: <20220126012203.2979709-1-pmalani@chromium.org>
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
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Alyssa, could you kindly test this with your existing setup? Thanks!

 drivers/platform/chrome/cros_ec_typec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5de0bfb0bc4d..7188f1d72f68 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1076,6 +1076,12 @@ static int cros_typec_probe(struct platform_device *pdev)
 
 	typec->dev = dev;
 	typec->ec = dev_get_drvdata(pdev->dev.parent);
+
+	if (!typec->ec) {
+		dev_err(dev, "couldn't find parent EC device\n");
+		return -ENODEV;
+	}
+
 	platform_set_drvdata(pdev, typec);
 
 	ret = cros_typec_get_cmd_version(typec);
-- 
2.35.0.rc0.227.g00780c9af4-goog

