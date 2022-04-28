Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F733512E78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiD1IcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbiD1IbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F0972D6;
        Thu, 28 Apr 2022 01:27:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C72351F88F;
        Thu, 28 Apr 2022 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDUTirs/68J75dLhVfxQ8SwGZggDnAgUBf0vqNCyldA=;
        b=uYPkEtI1D+dBDttNAMWwXe5ps2vwOgVNOH3jvmBtgFhBUy/z0IPKe2AMkUYo9qfXjXomlv
        eDi8P8+olYpzbp6RDG+C2VAYvNC2s/qwj3kH+fQ1mRdC6zeuKb69a8lZJCAUDt5w17TMiZ
        crrx8z21AJh4HirtTLTotjXWv2WOsT4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86DCA13491;
        Thu, 28 Apr 2022 08:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJVhHwZQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:50 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 11/19] xen/blkfront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Thu, 28 Apr 2022 10:27:35 +0200
Message-Id: <20220428082743.16593-12-jgross@suse.com>
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

Simplify blkfront's ring creation and removal via xenbus_setup_ring()
and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 37 ++++++++----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7f35e30e626a..bd7b34f29193 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1280,15 +1280,8 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	flush_work(&rinfo->work);
 
 	/* Free resources associated with old device channel. */
-	for (i = 0; i < info->nr_ring_pages; i++) {
-		if (rinfo->ring_ref[i] != INVALID_GRANT_REF) {
-			gnttab_end_foreign_access(rinfo->ring_ref[i], 0);
-			rinfo->ring_ref[i] = INVALID_GRANT_REF;
-		}
-	}
-	free_pages_exact(rinfo->ring.sring,
-			 info->nr_ring_pages * XEN_PAGE_SIZE);
-	rinfo->ring.sring = NULL;
+	xenbus_teardown_ring((void **)&rinfo->ring.sring, info->nr_ring_pages,
+			     rinfo->ring_ref);
 
 	if (rinfo->irq)
 		unbind_from_irqhandler(rinfo->irq, rinfo);
@@ -1679,30 +1672,16 @@ static int setup_blkring(struct xenbus_device *dev,
 			 struct blkfront_ring_info *rinfo)
 {
 	struct blkif_sring *sring;
-	int err, i;
+	int err;
 	struct blkfront_info *info = rinfo->dev_info;
 	unsigned long ring_size = info->nr_ring_pages * XEN_PAGE_SIZE;
-	grant_ref_t gref[XENBUS_MAX_RING_GRANTS];
-
-	for (i = 0; i < info->nr_ring_pages; i++)
-		rinfo->ring_ref[i] = INVALID_GRANT_REF;
 
-	sring = alloc_pages_exact(ring_size, GFP_NOIO);
-	if (!sring) {
-		xenbus_dev_fatal(dev, -ENOMEM, "allocating shared ring");
-		return -ENOMEM;
-	}
-	SHARED_RING_INIT(sring);
-	FRONT_RING_INIT(&rinfo->ring, sring, ring_size);
-
-	err = xenbus_grant_ring(dev, rinfo->ring.sring, info->nr_ring_pages, gref);
-	if (err < 0) {
-		free_pages_exact(sring, ring_size);
-		rinfo->ring.sring = NULL;
+	err = xenbus_setup_ring(dev, GFP_NOIO, (void **)&sring,
+				info->nr_ring_pages, rinfo->ring_ref);
+	if (err)
 		goto fail;
-	}
-	for (i = 0; i < info->nr_ring_pages; i++)
-		rinfo->ring_ref[i] = gref[i];
+
+	XEN_FRONT_RING_INIT(&rinfo->ring, sring, ring_size);
 
 	err = xenbus_alloc_evtchn(dev, &rinfo->evtchn);
 	if (err)
-- 
2.34.1

