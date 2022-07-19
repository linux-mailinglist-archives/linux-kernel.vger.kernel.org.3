Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA845794F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiGSIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiGSIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:09:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B9033E13;
        Tue, 19 Jul 2022 01:09:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26J88sKL051596;
        Tue, 19 Jul 2022 03:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658218134;
        bh=cLwKAOC+5jmeRMpW/COFbt2FmEKocO1bN7cVrqzvMo4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uEc9tyGTvih6GiTz1ocToF44tONd0x5rKrIpi9gJ5cUcIw7+MrpylDRQIy4Jg2hCc
         CmIc9VFQ6YbFCi4uqPorzB4j4tpzR8SZf4y1r97V9BeS9YPqv56TldPrdORsm6VDYy
         /MU3PcVLZgksY8UxXhw/x9dlUAdOEnWgybAoHrq0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26J88ssH022614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 03:08:54 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Jul 2022 03:08:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Jul 2022 03:08:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26J88rWf011258;
        Tue, 19 Jul 2022 03:08:53 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] drm/tidss: dt property to force 16bit VP output to a 24bit bridge
Date:   Tue, 19 Jul 2022 13:38:42 +0530
Message-ID: <20220719080845.22122-6-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719080845.22122-1-a-bhatia1@ti.com>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Override the DSS Videoport to output 16bit RGB565 instead of 24bit
RGB888 when the dt property "ti,rgb565-to-888" has been enanbled.

Co-developed-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index fb1fdecfc83a..94fce035c1d7 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -896,6 +896,8 @@ struct dispc_bus_format *dispc_vp_find_bus_fmt(struct dispc_device *dispc,
 	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI &&
 	    dispc->oldi_mode == OLDI_DUAL_LINK)
 		is_dual_link = true;
+	else if (bus_fmt == MEDIA_BUS_FMT_RGB888_1X24 && dispc->rgb565_to_888)
+		bus_fmt = MEDIA_BUS_FMT_RGB565_1X16;
 
 	for (i = 0; i < ARRAY_SIZE(dispc_bus_formats); ++i) {
 		if (dispc_bus_formats[i].bus_fmt == bus_fmt &&
-- 
2.37.0

