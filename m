Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C84AE62F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiBIAmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIAmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:42:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B8C061576;
        Tue,  8 Feb 2022 16:42:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a39so530693pfx.7;
        Tue, 08 Feb 2022 16:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWguoElz75KmwYY4xZ5q3MPGCTv+dwpJ1eiIIAf+DYI=;
        b=B/tjM26rF/X7BGRaXepy7IC+bec6E3rQaGugiZQ65QSzg8Wpus3jdf7Y8WIOmezWlf
         CG8Nns0vXM1MBB8xaPbM9xbRmkaTpfM/NrZoxbwAmIWlcNyx5TCjp1LsMIbW5NbLp6T3
         WRBTZ/dqrvX+zvB1/PKYobcJ4kF8KjXU0sH6gF6r/zLLeKpgD3P9sTUvaV9Np15D48pt
         TjfQxZpJyFs3sI0y77DvIiWLtu6IUgS/2k3alc3DG8GJE3mBdp5zTHK/B8Gwt7GRPtfw
         2H+ymXSNqch23+gFm5HijX2cjqv7YYuSE45Db9Y7Cp2Is5TJqEh7wK2dkAs+UhHRKYlx
         Yfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWguoElz75KmwYY4xZ5q3MPGCTv+dwpJ1eiIIAf+DYI=;
        b=Y+c0OOUFIhyfv43kwWglhe77Z0ziQtqK8uoDxdTrIY3L61sDsRqv6nKVfYS3+gTU9e
         K4f86XlFM6iREA/5+ID2Teg+3sSctxUgxc+6Kl+cUVpjdk4bYGQjJWOWA7eE67aMvAam
         zF8FmPUj7IpETWlv3Mc27tRfB2ap88AZuzbrWoznMdFpL44XxzU32R0YGg41ZQ7eHB33
         L6LZdciReOy03PTqymyXWSBbJErHpnrnOEv6IX6jVM3hVZP/a11HlfLKcQhyWDrXl6IH
         +4D/10N2fHrw3oAvNfnzVounxRa5kAhabIgcJUX4HNHFmZ5cW38EJ+nuKHMQt3nqLjFh
         W5Ag==
X-Gm-Message-State: AOAM531iMflkmmUtzpvdY5OANPaYrjzN1Tt5Fkzv+0124W49WosIdnnZ
        oUzt0+hIBTzSMKzYijFokdXaqurVCDA=
X-Google-Smtp-Source: ABdhPJyLflq8sRPyuisFQhnyUpzNtYM2Kz4jF5+2tNwEnkLgsiYU3zyYU9fh/KJvI6QjDkSbFQTrZg==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr1125962pgd.360.1644367338548;
        Tue, 08 Feb 2022 16:42:18 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id o8sm17404788pfu.52.2022.02.08.16.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:42:18 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     deller@gmx.de
Cc:     davidcomponentone@gmail.com, yang.guang5@zte.com.cn,
        caihuoqing@baidu.com, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] video: fbdev: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:42:05 +0800
Message-Id: <39e3389c6f734f69a01e0d38ef1605a4411d8f55.1644287273.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c:
202:8-16: WARNING: use scnprintf or sprintf
./drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c:
172:8-16: WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 .../video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 3db0232c31ab..155b3f8ad158 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -169,7 +169,7 @@ static ssize_t tpo_td043_vmirror_show(struct device *dev,
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ddata->vmirror);
+	return sysfs_emit(buf, "%d\n", ddata->vmirror);
 }
 
 static ssize_t tpo_td043_vmirror_store(struct device *dev,
@@ -199,7 +199,7 @@ static ssize_t tpo_td043_mode_show(struct device *dev,
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ddata->mode);
+	return sysfs_emit(buf, "%d\n", ddata->mode);
 }
 
 static ssize_t tpo_td043_mode_store(struct device *dev,
-- 
2.30.2

