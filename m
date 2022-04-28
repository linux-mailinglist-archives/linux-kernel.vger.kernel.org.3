Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76089512E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbiD1IdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344216AbiD1IbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53084A0BD6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:27:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF2F21F88E;
        Thu, 28 Apr 2022 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DySE+lWBPx7VwNEF3X1lwYDq+4S10O0jUUqyaBArCE0=;
        b=nbgsI2l8XvMPHhwykxKcjmjFm5ic18dsQ4iNKTc8cOED/bFxCbEf3NTRN8JBCmnMBKGyQ2
        qXLhAX68u5bD4eceSKKH1djjOsiFninHCccZsIkSwMsZEy1jxCtv8Ps2onc8BrAtqKGNng
        Yy+egfDuGQZXpsqZG2QPjJvI84+Pz7Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C01E513491;
        Thu, 28 Apr 2022 08:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mIuaLQhQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:52 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 19/19] xen/xenbus: eliminate xenbus_grant_ring()
Date:   Thu, 28 Apr 2022 10:27:43 +0200
Message-Id: <20220428082743.16593-20-jgross@suse.com>
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

There is no external user of xenbus_grant_ring() left, so merge it into
the only caller xenbus_setup_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- make error message more precise (Andrew Cooper)
---
 drivers/xen/xenbus/xenbus_client.c | 65 +++++++++---------------------
 include/xen/xenbus.h               |  2 -
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 1a2e0d94ccd1..d6fdd2d209d3 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -363,50 +363,6 @@ static void xenbus_switch_fatal(struct xenbus_device *dev, int depth, int err,
 		__xenbus_switch_state(dev, XenbusStateClosing, 1);
 }
 
-/**
- * xenbus_grant_ring
- * @dev: xenbus device
- * @vaddr: starting virtual address of the ring
- * @nr_pages: number of pages to be granted
- * @grefs: grant reference array to be filled in
- *
- * Grant access to the given @vaddr to the peer of the given device.
- * Then fill in @grefs with grant references.  Return 0 on success, or
- * -errno on error.  On error, the device will switch to
- * XenbusStateClosing, and the error will be saved in the store.
- */
-int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
-		      unsigned int nr_pages, grant_ref_t *grefs)
-{
-	int err;
-	unsigned int i;
-	grant_ref_t gref_head;
-
-	err = gnttab_alloc_grant_references(nr_pages, &gref_head);
-	if (err) {
-		xenbus_dev_fatal(dev, err, "granting access to ring page");
-		return err;
-	}
-
-	for (i = 0; i < nr_pages; i++) {
-		unsigned long gfn;
-
-		if (is_vmalloc_addr(vaddr))
-			gfn = pfn_to_gfn(vmalloc_to_pfn(vaddr));
-		else
-			gfn = virt_to_gfn(vaddr);
-
-		grefs[i] = gnttab_claim_grant_reference(&gref_head);
-		gnttab_grant_foreign_access_ref(grefs[i], dev->otherend_id,
-						gfn, 0);
-
-		vaddr = vaddr + XEN_PAGE_SIZE;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(xenbus_grant_ring);
-
 /*
  * xenbus_setup_ring
  * @dev: xenbus device
@@ -424,6 +380,7 @@ int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
 		      unsigned int nr_pages, grant_ref_t *grefs)
 {
 	unsigned long ring_size = nr_pages * XEN_PAGE_SIZE;
+	grant_ref_t gref_head;
 	unsigned int i;
 	int ret;
 
@@ -433,9 +390,25 @@ int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
 		goto err;
 	}
 
-	ret = xenbus_grant_ring(dev, *vaddr, nr_pages, grefs);
-	if (ret)
+	ret = gnttab_alloc_grant_references(nr_pages, &gref_head);
+	if (ret) {
+		xenbus_dev_fatal(dev, ret, "granting access to %u ring pages",
+				 nr_pages);
 		goto err;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long gfn;
+
+		if (is_vmalloc_addr(*vaddr))
+			gfn = pfn_to_gfn(vmalloc_to_pfn(vaddr[i]));
+		else
+			gfn = virt_to_gfn(vaddr[i]);
+
+		grefs[i] = gnttab_claim_grant_reference(&gref_head);
+		gnttab_grant_foreign_access_ref(grefs[i], dev->otherend_id,
+						gfn, 0);
+	}
 
 	return 0;
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index b533b4adc835..eaa932b99d8a 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -224,8 +224,6 @@ int xenbus_watch_pathfmt(struct xenbus_device *dev, struct xenbus_watch *watch,
 			 const char *pathfmt, ...);
 
 int xenbus_switch_state(struct xenbus_device *dev, enum xenbus_state new_state);
-int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
-		      unsigned int nr_pages, grant_ref_t *grefs);
 int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
 		      unsigned int nr_pages, grant_ref_t *grefs);
 void xenbus_teardown_ring(void **vaddr, unsigned int nr_pages,
-- 
2.34.1

