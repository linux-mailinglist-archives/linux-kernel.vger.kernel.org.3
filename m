Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1807553FC57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbiFGKwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242295AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60646F5D06;
        Tue,  7 Jun 2022 03:49:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D2F1C21B6C;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhaROz4RHhk/yptANg5YPRJmKprOMgDVGW4kW0s9DEc=;
        b=26bRXK2ozdO6V9sAacxXt9ZmQbSZ1x7bOgwYempK8rVfqNXxI+32WZHSxa66Leivangym1
        doDRjXnUGMH/kgN9hdyVmVqFFxpA/3LekY5uM/ItR86+kr9PtpBAeQAnw1sGrZ4Qin+aeK
        LJvSBi+xHa0nOC7nghlZgwmHXv/VF7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhaROz4RHhk/yptANg5YPRJmKprOMgDVGW4kW0s9DEc=;
        b=m4sWezWZbbPZ34wgw/8unHE4ztoxCRZsee/dvTzxfEEZpKVk7iq9rKK3ZA7n5rjFLe4ib9
        C3eRKS+LSXqpA9Dw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AAD992C141;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/36] tty/vt: consolemap: convert macros to static inlines
Date:   Tue,  7 Jun 2022 12:49:16 +0200
Message-Id: <20220607104946.18710-6-jslaby@suse.cz>
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

This commit changes !CONFIG_CONSOLE_TRANSLATIONS definitions to real
(inline) functions. So the commit:
* makes type checking much stronger,
* removes the need of many parentheses and casts, and
* makes the code more readable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/consolemap.h | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index abc28e4450bf..98171dbed51f 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -14,9 +14,9 @@
 
 #include <linux/types.h>
 
-#ifdef CONFIG_CONSOLE_TRANSLATIONS
 struct vc_data;
 
+#ifdef CONFIG_CONSOLE_TRANSLATIONS
 u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode);
 unsigned short *set_translate(int m, struct vc_data *vc);
 int conv_uni_to_pc(struct vc_data *conp, long ucs);
@@ -24,12 +24,33 @@ u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 #else
-#define inverse_translate(conp, glyph, uni) ((uint16_t)glyph)
-#define set_translate(m, vc) ((unsigned short *)NULL)
-#define conv_uni_to_pc(conp, ucs) ((int) (ucs > 0xff ? -1: ucs))
-#define conv_8bit_to_uni(c) ((uint32_t)(c))
-#define conv_uni_to_8bit(c) ((int) ((c) & 0xff))
-#define console_map_init(c) do { ; } while (0)
+static inline u16 inverse_translate(const struct vc_data *conp, int glyph,
+		int use_unicode)
+{
+	return glyph;
+}
+
+static inline unsigned short *set_translate(int m, struct vc_data *vc)
+{
+	return NULL;
+}
+
+static inline int conv_uni_to_pc(struct vc_data *conp, long ucs)
+{
+	return ucs > 0xff ? -1 : ucs;
+}
+
+static inline u32 conv_8bit_to_uni(unsigned char c)
+{
+	return c;
+}
+
+static inline int conv_uni_to_8bit(u32 uni)
+{
+	return uni & 0xff;
+}
+
+static inline void console_map_init(void) { }
 #endif /* CONFIG_CONSOLE_TRANSLATIONS */
 
 #endif /* __LINUX_CONSOLEMAP_H__ */
-- 
2.36.1

