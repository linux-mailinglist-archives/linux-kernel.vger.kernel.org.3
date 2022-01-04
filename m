Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F7484026
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiADKue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiADKub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:50:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42971C061761;
        Tue,  4 Jan 2022 02:50:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE5B6B811A5;
        Tue,  4 Jan 2022 10:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E7BC36AF2;
        Tue,  4 Jan 2022 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641293428;
        bh=mAUGebqXskPLCUJRFijZL3xQHDpHsqHI/qSoj0jDxko=;
        h=From:To:Cc:Subject:Date:From;
        b=0lleZ7Ebpcqiakc0wipvi1+6w/O8bZRrieTCJzg0eKXVHGAZ05cHzafpAWGPek4dI
         GvLXkaQOBxT6AkFqXluSyumiziGlTvedmAUqxtYWZS7FXBIy3xEmDkZn0pMs3D8zT4
         HsjC/b04ejN8IIdkab2IYmFGS/hdKYRxTT1FBUYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] kobject documentation: remove default_attrs information
Date:   Tue,  4 Jan 2022 11:50:24 +0100
Message-Id: <20220104105024.1014313-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458; h=from:subject; bh=mAUGebqXskPLCUJRFijZL3xQHDpHsqHI/qSoj0jDxko=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlX1LKYz3Tx3VkXN+WydLZh7OWa5t+ub7fErItb+bws1+Ok zNyZHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRT4sZ5vBvOiHteftifE/9pocBZ5 W/REeJ3mRYsJV7+bqJCxte2jLoNO/YyXqo8rPNIwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit aa30f47cf666 ("kobject: Add support for default attribute
groups to kobj_type") we have been encouraging the use of default_groups
instead of default_attrs, so reflect that information in the
documentation as well so that no new users get added while the kernel is
converted over to not use this field anymore.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/core-api/kobject.rst                    | 5 ++---
 Documentation/translations/zh_CN/core-api/kobject.rst | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/kobject.rst b/Documentation/core-api/kobject.rst
index 3d6e3107315d..7310247310a0 100644
--- a/Documentation/core-api/kobject.rst
+++ b/Documentation/core-api/kobject.rst
@@ -299,7 +299,6 @@ kobj_type::
     struct kobj_type {
             void (*release)(struct kobject *kobj);
             const struct sysfs_ops *sysfs_ops;
-            struct attribute **default_attrs;
             const struct attribute_group **default_groups;
             const struct kobj_ns_type_operations *(*child_ns_type)(struct kobject *kobj);
             const void *(*namespace)(struct kobject *kobj);
@@ -313,10 +312,10 @@ call kobject_init() or kobject_init_and_add().
 
 The release field in struct kobj_type is, of course, a pointer to the
 release() method for this type of kobject. The other two fields (sysfs_ops
-and default_attrs) control how objects of this type are represented in
+and default_groups) control how objects of this type are represented in
 sysfs; they are beyond the scope of this document.
 
-The default_attrs pointer is a list of default attributes that will be
+The default_groups pointer is a list of default attributes that will be
 automatically created for any kobject that is registered with this ktype.
 
 
diff --git a/Documentation/translations/zh_CN/core-api/kobject.rst b/Documentation/translations/zh_CN/core-api/kobject.rst
index 95634083dca0..0747b472fdea 100644
--- a/Documentation/translations/zh_CN/core-api/kobject.rst
+++ b/Documentation/translations/zh_CN/core-api/kobject.rst
@@ -258,7 +258,6 @@ kobject_put()以避免错误的发生是一个很好的做法。
     struct kobj_type {
             void (*release)(struct kobject *kobj);
             const struct sysfs_ops *sysfs_ops;
-            struct attribute **default_attrs;
             const struct attribute_group **default_groups;
             const struct kobj_ns_type_operations *(*child_ns_type)(struct kobject *kobj);
             const void *(*namespace)(struct kobject *kobj);
@@ -271,10 +270,10 @@ kobject_init()或kobject_init_and_add()时必须指定一个指向该结构的
 指针。
 
 当然，kobj_type结构中的release字段是指向这种类型的kobject的release()
-方法的一个指针。另外两个字段（sysfs_ops 和 default_attrs）控制这种
+方法的一个指针。另外两个字段（sysfs_ops 和 default_groups）控制这种
 类型的对象如何在 sysfs 中被表示；它们超出了本文的范围。
 
-default_attrs 指针是一个默认属性的列表，它将为任何用这个 ktype 注册
+default_groups 指针是一个默认属性的列表，它将为任何用这个 ktype 注册
 的 kobject 自动创建。
 
 
-- 
2.34.1

