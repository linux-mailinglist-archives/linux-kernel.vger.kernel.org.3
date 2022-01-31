Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00AD4A4911
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbiAaOMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379262AbiAaOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:12:17 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3BC06173B;
        Mon, 31 Jan 2022 06:12:17 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e9so12366307pgb.3;
        Mon, 31 Jan 2022 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tnE0wyNxKHyZ8k775+KkUncgCdQA0PjnSA4/A1ZW6ec=;
        b=OgFVT7pc9LR34GJPj68Tu0P0fwiOPndqLk8x/rqxdHzZkpdNVDRhjTMpzRbVjPLBpH
         SnxXrqexOnecBmouCk/oCqCbBhhrXDHfwoFbF9hYBhmSBnp4GWI7zFtrPU5Q2UMAsNFH
         XLyE84mza2IsyF+JiBElRSAv27ta26OPapKt/3g7RDvT+HBDloWr7MW6r1ITJtUh+fIx
         /x1V3VNR1Dzh5Y7K5kt0Fmb4VOBaZjqh2xJKIs9h8zGikpt6EJKMqxlLzCaE2WHiOwOe
         qCIv1TkVBgPvoyO6bs7X9eA1ONaGTEqAxW3J2utrsc97DShmr8i+N1w3icc5hobWVQO0
         7EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tnE0wyNxKHyZ8k775+KkUncgCdQA0PjnSA4/A1ZW6ec=;
        b=4JRXKghZU4pltvjo6or/xr9B5zX78jehbU/TFYrZKzL4nwAoe7TJsVIyzjlFoLmOcr
         qvD+7J7EJhrwXr/NQXOEAXgD/vxKsxr4AWhxHcxlkpX4krAwjNNvIy3UJ6jmNYtYJeeh
         329tLbkJpmW99asZMkaMSmWNCD49jJRKoOZ9F1MaJ6x545k1vGqp7wN2CPndUn1v2vIV
         cGdNhcGWYmH6LxwQKv7ewGZF707klU/HGhQWPocOB8XwGAHZRHfXoCOo1yBxchgvLGMd
         Dkv2xac7P7fsb0ZrZwd/y+FcYOIducNWsJWQwhMKCcE70lTBAKE8GrgzkAeQVtmR8zoi
         702Q==
X-Gm-Message-State: AOAM532NTBS62EAnXpzo1eGBkzrFPVcx+M8aDuDLMaZI1A9SA310fUqx
        LkrXUR3EB717Spdm68Yz9XalYz2TdM4=
X-Google-Smtp-Source: ABdhPJyLMqqVrHNOj+Bk7WYYS9Q0JddbaTefd7TtDAXiGj2uJBvnw6z8Om82z9k9qC5zlxQV02zZTA==
X-Received: by 2002:a63:1002:: with SMTP id f2mr16848056pgl.388.1643638336672;
        Mon, 31 Jan 2022 06:12:16 -0800 (PST)
Received: from localhost.localdomain ([124.253.246.115])
        by smtp.googlemail.com with ESMTPSA id g12sm18101682pfm.119.2022.01.31.06.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:12:16 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
X-Google-Original-From: Puranjay Mohan <p-mohan@ti.com>
To:     kishon@ti.com, vigneshr@ti.com, s-anna@ti.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH 1/2] remoteproc: Introduce deny_sysfs_ops flag
Date:   Mon, 31 Jan 2022 19:41:51 +0530
Message-Id: <1643638312-3912-2-git-send-email-p-mohan@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
References: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remoteproc framework provides sysfs interfaces for changing
the firmware name and for starting/stopping a remote processor
through the sysfs files 'state' and 'firmware'. The 'recovery'
sysfs file can also be used similarly to control the error recovery
state machine of a remoteproc. These interfaces are currently
allowed irrespective of how the remoteprocs were booted (like
remoteproc self auto-boot, remoteproc client-driven boot etc).
These interfaces can adversely affect a remoteproc and its clients
especially when a remoteproc is being controlled by a remoteproc
client driver(s). Also, not all remoteproc drivers may want to
support the sysfs interfaces by default.

Add support to deny the sysfs state/firmware/recovery change by
introducing a state flag 'deny_sysfs_ops' that the individual
remoteproc drivers can set based on their usage needs. The default
behavior is to allow the sysfs operations as before.

Implement attribute_group->is_visible() to hide the sysfs
state/firmware/recovery entries when deny_sysfs_ops flag is set.

Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
 include/linux/remoteproc.h            |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index ea8b89f97d7b..4a41abdd1f7b 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -230,6 +230,21 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(name);
 
+static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
+			       int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct rproc *rproc = to_rproc(dev);
+	umode_t mode = attr->mode;
+
+	if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
+				      attr == &dev_attr_firmware.attr ||
+				      attr == &dev_attr_state.attr))
+		mode = 0;
+
+	return mode;
+}
+
 static struct attribute *rproc_attrs[] = {
 	&dev_attr_coredump.attr,
 	&dev_attr_recovery.attr,
@@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
 };
 
 static const struct attribute_group rproc_devgroup = {
-	.attrs = rproc_attrs
+	.attrs = rproc_attrs,
+	.is_visible = rproc_is_visible,
 };
 
 static const struct attribute_group *rproc_devgroups[] = {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e0600e1e5c17..3849c66ce38f 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -523,6 +523,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  * @elf_class: firmware ELF class
@@ -562,6 +563,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool deny_sysfs_ops;
 	struct list_head dump_segments;
 	int nb_vdev;
 	u8 elf_class;
-- 
2.24.3

