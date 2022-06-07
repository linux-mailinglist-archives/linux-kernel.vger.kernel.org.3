Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE553FC33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbiFGKvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4DC97288;
        Tue,  7 Jun 2022 03:49:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A10F81F8F6;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+LjQ5CcdTzH2HTKHZ/VYIEk2ijL3cQwy6RClzMeQBU=;
        b=ZV5EcOWXwXWhDRMGeS65xZsdseabubXKc6hCkXmWdoAgFd4rIUV35S9UZLyJiZdmBtdzp+
        EZZIJezM22WV8zzMtzPHq5FB6q8xoz/uPTfAFRBcYBQbtW5uDyMI6e/iGofeL7buzNfDeA
        sxYY1UDkUDbO3YMV88b6V4ssm4qtdwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+LjQ5CcdTzH2HTKHZ/VYIEk2ijL3cQwy6RClzMeQBU=;
        b=eGjZqa5q/j/Kzya2Ykp/CcONnO2y+/ahvg+1ow6VQTEWXztnGSlKIcXTU8aEBbNDv1lfrQ
        D9z4xsEZNBwFqBBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7849E2C146;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/36] tty/vt: consolemap: remove extern from function decls
Date:   Tue,  7 Jun 2022 12:49:15 +0200
Message-Id: <20220607104946.18710-5-jslaby@suse.cz>
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

The extern keyword is not needed for function declarations. Remove it,
so that the consolemap header conforms to other tty headers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/consolemap.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index bcfce748c9d8..abc28e4450bf 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -17,12 +17,11 @@
 #ifdef CONFIG_CONSOLE_TRANSLATIONS
 struct vc_data;
 
-extern u16 inverse_translate(const struct vc_data *conp, int glyph,
-		int use_unicode);
-extern unsigned short *set_translate(int m, struct vc_data *vc);
-extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
-extern u32 conv_8bit_to_uni(unsigned char c);
-extern int conv_uni_to_8bit(u32 uni);
+u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode);
+unsigned short *set_translate(int m, struct vc_data *vc);
+int conv_uni_to_pc(struct vc_data *conp, long ucs);
+u32 conv_8bit_to_uni(unsigned char c);
+int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 #else
 #define inverse_translate(conp, glyph, uni) ((uint16_t)glyph)
-- 
2.36.1

