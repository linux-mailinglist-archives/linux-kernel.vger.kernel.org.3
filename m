Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F5480974
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhL1NNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhL1NN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:13:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E4CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 05:13:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D491B61193
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34B1C36AE8;
        Tue, 28 Dec 2021 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640697208;
        bh=IY1JSY+ns2iXA1O9Jn1pf+rlk1MoRrQelWyTgIJQcKs=;
        h=From:To:Cc:Subject:Date:From;
        b=xEptiuoBRrGHiJ6bC9EXO3r/UUL/rHZsDi4iTq9m0PXV3Vw2zNKB+VWscjigOKjwo
         gu/xBJagh2jVRcuFjrbNAwt9EDuTDt/L/ZHh6v3vArIc1ghbjCIRAfydSsHIvF5TZI
         Da+jaPxZr0bRBCB7b1u4VbHP84JOVSZWfWMPeS8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] UIO: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 14:13:19 +0100
Message-Id: <20211228131319.249324-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; h=from:subject; bh=IY1JSY+ns2iXA1O9Jn1pf+rlk1MoRrQelWyTgIJQcKs=; b=owGbwMvMwCRo6H6F97bub03G02pJDImneXPv2mSHxh/yOxP1eJ/08Reb/q6ZyrUkhEHsr7yfdsg2 nksCHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARCwmGeVo2X74Ypb5Zb+N9XfwCR/ u+xdY1NQzzbDZe26FrdXGVffkz9Uxp26oIJ95MAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the UIO code to use default_groups field which has been the
preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index ea96e319c8a0..43afbb7c5ab9 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -83,13 +83,14 @@ static struct map_sysfs_entry size_attribute =
 static struct map_sysfs_entry offset_attribute =
 	__ATTR(offset, S_IRUGO, map_offset_show, NULL);
 
-static struct attribute *attrs[] = {
+static struct attribute *map_attrs[] = {
 	&name_attribute.attr,
 	&addr_attribute.attr,
 	&size_attribute.attr,
 	&offset_attribute.attr,
 	NULL,	/* need to NULL terminate the list of attributes */
 };
+ATTRIBUTE_GROUPS(map);
 
 static void map_release(struct kobject *kobj)
 {
@@ -119,7 +120,7 @@ static const struct sysfs_ops map_sysfs_ops = {
 static struct kobj_type map_attr_type = {
 	.release	= map_release,
 	.sysfs_ops	= &map_sysfs_ops,
-	.default_attrs	= attrs,
+	.default_groups	= map_groups,
 };
 
 struct uio_portio {
@@ -178,6 +179,7 @@ static struct attribute *portio_attrs[] = {
 	&portio_porttype_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(portio);
 
 static void portio_release(struct kobject *kobj)
 {
@@ -207,7 +209,7 @@ static const struct sysfs_ops portio_sysfs_ops = {
 static struct kobj_type portio_attr_type = {
 	.release	= portio_release,
 	.sysfs_ops	= &portio_sysfs_ops,
-	.default_attrs	= portio_attrs,
+	.default_groups	= portio_groups,
 };
 
 static ssize_t name_show(struct device *dev,
-- 
2.34.1

