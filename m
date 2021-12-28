Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E2480A73
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhL1OoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:44:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35414 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhL1OoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:44:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A39836122B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8941EC36AEB;
        Tue, 28 Dec 2021 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640702651;
        bh=yybB9ya6ZBM3ufmr5GfKYVQu7RXKpxk3NHOthVfEvqI=;
        h=From:To:Cc:Subject:Date:From;
        b=kxp4/m/8uD+jKG1z91Jl34rLlej8zLRKa0syizx2RPhWWkbXVlMI9+bdpJ6d4CnNc
         zBmEnig4PZCWiRbFo9GWy2iv5GAhA6wxznV9YssPqxKUyyh0hhr3qxDUDo/FHq6q7I
         1bSkB2fzhf+cdeGROlwV1uJeKsOkqivdR3My7KC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [PATCH] orangefs: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 15:44:07 +0100
Message-Id: <20211228144407.391122-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; h=from:subject; bh=yybB9ya6ZBM3ufmr5GfKYVQu7RXKpxk3NHOthVfEvqI=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnlbarqF95ff/hRhWb+RWPD8gti067+Gitxh4vkRvbjByV ptrkd8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEBBcwzGRMOaIcJblywZOM+qYduf pKllwTOhnmV4U7nDJv2byLqSjts1iQx6lilgM5AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the orangfs code to use default_groups field which has been
the preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/orangefs/orangefs-sysfs.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
index 3627ea946402..de80b62553bb 100644
--- a/fs/orangefs/orangefs-sysfs.c
+++ b/fs/orangefs/orangefs-sysfs.c
@@ -894,10 +894,11 @@ static struct attribute *orangefs_default_attrs[] = {
 	&perf_time_interval_secs_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(orangefs_default);
 
 static struct kobj_type orangefs_ktype = {
 	.sysfs_ops = &orangefs_sysfs_ops,
-	.default_attrs = orangefs_default_attrs,
+	.default_groups = orangefs_default_groups,
 };
 
 static struct orangefs_attribute acache_hard_limit_attribute =
@@ -931,10 +932,11 @@ static struct attribute *acache_orangefs_default_attrs[] = {
 	&acache_timeout_msecs_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(acache_orangefs_default);
 
 static struct kobj_type acache_orangefs_ktype = {
 	.sysfs_ops = &orangefs_sysfs_ops,
-	.default_attrs = acache_orangefs_default_attrs,
+	.default_groups = acache_orangefs_default_groups,
 };
 
 static struct orangefs_attribute capcache_hard_limit_attribute =
@@ -968,10 +970,11 @@ static struct attribute *capcache_orangefs_default_attrs[] = {
 	&capcache_timeout_secs_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(capcache_orangefs_default);
 
 static struct kobj_type capcache_orangefs_ktype = {
 	.sysfs_ops = &orangefs_sysfs_ops,
-	.default_attrs = capcache_orangefs_default_attrs,
+	.default_groups = capcache_orangefs_default_groups,
 };
 
 static struct orangefs_attribute ccache_hard_limit_attribute =
@@ -1005,10 +1008,11 @@ static struct attribute *ccache_orangefs_default_attrs[] = {
 	&ccache_timeout_secs_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(ccache_orangefs_default);
 
 static struct kobj_type ccache_orangefs_ktype = {
 	.sysfs_ops = &orangefs_sysfs_ops,
-	.default_attrs = ccache_orangefs_default_attrs,
+	.default_groups = ccache_orangefs_default_groups,
 };
 
 static struct orangefs_attribute ncache_hard_limit_attribute =
@@ -1042,10 +1046,11 @@ static struct attribute *ncache_orangefs_default_attrs[] = {
 	&ncache_timeout_msecs_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(ncache_orangefs_default);
 
 static struct kobj_type ncache_orangefs_ktype = {
 	.sysfs_ops = &orangefs_sysfs_ops,
-	.default_attrs = ncache_orangefs_default_attrs,
+	.default_groups = ncache_orangefs_default_groups,
 };
 
 static struct orangefs_attribute pc_acache_attribute =
@@ -1072,10 +1077,11 @@ static struct attribute *pc_orangefs_default_attrs[] = {
 	&pc_ncache_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(pc_orangefs_default);
 
 static struct kobj_type pc_orangefs_ktype = {
 	.sysfs_ops = &orangefs_sysfs_ops,
-	.default_attrs = pc_orangefs_default_attrs,
+	.default_groups = pc_orangefs_default_groups,
 };
 
 static struct orangefs_attribute stats_reads_attribute =
@@ -1095,10 +1101,11 @@ static struct attribute *stats_orangefs_default_attrs[] = {
 	&stats_writes_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(stats_orangefs_default);
 
 static struct kobj_type stats_orangefs_ktype = {
 	.sysfs_ops = &orangefs_sysfs_ops,
-	.default_attrs = stats_orangefs_default_attrs,
+	.default_groups = stats_orangefs_default_groups,
 };
 
 static struct kobject *orangefs_obj;
-- 
2.34.1

