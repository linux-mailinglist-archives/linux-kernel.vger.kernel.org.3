Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7569512E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbiD1IdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbiD1IbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F9EA0BEE;
        Thu, 28 Apr 2022 01:27:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C6951F88B;
        Thu, 28 Apr 2022 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OIhlvhpDf96xGkhA26yZf7pns1SEZ9vLk/EobSBf7U=;
        b=e4ZiNoI9Kk/vxF6WBGPMvTgtaqzePnrbSEgd3HhKF9fP7PEcYc6C3tzqPjkZsraNDBQpgQ
        Xh5BmiCZb69+V49nJ6MhqGTMRLvrWvGZekAggS1g0NOR11UvMZk2/S6Lwh9yw+93369n8K
        zuoWN8JagVvATERzOOkykaCGvpybBDs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEBE613491;
        Thu, 28 Apr 2022 08:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GGn6OAdQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:51 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 16/19] xen/scsifront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Thu, 28 Apr 2022 10:27:40 +0200
Message-Id: <20220428082743.16593-17-jgross@suse.com>
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

Simplify scsifront's ring creation and removal via xenbus_setup_ring()
and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/scsi/xen-scsifront.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 4c55e479fc36..51afc66e839d 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -798,27 +798,15 @@ static int scsifront_alloc_ring(struct vscsifrnt_info *info)
 {
 	struct xenbus_device *dev = info->dev;
 	struct vscsiif_sring *sring;
-	grant_ref_t gref;
-	int err = -ENOMEM;
+	int err;
 
 	/***** Frontend to Backend ring start *****/
-	sring = (struct vscsiif_sring *)__get_free_page(GFP_KERNEL);
-	if (!sring) {
-		xenbus_dev_fatal(dev, err,
-			"fail to allocate shared ring (Front to Back)");
+	err = xenbus_setup_ring(dev, GFP_KERNEL, (void **)&sring, 1,
+				&info->ring_ref);
+	if (err)
 		return err;
-	}
-	SHARED_RING_INIT(sring);
-	FRONT_RING_INIT(&info->ring, sring, PAGE_SIZE);
 
-	err = xenbus_grant_ring(dev, sring, 1, &gref);
-	if (err < 0) {
-		free_page((unsigned long)sring);
-		xenbus_dev_fatal(dev, err,
-			"fail to grant shared ring (Front to Back)");
-		return err;
-	}
-	info->ring_ref = gref;
+	XEN_FRONT_RING_INIT(&info->ring, sring, PAGE_SIZE);
 
 	err = xenbus_alloc_evtchn(dev, &info->evtchn);
 	if (err) {
@@ -847,8 +835,7 @@ static int scsifront_alloc_ring(struct vscsifrnt_info *info)
 free_irq:
 	unbind_from_irqhandler(info->irq, info);
 free_gnttab:
-	gnttab_end_foreign_access(info->ring_ref,
-				  (unsigned long)info->ring.sring);
+	xenbus_teardown_ring((void **)&sring, 1, &info->ring_ref);
 
 	return err;
 }
@@ -856,8 +843,7 @@ static int scsifront_alloc_ring(struct vscsifrnt_info *info)
 static void scsifront_free_ring(struct vscsifrnt_info *info)
 {
 	unbind_from_irqhandler(info->irq, info);
-	gnttab_end_foreign_access(info->ring_ref,
-				  (unsigned long)info->ring.sring);
+	xenbus_teardown_ring((void **)&info->ring.sring, 1, &info->ring_ref);
 }
 
 static int scsifront_init_ring(struct vscsifrnt_info *info)
-- 
2.34.1

