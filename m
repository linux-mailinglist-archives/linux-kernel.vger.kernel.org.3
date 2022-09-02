Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7B5AB330
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiIBOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiIBOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:15:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75914D458
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A418B82AA1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D85FC433D7;
        Fri,  2 Sep 2022 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662125854;
        bh=jzG0D03+vxrGLGIs+YSm8b2wkD8dPvpWfTaQQGIfuUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=2ViCa0hSTALym2d7H6yIqIwgR8f1Cxi4K31j+6jsXg+w1JHIOCKWKLXjg1VZvqhcg
         ftRrqkTVmSIvwGK11JY5lSt1cKLALoA2oxNjjkp7XBYrB0hmbvV9VvaDwxTJgn5oXE
         O/5IXY5ow7hYMnDanucblQbpuWYVpwLfxi7TIOe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     tudor.ambarus@microchip.com, pratyush@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, stable <stable@kernel.org>
Subject: [PATCH] mtd: spi-nor: fix memory leak when using debugfs_lookup()
Date:   Fri,  2 Sep 2022 15:37:24 +0200
Message-Id: <20220902133724.278133-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=gregkh@linuxfoundation.org; h=from:subject; bh=jzG0D03+vxrGLGIs+YSm8b2wkD8dPvpWfTaQQGIfuUQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlC7EJ2v/4aB/pOcFJJuSPvsO+F/9TH8iail28bPHKyMTx9 VaCyI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZSdZ5hQevH1PPLlYxy/TfemvtXde 7U2z+8zjHMZMyf/qdsnvzMS3uCPF/bH1p8iOtQHQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  Fix this up to be much
simpler logic and only create the root debugfs directory once when the
driver is first accessed.  That resolves the memory leak and makes
things more obvious as to what the intent is.

Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Michael Walle <michael@walle.cc>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/spi-nor/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index df76cb5de3f9..3aab595e82d1 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -228,11 +228,11 @@ static void spi_nor_debugfs_unregister(void *data)
 
 void spi_nor_debugfs_register(struct spi_nor *nor)
 {
-	struct dentry *rootdir, *d;
+	static struct dentry *rootdir;
+	struct dentry *d;
 	int ret;
 
 	/* Create rootdir once. Will never be deleted again. */
-	rootdir = debugfs_lookup(SPI_NOR_DEBUGFS_ROOT, NULL);
 	if (!rootdir)
 		rootdir = debugfs_create_dir(SPI_NOR_DEBUGFS_ROOT, NULL);
 
-- 
2.37.3

