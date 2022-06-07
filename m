Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC353FC77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiFGKyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242331AbiFGKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC501F5D3F;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48DF11F95C;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZIoMqQGGLfGogLqhRC/8PFBN/3KA8xRO38ygrUs7+M=;
        b=Q0/rPDLtSfO9LU/7mMMN9ldo4Oc70O7Qjo6i78Z9WY6gRySL4xezBJ16+DTaxsx3oamRq2
        FE5YikGgKi3LHMXE9+NQiNSh0Hh4LWXvHH5zZNd+85bINQCeZ3twPze+jBGncdzEo5JUzb
        neiBierAXkeCPv2RKSApOA9r+k4cOJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZIoMqQGGLfGogLqhRC/8PFBN/3KA8xRO38ygrUs7+M=;
        b=kscQCgXfBuRdRTtk42Lj0gwR7k6OFLBesO43ZDGYQ7HT6cHH3uIuQWPHIggMh+7MvIJfbR
        VpsskQ+CrOqhGcCA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 21CBE2C141;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 18/36] tty/vt: consolemap: remove glyph < 0 check from set_inverse_trans_unicode()
Date:   Tue,  7 Jun 2022 12:49:28 +0200
Message-Id: <20220607104946.18710-18-jslaby@suse.cz>
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

glyph is now an int casted from u16. It can never be negative. So remove
the check and type glyph as u16 properly in set_inverse_trans_unicode().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 80536687acef..733795a3dc68 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -244,7 +244,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 static void set_inverse_trans_unicode(struct vc_data *conp,
 				      struct uni_pagedict *p)
 {
-	int i, j, k, glyph;
+	int i, j, k;
 	u16 **p1, *p2;
 	u16 *q;
 
@@ -268,9 +268,8 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 			if (!p2)
 				continue;
 			for (k = 0; k < UNI_ROW_GLYPHS; k++) {
-				glyph = p2[k];
-				if (glyph >= 0 && glyph < MAX_GLYPH
-					       && q[glyph] < 32)
+				u16 glyph = p2[k];
+				if (glyph < MAX_GLYPH && q[glyph] < 32)
 					q[glyph] = UNI(i, j, k);
 			}
 		}
-- 
2.36.1

