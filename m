Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077A753FC64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiFGKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142D92733;
        Tue,  7 Jun 2022 03:49:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C956221AE4;
        Tue,  7 Jun 2022 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ikkBKC1KqNjVSYGH4msAtxXZ42KrWWeGQjeVqqAJZ3w=;
        b=ny7dsd0GhKQHInyo7aIJPf85+8bsmwgrBA0y0F6lnveKOGHVgG80AZbpPMVZ3RI+FTOQpg
        UYMcbItPTEv1+9C1Y2ObAWHQYq6u5xEmk27KBDz+CjGytfrodzEZLozyknwtNq4LN4YEwe
        1guFnOEgXfgV53AeoUApZPiklfjfF9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ikkBKC1KqNjVSYGH4msAtxXZ42KrWWeGQjeVqqAJZ3w=;
        b=oJ8bWNBPeLhBNXo0PP4ehaysRdZzgb7JU5AfvUlaIcwaL7I8ayeFSavKgrLpEG0OG8jFbg
        LCh0MwUqYKb9ZPDg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0DC12C141;
        Tue,  7 Jun 2022 10:49:49 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/36] tty/vt: consolemap: use ARRAY_SIZE()
Date:   Tue,  7 Jun 2022 12:49:11 +0200
Message-Id: <20220607104946.18710-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
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

The code uses constants as bounds in loops. Use ARRAY_SIZE() with
appropriate parameters instead. This makes the loop bounds obvious.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index d815ac98b39e..839d75d1a6c0 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -408,7 +408,7 @@ static void con_release_unimap(struct uni_pagedir *p)
 		}
 		p->uni_pgdir[i] = NULL;
 	}
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < ARRAY_SIZE(p->inverse_translations); i++) {
 		kfree(p->inverse_translations[i]);
 		p->inverse_translations[i] = NULL;
 	}
@@ -798,7 +798,7 @@ u32 conv_8bit_to_uni(unsigned char c)
 int conv_uni_to_8bit(u32 uni)
 {
 	int c;
-	for (c = 0; c < 0x100; c++)
+	for (c = 0; c < ARRAY_SIZE(translations[USER_MAP]); c++)
 		if (translations[USER_MAP][c] == uni ||
 		   (translations[USER_MAP][c] == (c | 0xf000) && uni == c))
 			return c;
-- 
2.36.1

