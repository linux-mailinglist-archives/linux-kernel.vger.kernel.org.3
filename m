Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFA520240
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiEIQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiEIQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:27:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C12689D7;
        Mon,  9 May 2022 09:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D5F61452;
        Mon,  9 May 2022 16:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18849C385B4;
        Mon,  9 May 2022 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652113423;
        bh=SrbmG/FGRx9mnqf8kRpRVHkNIYGrA6qPuY6/5C7xAUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmChdpm2bT+XTKXg+8kYfVM7LxKIWNgM4goPhOfYiYSWw4CiCCo2E/MZSIQFuRSfh
         MIJoAEQmQdM2C3B3XarTl3M2BrWjFAo1to6WoXpiKTeUm5CgMeaqmweC6dk/1W3xHF
         4OZhPQgZZbi6qjPoGvMAgSqkYAnXTM/BKu2rnAyq4/xF2gPYwRNvBzIORdgziRBDHl
         lnpFNKHt3j+6Oym4NFljcYgzzoRcf6vN/YIefNU3j1gdpKsfB9HZJ4LHrtJv9Tvoss
         SeOcaH/Q3laiieFCuc7k8KOhnGXys7N6Yfuuh0DO1cbB45acuDBzlDKuLGjZPUWLpj
         xXIWzCeTRfdCg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1no6Ae-006xVS-Hw; Mon, 09 May 2022 18:23:40 +0200
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
Subject: [PATCH v6 2/4] module: update dependencies at try_module_get()
Date:   Mon,  9 May 2022 18:23:37 +0200
Message-Id: <28a942f860ccdee05751dcccc74b70e9d64f2b94.1652113087.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1652113087.git.mchehab@kernel.org>
References: <cover.1652113087.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

See [PATCH v6 0/4] at: https://lore.kernel.org/all/cover.1652113087.git.mchehab@kernel.org/

 include/linux/module.h |  8 +++--
 kernel/module/main.c   | 73 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 77961f5773b6..a66b9be92ef5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -618,12 +618,12 @@ extern void __module_get(struct module *module);
 
 /* This is the Right Way to get a module: if it fails, it's being removed,
  * so pretend it's not there. */
-extern bool try_module_get(struct module *module);
+extern bool try_module_get_owner(struct module *module, struct module *this);
 
 extern void module_put(struct module *module);
 
 #else /*!CONFIG_MODULE_UNLOAD*/
-static inline bool try_module_get(struct module *module)
+static inline bool try_module_get_owner(struct module *module, struct module *this)
 {
 	return !module || module_is_live(module);
 }
@@ -752,7 +752,7 @@ static inline void __module_get(struct module *module)
 {
 }
 
-static inline bool try_module_get(struct module *module)
+static inline bool try_module_get_owner(struct module *module, struct module *this)
 {
 	return true;
 }
@@ -893,6 +893,8 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+#define try_module_get(mod) try_module_get_owner(mod, THIS_MODULE)
+
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index fe44d46c378b..6044aeba0f18 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -139,6 +139,24 @@ int unregister_module_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
+static bool __try_module_get(struct module *module)
+{
+	bool ret = true;
+
+	if (module) {
+		preempt_disable();
+		/* Note: here, we can fail to get a reference */
+		if (likely(module_is_live(module) &&
+			   atomic_inc_not_zero(&module->refcnt) != 0))
+			trace_module_get(module, _RET_IP_);
+		else
+			ret = false;
+
+		preempt_enable();
+	}
+	return ret;
+}
+
 /*
  * We require a truly strong try_module_get(): 0 means success.
  * Otherwise an error is returned due to ongoing or failed
@@ -149,7 +167,7 @@ static inline int strong_try_module_get(struct module *mod)
 	BUG_ON(mod && mod->state == MODULE_STATE_UNFORMED);
 	if (mod && mod->state == MODULE_STATE_COMING)
 		return -EBUSY;
-	if (try_module_get(mod))
+	if (__try_module_get(mod))
 		return 0;
 	else
 		return -ENOENT;
@@ -620,6 +638,41 @@ static int ref_module(struct module *a, struct module *b)
 	return 0;
 }
 
+static int ref_module_dependency(struct module *mod, struct module *this)
+{
+	int ret = 0;
+
+	if (!this || !mod || !this->name || !mod->holders_dir)
+		return -EINVAL;
+
+	if (mod == this)
+		return 0;
+
+	mutex_lock(&module_mutex);
+
+	if (already_uses(this, mod))
+		goto ret;
+
+	ret = strong_try_module_get(mod);
+	if (ret)
+		goto ret;
+
+	ret = add_module_usage(this, mod);
+	if (ret) {
+		module_put(mod);
+		goto ret;
+	}
+
+#ifdef CONFIG_MODULE_UNLOAD
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
@@ -830,24 +883,16 @@ void __module_get(struct module *module)
 }
 EXPORT_SYMBOL(__module_get);
 
-bool try_module_get(struct module *module)
+bool try_module_get_owner(struct module *module, struct module *this)
 {
-	bool ret = true;
+	int ret = __try_module_get(module);
 
-	if (module) {
-		preempt_disable();
-		/* Note: here, we can fail to get a reference */
-		if (likely(module_is_live(module) &&
-			   atomic_inc_not_zero(&module->refcnt) != 0))
-			trace_module_get(module, _RET_IP_);
-		else
-			ret = false;
+	if (ret)
+		ref_module_dependency(module, this);
 
-		preempt_enable();
-	}
 	return ret;
 }
-EXPORT_SYMBOL(try_module_get);
+EXPORT_SYMBOL(try_module_get_owner);
 
 void module_put(struct module *module)
 {
-- 
2.35.3

