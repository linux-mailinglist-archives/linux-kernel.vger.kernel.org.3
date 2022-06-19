Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29CC55091F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiFSHYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFSHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:24:29 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B734A6430
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NF568
        0tDdMiZ6LPuk7ol+HY0gthMgl2QF1lEjUWZXaY=; b=FcLMt2dEtXKwvITan3REv
        SslneB6F17NBGWNf3hBLpln6Hoyqy50x5Y8YkzSNdRvOmCQZiZqlDBzXkOjG8iVJ
        xgRINTW/+d77WNJdkfRK+p+mfmacyT2frFZ5tb8V14h/LIMcXy2ZSRGkZDfKiP1n
        MeAuKGARkdK2SA49/Wxsa0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgB3xnL4zq5ikhTbFw--.650S2;
        Sun, 19 Jun 2022 15:23:37 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/cell: Fix refcount leak bugs
Date:   Sun, 19 Jun 2022 15:23:35 +0800
Message-Id: <20220619072335.4067728-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgB3xnL4zq5ikhTbFw--.650S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWfJrW3ZF17CFykuF1Utrb_yoW8AFWrpF
        1qkFZ7Cr10gr4vya4Iv3WDur4ayFnYqrW8Jw47A3srAwn3Xr97Xr4rAF1xCrs7Jr48Gayr
        Zr43Ka1SvFs3ua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI385UUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BklF1pEDwJK0wAAs9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use of_node_put() for of_find_node_by_path() and
of_find_node_by_phandle() to keep refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/cell/setup.c       | 2 ++
 arch/powerpc/platforms/cell/spu_manage.c  | 2 ++
 arch/powerpc/platforms/cell/spufs/inode.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 52de014983c9..47eaf75349f2 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -167,6 +167,8 @@ static int __init cell_publish_devices(void)
 		of_platform_device_create(np, NULL, NULL);
 	}
 
+	of_node_put(root);
+
 	/* There is no device for the MIC memory controller, thus we create
 	 * a platform device for it to attach the EDAC driver to.
 	 */
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index ae09c5a91b40..f1ac4c742069 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -488,6 +488,8 @@ static void __init init_affinity_node(int cbe)
 				avoid_ph = vic_dn->phandle;
 			}
 
+			of_node_put(vic_dn);
+
 			list_add_tail(&spu->aff_list, &last_spu->aff_list);
 			last_spu = spu;
 			break;
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 34334c32b7f5..320008528edd 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -660,6 +660,7 @@ spufs_init_isolated_loader(void)
 		return;
 
 	loader = of_get_property(dn, "loader", &size);
+	of_node_put(dn);
 	if (!loader)
 		return;
 
-- 
2.25.1

