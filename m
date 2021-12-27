Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746354801B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhL0Qjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:39:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36558 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhL0Qje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:39:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40BD561122
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 16:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A3EC36AE7;
        Mon, 27 Dec 2021 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640623173;
        bh=MRLmeRSY59lUiIpHfSURnA4jHpdxQoNtBl29g+X5uuU=;
        h=From:To:Cc:Subject:Date:From;
        b=0F4h1mv14C6IPi/lOhkah8/92hPvj6JdCalH+3k3oWzj47qJp8LOvZ4OvRKFas5PP
         TvJd+of4uoS+XnGpHdGZ6oomesSBWLXwPOmtfKuemzDZMXdWWbPe4MEg60+AoZiTim
         dUuHLCT4++8R9QhEvnYix06s+FNg83H40UF/xBmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH] kobject: remove kset from struct kset_uevent_ops callbacks
Date:   Mon, 27 Dec 2021 17:39:24 +0100
Message-Id: <20211227163924.3970661-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9032; h=from:subject; bh=MRLmeRSY59lUiIpHfSURnA4jHpdxQoNtBl29g+X5uuU=; b=owGbwMvMwCRo6H6F97bub03G02pJDIkn35j9cFwswJwn8PFBFCNjlpu0VU9Gs3cMb7Nog/fOHLNr CyI7YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCIWpxjm+znLB1cXCJ1WOyX1a22MxT 1F84UGDPP9xRuPyB7JPay8sETyitZX7dAzl/wB
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to pass the pointer to the kset in the struct
kset_uevent_ops callbacks as no one uses it, so just remove that pointer
entirely.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/core-api/kobject.rst                    |  7 +++----
 Documentation/translations/zh_CN/core-api/kobject.rst |  7 +++----
 drivers/base/bus.c                                    |  2 +-
 drivers/base/core.c                                   | 11 +++++------
 drivers/dma-buf/dma-buf-sysfs-stats.c                 |  2 +-
 fs/dlm/lockspace.c                                    |  3 +--
 fs/gfs2/sys.c                                         |  3 +--
 include/linux/kobject.h                               |  7 +++----
 kernel/params.c                                       |  2 +-
 lib/kobject_uevent.c                                  |  6 +++---
 10 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/Documentation/core-api/kobject.rst b/Documentation/core-api/kobject.rst
index d3b5bf9f643a..3d6e3107315d 100644
--- a/Documentation/core-api/kobject.rst
+++ b/Documentation/core-api/kobject.rst
@@ -373,10 +373,9 @@ If a kset wishes to control the uevent operations of the kobjects
 associated with it, it can use the struct kset_uevent_ops to handle it::
 
   struct kset_uevent_ops {
-          int (* const filter)(struct kset *kset, struct kobject *kobj);
-          const char *(* const name)(struct kset *kset, struct kobject *kobj);
-          int (* const uevent)(struct kset *kset, struct kobject *kobj,
-                        struct kobj_uevent_env *env);
+          int (* const filter)(struct kobject *kobj);
+          const char *(* const name)(struct kobject *kobj);
+          int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
   };
 
 
diff --git a/Documentation/translations/zh_CN/core-api/kobject.rst b/Documentation/translations/zh_CN/core-api/kobject.rst
index b7c37794cc7f..95634083dca0 100644
--- a/Documentation/translations/zh_CN/core-api/kobject.rst
+++ b/Documentation/translations/zh_CN/core-api/kobject.rst
@@ -325,10 +325,9 @@ ksets
 结构体kset_uevent_ops来处理它::
 
   struct kset_uevent_ops {
-          int (* const filter)(struct kset *kset, struct kobject *kobj);
-          const char *(* const name)(struct kset *kset, struct kobject *kobj);
-          int (* const uevent)(struct kset *kset, struct kobject *kobj,
-                        struct kobj_uevent_env *env);
+          int (* const filter)(struct kobject *kobj);
+          const char *(* const name)(struct kobject *kobj);
+          int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
   };
 
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index a64454f5f8c0..97936ec49bde 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -163,7 +163,7 @@ static struct kobj_type bus_ktype = {
 	.release	= bus_release,
 };
 
