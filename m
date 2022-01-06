Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EE48654C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiAFNb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:31:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48112 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAFNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:31:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B1A261BF5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D942C36AE5;
        Thu,  6 Jan 2022 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641475914;
        bh=OZjItfWzgrYcIfF0sJ+mwadsUO8MC4PRJXOXjQa54KQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pqNkByMdXPvKiscJhbY+E0GlsAcMWZSXqeGoOwthU7VOPWWD1tqx1P0UptZvYXiCp
         8lTYzNOEzD/Xnj+X0AZCJBvZ2nMaxX6T3rSoCPzAot8GW4kyQQJgzxkiyvfU3kH05v
         64CkikjFwM6HQDjek3jBdqd4oNy1NAB4OHauvFwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] kobject: kobj_type: remove default_attrs
Date:   Thu,  6 Jan 2022 14:31:51 +0100
Message-Id: <20220106133151.607703-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3724; h=from:subject; bh=OZjItfWzgrYcIfF0sJ+mwadsUO8MC4PRJXOXjQa54KQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDInX3rv+64xOmXKt3W66/Kc4d8PbXznyQ0LnPj14PZSNe60o 6x63jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIFi6GeUrMAQrhD19dYdJRNTbbdX zy2j1pdxnmxwbd/73xlXvaudXhIT3fpf0bZ58MAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all in-kernel users of default_attrs for the kobj_type are gone
and converted to properly use the default_groups pointer instead, it can
be safely removed.

There is one standard way to create sysfs files in a kobj_type, and not
two like before, causing confusion as to which should be used.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this can only be applied after all of the "use default_groups in
kobj_type" patches that have been sent to lkml over the past week or so
are applied to the tree.  I'll keep it in a branch for now for 0-day
build testing, but will only queue it up probably after 5.17-rc1 or
later after everything is fixed up.  Posting it here for review and
archival purposes.

 fs/sysfs/file.c         | 13 -------------
 include/linux/kobject.h |  1 -
 lib/kobject.c           | 32 --------------------------------
 3 files changed, 46 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 42dcf96881b6..a12ac0356c69 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -703,19 +703,6 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
 
 	ktype = get_ktype(kobj);
 	if (ktype) {
-		struct attribute **kattr;
-
-		/*
-		 * Change owner of the default attributes associated with the
-		 * ktype of @kobj.
-		 */
-		for (kattr = ktype->default_attrs; kattr && *kattr; kattr++) {
-			error = sysfs_file_change_owner(kobj, (*kattr)->name,
-							kuid, kgid);
-			if (error)
-				return error;
-		}
-
 		/*
 		 * Change owner of the default groups associated with the
 		 * ktype of @kobj.
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c7b47399b36a..57fb972fea05 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -120,7 +120,6 @@ extern char *kobject_get_path(struct kobject *kobj, gfp_t flag);
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;
-	struct attribute **default_attrs;	/* use default_groups instead */
 	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(struct kobject *kobj);
 	const void *(*namespace)(struct kobject *kobj);
diff --git a/lib/kobject.c b/lib/kobject.c
index 56fa037501b5..5f0e71ab292c 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -54,32 +54,6 @@ void kobject_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 		kobj->ktype->get_ownership(kobj, uid, gid);
 }
 
-/*
- * populate_dir - populate directory with attributes.
- * @kobj: object we're working on.
- *
- * Most subsystems have a set of default attributes that are associated
- * with an object that registers with them.  This is a helper called during
- * object registration that loops through the default attributes of the
- * subsystem and creates attributes files for them in sysfs.
- */
-static int populate_dir(struct kobject *kobj)
-{
-	const struct kobj_type *t = get_ktype(kobj);
-	struct attribute *attr;
-	int error = 0;
-	int i;
-
-	if (t && t->default_attrs) {
-		for (i = 0; (attr = t->default_attrs[i]) != NULL; i++) {
-			error = sysfs_create_file(kobj, attr);
-			if (error)
-				break;
-		}
-	}
-	return error;
-}
-
 static int create_dir(struct kobject *kobj)
 {
 	const struct kobj_type *ktype = get_ktype(kobj);
@@ -90,12 +64,6 @@ static int create_dir(struct kobject *kobj)
 	if (error)
 		return error;
 
-	error = populate_dir(kobj);
-	if (error) {
-		sysfs_remove_dir(kobj);
-		return error;
-	}
-
 	if (ktype) {
 		error = sysfs_create_groups(kobj, ktype->default_groups);
 		if (error) {
-- 
2.34.1

