Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF24A0231
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351335AbiA1Ukf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344412AbiA1Ujy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643402394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cvfn0bVpP3Fi5CVaGokDyVZniSa+9b2/16mV0usiezg=;
        b=Cl7laL25EoRXtcUrIuu+mm2Cjra5JeIbawhFsaOhPALcNuk8R0AUQBXVWH03mFT4tNmmMQ
        UY0OWSrrplOICPZskKkdlUz0TrQrQHw3UiW/PK1QE0MH05RQymKoQnAuM4fgFs8huMhWqM
        nfwOzWnTTr1QelAuaUASYb3gyffpXNs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-LmsYUS-vNhi_-urxx4ekxw-1; Fri, 28 Jan 2022 15:39:53 -0500
X-MC-Unique: LmsYUS-vNhi_-urxx4ekxw-1
Received: by mail-wm1-f70.google.com with SMTP id o3-20020a1ca503000000b0035056b042deso3489485wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cvfn0bVpP3Fi5CVaGokDyVZniSa+9b2/16mV0usiezg=;
        b=cpLfvHMRbuUW13cP5G4mbQOYoFhcvTDmS1x2N2BOxW7Yupy5esxV3nQAqRE7eZgyEy
         xcDvdGbJKnxPaLSWI7QejNEEipNKezXV4giV9GtZDAL98itSnpbjtftTBzXIZqnmSkM4
         //4+qgrQU1F4vZ32nAxD0Jkzq+SldaTYi5SFb5GMcCujU3RgHVcQ2jyUjzewQiHcVP9+
         iNFwohJwbk/vN6rzU3+Efv3EbCKMswekXkG4V3SnG40g1U8/QtkTZMlXL64HHoIq7oJq
         E1zkkplTbw/fN5vyGqP79iTdu+1Dk8xV03YkYmxPTJFOxdefdGG0rzxMe/nX4qX0+vTn
         3vjg==
X-Gm-Message-State: AOAM531cgE+uG300+G9NkH4JqSAeXwcJ2ITRUz3CjKfFOUmBoAF0R7NK
        ZID3KjKxjy/DQ3LzYUOBSXAQAg7L92CT8sh61/fV7obrjOATd6c8g3n1ho/MYtK3mERAqmbTpfj
        CZPLlphIlOnf1x8BbRN4RbiI=
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr17147961wmk.100.1643402392128;
        Fri, 28 Jan 2022 12:39:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwb+wzu/hLRoeXjm/y3t8LcvyRcltKIrNu92Ny5zltolnetF6p7wW8V6BSuucGgTUuwWffimQ==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr17147947wmk.100.1643402391944;
        Fri, 28 Jan 2022 12:39:51 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t5sm5619441wrw.92.2022.01.28.12.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:49 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v3 12/13] module: Move kdb_modules list out of core code
Date:   Fri, 28 Jan 2022 20:39:33 +0000
Message-Id: <20220128203934.600247-13-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128203934.600247-1-atomlin@redhat.com>
References: <20220128203934.600247-1-atomlin@redhat.com>
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
index 574cba3e0418..1f16e67f687f 100644
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
2.34.1

