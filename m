Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B3C47A519
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhLTGsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbhLTGsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:48:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465CC061574;
        Sun, 19 Dec 2021 22:48:01 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k21so1277516lfu.0;
        Sun, 19 Dec 2021 22:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYBN9i6peKxuXTivKObF0y8KGXjJeLNzHnB+9sO9314=;
        b=ksl5FhIbJ23IJlAtPa2xE2IXLTtzdBMSGHVBMZhztbtScIjdrBslSP82J1h3WRy1z+
         R4ppZHHra96Np+L0fc6/UVziJRxpzjQFvSpJ8dcQIRRKxvBPXngFuwJwdr11iWjkXr5W
         6FiTcaR4E7JocsDNlF7k8ToVPEsmIuomYrOasHfmJOpvvdp6tx9xsKPCdXnr+4+cT1PB
         EROT0fTMJLlves2+X7xV/cKf/VFvh8TyArfjmvWotz3VyUXUH5IgVAz/P5+nLWVrieHj
         +amCbHOi7eD1+X5NJ/Ha2Oc9qD49O3mnIaZ4MgU3CD0IeiRqAOeA9hLcrx4EmGkBfMCc
         csXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYBN9i6peKxuXTivKObF0y8KGXjJeLNzHnB+9sO9314=;
        b=CO1WhKQdd7i04N6ckcXS/hZaJlZyOPxKUT/2BBdfzFb/n7svURn3opQVjPjDZzR9Hv
         khPyPNyhiWXMh5PffSyuu9FmwosbknThm4dgLuVkEgu3KuzynQXTd27Yf1EbgVN8Sn+A
         l/UUemfjzZ5O5e8lF7+LhKqs3KrGBn46viNpJSQ9+bFysrLeDpvQ7rgwjf16x7lwzkUG
         6hNd3x9NQ1IQMKzDWdT8W2XYF7qHUm3xEztANZGrt8O//VBEbefiIIvxRh7drii+I4AW
         df/3v/pVnS9MKJDvHygSshp16Reu67ICPN57EzH+vd7t+yc1e2e5A4KnwOYMb7U7qsmu
         tW5g==
X-Gm-Message-State: AOAM532OIkT/i41DchDmC4SVO99oFTJxrQeIMcD1kpk1HI8iN7QYs0Tw
        XA86BcJ0GeXT7EGfrOQndb0=
X-Google-Smtp-Source: ABdhPJyLW2hjWRD0I/uy6YHstMe3tlW848uaFiTwHHyqXnzZU6U6THNDhCsE6B7K/v70k5T7MRr2lA==
X-Received: by 2002:a05:6512:3b07:: with SMTP id f7mr10948303lfv.567.1639982880158;
        Sun, 19 Dec 2021 22:48:00 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z39sm210260lfu.52.2021.12.19.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 22:47:59 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
Date:   Mon, 20 Dec 2021 07:47:30 +0100
Message-Id: <20211220064730.28806-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211220064730.28806-1-zajec5@gmail.com>
References: <20211220064730.28806-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This allows reading NVMEM cells using /sys/bus/nvmem/devices/*/cells/*
which may be helpful for userspace & debugging purposes.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/driver-api/nvmem.rst | 11 ++++++
 drivers/nvmem/core.c               | 60 ++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 287e86819640..20f7d68143be 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -185,6 +185,17 @@ ex::
   *
   0001000
 
+Single cells can be read using files located at::
+
+	/sys/bus/nvmem/devices/*/cells/*
+
+ex::
+
+  hexdump -C /sys/bus/nvmem/devices/mtd0/cells/mac
+
+  00000000  10 7b 44 c4 8a b0                                 |.{D...|
+  00000006
+
 7. DeviceTree Binding
 =====================
 
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 23a38dcf0fc4..785a56e33f69 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -55,6 +55,7 @@ struct nvmem_cell_entry {
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
+	struct bin_attribute	battr;
 };
 
 struct nvmem_cell {
@@ -73,6 +74,10 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
+static int __nvmem_cell_read(struct nvmem_device *nvmem,
+		      struct nvmem_cell_entry *cell,
+		      void *buf, size_t *len, const char *id);
+
 static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
 			    void *val, size_t bytes)
 {
@@ -338,8 +343,18 @@ static const struct attribute_group nvmem_bin_group = {
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 };
 
+static struct bin_attribute *nvmem_cells_bin_attrs[] = {
+	NULL,
+};
+
+static const struct attribute_group nvmem_cells_group = {
+	.name		= "cells",
+	.bin_attrs	= nvmem_cells_bin_attrs,
+};
+
 static const struct attribute_group *nvmem_dev_groups[] = {
 	&nvmem_bin_group,
+	&nvmem_cells_group,
 	NULL,
 };
 
@@ -431,7 +446,13 @@ static struct bus_type nvmem_bus_type = {
 
 static void nvmem_cell_entry_drop(struct nvmem_cell_entry *cell)
 {
+	struct device *dev = &cell->nvmem->dev;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
+
+	sysfs_remove_file_from_group(&dev->kobj, &cell->battr.attr,
+				     nvmem_cells_group.name);
+
 	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
@@ -448,11 +469,50 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 		nvmem_cell_entry_drop(cell);
 }
 
+static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *battr, char *buf,
+				    loff_t pos, size_t count)
+{
+	struct nvmem_cell_entry *cell = container_of(battr, struct nvmem_cell_entry, battr);
+	struct nvmem_device *nvmem = cell->nvmem;
+	size_t bytes;
+	u8 *data;
+	int err;
+
+	if (pos >= cell->bytes)
+		return 0;
+
+	data = kzalloc(cell->bytes, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = __nvmem_cell_read(nvmem, cell, data, &bytes, NULL);
+	if (!err)
+		memcpy(buf, data + pos, count - pos);
+
+	kfree(data);
+
+	return err ? err : bytes;
+}
+
 static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
 {
+	struct device *dev = &cell->nvmem->dev;
+	int err;
+
 	mutex_lock(&nvmem_mutex);
 	list_add_tail(&cell->node, &cell->nvmem->cells);
 	mutex_unlock(&nvmem_mutex);
+
+	sysfs_attr_init(&cell->battr.attr);
+	cell->battr.attr.name = cell->name;
+	cell->battr.attr.mode = 0400;
+	cell->battr.read = nvmem_cell_attr_read;
+	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
+					  nvmem_cells_group.name);
+	if (err)
+		dev_warn(dev, "Failed to add %s cell: %d\n", cell->name, err);
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
 }
 
-- 
2.31.1

