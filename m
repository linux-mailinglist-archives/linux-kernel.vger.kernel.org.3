Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86851BA0B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347014AbiEEIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347321AbiEEIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:20:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F3496A6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:16:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5F9F1F895;
        Thu,  5 May 2022 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651738606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yFjXHXMXwZa6Ccja7xlX/k6b/j03dysFoZbs8/tSS0=;
        b=tZpw7w2YZs7zI4Wv0ZhcBunFcpmESyHgadFim0wkQdlTZDZz7ZNdx1QNcQvdlPsvcwlSM2
        QWD8TVciM+/T64Fk45IKVJjeUCiDTZIQ8t9ZdDRgywz13/SQqfAoPJSygm1LjbV/XUYDrk
        5x1A1Gezd16QvlIB5qynYPOvcggWS7A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B70D213B11;
        Thu,  5 May 2022 08:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFNgK+6Hc2K1BwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 05 May 2022 08:16:46 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3 12/21] xen/xenbus: add xenbus_setup_ring() service function
Date:   Thu,  5 May 2022 10:16:31 +0200
Message-Id: <20220505081640.17425-13-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220505081640.17425-1-jgross@suse.com>
References: <20220505081640.17425-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most PV device frontends share very similar code for setting up shared
ring buffers:

- allocate page(s)
- init the ring admin data
- give the backend access to the ring via grants

Tearing down the ring requires similar actions in all frontends again:

- remove grants
- free the page(s)

Provide service functions xenbus_setup_ring() and xenbus_teardown_ring()
for that purpose.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_client.c | 69 ++++++++++++++++++++++++++++++
 include/xen/xenbus.h               |  4 ++
 2 files changed, 73 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index df6890681231..1a2e0d94ccd1 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -407,6 +407,75 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 }
 EXPORT_SYMBOL_GPL(xenbus_grant_ring);
 
+/*
+ * xenbus_setup_ring
+ * @dev: xenbus device
+ * @vaddr: pointer to starting virtual address of the ring
+ * @nr_pages: number of pages to be granted
+ * @grefs: grant reference array to be filled in
+ *
+ * Allocate physically contiguous pages for a shared ring buffer and grant it
+ * to the peer of the given device. The ring buffer is initially filled with
+ * zeroes. The virtual address of the ring is stored at @vaddr and the
+ * grant references are stored in the @grefs array. In case of error @vaddr
+ * will be set to NULL and @grefs will be filled with INVALID_GRANT_REF.
+ */
+int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
+		      unsigned int nr_pages, grant_ref_t *grefs)
+{
+	unsigned long ring_size = nr_pages * XEN_PAGE_SIZE;
+	unsigned int i;
+	int ret;
+
+	*vaddr = alloc_pages_exact(ring_size, gfp | __GFP_ZERO);
+	if (!*vaddr) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = xenbus_grant_ring(dev, *vaddr, nr_pages, grefs);
+	if (ret)
+		goto err;
+
+	return 0;
+
+ err:
+	if (*vaddr)
+		free_pages_exact(*vaddr, ring_size);
+	for (i = 0; i < nr_pages; i++)
+		grefs[i] = INVALID_GRANT_REF;
+	*vaddr = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_setup_ring);
+
+/*
+ * xenbus_teardown_ring
+ * @vaddr: starting virtual address of the ring
+ * @nr_pages: number of pages
+ * @grefs: grant reference array
+ *
+ * Remove grants for the shared ring buffer and free the associated memory.
+ * On return the grant reference array is filled with INVALID_GRANT_REF.
+ */
+void xenbus_teardown_ring(void **vaddr, unsigned int nr_pages,
+			  grant_ref_t *grefs)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (grefs[i] != INVALID_GRANT_REF) {
+			gnttab_end_foreign_access(grefs[i], 0);
+			grefs[i] = INVALID_GRANT_REF;
+		}
+	}
+
+	if (*vaddr)
+		free_pages_exact(*vaddr, nr_pages * XEN_PAGE_SIZE);
+	*vaddr = NULL;
+}
+EXPORT_SYMBOL_GPL(xenbus_teardown_ring);
 
 /**
  * Allocate an event channel for the given xenbus_device, assigning the newly
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index b13eb86395e0..b533b4adc835 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -226,6 +226,10 @@ int xenbus_watch_pathfmt(struct xenbus_device *dev, struct xenbus_watch *watch,
 int xenbus_switch_state(struct xenbus_device *dev, enum xenbus_state new_state);
 int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 		      unsigned int nr_pages, grant_ref_t *grefs);
+int xenbus_setup_ring(struct xenbus_device *dev, gfp_t gfp, void **vaddr,
+		      unsigned int nr_pages, grant_ref_t *grefs);
+void xenbus_teardown_ring(void **vaddr, unsigned int nr_pages,
+			  grant_ref_t *grefs);
 int xenbus_map_ring_valloc(struct xenbus_device *dev, grant_ref_t *gnt_refs,
 			   unsigned int nr_grefs, void **vaddr);
 
-- 
2.35.3