-static int bus_uevent_filter(struct kset *kset, struct kobject *kobj)
+static int bus_uevent_filter(struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d712ea11066b..60d703ebd123 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2261,7 +2261,7 @@ static struct kobj_type device_ktype = {
 };
 
 
-static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
+static int dev_uevent_filter(struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
 
@@ -2275,7 +2275,7 @@ static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
 	return 0;
 }
 
-static const char *dev_uevent_name(struct kset *kset, struct kobject *kobj)
+static const char *dev_uevent_name(struct kobject *kobj)
 {
 	struct device *dev = kobj_to_dev(kobj);
 
@@ -2286,8 +2286,7 @@ static const char *dev_uevent_name(struct kset *kset, struct kobject *kobj)
 	return NULL;
 }
 
-static int dev_uevent(struct kset *kset, struct kobject *kobj,
-		      struct kobj_uevent_env *env)
+static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	int retval = 0;
@@ -2382,7 +2381,7 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 
 	/* respect filter */
 	if (kset->uevent_ops && kset->uevent_ops->filter)
-		if (!kset->uevent_ops->filter(kset, &dev->kobj))
+		if (!kset->uevent_ops->filter(&dev->kobj))
 			goto out;
 
 	env = kzalloc(sizeof(struct kobj_uevent_env), GFP_KERNEL);
@@ -2390,7 +2389,7 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 		return -ENOMEM;
 
 	/* let the kset specific function add its keys */
-	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
+	retval = kset->uevent_ops->uevent(&dev->kobj, env);
 	if (retval)
 		goto out;
 
diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
index 053baadcada9..2bba0babcb62 100644
--- a/drivers/dma-buf/dma-buf-sysfs-stats.c
+++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
@@ -132,7 +132,7 @@ void dma_buf_stats_teardown(struct dma_buf *dmabuf)
 
 
 /* Statistics files do not need to send uevents. */
-static int dmabuf_sysfs_uevent_filter(struct kset *kset, struct kobject *kobj)
+static int dmabuf_sysfs_uevent_filter(struct kobject *kobj)
 {
 	return 0;
 }
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 10eddfa6c3d7..0bbb346cb892 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -216,8 +216,7 @@ static int do_uevent(struct dlm_ls *ls, int in)
 	return ls->ls_uevent_result;
 }
 
-static int dlm_uevent(struct kset *kset, struct kobject *kobj,
-		      struct kobj_uevent_env *env)
+static int dlm_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
 
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index c0a34d9ddee4..a6002b2d146d 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -767,8 +767,7 @@ void gfs2_sys_fs_del(struct gfs2_sbd *sdp)
 	wait_for_completion(&sdp->sd_kobj_unregister);
 }
 
-static int gfs2_uevent(struct kset *kset, struct kobject *kobj,
-		       struct kobj_uevent_env *env)
+static int gfs2_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
 	struct super_block *s = sdp->sd_vfs;
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 683172b2e094..ad90b49824dc 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -153,10 +153,9 @@ struct kobj_uevent_env {
 };
 
 struct kset_uevent_ops {
-	int (* const filter)(struct kset *kset, struct kobject *kobj);
-	const char *(* const name)(struct kset *kset, struct kobject *kobj);
-	int (* const uevent)(struct kset *kset, struct kobject *kobj,
-		      struct kobj_uevent_env *env);
+	int (* const filter)(struct kobject *kobj);
+	const char *(* const name)(struct kobject *kobj);
+	int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
 };
 
 struct kobj_attribute {
diff --git a/kernel/params.c b/kernel/params.c
index 9b90e3c4d3c0..5b92310425c5 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -926,7 +926,7 @@ static const struct sysfs_ops module_sysfs_ops = {
 	.store = module_attr_store,
 };
 
-static int uevent_filter(struct kset *kset, struct kobject *kobj)
+static int uevent_filter(struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index c87d5b6a8a55..7c44b7ae4c5c 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -501,7 +501,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	}
 	/* skip the event, if the filter returns zero. */
 	if (uevent_ops && uevent_ops->filter)
-		if (!uevent_ops->filter(kset, kobj)) {
+		if (!uevent_ops->filter(kobj)) {
 			pr_debug("kobject: '%s' (%p): %s: filter function "
 				 "caused the event to drop!\n",
 				 kobject_name(kobj), kobj, __func__);
@@ -510,7 +510,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 
 	/* originating subsystem */
 	if (uevent_ops && uevent_ops->name)
-		subsystem = uevent_ops->name(kset, kobj);
+		subsystem = uevent_ops->name(kobj);
 	else
 		subsystem = kobject_name(&kset->kobj);
 	if (!subsystem) {
@@ -554,7 +554,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 
 	/* let the kset specific function add its stuff */
 	if (uevent_ops && uevent_ops->uevent) {
-		retval = uevent_ops->uevent(kset, kobj, env);
+		retval = uevent_ops->uevent(kobj, env);
 		if (retval) {
 			pr_debug("kobject: '%s' (%p): %s: uevent() returned "
 				 "%d\n", kobject_name(kobj), kobj,
-- 
2.34.1

