Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227D94D6F10
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiCLNa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiCLNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:30:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A53D8930F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:29:31 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 075DC41C49
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091770;
        bh=k4Jb1JIbmx97RGU5zYwsibslXr/amA0TPgZk/TYiBU0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Vv353F/B0Xv5vVo88J1SjUin/VO2VhbtLgq16ozZGjej0km8RQ+VVwvSBCUvtxht2
         R/L865Oqo4J8GpUKrsmp2YgX1vVkXptw3uO1n6LK5ciXMB5//FWes30VPqkyKswY+x
         nITGH8044XJlRaT4h86dqFO08u7LaiBJ9sAtCTx0Iyn0bpq5p4cDaYlqcHaTz0kG4n
         iGFQoATr5uhbpDIlNu5apLP4NbyHVowrO0mrCfbqmTsnjM8rf3AM+Q8b8HsCiMBPXm
         0xBgjL+MovfNTf0jHY+d0KvlnX5ntn2N+ne4rEovzfJuDuKKPuhOMwdVvtm4XcdhB8
         Y1gzk3+T6GzKw==
Received: by mail-wm1-f71.google.com with SMTP id q189-20020a1c43c6000000b003898de01de4so1318322wma.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4Jb1JIbmx97RGU5zYwsibslXr/amA0TPgZk/TYiBU0=;
        b=tgznqHqnXio49JY1Zk1JKUHS9FAms8JBN3fXyvIYUQdlEZ8mq7W519LDuy62Bdn+zp
         dZOeGGzmKiFIMgA90zzSoCCrUQceH6Q1vu60K9vUNgLk9xSLBvxzdgRJtfNWZD5qJ5ej
         N9YHIdgcEx5L0wf/BAIpp5HasHki+3RpaWbKnVqVp6nqd5pBOV8xgLWMP0WTGtKX7dh3
         ZA3h+MuVLISuW+Pj3739IGUjeg89H1dlcwaYyR3enWCRhnUwgC6ifQa9foj7vWpB+pbs
         xkCY9dOEzNCJvn6ijVFDfs6k8l5FI9eU2OZykCGk47Gxm6lFxA9GwbqVhzs0EAHAZmaS
         hmdQ==
X-Gm-Message-State: AOAM532JdM8fw/n3urDiqwVgB2afzXykgToofUuUTBWdmesQxRd7iMl9
        s5Yd2xe5hwPGdR/uM5yUN8pEcNVTMYUW4wD9rZoexfrVbZ2KgL7t8zo6dg580t7V3Sm6bzijxK1
        H0M64cgtc+JvVSVwpaxu8yyRbyVX0QNS3rTN94RL6Ig==
X-Received: by 2002:a05:600c:205a:b0:380:d03d:9cd5 with SMTP id p26-20020a05600c205a00b00380d03d9cd5mr18973786wmg.89.1647091769338;
        Sat, 12 Mar 2022 05:29:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/UYRzL44sORF2ylmmKXb7vWoxaA4l4bh2hpunrfXO0ZX4FC17dWpWNzj8sLP8bds5v9sX3A==
X-Received: by 2002:a05:600c:205a:b0:380:d03d:9cd5 with SMTP id p26-20020a05600c205a00b00380d03d9cd5mr18973773wmg.89.1647091769175;
        Sat, 12 Mar 2022 05:29:29 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 08/11] vdpa: Use helper for safer setting of driver_override
Date:   Sat, 12 Mar 2022 14:28:53 +0100
Message-Id: <20220312132856.65163-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a helper to set driver_override to reduce amount of duplicated code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/vdpa/vdpa.c  | 29 ++++-------------------------
 include/linux/vdpa.h |  4 +++-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1ea525433a5c..2dabed1df35c 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -77,32 +77,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	const char *driver_override, *old;
-	char *cp;
+	int ret;
 
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = vdev->driver_override;
-	if (strlen(driver_override)) {
-		vdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		vdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 721089bb4c84..37117404660e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -64,7 +64,9 @@ struct vdpa_mgmt_dev;
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @config: the configuration ops for this device.
  * @cf_mutex: Protects get and set access to configuration layout.
  * @index: device index
-- 
2.32.0

