Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912F04C7EAE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiB1XpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiB1Xon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBFC7102156
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCVgx6h60KphAH4XrbUjxHa/sKqxkAwrzZ+dqhUICdc=;
        b=IZXRnQ31ge2qjk+u4WPGgjmKPA2w+vs1KnwJWSDOmJQon7MV8QoDuzhuYiVvkJJDxZirvL
        peR0U7wMwiPVFuxsdwvB59kJDSkx/I+dKxPBx/+As8uOdNtHNR+2XLnIMtGyvV4auUmrH1
        IJvFfSE/fDEpzON2ZIcqApGw57RXCG8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-l9j9CHtIO0C1VmfbaZ5Ufw-1; Mon, 28 Feb 2022 18:43:53 -0500
X-MC-Unique: l9j9CHtIO0C1VmfbaZ5Ufw-1
Received: by mail-wm1-f69.google.com with SMTP id 10-20020a1c020a000000b0037fae68fcc2so314804wmc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCVgx6h60KphAH4XrbUjxHa/sKqxkAwrzZ+dqhUICdc=;
        b=Xl4vz1Ptu8blsJ7L/6MC3+0bFFxlkqvGrzls/m25lX6JoG6zqO29SLjEQVgVmKCeCY
         lIqdPf+SbP3FkPjbt/gsXhA3BkFC8fYT3JIrcUJ7VCVgp56sTZBqH1BnbbVxmJtnt0Wm
         mMzQrjQx4TweSWkKB9DLRRRikYcvdLXXLEP+t3Y1WOHUK4umj8XIop2mXfmwth/rJpqm
         fe4QMDbxnsjDDhzShj/HnCrrVPhkubnCe/rQZ7Jt8ovMTXkBhatPNOE1Xddb1TFBlDKE
         CYQ/Q/bRle4owFTCy/KcBb6mopy+xRoFa8CLHCl7j/kqXhjsfQRrG1qlM2N+86qyO3GK
         vwHQ==
X-Gm-Message-State: AOAM530ppGIf/yxl3b+3810vxFvWXskpLn3euCnebW6qJRanXSaTJd5a
        lTkRNytLP0QZJlYOsL6/78z0lnwGiFEnXUaucaLkAxrjMyOx1b51iiT5IbLCMWgMnGSZ7z/WoiF
        5Lve8Mrmr+3wgnJkgbUr4cNc=
X-Received: by 2002:adf:efc6:0:b0:1ed:f546:bd94 with SMTP id i6-20020adfefc6000000b001edf546bd94mr16735763wrp.33.1646091832434;
        Mon, 28 Feb 2022 15:43:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvkHT2Nr5oVlCjs3WQD7yCipJPicE0ezxsN0GNl+lDKBwiQ2bhZCtnaHE/oS8Rl/COENGV8w==
X-Received: by 2002:adf:efc6:0:b0:1ed:f546:bd94 with SMTP id i6-20020adfefc6000000b001edf546bd94mr16735757wrp.33.1646091832269;
        Mon, 28 Feb 2022 15:43:52 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b001ea81265a5fsm15866904wro.99.2022.02.28.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:51 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Date:   Mon, 28 Feb 2022 23:43:21 +0000
Message-Id: <20220228234322.2073104-14-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates kdb_modules list to core kdb code
since the list of added/or loaded modules is no longer
private.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/debug/kdb/kdb_main.c    | 5 +++++
 kernel/debug/kdb/kdb_private.h | 4 ----
 kernel/module/main.c           | 4 ----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 0852a537dad4..5369bf45c5d4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
 int kdb_grep_leading;
 int kdb_grep_trailing;
 
+#ifdef CONFIG_MODULES
+extern struct list_head modules;
+static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
+#endif /* CONFIG_MODULES */
+
 /*
  * Kernel debugger state flags
  */
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 0d2f9feea0a4..1f8c519a5f81 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -226,10 +226,6 @@ extern void kdb_kbd_cleanup_state(void);
 #define kdb_kbd_cleanup_state()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
-#ifdef CONFIG_MODULES
-extern struct list_head *kdb_modules;
-#endif /* CONFIG_MODULES */
-
 extern char kdb_prompt_str[];
 
 #define	KDB_WORD_SIZE	((int)sizeof(unsigned long))
diff --git a/kernel/module/main.c b/kernel/module/main.c
index b8a59b5c3e3a..bcc4f7a82649 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -108,10 +108,6 @@ static void mod_update_bounds(struct module *mod)
 		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
 }
 
-#ifdef CONFIG_KGDB_KDB
-struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
-#endif /* CONFIG_KGDB_KDB */
-
 static void module_assert_mutex_or_preempt(void)
 {
 #ifdef CONFIG_LOCKDEP
-- 
2.34.1

