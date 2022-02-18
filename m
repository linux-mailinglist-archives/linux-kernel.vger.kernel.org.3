Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4954BC1FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiBRV2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:28:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiBRV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DE3D25C9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645219682;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=c/yVCyyvgFIiMBVk33HSBwVSCvK3NgtE6QCRf03gB6u7D2YwesAeT+KWwXRS0pwZmXocr+
        Vup806hZYzwkH2QTIC13Mb4c51DOl3ZJ4dsOOSWSZ+PZWmkcydT7IjXp2yBjWQk9xobCDm
        rfPIT8MoZjPr55FIf7j5NQcnO76rsoc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-IPg2z-pwOOeS-NGgYmy3tw-1; Fri, 18 Feb 2022 16:28:00 -0500
X-MC-Unique: IPg2z-pwOOeS-NGgYmy3tw-1
Received: by mail-wr1-f69.google.com with SMTP id g11-20020adfa48b000000b001e57dfb3c38so4066122wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=i103PSP092uwH2wOfbrJepw6+2qfz41xvp5h85cEBaI=;
        b=YuYkG7Ln1rpCb74ipIgitiphv8OQHd01i9olbNGyJw5pf2vuL3QO6Zfa4dOLIxmXf+
         CM7Lg/9shW3+5pZj8Pc3/kqyIggK2L/gkRwgDMf/1abeOr4G8MF75km0Nr9LPAu5V4FB
         uItGIoff4Jjenyt9RqmPZCUlSYlFkNne7/0NY49Walh4O5oe+RzZu+IZ2C2aOV1+jyH+
         AOlvXjge4VmfbTY4EGtZaWQTYZzYbHliwyrFLWrAo6cjc1ku8j3w4iNTSmCNsOjWBgm/
         YlKiQJzFId9Kz/q5zXP+wfLD+MDo4NjmKbtFYsiyY5mr4EpC+w9owg8OhERt88E9K75l
         VP0g==
X-Gm-Message-State: AOAM531nU2ERX/tam6H9C2z7XyBT/4lyjEJ+Lw+wKWdsbtdpztIca4WE
        1bdXlHQjUbcctuWUSHMAxO4wdhCQwq6DXFto7UbxpH1VN1p3uz8KsQgolPmD4LHGMMa/TCzDpep
        099aeRntG5rGJ7Rrzs/Up6Ko=
X-Received: by 2002:a5d:42ca:0:b0:1e6:2bf3:5c17 with SMTP id t10-20020a5d42ca000000b001e62bf35c17mr7211446wrr.621.1645219679642;
        Fri, 18 Feb 2022 13:27:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1kQCXheCttOPr4VlHl8ikfLjVEDe3AgMfyXnn/We3HoFXcmKWckq7+cg7ZrEuKXuy3vLyKA==
X-Received: by 2002:a5d:42ca:0:b0:1e6:2bf3:5c17 with SMTP id t10-20020a5d42ca000000b001e62bf35c17mr7211430wrr.621.1645219679418;
        Fri, 18 Feb 2022 13:27:59 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u15sm43544342wrn.48.2022.02.18.13.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:27:59 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, joe@perches.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v6 12/13] module: Move kdb_modules list out of core code
Date:   Fri, 18 Feb 2022 21:27:56 +0000
Message-Id: <20220218212757.888751-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218212757.888751-1-atomlin@redhat.com>
References: <20220218212757.888751-1-atomlin@redhat.com>
Reply-To: 20220218212511.887059-11-atomlin@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

