Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B575D508BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380031AbiDTPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380092AbiDTPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:12:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04203E5C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:10:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6E98B215FD;
        Wed, 20 Apr 2022 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650467400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDGIDWKPRWQB7unVe+D0Q46rvuLr6BdasgzAbPg2LQ4=;
        b=ldrF4kjq+B1ALbw+0FXFa11PZ6m6yv1eHafGyMjuw6sVEYhgTHTCPqG4eHHk3RNDnjFvFR
        uDngELLfvTSL23P1jfO6z9oZtu/Q96ANRFBwBt10W+2B3ZxB7zzO52ScagQgii6L1DZlt7
        yUr1q+kDuVo+nLFzfmzqcDwMKjr82z4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45D1113AD5;
        Wed, 20 Apr 2022 15:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kDnRD0giYGJILQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 20 Apr 2022 15:10:00 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 09/18] xen/xenbus: add xenbus_setup_ring() service function
Date:   Wed, 20 Apr 2022 17:09:33 +0200
Message-Id: <20220420150942.31235-10-jgross@suse.com>
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
2.34.1

