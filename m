Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9545C5260AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379742AbiEMLGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379732AbiEMLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:05:57 -0400
X-Greylist: delayed 503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 04:05:53 PDT
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE33DEF1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:05:50 -0700 (PDT)
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp6.goneo.de (Postfix) with ESMTPS id E2CB010A3329;
        Fri, 13 May 2022 12:57:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by hub1.goneo.de (Postfix) with ESMTPS id 49F2210A1E8A;
        Fri, 13 May 2022 12:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.eu;
        s=DKIM001; t=1652439441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OaoAYNGeTkjqRpT9BXELSpZRhtmoluGTZks7oz+u3I=;
        b=oyxTOcNnpA7wvYA8hX8Kszx8M5qhGFlS0q2v+c+mbP1hL4iebb0Aw3naz2QHlLrSSDHDI5
        5cwCBrorgj0DfHRxeKyivLA8u50MrxEDKpJ0AaiOpZQe2WbODIRS96oLCms8Ua5rzunQGg
        tBdaqtXuaRDkiaYafkplVbPI6WEYCgZtB7wFFPqPoWpNGFNVlJChQEYDoQ0ml4586W2JK7
        BvoFbA3EgCxvsm0byojsoxx8S9tgMytvTAhJXqlE8s3JTsol1zDb78bilbrg+o2ZU0zOGV
        iDBgy+zQFEab5S7ZF/06gXO7An4vPTXL13/A8U5jA0TEf8vGIH1t9cRhExMdHQ==
Received: from brot.fritz.box (unknown [IPv6:2a02:908:2a43:3560:cb6d:eb1d:27ff:405a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hub1.goneo.de (Postfix) with ESMTPSA id 0469110A1E87;
        Fri, 13 May 2022 12:57:20 +0200 (CEST)
From:   "Leon M. George" <leon@georgemail.eu>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     "Leon M. George" <leon@georgemail.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH] squashfs: free page if bio_add_page fails
Date:   Fri, 13 May 2022 12:57:09 +0200
Message-Id: <20220513105709.2209247-1-leon@georgemail.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: b6ee6c
X-Rspamd-UID: 4a24b1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In squashfs_bio_read, the page recently allocated for use with
bio_add_page isn't freed when the call fails.

This patch adds a call to __free_page.

Signed-off-by: Leon M. George <leon@georgemail.eu>
---
 fs/squashfs/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 622c844f6d11..5ca1c9caef7d 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -110,6 +110,7 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 		}
 		if (!bio_add_page(bio, page, len, offset)) {
 			error = -EIO;
+			__free_page(page);
 			goto out_free_bio;
 		}
 		offset = 0;
-- 
2.35.1

