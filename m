Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF5512E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbiD1Icr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbiD1IbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:31:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED1A0BD7;
        Thu, 28 Apr 2022 01:27:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECFC21F899;
        Thu, 28 Apr 2022 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TSQqudTcVLuLhQNOY3wWT3BirutbrjVm/F1DYUL/Jc=;
        b=bXQFN0N+BgI1kmZyCngmvHVCA1I+1WiKiyl4AoNXMJlXEBLY1bscsQfLjv+ocbOnCYApPF
        Bj/5Cq72navU9MxLn+AfqK7WV3/FX3gM1bLJgJ28Gl0hLTxsS7SNqZ8qKkurAL6KoXX2bH
        6ofYmp6Du47LiNOIHekEpuVElAnDZSs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDE1313491;
        Thu, 28 Apr 2022 08:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OFX/LARQamIBLgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 08:27:48 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 04/19] xen/usb: switch xen-hcd to use INVALID_GRANT_REF
Date:   Thu, 28 Apr 2022 10:27:28 +0200
Message-Id: <20220428082743.16593-5-jgross@suse.com>
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
2.34.1

