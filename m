Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5924B5C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiBNVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:08:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBNVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:07:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB99B119F63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:07:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id E04281F43F57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644870700;
        bh=CEk0DFXIUz+rib8Ps6KmDjMnwxb8SNNluWUTHums5hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ievNAjv7U7jDN0ChCw4YX7Jv0ZMu5Ut6BbrqUhRy3qDYLAUbYj6zDasWUaIIjgas5
         tk4XlVsU7AKz0HOAwgqXkpAqdo+rD5/DrxhSwcvv22hyJAVZmrRSjwrj8cQi2MSxox
         SEy4WmOboddgpfuXSiOoe58Hfh+qBLnP34hyjH9ZtT+Mor28hjJeVpOFBp/lMjGhMX
         cIbIvoaPwkBbkBwA8xIWxQbAmB554GaaVSnUyPC/hGyhvSvJZ3vtxoSDcYs/fQrxOw
         +lGQA+duIA1IpCuxMdJL+XdR+a7h7vxpH/SPqNzhRSS/VNniqaiowOMCl6Zq0TFIkq
         PeVDBll6CCjOg==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] drm/panfrost: Dynamically allocate pm_domains
Date:   Mon, 14 Feb 2022 15:31:32 -0500
Message-Id: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8192 requires 5 power domains. Rather than bump MAX_PM_DOMAINS and
waste memory on every supported Panfrost chip, instead dynamically
allocate pm_domain_devs and pm_domain_links. This adds some flexibility;
it seems inevitable a new MediaTek device will require more than 5
domains.

On non-MediaTek devices, this saves a small amount of memory.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 14 ++++++++++----
 drivers/gpu/drm/panfrost/panfrost_device.h |  5 ++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index ee612303f076..661cdec320af 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -127,7 +127,10 @@ static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
+	if (!pfdev->pm_domain_devs || !pfdev->pm_domain_links)
+		return;
+
+	for (i = 0; i < pfdev->comp->num_pm_domains; i++) {
 		if (!pfdev->pm_domain_devs[i])
 			break;
 
@@ -161,9 +164,12 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
 		return -EINVAL;
 	}
 
-	if (WARN(num_domains > ARRAY_SIZE(pfdev->pm_domain_devs),
-			"Too many supplies in compatible structure.\n"))
-		return -EINVAL;
+	pfdev->pm_domain_devs = devm_kcalloc(pfdev->dev, num_domains,
+					     sizeof(*pfdev->pm_domain_devs),
+					     GFP_KERNEL);
+	pfdev->pm_domain_links = devm_kcalloc(pfdev->dev, num_domains,
+					      sizeof(*pfdev->pm_domain_links),
+					      GFP_KERNEL);
 
 	for (i = 0; i < num_domains; i++) {
 		pfdev->pm_domain_devs[i] =
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 8b25278f34c8..98e3039696f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -22,7 +22,6 @@ struct panfrost_job;
 struct panfrost_perfcnt;
 
 #define NUM_JOB_SLOTS 3
-#define MAX_PM_DOMAINS 3
 
 struct panfrost_features {
 	u16 id;
@@ -87,8 +86,8 @@ struct panfrost_device {
 	struct regulator_bulk_data *regulators;
 	struct reset_control *rstc;
 	/* pm_domains for devices with more than one. */
-	struct device *pm_domain_devs[MAX_PM_DOMAINS];
-	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
+	struct device **pm_domain_devs;
+	struct device_link **pm_domain_links;
 	bool coherent;
 
 	struct panfrost_features features;
-- 
2.34.1

