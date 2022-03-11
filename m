Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140BB4D5FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbiCKKgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiCKKgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:36:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2051160F9;
        Fri, 11 Mar 2022 02:35:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1505421901;
        Fri, 11 Mar 2022 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646994903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cl8eXsZGXE2910dV3+hGtO5AmlArXF2/CNH7AFhna9A=;
        b=jzLP/R1zJqyhsxtF02jryM8k300pfwJZXj8gxvxt/4Nm6TDhvTgoPKqENjWl1clmPGCMbt
        UIL2Xl9sT9WOeDqiCb8WyElSfyhKO6RDIANpNYwGrrZN/pHL8Z7FWmqzuDzEpdMtsLQpdh
        GxViyLpxS0aatuAWvXEwYj0rudthaDU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D69EB13A85;
        Fri, 11 Mar 2022 10:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pe8nM9YlK2I5dgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 11 Mar 2022 10:35:02 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] xen/usb: don't use arbitrary_virt_to_machine()
Date:   Fri, 11 Mar 2022 11:35:00 +0100
Message-Id: <20220311103500.12885-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
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

arbitrary_virt_to_machine() is meant to be used in PV guests only.
Replace its usage with virt_to_gfn().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/usb/host/xen-hcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 5f4a00df4f1c..01db5c767251 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -589,14 +589,12 @@ static void xenhcd_gnttab_map(struct xenhcd_info *info, void *addr, int length,
 			      int nr_pages, int flags)
 {
 	grant_ref_t ref;
-	unsigned long buffer_mfn;
 	unsigned int offset;
 	unsigned int len = length;
 	unsigned int bytes;
 	int i;
 
 	for (i = 0; i < nr_pages; i++) {
-		buffer_mfn = PFN_DOWN(arbitrary_virt_to_machine(addr).maddr);
 		offset = offset_in_page(addr);
 
 		bytes = PAGE_SIZE - offset;
@@ -605,7 +603,7 @@ static void xenhcd_gnttab_map(struct xenhcd_info *info, void *addr, int length,
 
 		ref = gnttab_claim_grant_reference(gref_head);
 		gnttab_grant_foreign_access_ref(ref, info->xbdev->otherend_id,
-						buffer_mfn, flags);
+						virt_to_gfn(addr), flags);
 		seg[i].gref = ref;
 		seg[i].offset = (__u16)offset;
 		seg[i].length = (__u16)bytes;
-- 
2.34.1

