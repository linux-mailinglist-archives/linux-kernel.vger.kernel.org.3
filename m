Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1248585E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiAEScN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiAESbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:31:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3242DC061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:31:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E29BBB81D0E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A9C36AE3;
        Wed,  5 Jan 2022 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641407496;
        bh=zE+7ffio+O9uJrwxJfyDIOj3L0z6ifW32qNmwf1FA3U=;
        h=From:To:Cc:Subject:Date:From;
        b=eeydPoE84v4MKL6GSE8oBVVlpoXS/9hT0UqM8e+bjRkHeoK8duRTH2+ixq8gepOdd
         fd324jb4J9onsTE9ZSJGbM655PSF+Ni0odw0MlebHnzdvj7ugY+ov2LN4ce2UfSCWk
         kGcGOCAbM3fAXiwSL5ekNoVexRit9n770PaTxCXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] qemu_fw_cfg: use default_groups in kobj_type
Date:   Wed,  5 Jan 2022 19:31:33 +0100
Message-Id: <20220105183133.2812848-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; h=from:subject; bh=zE+7ffio+O9uJrwxJfyDIOj3L0z6ifW32qNmwf1FA3U=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXn7Bed3q+1jA1e/uq2UVeKU9ZnnNHeyp92FnB5DNh3XS2 qkvzO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiVfcZ5oqZLX4ttOKekBxfXfXaCM evtecXCjEs2HDaSdxTj+m9l0/7wdqlH7fsYmAPAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the firmware qemu_fw_cfg sysfs code to use default_groups
field which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: Gabriel Somlo <somlo@cmu.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/qemu_fw_cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 172c751a4f6c..c62f05420d32 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -395,7 +395,7 @@ static void fw_cfg_sysfs_cache_cleanup(void)
 	}
 }
 
-/* default_attrs: per-entry attributes and show methods */
+/* per-entry attributes and show methods */
 
 #define FW_CFG_SYSFS_ATTR(_attr) \
 struct fw_cfg_sysfs_attribute fw_cfg_sysfs_attr_##_attr = { \
@@ -428,6 +428,7 @@ static struct attribute *fw_cfg_sysfs_entry_attrs[] = {
 	&fw_cfg_sysfs_attr_name.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(fw_cfg_sysfs_entry);
 
 /* sysfs_ops: find fw_cfg_[entry, attribute] and call appropriate show method */
 static ssize_t fw_cfg_sysfs_attr_show(struct kobject *kobj, struct attribute *a,
@@ -454,7 +455,7 @@ static void fw_cfg_sysfs_release_entry(struct kobject *kobj)
 
 /* kobj_type: ties together all properties required to register an entry */
 static struct kobj_type fw_cfg_sysfs_entry_ktype = {
-	.default_attrs = fw_cfg_sysfs_entry_attrs,
+	.default_groups = fw_cfg_sysfs_entry_groups,
 	.sysfs_ops = &fw_cfg_sysfs_attr_ops,
 	.release = fw_cfg_sysfs_release_entry,
 };
-- 
2.34.1

