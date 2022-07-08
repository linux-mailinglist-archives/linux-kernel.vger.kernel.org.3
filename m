Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC52B56C1DD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbiGHTYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbiGHTYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:24:02 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48773255B2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:24:02 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 9ta1o86XNV0xU9ta1oRIrR; Fri, 08 Jul 2022 21:24:00 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Jul 2022 21:24:00 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] firmware: ti_sci: Use the non-atomic bitmap API when applicable
Date:   Fri,  8 Jul 2022 21:23:56 +0200
Message-Id: <fb7edc555b6fa7c74707f13e422196693a834bc8.1657308216.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ee11e9e83f7c1552d237f5c28f554319fcbbf1f.1657308216.git.christophe.jaillet@wanadoo.fr>
References: <3ee11e9e83f7c1552d237f5c28f554319fcbbf1f.1657308216.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usages of the 'res_map' bitmap is protected with a spinlock, so non-atomic
functions can be used to set/clear bits.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/firmware/ti_sci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 522be2b75ce1..49677533f376 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3096,7 +3096,7 @@ u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
 
 		free_bit = find_first_zero_bit(desc->res_map, res_count);
 		if (free_bit != res_count) {
-			set_bit(free_bit, desc->res_map);
+			__set_bit(free_bit, desc->res_map);
 			raw_spin_unlock_irqrestore(&res->lock, flags);
 
 			if (desc->num && free_bit < desc->num)
@@ -3127,10 +3127,10 @@ void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
 
 		if (desc->num && desc->start <= id &&
 		    (desc->start + desc->num) > id)
-			clear_bit(id - desc->start, desc->res_map);
+			__clear_bit(id - desc->start, desc->res_map);
 		else if (desc->num_sec && desc->start_sec <= id &&
 			 (desc->start_sec + desc->num_sec) > id)
-			clear_bit(id - desc->start_sec, desc->res_map);
+			__clear_bit(id - desc->start_sec, desc->res_map);
 	}
 	raw_spin_unlock_irqrestore(&res->lock, flags);
 }
-- 
2.34.1

