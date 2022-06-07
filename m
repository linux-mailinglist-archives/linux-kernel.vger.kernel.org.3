Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E107E53FC42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbiFGKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242300AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665F97282;
        Tue,  7 Jun 2022 03:49:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E32621B65;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQcP4g9bnGcgFsA3d+Ll965iBWky1rObtxMTP+JQWbk=;
        b=Cd7RaDYE0fhQn6isCIvxDta5/LyvGtsd9BM5JzGSYoHrl/ZtwYDOz/qMtAq7eNboqJKYCJ
        ZVgmMucWAWEDgVoHJK6njOV1+O6fShFm49avBGSWq+CstDV2u38/Wvy60k9JvHlS3U77MM
        U4qd2kKvHWVbgt6tHL7YAoGDqv3qwhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQcP4g9bnGcgFsA3d+Ll965iBWky1rObtxMTP+JQWbk=;
        b=y3g4wFrnWx9oi42v7D9gmduqGDqldAhAA1e23n/XkE/Go/jK18rdrqoTZ16Kcw6lT61Vot
        Bh92cczLBAV0LxCQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 46E042C145;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/36] tty/vt: consolemap: decrypt inverse_translate()
Date:   Tue,  7 Jun 2022 12:49:14 +0200
Message-Id: <20220607104946.18710-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607104946.18710-1-jslaby@suse.cz>
References: <20220607104946.18710-1-jslaby@suse.cz>
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

Fix invalid indentation and demystify the code by removing superfluous
"else"s. The "else"s are unneeded as they always follow an "if"-true
branch containing a "return". The code is now way more readable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 15aa10ff87ad..fb61158f4dc6 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -285,25 +285,26 @@ u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode)
 {
 	struct uni_pagedict *p;
 	int m;
+
 	if (glyph < 0 || glyph >= MAX_GLYPH)
 		return 0;
-	else {
-		p = *conp->vc_uni_pagedir_loc;
-		if (!p)
+
+	p = *conp->vc_uni_pagedir_loc;
+	if (!p)
+		return glyph;
+
+	if (use_unicode) {
+		if (!p->inverse_trans_unicode)
 			return glyph;
-		else if (use_unicode) {
-			if (!p->inverse_trans_unicode)
-				return glyph;
-			else
-				return p->inverse_trans_unicode[glyph];
-			} else {
-			m = inv_translate[conp->vc_num];
-			if (!p->inverse_translations[m])
-				return glyph;
-			else
-				return p->inverse_translations[m][glyph];
-			}
+
+		return p->inverse_trans_unicode[glyph];
 	}
+
+	m = inv_translate[conp->vc_num];
+	if (!p->inverse_translations[m])
+		return glyph;
+
+	return p->inverse_translations[m][glyph];
 }
 EXPORT_SYMBOL_GPL(inverse_translate);
 
-- 
2.36.1

