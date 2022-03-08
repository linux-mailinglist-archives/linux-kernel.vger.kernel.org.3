Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9B4D1CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348143AbiCHQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348141AbiCHQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:09:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD145780
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4B8AB81AE4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80638C340EB;
        Tue,  8 Mar 2022 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646755690;
        bh=AwGaASbjETpK4nZOLdxXknvHFDS1cXriyWuhbix2BOk=;
        h=From:To:Cc:Subject:Date:From;
        b=JlxmXyQ9i/uGi0mTu813EeOoGwxorHisDmVWJfzihVN11unNsKANxpRCwBckMo6gW
         sXLRmNW3acloiyou9mrGKIVE8CiB8nZUr4x+8rL7if3ub81ceppqk+G4k5+B17zeOQ
         xlgz7694bABrbOy9AjSb69nCxLoHAVywwAPLixwKXaGYb9L87F1NtQwYi0+giYTOO8
         +LP3xq5VijPw++S1MGE3Dk1DD/URryU2xbplfs/Bw7+k0Yug82x/lMtQCy3ylyvCoD
         tL3pToQoFJhM5s5x4zmsDoudb6QR0hwniUDARx2UGCCjOPq4a6wGWH8fjyBIFep2Xm
         OsLtUGYL00GfQ==
Received: by wens.tw (Postfix, from userid 1000)
        id 334BC5FC3B; Wed,  9 Mar 2022 00:08:08 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm: ssd130x: Fix COM scan direction register mask
Date:   Wed,  9 Mar 2022 00:07:57 +0800
Message-Id: <20220308160758.26060-1-wens@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The SSD130x's command to toggle COM scan direction uses bit 3 and only
bit 3 to set the direction of the scanout. The driver has an incorrect
GENMASK(3, 2), causing the setting to be set on bit 2, rendering it
ineffective.

Fix the mask to only bit 3, so that the requested setting is applied
correctly.

Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index ce4dc20412e0..ccd378135589 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -61,7 +61,7 @@
 #define SSD130X_SET_COM_PINS_CONFIG		0xda
 #define SSD130X_SET_VCOMH			0xdb
 
-#define SSD130X_SET_COM_SCAN_DIR_MASK		GENMASK(3, 2)
+#define SSD130X_SET_COM_SCAN_DIR_MASK		GENMASK(3, 3)
 #define SSD130X_SET_COM_SCAN_DIR_SET(val)	FIELD_PREP(SSD130X_SET_COM_SCAN_DIR_MASK, (val))
 #define SSD130X_SET_CLOCK_DIV_MASK		GENMASK(3, 0)
 #define SSD130X_SET_CLOCK_DIV_SET(val)		FIELD_PREP(SSD130X_SET_CLOCK_DIV_MASK, (val))
-- 
2.34.1

