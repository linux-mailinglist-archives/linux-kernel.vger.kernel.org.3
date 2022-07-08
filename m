Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123DB56C1C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiGHTX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiGHTXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:23:53 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF02924953
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:23:50 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 9tZroHmKEEhCQ9tZrokYfy; Fri, 08 Jul 2022 21:23:48 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Jul 2022 21:23:48 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] firmware: ti_sci: Use the bitmap API to allocate bitmaps
Date:   Fri,  8 Jul 2022 21:23:46 +0200
Message-Id: <3ee11e9e83f7c1552d237f5c28f554319fcbbf1f.1657308216.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_bitmap_zalloc() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/firmware/ti_sci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ebc32bbd9b83..522be2b75ce1 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3201,9 +3201,8 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 
 		valid_set = true;
 		res_count = res->desc[i].num + res->desc[i].num_sec;
-		res->desc[i].res_map =
-			devm_kzalloc(dev, BITS_TO_LONGS(res_count) *
-				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
+		res->desc[i].res_map = devm_bitmap_zalloc(dev, res_count,
+							  GFP_KERNEL);
 		if (!res->desc[i].res_map)
 			return ERR_PTR(-ENOMEM);
 	}
-- 
2.34.1

