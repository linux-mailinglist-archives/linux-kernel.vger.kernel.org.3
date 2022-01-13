Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84A948DAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiAMPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiAMPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D0C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:44:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BBE60AF5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D92C36AEB;
        Thu, 13 Jan 2022 15:44:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l8jcayDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642088682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHRHZ2DmZlajNxmwLMwsAzCzT3jhXz6vdabZy1NYR/I=;
        b=l8jcayDscAwo8aPrUPpAdn6Mw9OBhfaBPk5SE1sF8X/M5DYwvnQr9eepqVmbvsUE3sdNvC
        FKLcOPeA1sFSPCPUR/M+lgkfz9VqFcfxGCo/ZgXk20IBIc7g/m0TzBSN3NISGOU6T8y1ot
        UgS6I0/3YvK6TfFHzqo40DRt+o5wNEg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c000dd5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 13 Jan 2022 15:44:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 7/7] random: de-duplicate INPUT_POOL constants
Date:   Thu, 13 Jan 2022 16:44:13 +0100
Message-Id: <20220113154413.29513-8-Jason@zx2c4.com>
In-Reply-To: <20220113154413.29513-1-Jason@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already had the POOL_* constants, so deduplicate the older INPUT_POOL
ones. As well, fold EXTRACT_SIZE into the poolinfo enum, since it's
related.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 46aee3dcd807..839c231485f2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -358,13 +358,6 @@
 
 /* #define ADD_INTERRUPT_BENCH */
 
-/*
- * Configuration information
- */
-#define INPUT_POOL_SHIFT	12
-#define INPUT_POOL_WORDS	(1 << (INPUT_POOL_SHIFT-5))
-#define EXTRACT_SIZE		(BLAKE2S_HASH_SIZE / 2)
-
 /*
  * To allow fractional bits to be tracked, the entropy_count field is
  * denominated in units of 1/8th bits.
@@ -440,7 +433,9 @@ enum poolinfo {
 	POOL_TAP2 = 76,
 	POOL_TAP3 = 51,
 	POOL_TAP4 = 25,
-	POOL_TAP5 = 1
+	POOL_TAP5 = 1,
+
+	EXTRACT_SIZE = BLAKE2S_HASH_SIZE / 2
 };
 
 /*
@@ -503,7 +498,7 @@ MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
  *
  **********************************************************************/
 
-static u32 input_pool_data[INPUT_POOL_WORDS] __latent_entropy;
+static u32 input_pool_data[POOL_WORDS] __latent_entropy;
 
 static struct {
 	/* read-only data: */
@@ -1961,7 +1956,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 #include <linux/sysctl.h>
 
 static int min_write_thresh;
-static int max_write_thresh = INPUT_POOL_WORDS * 32;
+static int max_write_thresh = POOL_WORDS * 32;
 static int random_min_urandom_seed = 60;
 static char sysctl_bootid[16];
 
@@ -2018,7 +2013,7 @@ static int proc_do_entropy(struct ctl_table *table, int write,
 	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
 }
 
-static int sysctl_poolsize = INPUT_POOL_WORDS * 32;
+static int sysctl_poolsize = POOL_BITS;
 extern struct ctl_table random_table[];
 struct ctl_table random_table[] = {
 	{
-- 
2.34.1

