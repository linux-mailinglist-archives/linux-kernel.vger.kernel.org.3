Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F45D57BF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiGTV0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGTV0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:26:41 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7F4D822
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 14:26:39 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id EHDJogmrO0UP7EHDJomVbt; Wed, 20 Jul 2022 23:26:38 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 23:26:38 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] devres: Slightly optimize alloc_dr()
Date:   Wed, 20 Jul 2022 23:26:36 +0200
Message-Id: <d255bd871484e63cdd628e819f929e2df59afb02.1658352383.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the gfp flag used for the memory allocation already has __GFP_ZERO,
then there is no need to explicitly clear the "struct devres_node". It is
already zeroed.

This saves a few cycles when using devm_zalloc() and co.

In the case of devres_alloc() (which calls __devres_alloc_node()), the
compiler could remove the test and the memset() because it should be able
to see that the __GFP_ZERO flag is set.
So this would make the code both faster and smaller.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/base/devres.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 864d0b3f566e..4ab2b50ee38f 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -117,7 +117,9 @@ static __always_inline struct devres * alloc_dr(dr_release_t release,
 	if (unlikely(!dr))
 		return NULL;
 
-	memset(dr, 0, offsetof(struct devres, data));
+	/* No need to clear memory twice */
+	if (!(gfp & __GFP_ZERO))
+		memset(dr, 0, offsetof(struct devres, data));
 
 	INIT_LIST_HEAD(&dr->node.entry);
 	dr->node.release = release;
-- 
2.34.1

