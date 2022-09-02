Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DD5AB6D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiIBQtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiIBQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:49:47 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6B11A26
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:39:55 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id U9hwotD6YjJi0U9hxo8ald; Fri, 02 Sep 2022 18:39:54 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Sep 2022 18:39:54 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mm@kvack.org
Subject: [PATCH v2] mm/mremap_pages: Save a few cycles in get_dev_pagemap()
Date:   Fri,  2 Sep 2022 18:39:52 +0200
Message-Id: <9ef1562a1975371360f3e263856e9f1c5749b656.1662136782.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
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

Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
save a few cycles when it is known that the rcu lock is already
taken/released.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Matthew Wilcox <willy@infradead.org> commented on v1 that it is just a slow
path... but it is also just an easy patch :)

If considered as useless, let me know and I'll drop it from my WIP list.

Changes in v2:
  * (no code change)
  * synch with latest -next

v1:
  https://lore.kernel.org/all/b4a47154877853cc64be3a35dcfd594d40cc2bce.1635975283.git.christophe.jaillet@wanadoo.fr/
---
 mm/memremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 58b20c3c300b..25029a474d30 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -454,7 +454,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 	/* fall back to slow path lookup */
 	rcu_read_lock();
 	pgmap = xa_load(&pgmap_array, PHYS_PFN(phys));
-	if (pgmap && !percpu_ref_tryget_live(&pgmap->ref))
+	if (pgmap && !percpu_ref_tryget_live_rcu(&pgmap->ref))
 		pgmap = NULL;
 	rcu_read_unlock();
 
-- 
2.34.1

