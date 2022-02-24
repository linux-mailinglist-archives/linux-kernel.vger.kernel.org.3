Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C94C3879
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiBXWKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiBXWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:10:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8D285712
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4B87B826AE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC70C340E9;
        Thu, 24 Feb 2022 22:10:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TtV0BeYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645740601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6q7ftuuL27e2Gb8WvMPh2vR53oqJaiSfS8otjMFxHkk=;
        b=TtV0BeYe/UiCjSsywExJ//EqqxFBRSU5bZgDhcelc7Ew1WLxdL2KlPH9MzvoCmiBl3Cx41
        FAlLbX4tZUGbbSuJH2NhV+etXg54EblzZ9KlmBwUdvfXKCBWHCZPz58Gl+oow106w47ZBO
        +7I5hLprPcuPpQOwDwfa8YsUrFYpgQQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 82e0829f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Feb 2022 22:10:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: cleanup UUID handling
Date:   Thu, 24 Feb 2022 23:09:58 +0100
Message-Id: <20220224220958.93263-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than hard coding various lengths, we can use the right constants.
Strings should be `char *` while buffers should be `u8 *`. Rather than
have a nonsensical and unused maxlength, just remove it. Finally, use
snprintf instead of sprintf, just out of good hygiene.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1d6cb0779acd..a26c6e7cc93b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1632,11 +1632,11 @@ const struct file_operations urandom_fops = {
 static int sysctl_random_min_urandom_seed = 60;
 static int sysctl_random_write_wakeup_bits = POOL_MIN_BITS;
 static int sysctl_poolsize = POOL_BITS;
-static char sysctl_bootid[16];
+static u8 sysctl_bootid[UUID_SIZE];
 
 /*
  * This function is used to return both the bootid UUID, and random
- * UUID.  The difference is in whether table->data is NULL; if it is,
+ * UUID. The difference is in whether table->data is NULL; if it is,
  * then a new UUID is generated and returned to the user.
  *
  * If the user accesses this via the proc interface, the UUID will be
@@ -1646,8 +1646,15 @@ static char sysctl_bootid[16];
 static int proc_do_uuid(struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos)
 {
-	struct ctl_table fake_table;
-	unsigned char buf[64], tmp_uuid[16], *uuid;
+	u8 tmp_uuid[UUID_SIZE], *uuid;
+	char uuid_string[UUID_STRING_LEN + 1];
+	struct ctl_table fake_table = {
+		.data = uuid_string,
+		.maxlen = sizeof(uuid_string)
+	};
+
+	if (write)
+		return -EPERM;
 
 	uuid = table->data;
 	if (!uuid) {
@@ -1662,12 +1669,8 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buffer,
 		spin_unlock(&bootid_spinlock);
 	}
 
-	sprintf(buf, "%pU", uuid);
-
-	fake_table.data = buf;
-	fake_table.maxlen = sizeof(buf);
-
-	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
+	snprintf(uuid_string, sizeof(uuid_string), "%pU", uuid);
+	return proc_dostring(&fake_table, 0, buffer, lenp, ppos);
 }
 
 static struct ctl_table random_table[] = {
@@ -1702,13 +1705,11 @@ static struct ctl_table random_table[] = {
 	{
 		.procname	= "boot_id",
 		.data		= &sysctl_bootid,
-		.maxlen		= 16,
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
 	{
 		.procname	= "uuid",
-		.maxlen		= 16,
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
-- 
2.35.1

