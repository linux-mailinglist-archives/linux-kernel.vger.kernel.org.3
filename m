Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC94EA1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345718AbiC1Uus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346399AbiC1Usg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:48:36 -0400
Received: from stuerz.xyz (unknown [45.77.206.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1CDEBD;
        Mon, 28 Mar 2022 13:46:49 -0700 (PDT)
Received: by stuerz.xyz (Postfix, from userid 114)
        id B7348FB5E4; Mon, 28 Mar 2022 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stuerz.xyz; s=mail;
        t=1648500408; bh=5t9XKqDfb1pVMMfFmkQUBKRx7TGbB+L68FzAskNSgbw=;
        h=From:To:Cc:Subject:Date:From;
        b=aaNkupoizOKf82Kgx7o2zWfINV0bXNmZpP4vp5oog25xHEj7aTg/LOOm/GZGcOOnv
         mXauQplxQvI4GGuM0Kow5URxqRzNhKxqhBD1DR6zrzjJw2/0rvzQG0fky9lFX9Nsse
         PQHtpLrDQKlQeRS0JM6MVbbqXo0ZroCWqDNjuBN+m0+ZqpXKKzmykRwY5jif/Gxrr6
         GuXeQjN6+Bg+JBjeYVGDFSg0jUkg41y80qtPTdahPrc7+xmVV+a4ja2ZwI29nT4qt1
         TEWT+QHJhwQqTb757+8V9zmdfVz69xxTY9AbAEvKUOH8F+uU1rV9m/RizC+W6iF74+
         GVF/Yb0G+8dlg==
Received: from benni-fedora.. (unknown [IPv6:2a02:8109:a100:1a48:ff0:ef2f:d4da:17d8])
        by stuerz.xyz (Postfix) with ESMTPSA id 6082DFB404;
        Mon, 28 Mar 2022 20:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stuerz.xyz; s=mail;
        t=1648500406; bh=5t9XKqDfb1pVMMfFmkQUBKRx7TGbB+L68FzAskNSgbw=;
        h=From:To:Cc:Subject:Date:From;
        b=GkG5TgSFSGAQh7MfaSjiP7EiXN1Tl7OzcnYkBoU3sMnkLvQ70mSl5DahbFhYoo4T0
         VPAKLjEbapZ69QpIQb4tnCCcWTqKRda2bCq8L5hp211uYXIqeHcoM2MvNCp/DpQpNg
         WXnU8qhv10gstCGoE5y6qWDHPUc8OEzGzl9Qxxc16DZaHo6+fFDOo7lu9gHPkM+Pwv
         bEzyc9xgZw6rpLUwxvdhTRpjYrD5MVB9gtwVyPdijBEWWm0NMpKBMrPMGkBXA+rvdJ
         8jQzPAFxB6/6OWtg7KHl6ihzZa7o5DUQB9TUUYZFO/NdsSbKoSokwegd3NrarkgrhA
         vh3BUIT28kP3g==
From:   =?UTF-8?q?Benjamin=20St=C3=BCrz?= <benni@stuerz.xyz>
To:     linux@simtec.co.uk
Cc:     krzk@kernel.org, alim.akhtar@samsung.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Benjamin=20St=C3=BCrz?= <benni@stuerz.xyz>
Subject: [PATCH v2] s3c: Improve readability of bast_pc104_irqmask[]
Date:   Mon, 28 Mar 2022 22:46:38 +0200
Message-Id: <20220328204638.273157-1-benni@stuerz.xyz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace comments in bast_pc104_irqmask[] with C99's designated
initializers because it makes the code cleaner and easier to read.

Signed-off-by: Benjamin Stürz <benni@stuerz.xyz>
---
 arch/arm/mach-s3c/bast-irq.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-s3c/bast-irq.c b/arch/arm/mach-s3c/bast-irq.c
index d299f124e6dc..618b51db3eef 100644
--- a/arch/arm/mach-s3c/bast-irq.c
+++ b/arch/arm/mach-s3c/bast-irq.c
@@ -28,23 +28,11 @@
 /* table of ISA irq nos to the relevant mask... zero means
  * the irq is not implemented
 */
-static const unsigned char bast_pc104_irqmasks[] = {
-	0,   /* 0 */
-	0,   /* 1 */
-	0,   /* 2 */
-	1,   /* 3 */
-	0,   /* 4 */
-	2,   /* 5 */
-	0,   /* 6 */
-	4,   /* 7 */
-	0,   /* 8 */
-	0,   /* 9 */
-	8,   /* 10 */
-	0,   /* 11 */
-	0,   /* 12 */
-	0,   /* 13 */
-	0,   /* 14 */
-	0,   /* 15 */
+static const unsigned char bast_pc104_irqmasks[16] = {
+	[3]  = 1,
+	[5]  = 2,
+	[7]  = 4,
+	[10] = 8,
 };
 
 static const unsigned char bast_pc104_irqs[] = { 3, 5, 7, 10 };
-- 
2.35.1

