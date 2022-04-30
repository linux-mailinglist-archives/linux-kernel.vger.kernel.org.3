Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDC515F77
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiD3ROZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243340AbiD3ROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:14:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AAEFD1E;
        Sat, 30 Apr 2022 10:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60DF5B8077F;
        Sat, 30 Apr 2022 17:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B57C385AA;
        Sat, 30 Apr 2022 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651338651;
        bh=+7jXUBzEVdqXeKK0kRGylvrQWUjmQVZ+Zn0af0572r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVpIF9zgxN+mEB1kPhL20QKtJOhUYkRQXxspTz+YCJo/Visor8+j9kSGZBHe5n5lC
         SFb3ov6YLrToFcPP6+5ehM6JsPZlDeeNuMreJUsbQhysuuOeH6Q2E2ZR/onoOID7Dd
         NpCvM9cJvqH8tcUF7v7CFccdyelfl4XXSugyuZ7u7FUfCZlT5Lq0dtvoL5PIfC9Prx
         0pEy6P9aujZUU3Sp7Zu8YvliLi5Pa8cfQKWGbKE4h4toHtw/Xu5J/RSSdeSo4mX0Z6
         +67KNMfJzrTEhb95OH3MuM0dxwiIkg9Zi+I+qlucsbWBwkcpzfJ3+MDCFkAuDG2hb1
         oGjdwBvvwf/TA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nkqcJ-001tIJ-CM; Sat, 30 Apr 2022 18:10:47 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Kai Vehmanen" <kai.vehmanen@intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@intel.com>,
        "Takashi Iwai" <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mauro.chehab@linux.intel.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 1/2] module: update dependencies at try_module_get()
Date:   Sat, 30 Apr 2022 18:10:45 +0100
Message-Id: <6121371a6f701e1c03a5363bf4738bd446324c05.1651338466.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651338466.git.mchehab@kernel.org>
References: <cover.1651338466.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, device drivers are bound into each other via try_module_get(),
making such references invisible when looking at /proc/modules or lsmod.

Add a function to allow setting up module references for such
cases, and call it when try_module_get() is used.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v4 0/2] at: https://lore.kernel.org/all/cover.1651338466.git.mchehab@kernel.org/

 include/linux/module.h |  8 +++++---
 kernel/module/main.c   | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 46d4d5f2516e..3b67720faf3b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -620,12 +620,12 @@ extern void __module_get(struct module *module);
 
 /* This is the Right Way to get a module: if it fails, it's being removed,
  * so pretend it's not there. */
-extern bool try_module_get(struct module *module);
+extern bool __try_module_get(struct module *module, struct module *this);
 
 extern void module_put(struct module *module);
 
 #else /*!CONFIG_MODULE_UNLOAD*/
-static inline bool try_module_get(struct module *module)
+static inline bool __try_module_get(struct module *module, struct module *this)
 {
 	return !module || module_is_live(module);
 }
@@ -740,7 +740,7 @@ static inline void __module_get(struct module *module)
 {
 }
 
-static inline bool try_module_get(struct module *module)
+static inline bool __try_module_get(struct module *module, struct module *this)
 {
 	return true;
 }
@@ -875,6 +875,8 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+#define try_module_get(mod) __try_module_get(mod, THIS_MODULE)
+
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 05a42d8fcd7a..d63ebf52392b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -631,6 +631,33 @@ static int ref_module(struct module *a, struct module *b)
 	return 0;
 }
 
+static int ref_module_dependency(struct module *mod, struct module *this)
+{
+	int ret;
+
+	if (!this || !this->name)
+		return -EINVAL;
+
+	if (mod == this)
+		return 0;
+
+	mutex_lock(&module_mutex);
+
+	ret = ref_module(this, mod);
+
+#ifdef CONFIG_MODULE_UNLOAD
+	if (ret)
+		goto ret;
+
+	ret = sysfs_create_link(mod->holders_dir,
+				&this->mkobj.kobj, this->name);
+#endif
+
+ret:
+	mutex_unlock(&module_mutex);
+	return ret;
+}
+
 /* Clear the unload stuff of the module. */
 static void module_unload_free(struct module *mod)
 {
@@ -841,7 +868,7 @@ void __module_get(struct module *module)
 }
 EXPORT_SYMBOL(__module_get);
 
-bool try_module_get(struct module *module)
+bool __try_module_get(struct module *module, struct module *this)
 {
 	bool ret = true;
 
@@ -856,9 +883,11 @@ bool try_module_get(struct module *module)
 
 		preempt_enable();
 	}
+	if (ret)
+		ref_module_dependency(module, this);
 	return ret;
 }
-EXPORT_SYMBOL(try_module_get);
+EXPORT_SYMBOL(__try_module_get);
 
 void module_put(struct module *module)
 {
-- 
2.35.1

