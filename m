Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A585AFEFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIGIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIGIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:30:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2CC7F093
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:30:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B30133B5E;
        Wed,  7 Sep 2022 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662539442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZBcullYCL55qBcxn94Qah8Xofn2njMwOJzCNuYUQe5M=;
        b=hIg1gva4IOUEnJDAUT/SxLY1VdnKSr02EhfeOD3X5wh6pvMap7pRqPFHcKzB5G4YkP8C4V
        rzu2cXku/eRkF+AF7BuAa2FmxUKWSQYtcv3X420n2C1uJ/9xxaGOIy7whUD0vgltH1+zhC
        Ip8FCwDQwDbjxUbFdUNXpbioVuKiqjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662539442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZBcullYCL55qBcxn94Qah8Xofn2njMwOJzCNuYUQe5M=;
        b=3drsF299odbWO/n4tWkjm+eVaWzakSZvt1DwLwwkOa9XTxCRaf/bcp3iBTy7jiYdOeibul
        B/saxyQGr+GgD6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5664213A66;
        Wed,  7 Sep 2022 08:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3WWJE7JWGGPRFgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 07 Sep 2022 08:30:42 +0000
Date:   Wed, 7 Sep 2022 10:30:41 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] firmware: dmi: Fortify entry point length checks
Message-ID: <20220907103041.0a88d5c4@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the SMBIOS entry point is long enough to include all the
fields we need. Otherwise it is pointless to even attempt to verify
its checksum.

Also fix the maximum length check, which is technically 32, not 31.
It does not matter in practice as the only valid values are 31 (for
SMBIOS 2.x) and 24 (for SMBIOS 3.x), but let's still have the check
right in case new fields are added to either structure in the future.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/lkml/20220823094857.27f3d924@endymion.delvare/T/
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/firmware/dmi_scan.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-5.19.orig/drivers/firmware/dmi_scan.c	2022-09-06 15:22:44.279728845 +0200
+++ linux-5.19/drivers/firmware/dmi_scan.c	2022-09-07 10:16:55.743362320 +0200
@@ -568,7 +568,8 @@ static int __init dmi_present(const u8 *
 	u32 smbios_ver;
 
 	if (memcmp(buf, "_SM_", 4) == 0 &&
-	    buf[5] < 32 && dmi_checksum(buf, buf[5])) {
+	    buf[5] >= 31 && buf[5] <= 32 &&
+	    dmi_checksum(buf, buf[5])) {
 		smbios_ver = get_unaligned_be16(buf + 6);
 		smbios_entry_point_size = buf[5];
 		memcpy(smbios_entry_point, buf, smbios_entry_point_size);
@@ -629,7 +630,8 @@ static int __init dmi_present(const u8 *
 static int __init dmi_smbios3_present(const u8 *buf)
 {
 	if (memcmp(buf, "_SM3_", 5) == 0 &&
-	    buf[6] < 32 && dmi_checksum(buf, buf[6])) {
+	    buf[6] >= 24 && buf[6] <= 32 &&
+	    dmi_checksum(buf, buf[6])) {
 		dmi_ver = get_unaligned_be24(buf + 7);
 		dmi_num = 0;			/* No longer specified */
 		dmi_len = get_unaligned_le32(buf + 12);


-- 
Jean Delvare
SUSE L3 Support
