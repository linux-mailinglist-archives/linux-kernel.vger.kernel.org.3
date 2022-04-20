Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E17508BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380147AbiDTPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380090AbiDTPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:12:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B13EA85
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:10:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F52C1F74E;
        Wed, 20 Apr 2022 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650467400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27ryrQ9/V3A+L0L1cMkzg+znNHks8+NEi42Ak1eCxTQ=;
        b=tZ70zY2Z8ae+EH5HDjSsCrE0+Obr0+3PLdmMlwpcYTQS6O/gxKd5Wt0smGPntpM64zeZns
        oDNx8gIE1hM6kQMNo7Cc4s/LzaDVNqHIV/dBcgmK7lqMVFb+cnuA2Tt5XNHncoqPC6Byia
        RGfEx698LwhJYEYLJteROadnU2YJOEo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1721D13AD5;
        Wed, 20 Apr 2022 15:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJqaBEgiYGJILQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 20 Apr 2022 15:10:00 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 08/18] xen/shbuf: switch xen-front-pgdir-shbuf to use INVALID_GRANT_REF
Date:   Wed, 20 Apr 2022 17:09:32 +0200
Message-Id: <20220420150942.31235-9-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420150942.31235-1-jgross@suse.com>
References: <20220420150942.31235-1-jgross@suse.com>
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
 drivers/xen/xen-front-pgdir-shbuf.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/xen/xen-front-pgdir-shbuf.c b/drivers/xen/xen-front-pgdir-shbuf.c
index a959dee21134..fa2921d4fbfc 100644
--- a/drivers/xen/xen-front-pgdir-shbuf.c
+++ b/drivers/xen/xen-front-pgdir-shbuf.c
@@ -21,15 +21,6 @@
 
 #include <xen/xen-front-pgdir-shbuf.h>
 
-#ifndef GRANT_INVALID_REF
-/*
- * FIXME: usage of grant reference 0 as invalid grant reference:
- * grant reference 0 is valid, but never exposed to a PV driver,
- * because of the fact it is already in use/reserved by the PV console.
- */
-#define GRANT_INVALID_REF	0
-#endif
-
 /**
  * This structure represents the structure of a shared page
  * that contains grant references to the pages of the shared
@@ -83,7 +74,7 @@ grant_ref_t
 xen_front_pgdir_shbuf_get_dir_start(struct xen_front_pgdir_shbuf *buf)
 {
 	if (!buf->grefs)
-		return GRANT_INVALID_REF;
+		return INVALID_GRANT_REF;
 
 	return buf->grefs[0];
 }
@@ -142,7 +133,7 @@ void xen_front_pgdir_shbuf_free(struct xen_front_pgdir_shbuf *buf)
 		int i;
 
 		for (i = 0; i < buf->num_grefs; i++)
-			if (buf->grefs[i] != GRANT_INVALID_REF)
+			if (buf->grefs[i] != INVALID_GRANT_REF)
 				gnttab_end_foreign_access(buf->grefs[i], 0UL);
 	}
 	kfree(buf->grefs);
@@ -355,7 +346,7 @@ static void backend_fill_page_dir(struct xen_front_pgdir_shbuf *buf)
 	}
 	/* Last page must say there is no more pages. */
 	page_dir = (struct xen_page_directory *)ptr;
-	page_dir->gref_dir_next_page = GRANT_INVALID_REF;
+	page_dir->gref_dir_next_page = INVALID_GRANT_REF;
 }
 
 /**
@@ -384,7 +375,7 @@ static void guest_fill_page_dir(struct xen_front_pgdir_shbuf *buf)
 
 		if (grefs_left <= XEN_NUM_GREFS_PER_PAGE) {
 			to_copy = grefs_left;
-			page_dir->gref_dir_next_page = GRANT_INVALID_REF;
+			page_dir->gref_dir_next_page = INVALID_GRANT_REF;
 		} else {
 			to_copy = XEN_NUM_GREFS_PER_PAGE;
 			page_dir->gref_dir_next_page = buf->grefs[i + 1];
-- 
2.34.1

