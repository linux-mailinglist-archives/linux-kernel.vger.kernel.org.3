Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D69517898
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387527AbiEBUyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387507AbiEBUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 003F76586
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651524677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RrE130eSMlvd7DvNif1xecZQXGFe2pTq64QlGNfROg=;
        b=UAD49mW00URn2Cio8csmV5cC/LRQtfnHOvHcLC2n/Km2yvojA0KtFCr3P+XB9iaaYYXDcL
        4jRb2ZgodYIhBvMnI8wyblqzlJguy5SNZfLlrj+oxMuxEiiTjlZ41A8mMhRLB19t3VBbuI
        gd8jVcIL7FKPexejBDO3QsanR8X6eLs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-Uc2B5DjjOMSqoit7RFsq_w-1; Mon, 02 May 2022 16:51:16 -0400
X-MC-Unique: Uc2B5DjjOMSqoit7RFsq_w-1
Received: by mail-wm1-f69.google.com with SMTP id z23-20020a05600c221700b003942fd37764so214300wml.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RrE130eSMlvd7DvNif1xecZQXGFe2pTq64QlGNfROg=;
        b=bsX/kxXJfFg9ye5IkuJHtNXu5zNWOLpruoq983e2kpZH9tQar5fBG3QVYGm6WxIRol
         6qM1WpCWIBhnT69/69cNwng+1xz02qMd70q1oSyHs/ISpV8clkA9R8wWdUOPmI9AK4DI
         wmNgI7o+bdeLVw2EyCTZmTHL6DuzQT1MjP47QbQ92GZFR2TnN5/VecEINGBDf+1M20Ge
         iC0zfudJsEx3ZeWpndOu6hhE5sxHb8jb+bR9uqsbo+BwjKLDZ1FnhYgM20lFyrl713Dn
         i7LMPbagDisd3xpQpj7Oc6yxIfHdvoVf7qZINIzifc8YydOdYjpsLtEI2XgQH8kX/973
         ov6w==
X-Gm-Message-State: AOAM5311gf1xLk+uVPDyfRx8uzB+7ZLPsxFhq0k5KQXBv9L3vhzyesiZ
        5Mn7q2mFg/5eoOudc58/jVYEkkoUb9tCk3mwJMQPQf9qk9ZV4wV0dF5A9YQpgADUAZa2aTd3Y9Z
        XBj6YLHVogXJq2L2SwUTsoPk=
X-Received: by 2002:a05:600c:6009:b0:394:33ef:86c8 with SMTP id az9-20020a05600c600900b0039433ef86c8mr661408wmb.83.1651524673930;
        Mon, 02 May 2022 13:51:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkos8YnAEh9YSvm+XhUHPRClq8ESwoIPdhprAcYE9bzhNBVujcte0JM5awEg64V0rA4vlgxA==
X-Received: by 2002:a05:600c:6009:b0:394:33ef:86c8 with SMTP id az9-20020a05600c600900b0039433ef86c8mr661386wmb.83.1651524673646;
        Mon, 02 May 2022 13:51:13 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e23-20020adf9bd7000000b0020c5253d8ccsm8068190wrc.24.2022.05.02.13.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:51:12 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v5 2/3] module: Move module_assert_mutex_or_preempt() to internal.h
Date:   Mon,  2 May 2022 21:51:04 +0100
Message-Id: <20220502205105.919523-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220502205105.919523-1-atomlin@redhat.com>
References: <20220502205105.919523-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates module_assert_mutex_or_preempt() to internal.h.
So, the aforementiond function can be used outside of main/or core
module code yet will remain restricted for internal use only.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/internal.h | 12 ++++++++++++
 kernel/module/main.c     | 11 -----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index abbd1c5ef264..0bdf64c9dfb5 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/rculist.h>
+#include <linux/rcupdate.h>
 
 #ifndef ARCH_SHF_SMALL
 #define ARCH_SHF_SMALL 0
@@ -102,6 +103,17 @@ long module_get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
 char *module_flags(struct module *mod, char *buf);
 size_t module_flags_taint(unsigned long taints, char *buf);
 
+static inline void module_assert_mutex_or_preempt(void)
+{
+#ifdef CONFIG_LOCKDEP
+	if (unlikely(!debug_locks))
+		return;
+
+	WARN_ON_ONCE(!rcu_read_lock_sched_held() &&
+		     !lockdep_is_held(&module_mutex));
+#endif
+}
+
 static inline unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 7dbdd098b995..7a0484900320 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -118,17 +118,6 @@ static void mod_update_bounds(struct module *mod)
 #endif
 }
 
-static void module_assert_mutex_or_preempt(void)
-{
-#ifdef CONFIG_LOCKDEP
-	if (unlikely(!debug_locks))
-		return;
-
-	WARN_ON_ONCE(!rcu_read_lock_sched_held() &&
-		!lockdep_is_held(&module_mutex));
-#endif
-}
-
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
-- 
2.34.1

