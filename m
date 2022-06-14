Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A440E54ACE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352640AbiFNJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbiFNJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:05:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D353DDE6;
        Tue, 14 Jun 2022 02:05:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C1DD01F94B;
        Tue, 14 Jun 2022 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655197541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xe6GvvsoQamREKSFfsgIANQWYjRr6/747QxLbv2QSJo=;
        b=aXu3B88ylDNDHoEvkGwIY2Jm9hwwQvV6l9t4H4+6pXmRJLWiQ2tumFZ3W9aNEXS1qKN18A
        ayw5g1SrjaPS543gFuEwQxYrfPNHqQHXk2pUKZzNz/YyRud+Jax9gbRt7p/tAd5YoLifTb
        bs3J5kOux9vCk++sdfltl54ErA/nsJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655197541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xe6GvvsoQamREKSFfsgIANQWYjRr6/747QxLbv2QSJo=;
        b=N2y7uQUlK6S0Mfwd+9E4LSIU2Zs+EF9Me0FeBW7KkG7EBZCR8GEzl99eAZW7bJu7WnA/AS
        YtvpLI/B6K64w3CQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97A302C141;
        Tue, 14 Jun 2022 09:05:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 6/8] tty/vt: consolemap: improve UNI_*() macros definitions
Date:   Tue, 14 Jun 2022 11:05:35 +0200
Message-Id: <20220614090537.15557-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614090537.15557-1-jslaby@suse.cz>
References: <20220614075713.32767-1-jslaby@suse.cz>
 <20220614090537.15557-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use FIELD_GET() and GENMASK() helpers instead of direct shifts and ANDs.
This makes the code even more obvious. I didn't know about the helpers
at the time of writing the macros.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 16d0d8f04f0e..9e94ec0e0f83 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -23,6 +23,8 @@
  * stack overflow.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/kd.h>
 #include <linux/errno.h>
@@ -190,10 +192,17 @@ static enum translation_map inv_translate[MAX_NR_CONSOLES];
 #define UNI_DIR_ROWS	32U
 #define UNI_ROW_GLYPHS	64U
 
-#define UNI_DIR(uni)		( (uni)                   >> 11)
-#define UNI_ROW(uni)		(((uni) & GENMASK(10, 6)) >>  6)
-#define UNI_GLYPH(uni)		( (uni) & GENMASK( 5, 0))
-#define UNI(dir, row, glyph)	(((dir) << 11) | ((row) << 6) | (glyph))
+#define UNI_DIR_BITS		GENMASK(15, 11)
+#define UNI_ROW_BITS		GENMASK(10,  6)
+#define UNI_GLYPH_BITS		GENMASK( 5,  0)
+
+#define UNI_DIR(uni)		FIELD_GET(UNI_DIR_BITS, (uni))
+#define UNI_ROW(uni)		FIELD_GET(UNI_ROW_BITS, (uni))
+#define UNI_GLYPH(uni)		FIELD_GET(UNI_GLYPH_BITS, (uni))
+
+#define UNI(dir, row, glyph)	(FIELD_PREP(UNI_DIR_BITS, (dir)) | \
+				 FIELD_PREP(UNI_ROW_BITS, (row)) | \
+				 FIELD_PREP(UNI_GLYPH_BITS, (glyph)))
 
 /**
  * struct uni_pagedict -- unicode directory
-- 
2.36.1

