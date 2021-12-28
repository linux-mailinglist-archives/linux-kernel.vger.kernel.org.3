Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349B5480978
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhL1NOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhL1NOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:14:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15863C061574;
        Tue, 28 Dec 2021 05:14:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C668EB811EF;
        Tue, 28 Dec 2021 13:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F1DC36AE8;
        Tue, 28 Dec 2021 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640697272;
        bh=8jpFq1AYq4RbTwegXdsNwRM8niXpio96faqJOItKqDU=;
        h=From:To:Cc:Subject:Date:From;
        b=fqkHnQqQu//4HxNkavBwcqWzCiCf8SAtsZw8sdCQDPSAyJ8TfceUyiGM38gPqMq7y
         TLtotPhaGhKykMKK0wMa+K1gv27xsM0pdZ6lpxzJMvhSnOf7QBOR/HogHX73bZKnia
         DpU0CkqiDbx+1JDz6fFULUI7aT+TQy2JyZ1yrQZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: sysfs: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 14:14:23 +0100
Message-Id: <20211228131423.249752-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; h=from:subject; bh=8jpFq1AYq4RbTwegXdsNwRM8niXpio96faqJOItKqDU=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnedcfMPgyZdv/vVpdtRvW8Jvt0GNKUpo+lfPZ2osbnqaV /zws3BHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATqUxhmCs/z2/ZTI7F+4Vs/vEUar 2u3CW2q41hvvPqFk2/kJCZIqWhqs0/z0/4PenWUQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the ACPI sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/cppc_acpi.c    | 3 ++-
 drivers/acpi/device_sysfs.c | 3 ++-
 drivers/acpi/sysfs.c        | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a85c351589be..d251b2a1cd15 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -179,10 +179,11 @@ static struct attribute *cppc_attrs[] = {
 	&lowest_freq.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(cppc);
 
 static struct kobj_type cppc_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
-	.default_attrs = cppc_attrs,
+	.default_groups = cppc_groups,
 };
 
 static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 61271e61c307..d5d6403ba07b 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -53,6 +53,7 @@ static struct attribute *acpi_data_node_default_attrs[] = {
 	&data_node_path.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(acpi_data_node_default);
 
 #define to_data_node(k) container_of(k, struct acpi_data_node, kobj)
 #define to_attr(a) container_of(a, struct acpi_data_node_attr, attr)
@@ -79,7 +80,7 @@ static void acpi_data_node_release(struct kobject *kobj)
 
 static struct kobj_type acpi_data_node_ktype = {
 	.sysfs_ops = &acpi_data_node_sysfs_ops,
-	.default_attrs = acpi_data_node_default_attrs,
+	.default_groups = acpi_data_node_default_groups,
 	.release = acpi_data_node_release,
 };
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 00c0ebaab29f..a4b638bea6f1 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -939,10 +939,11 @@ static struct attribute *hotplug_profile_attrs[] = {
 	&hotplug_enabled_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(hotplug_profile);
 
 static struct kobj_type acpi_hotplug_profile_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
-	.default_attrs = hotplug_profile_attrs,
+	.default_groups = hotplug_profile_groups,
 };
 
 void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
-- 
2.34.1

