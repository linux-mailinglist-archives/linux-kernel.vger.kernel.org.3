Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876F8510978
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354416AbiDZUH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354385AbiDZUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:07:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE0FE5E36
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651003452; x=1682539452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qkEcCd9d2bx85BPUH+afP8zbP/HZaJPrvil7Desz+0=;
  b=Bc65u+bT9zauGtEZjUoTjCzKWILelhkIkcib0sk5Wmaom8OitNV8AhA7
   fyZwDdDVP346oBe0QMxZpVo1sfLZSVshxmDuZmjFO0DpnKoz/rCVDH/FH
   g0mUI8LJsRlWwDKOtdXTV7UFGLg56wLGCZRXc+dYHVZrxc6wUscOBDd42
   NpyZvofDMif/878TzI4i6Lv6sI0l7LRKSe0eeMqqojbPLcL8kDfqaAdr+
   g1ruhthhf5XGI35Sz9CemJigdLOXJaiczjkNNXowQUba2Y1P21sy0aQLa
   NyFXojg8y27nFcxNGxPjUPkxhS/9F598nwLygviANf2E57KeZ5HGu27mD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="253082443"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="253082443"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:03:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="580129117"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.180.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:03:58 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 1/2] firmware_loader: Fix configs for sysfs split
Date:   Tue, 26 Apr 2022 13:03:55 -0700
Message-Id: <20220426200356.126085-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426200356.126085-1-russell.h.weight@intel.com>
References: <20220426200356.126085-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the CONFIGs around register_sysfs_loader(),
unregister_sysfs_loader(), register_firmware_config_sysctl(), and
unregister_firmware_config_sysctl(). The full definitions of the
register_sysfs_loader() and unregister_sysfs_loader() functions should
be used whenever CONFIG_FW_LOADER_SYSFS is defined. The
register_firmware_config_sysctl() and unregister_firmware_config_sysctl()
functions should be stubbed out unless CONFIG_FW_LOADER_USER_HELPER
CONFIG_SYSCTL are both defined.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/base/firmware_loader/sysfs.c |  2 --
 drivers/base/firmware_loader/sysfs.h | 10 ++++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index c09fcebeada9..eb7d9322a56e 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -110,7 +110,6 @@ static struct class firmware_class = {
 	.dev_release	= fw_dev_release,
 };
 
-#ifdef CONFIG_FW_LOADER_USER_HELPER
 int register_sysfs_loader(void)
 {
 	int ret = class_register(&firmware_class);
@@ -125,7 +124,6 @@ void unregister_sysfs_loader(void)
 	unregister_firmware_config_sysctl();
 	class_unregister(&firmware_class);
 }
-#endif
 
 static ssize_t firmware_loading_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
diff --git a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
index c21bcfe374ff..e6c487937817 100644
--- a/drivers/base/firmware_loader/sysfs.h
+++ b/drivers/base/firmware_loader/sysfs.h
@@ -46,10 +46,12 @@ static inline void __fw_fallback_set_timeout(int timeout)
 {
 	fw_fallback_config.loading_timeout = timeout;
 }
+#endif
 
+#ifdef CONFIG_FW_LOADER_SYSFS
 int register_sysfs_loader(void);
 void unregister_sysfs_loader(void);
-#ifdef CONFIG_SYSCTL
+#if defined(CONFIG_FW_LOADER_USER_HELPER) && defined(CONFIG_SYSCTL)
 int register_firmware_config_sysctl(void);
 void unregister_firmware_config_sysctl(void);
 #else
@@ -59,8 +61,8 @@ static inline int register_firmware_config_sysctl(void)
 }
 
 static inline void unregister_firmware_config_sysctl(void) { }
-#endif /* CONFIG_SYSCTL */
-#else /* CONFIG_FW_LOADER_USER_HELPER */
+#endif /* CONFIG_FW_LOADER_USER_HELPER && CONFIG_SYSCTL */
+#else /* CONFIG_FW_LOADER_SYSFS */
 static inline int register_sysfs_loader(void)
 {
 	return 0;
@@ -69,7 +71,7 @@ static inline int register_sysfs_loader(void)
 static inline void unregister_sysfs_loader(void)
 {
 }
-#endif /* CONFIG_FW_LOADER_USER_HELPER */
+#endif /* CONFIG_FW_LOADER_SYSFS */
 
 struct fw_sysfs {
 	bool nowait;
-- 
2.25.1

