Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35D44A3A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356760AbiA3Vdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356636AbiA3Vcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643578355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WWouBNY6XHsJho+NkhowbAagBN3wD6Bcpj36xe5bwk=;
        b=iNbKc9aDbpu/cDmHdtvNCtV4oWZG/nt128Qw9G9qSjnDUQ7GuuB4/Abb84z2Z7UBmbPa9g
        nXdH5FOzcAnA5t3ZtQZ5m+2C2QAlMQVCIeAMD4i1MB25BaQ3airH99WpEdtVhNWGScdZ+Q
        O9g4Oqj2o2kEK5gWnzp0r517S0NVhQ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-7IYZ8pORMzuiG9vTWAYc2g-1; Sun, 30 Jan 2022 16:32:34 -0500
X-MC-Unique: 7IYZ8pORMzuiG9vTWAYc2g-1
Received: by mail-wm1-f71.google.com with SMTP id n22-20020a05600c3b9600b00352d3f6a850so442138wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WWouBNY6XHsJho+NkhowbAagBN3wD6Bcpj36xe5bwk=;
        b=lhz49+F9yu88sXEs4DZPkODnMGM3uKm+UyCsDk5YcKUiLk/HurWgGHD+07NXyNQcBV
         kVdPnJQ53Ku2tPgqUzlL3M3gbdF8K5WwBtfk/L1fQHbBkSBS1rsSWpo29l+1HfAToetO
         a3zpKO2o6rDY7j3FLJbHRvrIx8P6IJvr6pgnEoDAbgg155A56Fm4UbYr/65yl2ja6BbZ
         MJ723U06P+RzitbexYcb+eoij9QiAL9vuHLwdIW27B8W23/insDHcePb5Q35z1lI8TyX
         T0/+SBQgiKiNTjANp0fCEp+TJCr1pOpdSkzjeO9orRyzVCATCqLEs1btGmADaw9+FB9u
         sUyw==
X-Gm-Message-State: AOAM533HX+wXT9F38rsxgCfYkWVlpjloUfdF6tWNCWz/diT7hEZBUTOw
        KSE6++o/XbuD5z3NTJ2frN6vfJtJbJNgTfZr1rg6w0eSx/4q1j07bu1Pw/alM0LK20dE+0Sds/j
        1+tF+wI6Q+28unwpRmD59zTc=
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr15258951wrz.54.1643578353045;
        Sun, 30 Jan 2022 13:32:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxnioIPHbSlQTlSmnwMfQCG2ZAC/+LiIaUTTnbob+kakVGHe+nULEei/uHEJHjOGr8GoH4Vw==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr15258935wrz.54.1643578352896;
        Sun, 30 Jan 2022 13:32:32 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o3sm10006613wrq.70.2022.01.30.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:32:32 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: [RFC PATCH v4 12/13] module: Move kdb_modules list out of core code
Date:   Sun, 30 Jan 2022 21:32:13 +0000
Message-Id: <20220130213214.1042497-13-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130213214.1042497-1-atomlin@redhat.com>
References: <20220130213214.1042497-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates kdb_modules list to core kdb code
since the list of added/or loaded modules is no longer
private.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/debug/kdb/kdb_main.c | 5 +++++
 kernel/module/main.c        | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 0852a537dad4..f101f5f078f4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
 int kdb_grep_leading;
 int kdb_grep_trailing;
 
+#ifdef CONFIG_MODULES
+extern struct list_head modules;
+struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
+#endif /* CONFIG_MODULES */
+
 /*
  * Kernel debugger state flags
  */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1d16faea82b3..59e1c271812c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -104,10 +104,6 @@ static void mod_update_bounds(struct module *mod)
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

