Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B151603D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiD3UIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244872AbiD3UI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 16:08:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A06441;
        Sat, 30 Apr 2022 13:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A43C3B80782;
        Sat, 30 Apr 2022 20:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539C3C385AC;
        Sat, 30 Apr 2022 20:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651349102;
        bh=YBVomZl4RVo3jBNoYeM2ZLRDDCLy1BHDVUqS6Moyyd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pe8WVSH8GPHWYebmIq6mjREr9L6FXkJqdMybW8BlmtIV5WE12PcKWoACgfWgsmnyX
         K4aMUB2wvTEh2nwPur0nu0t0eqhl5pnF/8JANLhIiKmJXIOixQj5Zn4x9vjWN0wZJx
         f98c3l2MUrt9AwPhPDMNYWigR9oYsgNQHivEij0s0lA7BIEozQzsJoyHMbZgN5/Xu/
         vAF1PScNwlDJI5PUYiK2PCjEhwhjyK2Swk0WpkUTOdFZR8QJKn0Z/nDiqHUS/ak66Y
         pOeS4nSWxEgfdi5Ktdtz5qe6OB+nyzoaI/i5TMWBVNF7uAhMMTOJl+pt/lTeoAMny9
         Fn9CiMBmn3Oyw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nktKr-001uvu-NH; Sat, 30 Apr 2022 21:04:57 +0100
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
Subject: [PATCH v5 1/2] module: update dependencies at try_module_get()
Date:   Sat, 30 Apr 2022 21:04:54 +0100
Message-Id: <ad2a9fe66cf502e2e2e2325f1f04d0fae36aa82b.1651348913.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651348913.git.mchehab@kernel.org>
References: <cover.1651348913.git.mchehab@kernel.org>
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

See [PATCH v5 0/2] at: https://lore.kernel.org/all/cover.1651348913.git.mchehab@kernel.org/

 include/linux/module.h |  8 ++++--
 kernel/module/main.c   | 65 +++++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 46d4d5f2516e..3d9d38c426b4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -620,12 +620,12 @@ extern void __module_get(struct module *module);
 
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
@@ -740,7 +740,7 @@ static inline void __module_get(struct module *module)
 {
 }
 
-static inline bool try_module_get(struct module *module)
+static inline bool try_module_get_owner(struct module *module, struct module *this)
 {
 	return true;
 }
@@ -875,6 +875,8 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+#define try_module_get(mod) try_module_get_owner(mod, THIS_MODULE)
+
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 05a42d8fcd7a..218c4308bb7a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -150,6 +150,24 @@ int unregister_module_notifier(struct notifier_block *nb)
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
@@ -160,7 +178,7 @@ static inline int strong_try_module_get(struct module *mod)
 	BUG_ON(mod && mod->state == MODULE_STATE_UNFORMED);
 	if (mod && mod->state == MODULE_STATE_COMING)
 		return -EBUSY;
-	if (try_module_get(mod))
+	if (__try_module_get(mod))
 		return 0;
 	else
 		return -ENOENT;
@@ -631,6 +649,33 @@ static int ref_module(struct module *a, struct module *b)
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
@@ -841,24 +886,16 @@ void __module_get(struct module *module)
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
2.35.1

