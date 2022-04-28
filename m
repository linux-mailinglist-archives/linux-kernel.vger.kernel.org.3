Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD0512E76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiD1Idq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiD1IbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F9A0BCC;
        Thu, 28 Apr 2022 01:27:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7237D1F88A;
        Thu, 28 Apr 2022 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cqwaPLtFzhyk9LMWncXmAETsj1bDnyp+ydH1my5u10=;
        b=XTUSjtzPzruE8bhqvv73TtSTB50qK9+aNrXbuRtAJ9c6hvz9KnGSHEC+p8iV6zrfVFvbr7
        Me2MbBlNtrfCJ/FKyPE9+PGYOV6x5DQhu0AqYudjZTvyTvrfxBYt3eMH0Ldo8Fj7KYWYxl
        hQkceNSNaNLcPkHDy8rh2e1023pRJhY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43ED413491;
        Thu, 28 Apr 2022 08:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QF5XDwhQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:52 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 17/19] xen/usbfront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Thu, 28 Apr 2022 10:27:41 +0200
Message-Id: <20220428082743.16593-18-jgross@suse.com>
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

Simplify xen-hcd's ring creation and removal via xenbus_setup_ring()
and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xen-hcd.c | 61 ++++++++++----------------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 9cbc7c2dab02..de1b09158318 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -1098,19 +1098,10 @@ static void xenhcd_destroy_rings(struct xenhcd_info *info)
 		unbind_from_irqhandler(info->irq, info);
 	info->irq = 0;
 
-	if (info->urb_ring_ref != INVALID_GRANT_REF) {
-		gnttab_end_foreign_access(info->urb_ring_ref,
-					  (unsigned long)info->urb_ring.sring);
-		info->urb_ring_ref = INVALID_GRANT_REF;
-	}
-	info->urb_ring.sring = NULL;
-
-	if (info->conn_ring_ref != INVALID_GRANT_REF) {
-		gnttab_end_foreign_access(info->conn_ring_ref,
-					  (unsigned long)info->conn_ring.sring);
-		info->conn_ring_ref = INVALID_GRANT_REF;
-	}
-	info->conn_ring.sring = NULL;
+	xenbus_teardown_ring((void **)&info->urb_ring.sring, 1,
+			     &info->urb_ring_ref);
+	xenbus_teardown_ring((void **)&info->conn_ring.sring, 1,
+			     &info->conn_ring_ref);
 }
 
 static int xenhcd_setup_rings(struct xenbus_device *dev,
@@ -1118,46 +1109,24 @@ static int xenhcd_setup_rings(struct xenbus_device *dev,
 {
 	struct xenusb_urb_sring *urb_sring;
 	struct xenusb_conn_sring *conn_sring;
-	grant_ref_t gref;
 	int err;
 
-	info->urb_ring_ref = INVALID_GRANT_REF;
 	info->conn_ring_ref = INVALID_GRANT_REF;
-
-	urb_sring = (struct xenusb_urb_sring *)get_zeroed_page(
-							GFP_NOIO | __GFP_HIGH);
-	if (!urb_sring) {
-		xenbus_dev_fatal(dev, -ENOMEM, "allocating urb ring");
-		return -ENOMEM;
-	}
-	SHARED_RING_INIT(urb_sring);
-	FRONT_RING_INIT(&info->urb_ring, urb_sring, PAGE_SIZE);
-
-	err = xenbus_grant_ring(dev, urb_sring, 1, &gref);
-	if (err < 0) {
-		free_page((unsigned long)urb_sring);
-		info->urb_ring.sring = NULL;
-		goto fail;
-	}
-	info->urb_ring_ref = gref;
-
-	conn_sring = (struct xenusb_conn_sring *)get_zeroed_page(
-							GFP_NOIO | __GFP_HIGH);
-	if (!conn_sring) {
-		xenbus_dev_fatal(dev, -ENOMEM, "allocating conn ring");
-		err = -ENOMEM;
-		goto fail;
+	err = xenbus_setup_ring(dev, GFP_NOIO | __GFP_HIGH,
+				(void **)&urb_sring, 1, &info->urb_ring_ref);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "allocating urb ring");
+		return err;
 	}
-	SHARED_RING_INIT(conn_sring);
-	FRONT_RING_INIT(&info->conn_ring, conn_sring, PAGE_SIZE);
+	XEN_FRONT_RING_INIT(&info->urb_ring, urb_sring, PAGE_SIZE);
 
-	err = xenbus_grant_ring(dev, conn_sring, 1, &gref);
-	if (err < 0) {
-		free_page((unsigned long)conn_sring);
-		info->conn_ring.sring = NULL;
+	err = xenbus_setup_ring(dev, GFP_NOIO | __GFP_HIGH,
+				(void **)&conn_sring, 1, &info->conn_ring_ref);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "allocating conn ring");
 		goto fail;
 	}
-	info->conn_ring_ref = gref;
+	XEN_FRONT_RING_INIT(&info->conn_ring, conn_sring, PAGE_SIZE);
 
 	err = xenbus_alloc_evtchn(dev, &info->evtchn);
 	if (err) {
-- 
2.34.1

