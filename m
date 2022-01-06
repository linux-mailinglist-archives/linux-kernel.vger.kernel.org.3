Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0140486DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbiAFXn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343582AbiAFXnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1lOBRpMAGkWz55gR1tG3JnxjneKMph16mPglikuVp0=;
        b=VNuCIguEmArEU7T+doajw7X1SyKzlWLcDoqi2++wkgZV1lwIECIl5uG+0mCtMxzovCe6Jj
        z5vUCgqkVhdjx/IebEEupB2F8klw9axCa7B4edtJzQt341T6PkVSwbnNPBWDMglVHImnhh
        zOpPvZtujFiW+3XS8nzL3WdWA5XQs7U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-fOPOVs0LMy2fN9f8752kqw-1; Thu, 06 Jan 2022 18:43:36 -0500
X-MC-Unique: fOPOVs0LMy2fN9f8752kqw-1
Received: by mail-wm1-f72.google.com with SMTP id n14-20020a05600c3b8e00b0034693893555so624878wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1lOBRpMAGkWz55gR1tG3JnxjneKMph16mPglikuVp0=;
        b=FfhImXc+oir6q0/xHzgWYq+lvNmB5PuLgZrp8ZSNSF60wI53F0d+Y4g7KKsugYKIa0
         F82jq/beWXfTaT+CZ7gXTZetn7HdDPukwSY0m7GWgZ2cL4GIAO3T7c5uiAsw3pi5sp29
         ZGgJBGXgk9T6B5+bvu84DQjqHQbc8dS8qjY4H27W3+RV2uuEowEG0dUpCcKP594w/HRU
         vAWkD2godBuuCsBxH5ebH/GGM3viIF8LSjTHI1usrBAtnE9ZCAno+48W4Xeu7S0hSkvo
         t1suv5sOOUqK8pfsUU8TI4BlVZZ+TXk2cdbNEQtC0Vc1pZj+0kfEvQb6+f4wJNZbyzua
         XoHA==
X-Gm-Message-State: AOAM532cZd7Ltxj/cBYrhVjLO9UPcWWbJ0TuXYH7PkNSZ2lYayPYcqP3
        IymeslDF2RWh9N6wC2oaLM67b51RTfy9NQPO112ueZ4/QKzMXyCrXDzouNqCr9vNI93e4mC7OS4
        7NvVS0B0j9sYcD4B2kJ8jpSQ=
X-Received: by 2002:a1c:3b86:: with SMTP id i128mr8934056wma.50.1641512613952;
        Thu, 06 Jan 2022 15:43:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm34Qkm/iu5cTZq8D+bvs0YhUr+bS4xpiu0coZNklUOksu0Ub+seGzIiaUugWtOgo0PTEvuQ==
X-Received: by 2002:a1c:3b86:: with SMTP id i128mr8934043wma.50.1641512613780;
        Thu, 06 Jan 2022 15:43:33 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b16sm3289165wmq.41.2022.01.06.15.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:33 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 12/13] module: Move kdb_modules list out of core code
Date:   Thu,  6 Jan 2022 23:43:18 +0000
Message-Id: <20220106234319.2067842-13-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
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
index d8ee5647b732..ef61fb65671a 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -60,6 +60,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
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
index 354fb2697188..09012246907a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -95,10 +95,6 @@ static void mod_update_bounds(struct module *mod)
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
2.31.1

