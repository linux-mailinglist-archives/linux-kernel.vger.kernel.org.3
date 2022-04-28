Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36441512E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiD1Ick (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbiD1IbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2DA0BE3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:27:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B78F51F88A;
        Thu, 28 Apr 2022 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPIngja7rfH6/X0ahWtYB7L7nX8NRl4zj/+cjR7xZr0=;
        b=b7TnDrRcZ8z68LrDQfaX1DqYfORj8ovWaBSLWfmePTyAcTrj7ib5gCErS/v1IQdBeh1X3M
        Qu5cD8Fe5euQgJsZU3TUwzQz/XM70bZA++EtW65/fPX/tHI910GU8H0Dh8g3F4RlQWAky9
        CV2BiAzCmMq6L8R2HrQyYiQ9FoU5Y7A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A17913491;
        Thu, 28 Apr 2022 08:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFi8HwVQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:49 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 07/19] xen/dmabuf: switch gntdev-dmabuf to use INVALID_GRANT_REF
Date:   Thu, 28 Apr 2022 10:27:31 +0200
Message-Id: <20220428082743.16593-8-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220428082743.16593-1-jgross@suse.com>
References: <20220428082743.16593-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a private macro for an invalid grant reference use
the common one.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/gntdev-dmabuf.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index d5bfd7b867fc..91073b4e4a20 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -24,15 +24,6 @@
 
 MODULE_IMPORT_NS(DMA_BUF);
 
-#ifndef GRANT_INVALID_REF
-/*
- * Note on usage of grant reference 0 as invalid grant reference:
- * grant reference 0 is valid, but never exposed to a driver,
- * because of the fact it is already in use/reserved by the PV console.
- */
-#define GRANT_INVALID_REF	0
-#endif
-
 struct gntdev_dmabuf {
 	struct gntdev_dmabuf_priv *priv;
 	struct dma_buf *dmabuf;
@@ -532,7 +523,7 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (refs[i] != GRANT_INVALID_REF)
+		if (refs[i] != INVALID_GRANT_REF)
 			gnttab_end_foreign_access(refs[i], 0UL);
 }
 
@@ -567,7 +558,7 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 	gntdev_dmabuf->nr_pages = count;
 
 	for (i = 0; i < count; i++)
-		gntdev_dmabuf->u.imp.refs[i] = GRANT_INVALID_REF;
+		gntdev_dmabuf->u.imp.refs[i] = INVALID_GRANT_REF;
 
 	return gntdev_dmabuf;
 
-- 
2.34.1

