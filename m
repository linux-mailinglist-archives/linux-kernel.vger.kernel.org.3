Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D881D4BF8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiBVNR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBVNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 861C37DE16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645535818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=jIMt0nUTjn9uCIibbtj6x4m7V9/xVc8xTk9mt7MPOfZA40+Ucrja/eE9zi1YaZPGVFmFMz
        8kDy3HcF8RezSD3WvUW8PxAoyuQHH+qe/J7TvrkAHAgL+8czWQQ2yxmL+G3LIndsGPRVPW
        KWBzqAWCnOYUTAjnRT7znofy5WxIizE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-ebXoms_UMaaUP1_UYASsVg-1; Tue, 22 Feb 2022 08:16:57 -0500
X-MC-Unique: ebXoms_UMaaUP1_UYASsVg-1
Received: by mail-wr1-f70.google.com with SMTP id j8-20020adfc688000000b001e3322ced69so8945666wrg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=E33c5/9LhUtz3Q/+3ODWV1vCC48Ot8zZK+NVLxWCRGRJdbhlbYJvgHVLM5mPcrizde
         DUer7jwSlZ/NCTKtemap60pDxVcqkOpNXizvZRvMWJV4ePR/6kqVS13E64CW7sXtWBPj
         YfZiyJ8QHHATrvrdFZ8c008WXAwB/lsJStX2Efaw9mpFADnNIumRoMycxfu0tElEGslj
         snyN54RR3vpJLPR0J8ipGVVL+0yQrTiPIplIz7p2ccHNRrJOtf2mfcbTAc6u0mr5foz+
         PbYeSWjqlyBZaxMNffNBirYesibPtiAwRCM4gSyA7scE+O0dEur5EvN7ckWszjX6OJDr
         INRg==
X-Gm-Message-State: AOAM530WP2iQ1OS4y67WnOtPk7C3XKYmK1ffbaAyNH9p43S+kD+qi13x
        Tw1td+o5BFTSLayzOB3rHdNMLGQrPw+rfER4peamusds3CG+oPGS83AvNhAmEknWxXRHnUb3te7
        7rW5In8ncVT0J9IrkV6zlOb0=
X-Received: by 2002:a7b:c74e:0:b0:37b:9785:fbe5 with SMTP id w14-20020a7bc74e000000b0037b9785fbe5mr3295549wmk.54.1645535816658;
        Tue, 22 Feb 2022 05:16:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPe/RBLGHCG5LhYm5QVzuvAesPgVKQvj5ua3K+B3a7c2SCNK9DQkgQxpJ6QFWyakZXMp4q5Q==
X-Received: by 2002:a7b:c74e:0:b0:37b:9785:fbe5 with SMTP id w14-20020a7bc74e000000b0037b9785fbe5mr3295523wmk.54.1645535816451;
        Tue, 22 Feb 2022 05:16:56 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm3079698wmq.6.2022.02.22.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:16:56 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v7 12/13] module: Move kdb_modules list out of core code
Date:   Tue, 22 Feb 2022 13:16:54 +0000
Message-Id: <20220222131655.1352953-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222130911.1348513-1-atomlin@redhat.com>
References: <20220222130911.1348513-1-atomlin@redhat.com>
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

