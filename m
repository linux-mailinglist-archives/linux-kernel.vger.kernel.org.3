Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1294F480A70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhL1Om6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:42:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35024 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhL1Om5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:42:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC59611DF;
        Tue, 28 Dec 2021 14:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5A4C36AE8;
        Tue, 28 Dec 2021 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640702576;
        bh=relxSkFQq4Um8LOlSdAh9XgM8IqLjtm/+lkAfpCGTt4=;
        h=From:To:Cc:Subject:Date:From;
        b=NmAKKkje61i7pXDyPXPMQw9Hm3tklusHNVtjrT5GqqaZQ+o7X7QTqleRJNMaEiV9g
         9c4JguVxQoYKgM88KSzB+Cm3FuEVx15AVpdEectrN21DHsJOHyEQEyvLVT2ohUurmW
         JfGwFYceDHDOuWrsht2XyRJFhJnyaxmRcW26cPko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org
Subject: [PATCH] nilfs2: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 15:42:52 +0100
Message-Id: <20211228144252.390554-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3584; h=from:subject; bh=relxSkFQq4Um8LOlSdAh9XgM8IqLjtm/+lkAfpCGTt4=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnlXKmC4XX5AbsdXlW8TLxaymn4P6DqbO5/bl/rvvlopj5 ymJ7RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwk+BLDPBueCU5m6bwi8yS4+b7bxv 4QZTG7yTA/NWLiM97dK5+Y++7ceffrgnTefY9LAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the nilfs2 code to use default_groups field which has been
the preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 81f35c5b5a40..379d22e28ed6 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -57,7 +57,7 @@ static void nilfs_##name##_attr_release(struct kobject *kobj) \
 	complete(&subgroups->sg_##name##_kobj_unregister); \
 } \
 static struct kobj_type nilfs_##name##_ktype = { \
-	.default_attrs	= nilfs_##name##_attrs, \
+	.default_groups	= nilfs_##name##_groups, \
 	.sysfs_ops	= &nilfs_##name##_attr_ops, \
 	.release	= nilfs_##name##_attr_release, \
 }
@@ -129,6 +129,7 @@ static struct attribute *nilfs_snapshot_attrs[] = {
 	NILFS_SNAPSHOT_ATTR_LIST(README),
 	NULL,
 };
+ATTRIBUTE_GROUPS(nilfs_snapshot);
 
 static ssize_t nilfs_snapshot_attr_show(struct kobject *kobj,
 					struct attribute *attr, char *buf)
@@ -166,7 +167,7 @@ static const struct sysfs_ops nilfs_snapshot_attr_ops = {
 };
 
 static struct kobj_type nilfs_snapshot_ktype = {
-	.default_attrs	= nilfs_snapshot_attrs,
+	.default_groups	= nilfs_snapshot_groups,
 	.sysfs_ops	= &nilfs_snapshot_attr_ops,
 	.release	= nilfs_snapshot_attr_release,
 };
@@ -226,6 +227,7 @@ static struct attribute *nilfs_mounted_snapshots_attrs[] = {
 	NILFS_MOUNTED_SNAPSHOTS_ATTR_LIST(README),
 	NULL,
 };
+ATTRIBUTE_GROUPS(nilfs_mounted_snapshots);
 
 NILFS_DEV_INT_GROUP_OPS(mounted_snapshots, dev);
 NILFS_DEV_INT_GROUP_TYPE(mounted_snapshots, dev);
@@ -339,6 +341,7 @@ static struct attribute *nilfs_checkpoints_attrs[] = {
 	NILFS_CHECKPOINTS_ATTR_LIST(README),
 	NULL,
 };
+ATTRIBUTE_GROUPS(nilfs_checkpoints);
 
 NILFS_DEV_INT_GROUP_OPS(checkpoints, dev);
 NILFS_DEV_INT_GROUP_TYPE(checkpoints, dev);
@@ -428,6 +431,7 @@ static struct attribute *nilfs_segments_attrs[] = {
 	NILFS_SEGMENTS_ATTR_LIST(README),
 	NULL,
 };
+ATTRIBUTE_GROUPS(nilfs_segments);
 
 NILFS_DEV_INT_GROUP_OPS(segments, dev);
 NILFS_DEV_INT_GROUP_TYPE(segments, dev);
@@ -689,6 +693,7 @@ static struct attribute *nilfs_segctor_attrs[] = {
 	NILFS_SEGCTOR_ATTR_LIST(README),
 	NULL,
 };
+ATTRIBUTE_GROUPS(nilfs_segctor);
 
 NILFS_DEV_INT_GROUP_OPS(segctor, dev);
 NILFS_DEV_INT_GROUP_TYPE(segctor, dev);
@@ -816,6 +821,7 @@ static struct attribute *nilfs_superblock_attrs[] = {
 	NILFS_SUPERBLOCK_ATTR_LIST(README),
 	NULL,
 };
+ATTRIBUTE_GROUPS(nilfs_superblock);
 
 NILFS_DEV_INT_GROUP_OPS(superblock, dev);
 NILFS_DEV_INT_GROUP_TYPE(superblock, dev);
@@ -924,6 +930,7 @@ static struct attribute *nilfs_dev_attrs[] = {
 	NILFS_DEV_ATTR_LIST(README),
 	NULL,
 };
+ATTRIBUTE_GROUPS(nilfs_dev);
 
 static ssize_t nilfs_dev_attr_show(struct kobject *kobj,
 				    struct attribute *attr, char *buf)
@@ -961,7 +968,7 @@ static const struct sysfs_ops nilfs_dev_attr_ops = {
 };
 
 static struct kobj_type nilfs_dev_ktype = {
-	.default_attrs	= nilfs_dev_attrs,
+	.default_groups	= nilfs_dev_groups,
 	.sysfs_ops	= &nilfs_dev_attr_ops,
 	.release	= nilfs_dev_attr_release,
 };
-- 
2.34.1

