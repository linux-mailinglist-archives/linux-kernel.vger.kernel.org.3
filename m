Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B451BA20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347410AbiEEIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346964AbiEEIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:20:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23FD4738D;
        Thu,  5 May 2022 01:16:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F7012129A;
        Thu,  5 May 2022 08:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651738605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40GR81qLBAKpQ1pdFfw5ZbcFKNAIeNjaSwOGqddCksA=;
        b=EYWTHAdH5RBPO4czJu3WhK/zfuAs3DPsQSFX7ShogW2nC4Y+RSVboPlZrXxv7vWz6rPt4r
        hH6yrF93UKdeG02In73kBwMr+ScCL3WB97iWJbmhTeE3jQIFTITqOW8UWBzubf6sOu4oSJ
        NLeFPsnT2hA+8Ihi6gyc0hhiGm3PHGg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FEC413B11;
        Thu,  5 May 2022 08:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPtXDu2Hc2K1BwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 05 May 2022 08:16:45 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 06/21] xen/usb: switch xen-hcd to use INVALID_GRANT_REF
Date:   Thu,  5 May 2022 10:16:25 +0200
Message-Id: <20220505081640.17425-7-jgross@suse.com>
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

Instead of using a private macro for an invalid grant reference use
the common one.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xen-hcd.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 3e487baf8422..9cbc7c2dab02 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -87,8 +87,6 @@ struct xenhcd_info {
 	bool error;
 };
 
-#define GRANT_INVALID_REF 0
-
 #define XENHCD_RING_JIFFIES (HZ/200)
 #define XENHCD_SCAN_JIFFIES 1
 
@@ -1100,17 +1098,17 @@ static void xenhcd_destroy_rings(struct xenhcd_info *info)
 		unbind_from_irqhandler(info->irq, info);
 	info->irq = 0;
 
-	if (info->urb_ring_ref != GRANT_INVALID_REF) {
+	if (info->urb_ring_ref != INVALID_GRANT_REF) {
 		gnttab_end_foreign_access(info->urb_ring_ref,
 					  (unsigned long)info->urb_ring.sring);
-		info->urb_ring_ref = GRANT_INVALID_REF;
+		info->urb_ring_ref = INVALID_GRANT_REF;
 	}
 	info->urb_ring.sring = NULL;
 
-	if (info->conn_ring_ref != GRANT_INVALID_REF) {
+	if (info->conn_ring_ref != INVALID_GRANT_REF) {
 		gnttab_end_foreign_access(info->conn_ring_ref,
 					  (unsigned long)info->conn_ring.sring);
-		info->conn_ring_ref = GRANT_INVALID_REF;
+		info->conn_ring_ref = INVALID_GRANT_REF;
 	}
 	info->conn_ring.sring = NULL;
 }
@@ -1123,8 +1121,8 @@ static int xenhcd_setup_rings(struct xenbus_device *dev,
 	grant_ref_t gref;
 	int err;
 
-	info->urb_ring_ref = GRANT_INVALID_REF;
-	info->conn_ring_ref = GRANT_INVALID_REF;
+	info->urb_ring_ref = INVALID_GRANT_REF;
+	info->conn_ring_ref = INVALID_GRANT_REF;
 
 	urb_sring = (struct xenusb_urb_sring *)get_zeroed_page(
 							GFP_NOIO | __GFP_HIGH);
-- 
2.35.3

