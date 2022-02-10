Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB584B0F98
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbiBJODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:03:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbiBJODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:03:17 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9EEBF5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:03:16 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21AE35dK007606;
        Thu, 10 Feb 2022 08:03:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644501785;
        bh=PiljcDEbg06UCTJ9yZCFbrV4SBZ07VQn7L8EF42ldHs=;
        h=From:To:CC:Subject:Date;
        b=UQXriwppD610PoH34lX2lGKDBDN/juwI102urjc7inUHzYIzZSw8FhRwMPGubaFpM
         V5WKcwhr6k7EZZR+m6ZelutM+LWf2UJk9kSUwCadqj6MpXjPUX53Wrq13SSBqJzwMa
         gkPNqlTKsi+qlf5x8sN34xUP4IbD5sQaEm6Nnfvc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21AE35x3027136
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Feb 2022 08:03:05 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 10
 Feb 2022 08:03:04 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 10 Feb 2022 08:03:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21AE331H077747;
        Thu, 10 Feb 2022 08:03:04 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <thierry.reding@gmail.com>
CC:     <sam@ravnborg.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <nikhil.nd@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH] drm/panel: simple: Initialize bpc in RK101II01D-CT panel descriptor
Date:   Thu, 10 Feb 2022 19:33:00 +0530
Message-ID: <20220210140300.11900-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize bpc while creating panel_desc structure for RK101II01D-CT

Below warning is triggered since bpc is not being initialized

WARNING: CPU: 2 PID: 47 at drivers/gpu/drm/panel/panel-simple.c:614
panel_simple_probe+0x1b0/0x3c8

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c324a3ed34b9..c09eb5ad65fc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3058,6 +3058,7 @@ static const struct drm_display_mode rocktech_rk101ii01d_ct_mode = {
 
 static const struct panel_desc rocktech_rk101ii01d_ct = {
 	.modes = &rocktech_rk101ii01d_ct_mode,
+	.bpc = 8,
 	.num_modes = 1,
 	.size = {
 		.width = 217,
-- 
2.17.1

