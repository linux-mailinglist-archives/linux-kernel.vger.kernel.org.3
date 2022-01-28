Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BCF4A0344
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbiA1WEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiA1WEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:04:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D98C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:04:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c7-20020a25a2c7000000b00613e4dbaf97so14968024ybn.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9kuLsoxSY0OiUWPOZQPW3S5zK0U21m9yY4je+fn9waE=;
        b=VaaHhdrb7XS5lp77SYAo08EZ/jKt5Gz4mqwTZku845U4SOGYlL+HuEnAy84StZXiub
         0zKb+nSuzyEl+8LGjsdM35+aWi1DRE5plxK+qC8Z0BxFyVdGC98sbWhaX5cTT3v4DC1D
         K7A6Nm82kOl16/aL2kiTkFFF5AQTxJfB9N6U/m2Et2qR8fZWPubo5ENICkLYjFVsbinO
         Tqqt5l4bDtdmJyfLIU5eLDcM9K0SX9RXkDsHrMMCZPRhlP4AiKpKgNHPN/vtmDkwapiU
         0x2pkoT6+EcjxHlWEC6t1EvgKN/ADbKDZc/PBT6w2wS1azvdmTP8rvdgupZUWjH+xBUM
         PCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9kuLsoxSY0OiUWPOZQPW3S5zK0U21m9yY4je+fn9waE=;
        b=b5GoZ7UASlnSFeAdoyuehtD1TWkXSemz1blBtvfYsiBmBGHn8jXFowJdlaOKfSJWT0
         px6FRGvnM5yxTwfqMh6So7efBodOo1Yif4G/IrVXbqF4+Mjjkj4QkqXzN63zv6JmfrdH
         0QktBZz52mODHGuWyAtxgxhwpO4R3ROgRR0PM4WSm4aKMj2m0Dz4ux1uHVF1zvN7cMuD
         0PJ5zU2Ws/8q2m45mjLjIVbn45s0Fiz3F9WZ43RMg4kbxwM2m/202e7g7/Xt6QfoRRr/
         mQqq1lHsRQWS3/YyEQ4qKsgIXSAUttBcySHItCAWhF/sOnVDhwQ8ohsIEQ92TdhVgznk
         xcgQ==
X-Gm-Message-State: AOAM533BbyRW/WFQcACZ9DBypTI3ltNACda2GJT7G27dDnMnPAqAUoxF
        9d4kT3xASDYtMOWjZnolvXZP8vksC/bv
X-Google-Smtp-Source: ABdhPJwgvPLRgmWG81wNjsJg35Uq+9RVmeCuus+Ga6cp08WjWtOA/pE4BetzuiG3uOVuV07lPCRuY4m4MA+2
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:562d:d821:bf6:b545])
 (user=jmeurin job=sendgmr) by 2002:a25:6146:: with SMTP id
 v67mr15737383ybb.408.1643407453772; Fri, 28 Jan 2022 14:04:13 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:04:06 -0800
Message-Id: <20220128220406.4058777-1-jmeurin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] Add a timestamp to the oops header.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The saved panics in the mtdoops partition now include a timestamp
in the expanded header after the existing sequence number.

This patch depends on patch 2268aeacced1.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 09a26747f490..7f5869c209a8 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/timekeeping.h>
 #include <linux/mtd/mtd.h>
 #include <linux/kmsg_dump.h>
 
@@ -23,7 +24,7 @@
 #define MTDOOPS_MAX_MTD_SIZE (8 * 1024 * 1024)
 
 #define MTDOOPS_KERNMSG_MAGIC 0x5d005d00
-#define MTDOOPS_HEADER_SIZE   8
+#define MTDOOPS_HEADER_SIZE   16
 
 static unsigned long record_size = 4096;
 module_param(record_size, ulong, 0400);
@@ -180,6 +181,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	size_t retlen;
 	u32 *hdr;
 	int ret;
+	ktime_t ktime = ktime_get_real();
 
 	if (test_and_set_bit(0, &cxt->oops_buf_busy))
 		return;
@@ -188,6 +190,8 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	hdr = cxt->oops_buf;
 	hdr[0] = cxt->nextcount;
 	hdr[1] = MTDOOPS_KERNMSG_MAGIC;
+	hdr[2] = (u32) (ktime >> 32);
+	hdr[3] = (u32) (ktime & 0xffffffff);
 
 	if (panic) {
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
-- 
2.35.0.rc2.247.g8bbb082509-goog

