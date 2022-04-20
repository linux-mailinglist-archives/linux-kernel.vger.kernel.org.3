Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD750876D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378297AbiDTLz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378272AbiDTLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5E04248E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650455585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyEpFOsVjUMPpghKZCBH2maNdoYb/HCQD9/+9CauZP8=;
        b=RwYQVmmUtwVwaTlP7CMyhz9J22zfRruBL6q7j/xJD7OH6kxzbZ6AwwJfxHagS7K+ewwOAL
        3X+CQzelY4ZGUUYlz06GwURUnl3fFe+RDYB10DnwFaGsaeGNg6WPo8H4U9BueGYvjb1Hla
        QIchotB4F6np39BMrs/yZDmBQv6Ob/k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-51GZh-IwO-WK3FW4c46ONw-1; Wed, 20 Apr 2022 07:53:04 -0400
X-MC-Unique: 51GZh-IwO-WK3FW4c46ONw-1
Received: by mail-wr1-f70.google.com with SMTP id p18-20020adf9592000000b00207bc12decbso324230wrp.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyEpFOsVjUMPpghKZCBH2maNdoYb/HCQD9/+9CauZP8=;
        b=5jvd1CcoHTvUjbxVAbViMbT1fbGQdNmWLcAAIN+iTgxIC6MOX/n2kTzibPTydcd4UX
         C4o2aq0kqonsFBPAPOugg1M7HU13LjRJYRTkeRafz7hkY8qt7YgN70TLm5+itLxdO9nr
         TrBhWCwg5urqVb7xZ8ivbo4jNDhJIY5F0awB8N2rJdWFeIo57IUaagtYYOPdPyAmgvUR
         0qGAQKCzWMwIIHrriHTGRkz4ywnlJvPfkWQX3HKVR3FHBaXjIzOiFNAJmNIk7nY00kAL
         2jO/y9naYRRcDIIUXaLnyXV/R1prKFucwQkfktSM1yfBhPKWq/BQKKoAtm6w7O8GNtEk
         RSxg==
X-Gm-Message-State: AOAM533FrJUj+dDLRqpP9eUNkINEEN9JzK8O4Ud5JdRAplF4ETz8tTtl
        nIERxkZ/XHx/axCTeDyL2MUlvrKHnRSnbnZXqsHk+fF755XqLU9lidDhl0Wqd+Xdzeij5FeuDuM
        UcwlzddekVn7VZH16dvZT9Cs=
X-Received: by 2002:adf:f783:0:b0:207:a8ce:c155 with SMTP id q3-20020adff783000000b00207a8cec155mr15340435wrp.258.1650455583063;
        Wed, 20 Apr 2022 04:53:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3mdcDdgnw8wBFd4oSvz2RFBCBuLcli0LAQbYaimimhCAkyCaDc/C/mRRY0k5Jc+1/dIwhWA==
X-Received: by 2002:adf:f783:0:b0:207:a8ce:c155 with SMTP id q3-20020adff783000000b00207a8cec155mr15340418wrp.258.1650455582802;
        Wed, 20 Apr 2022 04:53:02 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v11-20020a056000144b00b0020a9c02f60dsm6333233wrx.50.2022.04.20.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:53:01 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v3 2/2] module: Introduce module unload taint tracking
Date:   Wed, 20 Apr 2022 12:52:57 +0100
Message-Id: <20220420115257.3498300-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420115257.3498300-1-atomlin@redhat.com>
References: <20220420115257.3498300-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only the initial module that tainted the kernel is
recorded e.g. when an out-of-tree module is loaded.

The purpose of this patch is to allow the kernel to maintain a record of
each unloaded module that taints the kernel. So, in addition to
displaying a list of linked modules (see print_modules()) e.g. in the
event of a detected bad page, unloaded modules that carried a taint/or
taints are displayed too. A tainted module unload count is maintained.

The number of tracked modules is not fixed. This feature is disabled by
default.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 init/Kconfig         | 11 ++++++++
 kernel/module/main.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..6b30210f787d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2118,6 +2118,17 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
+config MODULE_UNLOAD_TAINT_TRACKING
+	bool "Tainted module unload tracking"
+	depends on MODULE_UNLOAD
+	default n
+	help
+	  This option allows you to maintain a record of each unloaded
+	  module that tainted the kernel. In addition to displaying a
+	  list of linked (or loaded) modules e.g. on detection of a bad
+	  page (see bad_page()), the aforementioned details are also
+	  shown. If unsure, say N.
+
 config MODVERSIONS
 	bool "Module versioning support"
 	help
diff --git a/kernel/module/main.c b/kernel/module/main.c
index ea78cec316dd..d7cc64172dd1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -68,6 +68,16 @@
  */
 DEFINE_MUTEX(module_mutex);
 LIST_HEAD(modules);
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+static LIST_HEAD(unloaded_tainted_modules);
+
+struct mod_unload_taint {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	unsigned long taints;
+	u64 count;
+};
+#endif
 
 /* Work queue for freeing init sections in success case */
 static void do_free_init(struct work_struct *w);
@@ -150,6 +160,41 @@ int unregister_module_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+static int try_add_tainted_module(struct module *mod)
+{
+	struct mod_unload_taint *mod_taint;
+
+	module_assert_mutex_or_preempt();
+
+	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
+				lockdep_is_held(&module_mutex)) {
+		size_t len = strlen(mod_taint->name);
+
+		if (len == strlen(mod->name) && !memcmp(mod_taint->name, mod->name, len) &&
+		    mod_taint->taints & mod->taints) {
+			mod_taint->count++;
+			goto out;
+		}
+	}
+
+	mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
+	if (unlikely(!mod_taint))
+		return -ENOMEM;
+	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
+	mod_taint->taints = mod->taints;
+	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
+	mod_taint->count = 1;
+out:
+	return 0;
+}
+#else /* MODULE_UNLOAD_TAINT_TRACKING */
+static int try_add_tainted_module(struct module *mod)
+{
+	return 0;
+}
+#endif
+
 /*
  * We require a truly strong try_module_get(): 0 means success.
  * Otherwise an error is returned due to ongoing or failed
@@ -1201,6 +1246,9 @@ static void free_module(struct module *mod)
 	module_bug_cleanup(mod);
 	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
 	synchronize_rcu();
+	if (try_add_tainted_module(mod))
+		pr_err("%s: adding tainted module to the unloaded tainted modules list failed.\n",
+		       mod->name);
 	mutex_unlock(&module_mutex);
 
 	/* Clean up CFI for the module. */
@@ -3126,6 +3174,9 @@ struct module *__module_text_address(unsigned long addr)
 void print_modules(void)
 {
 	struct module *mod;
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	struct mod_unload_taint *mod_taint;
+#endif
 	char buf[MODULE_FLAGS_BUF_SIZE];
 
 	printk(KERN_DEFAULT "Modules linked in:");
@@ -3136,6 +3187,20 @@ void print_modules(void)
 			continue;
 		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
 	}
+#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
+	if (!list_empty(&unloaded_tainted_modules)) {
+		printk(KERN_DEFAULT "Unloaded tainted modules:");
+		list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
+					list) {
+			size_t l;
+
+			l = module_flags_taint(mod_taint->taints, buf);
+			buf[l++] = '\0';
+			pr_cont(" %s(%s):%llu", mod_taint->name, buf,
+				mod_taint->count);
+		}
+#endif
+	}
 	preempt_enable();
 	if (last_unloaded_module[0])
 		pr_cont(" [last unloaded: %s]", last_unloaded_module);
-- 
2.34.1

