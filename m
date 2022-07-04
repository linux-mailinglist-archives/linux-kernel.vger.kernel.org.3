Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A87565A22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiGDPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiGDPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:42:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84E11466
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:42:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so14055621wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a0Rzbb8icmC8RVtc3T8ErljDbsFF9Mc0JN0kql2Oo9Q=;
        b=Pxww1B52DFqHrvI6Li6YrvFsbywuSSQBUHn2M1ArN0nw6ZEr0gXWNjeLpHj1OVlj3x
         GT5gZ072Zt48e69tHpK66BdwE8Vf3oRA8gCRU4EM4ZGRY8jz9mCmapkFniUVgGaffA8/
         D27AacQW8GnHTx/4A5gjaxO3/C/KUDQz5tcPYeHwY4Xy4WXAujqIzYOgTePogYeH0+Ww
         bbXyE4DELCKxm32fj4gP4fFeROsEJ4hTECdUFsjb9xo6NIA6l819MfzYqD+HW8WRvF1p
         hqpZypx9JphH07VaiaLMLhL6Ei04sf9GOPckeXSwZ0ZlILIgVFERrUKxsgbViJ6u8Xct
         /HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a0Rzbb8icmC8RVtc3T8ErljDbsFF9Mc0JN0kql2Oo9Q=;
        b=IPVcBBjwabE726cT6MMYYDRT8Fd3htEIg0YH1+kf+c4wfz933EnenVQYCwi7QR4Wwm
         iaP/dVMV2sWEsoGoU/2e/hY7XL3ahaLm1pyWOhLgf3ztuvhEH20AK2tdanzkz9pZk3Bw
         Q8J2Zn7msbng7QdWP7PVaAOW+mB9oK+9RQE6LKU1Wvu/Hj8RMBA6/bSG4fPhOUcLOVJe
         KIlenQObBn693RavSCQNLiGuK9DP3g/fQ2Fb7pbD1IzipWxut7+hee9VTRa4AGqrM0wr
         1iE0zd6pE47jUIoHYzWyZuLHf9SOpQH1T9XYQJSnrC12PhUajQrsDVoykXcNkRvDJIM3
         NyPQ==
X-Gm-Message-State: AJIora8Sgv5oKNsK9GhEvxTzY31wuo70ekTIyNIftMeCYRPoG2mMi82n
        PnzGOz0fRm6hABpRNDmCvCRdWg==
X-Google-Smtp-Source: AGRyM1vs/yz829mXAuTX5+fl6iGpF2UoW6b7NwQVrAGP3z+qDp1pvJgJRch42C9YTV7ymyTvGQuAag==
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr28028244wrn.197.1656949374267;
        Mon, 04 Jul 2022 08:42:54 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a9e8:9fdd:fa2d:1c72])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0021d6b851ca1sm2763749wrr.111.2022.07.04.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:42:53 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 3/7] coresight: configfs: Add in binary attributes to load files
Date:   Mon,  4 Jul 2022 16:42:45 +0100
Message-Id: <20220704154249.11501-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704154249.11501-1-mike.leach@linaro.org>
References: <20220704154249.11501-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in functionality and binary attribute to load and unload
configurations as binary data.

Files are loaded via the 'load' binary attribute. System reads the incoming
file, which must be formatted correctly as defined in the file reader code.
This will create configuration(s) and/or feature(s) and load them
into the system.

These will then appear in configfs, in the 'configurations' and 'features'
directories, ready for use.

A mutex is used to prevent load and unload operations from happening
simultaneously. Further, a flag enabling configfs load/unload is
provided, along with API calls to allow this functionality to be
controlled during start-up and shut-down, and when configurations
are loaded via loadable modules.

This ensures that load/unload operations are strictly serialised.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c     | 181 +++++++++++++++++-
 .../coresight/coresight-syscfg-configfs.h     |   3 +
 .../hwtracing/coresight/coresight-syscfg.c    | 107 +++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |   1 +
 4 files changed, 285 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 6e8c8db52d39..16c20598198e 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -7,8 +7,33 @@
 #include <linux/configfs.h>
 
 #include "coresight-config.h"
+#include "coresight-config-file.h"
 #include "coresight-syscfg-configfs.h"
 
+/* prevent race in load / unload operations */
+static DEFINE_MUTEX(cfs_mutex);
+
+/*
+ * need to enable / disable load via configfs when
+ * initialising / shutting down the subsystem, or
+ * loading / unloading module.
+ */
+static bool cscfg_fs_load_enabled;
+
+void cscfg_configfs_enable_fs_load(void)
+{
+	mutex_lock(&cfs_mutex);
+	cscfg_fs_load_enabled = true;
+	mutex_unlock(&cfs_mutex);
+}
+
+void cscfg_configfs_disable_fs_load(void)
+{
+	mutex_lock(&cfs_mutex);
+	cscfg_fs_load_enabled = false;
+	mutex_unlock(&cfs_mutex);
+}
+
 /* create a default ci_type. */
 static inline struct config_item_type *cscfg_create_ci_type(void)
 {
@@ -431,14 +456,157 @@ static void cscfg_destroy_feature_group(struct config_group *feat_group)
 	kfree(feat_view);
 }
 
