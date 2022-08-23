Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCB59CD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiHWAQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiHWAQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:16:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692DE22A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:16:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27N0GabP084538;
        Mon, 22 Aug 2022 19:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661213796;
        bh=IXS3eOpGeVTQhnzmRvwBTKZZwv0GAWdYS0tpv7glTv4=;
        h=From:To:CC:Subject:Date;
        b=CtsjRT6KqXspxbsq858IDz7DOMgcoMVGPp6gP4znuKH7oUCscQ44v0V13Q7m17q6d
         zAiVkVVC77V6A3g1BanAqh70jA63g4Duiz6sh6ZFRwlwoTPt7YsrmWyHP9L3ZHFvR0
         EZRLmt7CEefrLTaPKti+JhzypQ9ebPnj0AIJBNS8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27N0GZqC018842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 19:16:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 19:16:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 19:16:35 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27N0GZ0u007537;
        Mon, 22 Aug 2022 19:16:35 -0500
From:   Andrew Davis <afd@ti.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH] drm/tidss: Set max DMA segment size
Date:   Mon, 22 Aug 2022 19:16:34 -0500
Message-ID: <20220823001634.11461-1-afd@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have no segment size limitations. Set to unlimited.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index dd3c6a606ae2..624545e4636c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2685,6 +2685,7 @@ int dispc_init(struct tidss_device *tidss)
 		if (r)
 			dev_warn(dev, "cannot set DMA masks to 48-bit\n");
 	}
+	dma_set_max_seg_size(dev, UINT_MAX);
 
 	dispc = devm_kzalloc(dev, sizeof(*dispc), GFP_KERNEL);
 	if (!dispc)
-- 
2.36.1

