Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDBF53FC6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbiFGKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD73F5D2E;
        Tue,  7 Jun 2022 03:49:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 738BA21B73;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dc00+v41riTVE2YjckLepBjcqVd8iCS58CfTEBLud4Y=;
        b=aPkQU7QatxA0ndTGVmWwi98BoSWSBucHDbrdPuvKI7PHtB2itPhtsLQqRcdsPYuSw95/Yr
        oRtVdhD26cmJ8/n+9GLH9ev0ZDOpYr5In3QNr4SpvKOOf53jDfZrEQyMsYjMte0irKP335
        hzpbfqQjD7efrShM8tza6M5uBkzdV/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dc00+v41riTVE2YjckLepBjcqVd8iCS58CfTEBLud4Y=;
        b=mSRdvcID3iyPhFaB8N0vRJraa2xJaq/KqjLmqV/l/V8jF7Z9SMMlnQma51Nre7z7a2DW1b
        pcq9R3WAla78p9Cw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4CCE92C141;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/36] tty/vt: consolemap: use | for binary addition
Date:   Tue,  7 Jun 2022 12:49:19 +0200
Message-Id: <20220607104946.18710-9-jslaby@suse.cz>
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

Unicode letters are composed as a bit shifts and sums of three values.
Use "|" and not "+" for these bit operations. The former is indeed more
appropriate.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index f97081e01b71..016c1a0b4290 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -265,7 +265,7 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 				glyph = p2[k];
 				if (glyph >= 0 && glyph < MAX_GLYPH
 					       && q[glyph] < 32)
-		  			q[glyph] = (i << 11) + (j << 6) + k;
+					q[glyph] = (i << 11) | (j << 6) | k;
 			}
 		}
 	}
@@ -788,7 +788,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 						continue;
 					if (ect < ct) {
 						unilist[ect].unicode =
-							(i<<11)+(j<<6)+k;
+							(i<<11) | (j<<6) | k;
 						unilist[ect].fontpos = *p2;
 					}
 					ect++;
-- 
2.36.1

