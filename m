Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A448580A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiAESR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:17:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51134 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiAESR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:17:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7654B81CE8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121E1C36AE0;
        Wed,  5 Jan 2022 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641406643;
        bh=IvYvq2lD1COKHPMNCP7CW/S4RSWAMCAG8xA8pmvjwx4=;
        h=From:To:Cc:Subject:Date:From;
        b=EfFr67UqdVrB77F65fhTXrZX6OiWRv1QfiyYsj/2Yh+XznyJSfo2as0euG6md3ACG
         NToIdKmC7WAgeGJCgNShUCb8HUPHMGixfFZUbFNzuf/fpREYlaq0ThkkuVUHDyYbDg
         X3VOy2Wzo2IKKj2ivqSHVbz79r0ET5Ox7hByYqqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] firmware: dmi-sysfs: use default_groups in kobj_type
Date:   Wed,  5 Jan 2022 19:17:19 +0100
Message-Id: <20220105181719.2737782-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; h=from:subject; bh=IvYvq2lD1COKHPMNCP7CW/S4RSWAMCAG8xA8pmvjwx4=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXH6z1PzTl5Jpju+b1bF1wUXzn/4UrZWW/nxVkv+R3ao7/ y9iFCh2xLAyCTAyyYoosX7bxHN1fcUjRy9D2NMwcViaQIQxcnAIwkRPuDHPl7TqXni3/xKjz41ZwVb 3X/eK3W/kZFhw4PM3z/wn96Cp1+y/6qW+NrrEyLQMA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the firmware dmi-sysfs sysfs code to use default_groups
field which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/dmi-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 8b8127fa8955..3a353776bd34 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -302,12 +302,12 @@ static struct attribute *dmi_sysfs_sel_attrs[] = {
 	&dmi_sysfs_attr_sel_per_log_type_descriptor_length.attr,
 	NULL,
 };
-
+ATTRIBUTE_GROUPS(dmi_sysfs_sel);
 
 static struct kobj_type dmi_system_event_log_ktype = {
 	.release = dmi_entry_free,
 	.sysfs_ops = &dmi_sysfs_specialize_attr_ops,
-	.default_attrs = dmi_sysfs_sel_attrs,
+	.default_groups = dmi_sysfs_sel_groups,
 };
 
 typedef u8 (*sel_io_reader)(const struct dmi_system_event_log *sel,
@@ -518,6 +518,7 @@ static struct attribute *dmi_sysfs_entry_attrs[] = {
 	&dmi_sysfs_attr_entry_position.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(dmi_sysfs_entry);
 
 static ssize_t dmi_entry_raw_read_helper(struct dmi_sysfs_entry *entry,
 					 const struct dmi_header *dh,
@@ -565,7 +566,7 @@ static void dmi_sysfs_entry_release(struct kobject *kobj)
 static struct kobj_type dmi_sysfs_entry_ktype = {
 	.release = dmi_sysfs_entry_release,
 	.sysfs_ops = &dmi_sysfs_attr_ops,
-	.default_attrs = dmi_sysfs_entry_attrs,
+	.default_groups = dmi_sysfs_entry_groups,
 };
 
 static struct kset *dmi_kset;
-- 
2.34.1

