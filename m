Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7341B4BFA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiBVOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiBVONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DF0A113AED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=Wu+OIWlBDb91q2o70FdlWukJDhHahL0lbiZPukv+F1kr3bwzEGVDHhdCt8IujntWAunroR
        W0Gqv3QckTOc/W9a/6K4s7QCYXzTeuwCcGRVvWUDEKKCXBTidbtisMNNUC2fu30tg6qtLa
        yQLcf5agvJDrZmqCXdBsn08O0dKCrIk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-eT2wwWT1NCe8c_n4wQOmxg-1; Tue, 22 Feb 2022 09:13:21 -0500
X-MC-Unique: eT2wwWT1NCe8c_n4wQOmxg-1
Received: by mail-wr1-f70.google.com with SMTP id w26-20020adf8bda000000b001e33dbc525cso8943614wra.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=CMY9ldBw57PI6kFEcn4PShNWkm/U8OgcungWleKhybX5lLSWRIKkDfJotrB1nleyBr
         YkZ+Oj3q/XFuNbZZ2YQuR73W9o5TKT9Ae0BlwjAhdAHxExHF4hQ06mqEzK12hBz0NRj5
         Tx8gaHz2J/HpCLbjdanzF3qPXbhUpZ2wdkpE4gxDm57dVTPz/8HERPuLnrH2DuwqMcz+
         B6C4Ho9w8bzM2Z+irXWkyf+KLeaPxN7PPn0N/S4i7kTig0FFkHnRw7F9tzOVT5sEHIrD
         1sWva2sBeFuvKvN7RlR4nyTS04D7QZxQwebLO6AkTz+UqTHTD9aPiU9w2vzGsuvMjOZG
         EQCQ==
X-Gm-Message-State: AOAM530ByI42hkEBuGkvSOElWWix0I+jVYyfmCnr8+fYS8hbKZ10mucU
        Fc1ZxNfq73LWRldz+8jVgdZw134b/zXnMMuCEpfdNMQlMjvp2l2rpDQim49SbZo8nbytjentF12
        ZC0unmhBUvY0QmpKhO3B3A1c=
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr3483016wmk.58.1645539200133;
        Tue, 22 Feb 2022 06:13:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6YxDMv4TmmFlo2qDNI4ZTeMejQdZ8kRAII4z7tr97kukxRE6wN6LPuNR5BkNnmKSASfAGrA==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr3482990wmk.58.1645539199918;
        Tue, 22 Feb 2022 06:13:19 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 20sm2467724wmk.26.2022.02.22.06.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:19 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 12/13] module: Move kdb_modules list out of core code
Date:   Tue, 22 Feb 2022 14:13:02 +0000
Message-Id: <20220222141303.1392190-13-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates kdb_modules list to core kdb code
since the list of added/or loaded modules is no longer
private.

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