-static struct config_item_type cscfg_configs_type = {
+/* Attributes in configfs that allow load and unload of configuration binary files */
+
+/* free memory associated with a configfs loaded configuration file & descriptors */
+void cscfg_configfs_free_owner_info(struct cscfg_load_owner_info *owner_info)
+{
+	struct cscfg_fs_load_descs *load_descs = 0;
+
+	if (!owner_info)
+		return;
+
+	load_descs = (struct cscfg_fs_load_descs *)(owner_info->owner_handle);
+
+	if (load_descs) {
+		/* free the data allocated on file load, pointed to by load_descs */
+		cscfg_file_free_load_descs(load_descs);
+		kfree(load_descs);
+	}
+
+	kfree(owner_info);
+}
+
+
+/* load "buffer" as a configuration binary file */
+static ssize_t cscfg_cfg_load_write(struct config_item *item, const void *buffer, size_t size)
+{
+	struct cscfg_fs_load_descs *load_descs = 0;
+	struct cscfg_load_owner_info *owner_info = 0;
+	int err = 0;
+
+	/* ensure we cannot simultaneously load and unload */
+	if (!mutex_trylock(&cfs_mutex))
+		return -EBUSY;
+
+	/* check configfs load / unload ops are permitted */
+	if (!cscfg_fs_load_enabled) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	if (size > CSCFG_FILE_MAXSIZE) {
+		pr_err("cscfg: Load error - Input file too large.\n");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+
+	load_descs = kzalloc(sizeof(struct cscfg_fs_load_descs), GFP_KERNEL);
+	owner_info = kzalloc(sizeof(struct cscfg_load_owner_info), GFP_KERNEL);
+	if (!load_descs || !owner_info) {
+		err = -ENOMEM;
+		goto exit_memfree;
+	}
+
+	owner_info->owner_handle = load_descs;
+	owner_info->type = CSCFG_OWNER_CONFIGFS;
+
+	err = cscfg_file_read_buffer(buffer, size, load_descs);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to read input file.\n");
+		goto exit_memfree;
+	}
+
+	err = cscfg_load_config_sets(load_descs->config_descs, load_descs->feat_descs, owner_info);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to load configuaration file.\n");
+		goto exit_memfree;
+	}
+
+	mutex_unlock(&cfs_mutex);
+	return size;
+
+exit_memfree:
+	cscfg_configfs_free_owner_info(owner_info);
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+CONFIGFS_BIN_ATTR_WO(cscfg_cfg_, load, NULL, CSCFG_FILE_MAXSIZE);
+
+/* read "buffer" and unload configuration */
+static ssize_t cscfg_cfg_unload_write(struct config_item *item, const void *buffer, size_t size)
+{
+	struct cscfg_load_owner_info *owner_info = 0;
+	const char *name;
+	int err = 0;
+
+	/* ensure we cannot simultaneously load and unload */
+	if (!mutex_trylock(&cfs_mutex))
+		return -EBUSY;
+
+	/* check configfs load / unload ops are permitted */
+	if (!cscfg_fs_load_enabled) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	if (size > CSCFG_FILE_MAXSIZE) {
+		pr_err("cscfg: Unload error - Input file too large\n");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+
+	err = cscfg_file_read_buffer_first_name(buffer, size, &name);
+	if (err) {
+		pr_err("cscfg: Unload error - Failed to read input file\n");
+		goto exit_unlock;
+	}
+
+	owner_info = cscfg_find_fs_owned_cfg_by_name(name);
+	if (!owner_info) {
+		pr_err("cscfg: Unload error: Failed to find %s from input file\n",
+		       name);
+		goto exit_unlock;
+	}
+	err = cscfg_unload_config_sets(owner_info);
+	if (err) {
+		pr_err("cscfg: Unload error: Cannot unload configuration %s\n",
+		       name);
+		goto exit_unlock;
+	}
+
+	cscfg_configfs_free_owner_info(owner_info);
+
+	err = size;
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+CONFIGFS_BIN_ATTR_WO(cscfg_cfg_, unload, NULL, CSCFG_FILE_MAXSIZE);
+
+static struct configfs_bin_attribute *cscfg_config_configfs_bin_attrs[] = {
+	&cscfg_cfg_attr_load,
+	&cscfg_cfg_attr_unload,
+	NULL,
+};
+
+static struct config_item_type cscfg_configs_load_type = {
 	.ct_owner = THIS_MODULE,
+	.ct_bin_attrs = cscfg_config_configfs_bin_attrs,
 };
 
+static struct config_item_type cscfg_configs_grp_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+/* group for configurations dir */
 static struct config_group cscfg_configs_grp = {
 	.cg_item = {
 		.ci_namebuf = "configurations",
-		.ci_type = &cscfg_configs_type,
+		.ci_type = &cscfg_configs_grp_type,
 	},
 };
 
@@ -508,18 +676,17 @@ void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc)
 int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr)
 {
 	struct configfs_subsystem *subsys;
-	struct config_item_type *ci_type;
 
 	if (!cscfg_mgr)
 		return -EINVAL;
 
-	ci_type = cscfg_create_ci_type();
-	if (!ci_type)
-		return -ENOMEM;
+	/* load and unload by configfs initially disabled */
+	cscfg_fs_load_enabled = false;
 
+	/* init subsystem group - with load and unload attributes */
 	subsys = &cscfg_mgr->cfgfs_subsys;
 	config_item_set_name(&subsys->su_group.cg_item, CSCFG_FS_SUBSYS_NAME);
-	subsys->su_group.cg_item.ci_type = ci_type;
+	subsys->su_group.cg_item.ci_type = &cscfg_configs_load_type;
 
 	config_group_init(&subsys->su_group);
 	mutex_init(&subsys->su_mutex);
diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.h b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
index 373d84d43268..decc96842ade 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
@@ -45,5 +45,8 @@ int cscfg_configfs_add_config(struct cscfg_config_desc *config_desc);
 int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc);
 void cscfg_configfs_del_config(struct cscfg_config_desc *config_desc);
 void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc);
