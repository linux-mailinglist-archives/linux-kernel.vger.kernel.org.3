Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241485A5D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiH3HgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiH3HgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:36:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B91BC800
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC3F0B816B3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04C3C433D6;
        Tue, 30 Aug 2022 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661844972;
        bh=N5gaZtyYBowf9OQhQgYdpXYv/RxoiHfSaAtM2SKjB4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=MC1Z0vxFG9LMcLq41YRlMOWaezF4X/AFoqzr7qg294jNMUs8JeENcaQ9Q3HpG9IK2
         6efyquLZvW3Tm9pR5cl3q9vq3y6luV8bmsmg48RaOgA6X9pmm7vxI6qkLWYD8zuZNf
         TlDQcX4lBUe1iBeMdbC50cm91ZFY+0C8zOAlAmDlfOfOZ+LPDb4gFooEWFphclgNMa
         h9ao+/QMD5ktHMmHYoSNeh3IG14ISKDd85uxTINnYio0ld+EuuNk332Gt7YfVYgFoD
         w84naT+zwD3+kQdq6CTysamc8rwpZVWbEBPOs7FKgkp9PWAgDdXGOsTRv5DliI/5vz
         YJfuw0rHvPjww==
From:   matthias.bgg@kernel.org
To:     nfraprado@collabora.com, angelogioacchino.delregno@collabora.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] soc: mediatek: mtk-svs: fix compilation error
Date:   Tue, 30 Aug 2022 09:36:04 +0200
Message-Id: <20220830073604.21260-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

When compiling on other architectures, compile test fails due to missing
bitfield.h include.

Fixes: a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros where possible")
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/soc/mediatek/mtk-svs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index da1a3bfc8633..11a571d3f013 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2022 MediaTek Inc.
  */
 
-#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpuidle.h>
-- 
2.37.2

