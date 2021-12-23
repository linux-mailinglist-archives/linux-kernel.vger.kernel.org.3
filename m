Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194B347E811
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349962AbhLWTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:16:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51806 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbhLWTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:16:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJGPeX116813;
        Thu, 23 Dec 2021 13:16:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640286985;
        bh=nwwld5OgWWX2rCypcvfqeWC/in7Aq4Ky8XkQKe0QcxY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O/mv/BM3UDRuUtfj4Iig9MZkRfn8RyixpD0MhfIHNnmGzcn7vSwpg8K84dDGOAPyg
         N+Hm5wmEjTnC6Zs59qSrRB/o9ZMlChls42hwBOpXgHLHv8d9pge2c99auuldogwOQ3
         ne7A3dI9JeJnD5WkRPPQa/ivhhEAG558SjHSxaGE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNJGPlG017955
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 13:16:25 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 13:16:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 13:16:24 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJGGQO006164;
        Thu, 23 Dec 2021 13:16:21 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH v5 01/14] media: cadence: csi2rx: Unregister v4l2 async notifier
Date:   Fri, 24 Dec 2021 00:46:02 +0530
Message-ID: <20211223191615.17803-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211223191615.17803-1-p.yadav@ti.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The notifier is added to the global notifier list when registered. When
the module is removed, the struct csi2rx_priv in which the notifier is
embedded, is destroyed. As a result the notifier list has a reference to
a notifier that no longer exists. This causes invalid memory accesses
when the list is iterated over. Similar for when the probe fails.

Unregister and clean up the notifier to avoid this.

Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v5:
- Cleanup notifier in csi2rx_parse_dt() after the call to
  v4l2_async_nf_add_fwnode_remote().

Changes in v3:
- New in v3.

 drivers/media/platform/cadence/cdns-csi2rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index cc3ebb0d96f6..2a23da6a0b8e 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -404,8 +404,10 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 	asd = v4l2_async_nf_add_fwnode_remote(&csi2rx->notifier, fwh,
 					      struct v4l2_async_subdev);
 	of_node_put(ep);
-	if (IS_ERR(asd))
+	if (IS_ERR(asd)) {
+		v4l2_async_nf_cleanup(&csi2rx->notifier);
 		return PTR_ERR(asd);
+	}
 
 	csi2rx->notifier.ops = &csi2rx_notifier_ops;
 
@@ -467,6 +469,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	return 0;
 
 err_cleanup:
+	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
 err_free_priv:
 	kfree(csi2rx);
@@ -477,6 +480,8 @@ static int csi2rx_remove(struct platform_device *pdev)
 {
 	struct csi2rx_priv *csi2rx = platform_get_drvdata(pdev);
 
+	v4l2_async_nf_unregister(&csi2rx->notifier);
+	v4l2_async_nf_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
 	kfree(csi2rx);
 
-- 
2.33.1.835.ge9e5ba39a7