+void cscfg_configfs_free_owner_info(struct cscfg_load_owner_info *owner_info);
+void cscfg_configfs_enable_fs_load(void);
+void cscfg_configfs_disable_fs_load(void);
 
 #endif /* CORESIGHT_SYSCFG_CONFIGFS_H */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 11138a9762b0..fcb885ba5084 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -554,6 +554,22 @@ static int cscfg_fs_register_cfgs_feats(struct cscfg_config_desc **config_descs,
 	return 0;
 }
 
+/*
+ * check owner info and if module owner, disable / enable
+ * configfs load ops.
+ */
+static void cscfg_check_disable_fs_load(struct cscfg_load_owner_info *owner_info)
+{
+	if (owner_info->type == CSCFG_OWNER_MODULE)
+		cscfg_configfs_disable_fs_load();
+}
+
+static void cscfg_check_enable_fs_load(struct cscfg_load_owner_info *owner_info)
+{
+	if (owner_info->type == CSCFG_OWNER_MODULE)
+		cscfg_configfs_enable_fs_load();
+}
+
 /**
  * cscfg_load_config_sets - API function to load feature and config sets.
  *
@@ -578,6 +594,9 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 {
 	int err = 0;
 
+	/* if this load is by module owner, need to disable configfs load/unload */
+	cscfg_check_disable_fs_load(owner_info);
+
 	mutex_lock(&cscfg_mutex);
 	if (cscfg_mgr->load_state != CSCFG_NONE) {
 		mutex_unlock(&cscfg_mutex);
@@ -634,6 +653,8 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 exit_unlock:
 	cscfg_mgr->load_state = CSCFG_NONE;
 	mutex_unlock(&cscfg_mutex);
+
+	cscfg_check_enable_fs_load(owner_info);
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
@@ -659,6 +680,9 @@ int cscfg_unload_config_sets(struct cscfg_load_owner_info *owner_info)
 	int err = 0;
 	struct cscfg_load_owner_info *load_list_item = NULL;
 
+	/* if this unload is by module owner, need to disable configfs load/unload */
+	cscfg_check_disable_fs_load(owner_info);
+
 	mutex_lock(&cscfg_mutex);
 	if (cscfg_mgr->load_state != CSCFG_NONE) {
 		mutex_unlock(&cscfg_mutex);
@@ -705,10 +729,65 @@ int cscfg_unload_config_sets(struct cscfg_load_owner_info *owner_info)
 exit_unlock:
 	cscfg_mgr->load_state = CSCFG_NONE;
 	mutex_unlock(&cscfg_mutex);
+
+	cscfg_check_enable_fs_load(owner_info);
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_unload_config_sets);
 
+/* find a configuration owned by configfs by name of config / first feature */
+struct cscfg_load_owner_info *cscfg_find_fs_owned_cfg_by_name(const char *name)
+{
+	struct cscfg_load_owner_info *owner_info = NULL;
+	struct cscfg_fs_load_descs *fs_load_cfg;
+	struct cscfg_config_desc *config_desc;
+	struct cscfg_feature_desc *feat_desc;
+
+	mutex_lock(&cscfg_mutex);
+
+	/* search the load_owner list for CONFIGFS loaded types */
+	list_for_each_entry(owner_info, &cscfg_mgr->load_order_list, item) {
+		/* if this is a config fs owned item, then try to match */
+		if (owner_info->type == CSCFG_OWNER_CONFIGFS) {
+			fs_load_cfg = owner_info->owner_handle;
+			/* first try to match the name against the config if it exists */
+			if (fs_load_cfg->config_descs[0]) {
+				config_desc = fs_load_cfg->config_descs[0];
+				if (!strcmp(config_desc->name, name))
+					goto exit_unlock;
+			/* no config - match against first feature name */
+			} else {
+				feat_desc = fs_load_cfg->feat_descs[0];
+				if (!strcmp(feat_desc->name, name))
+					goto exit_unlock;
+			}
+		}
+	}
+
+	/* not found */
+	owner_info = NULL;
+
+exit_unlock:
+	mutex_unlock(&cscfg_mutex);
+	return owner_info;
+}
+
+/* get configfs config load name from configfs type owner */
+static const char *cscfg_find_load_name_fs_owned_cfg(struct cscfg_load_owner_info *owner_info)
+{
+	struct cscfg_fs_load_descs *fs_load_cfg;
+	const char *name = "unknown";
+
+	if (owner_info->type == CSCFG_OWNER_CONFIGFS) {
+		fs_load_cfg = (struct cscfg_fs_load_descs *)owner_info->owner_handle;
+		if (fs_load_cfg->config_descs[0])
+			name = fs_load_cfg->config_descs[0]->name;
+		else if (fs_load_cfg->feat_descs[0])
+			name = fs_load_cfg->feat_descs[0]->name;
+	}
+	return name;
+}
+
 /* Handle coresight device registration and add configs and features to devices */
 
 /* iterate through config lists and load matching configs to device */
@@ -1206,6 +1285,7 @@ static int cscfg_create_device(void)
 static void cscfg_unload_cfgs_on_exit(void)
 {
 	struct cscfg_load_owner_info *owner_info = NULL;
+	bool free_configfs_owner = false;
 
 	/*
 	 * grab the mutex - even though we are exiting, some configfs files
@@ -1240,6 +1320,23 @@ static void cscfg_unload_cfgs_on_exit(void)
 			 */
 			pr_err("cscfg: ERROR: prior module failed to unload configuration\n");
 			goto list_remove;
+
+		case CSCFG_OWNER_CONFIGFS:
+			/*
+			 * configfs loaded items may still be present if the user did not
+			 * unload them during the session. These have dynamically allocated
+			 * descriptor tables (unlike the two types above that are statically
+			 * allocated at compile time)
+			 */
+			pr_info("cscfg: unloading configfs loaded configuration %s\n",
+				cscfg_find_load_name_fs_owned_cfg(owner_info));
+
+			/*
+			 * as this is not being unloaded by configfs, need to flag the
+			 * requirement to free up the descriptors.
+			 */
+			free_configfs_owner = true;
+			break;
 		}
 
 		/* remove from configfs - outside the scope of the list mutex */
@@ -1253,6 +1350,12 @@ static void cscfg_unload_cfgs_on_exit(void)
 list_remove:
 		/* remove from load order list */
 		list_del(&owner_info->item);
+
+		/* configfs owned dynamic loaded config, free memory now */
+		if (free_configfs_owner) {
+			cscfg_configfs_free_owner_info(owner_info);
+			free_configfs_owner = false;
+		}
 	}
 	mutex_unlock(&cscfg_mutex);
 }
@@ -1284,6 +1387,9 @@ int __init cscfg_init(void)
 	if (err)
 		goto exit_err;
 
+	/* can now allow load / unload from configfs */
+	cscfg_configfs_enable_fs_load();
+
 	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
 	return 0;
 
@@ -1294,5 +1400,6 @@ int __init cscfg_init(void)
 
 void cscfg_exit(void)
 {
+	cscfg_configfs_disable_fs_load();
 	cscfg_clear_device();
 }
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index d0c9543850c0..752ffcd1eee8 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -108,6 +108,7 @@ int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
 				int param_idx, u64 value);
 int cscfg_config_sysfs_activate(struct cscfg_config_desc *cfg_desc, bool activate);
 void cscfg_config_sysfs_set_preset(int preset);
+struct cscfg_load_owner_info *cscfg_find_fs_owned_cfg_by_name(const char *name);
 
 /* syscfg manager external API */
 int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
-- 
2.17.1

