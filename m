Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691584862A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiAFKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:03:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38630 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiAFKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:03:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6439D61671;
        Thu,  6 Jan 2022 10:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3F6C36AE5;
        Thu,  6 Jan 2022 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641463418;
        bh=KFWyjx1BkuXLv8yzjWsH/m2TYNLsl9IwdLd6y1DXRKU=;
        h=From:To:Cc:Subject:Date:From;
        b=ddwopC1Fw6i5MX4RXUlhcY6Qy4GfNYTgzBmFzMfOjms372m13ZudIRxAx34roSZ1Q
         xlsDs+why3iBIdF7IQ5sqP0v0idmQw8/f8SUCrBLw3tZn6YPHbhIc8pbEzwlajbmHo
         7Q9Uycd9FSBrKiJdiYTj05KvpHhTLoS04oxvh5DI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH] md: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 11:03:35 +0100
Message-Id: <20220106100335.3279066-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; h=from:subject; bh=KFWyjx1BkuXLv8yzjWsH/m2TYNLsl9IwdLd6y1DXRKU=; b=owGbwMvMwCRo6H6F97bub03G02pJDInX9pU7Ju3Y/ZIxW+7OOo8SmW05cz8nxG7SV/aYnfSHY53i RM9/HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRQ2sZFsx9IKXy9vWVl813f1T0XJ v0aJXjsTsMCxqvqG9tOVin/0cxbcexr1ZLvj+92QsA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the md rdev sysfs code to use default_groups field which
has been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5111ed966947..7642f3fb38e6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3602,6 +3602,7 @@ static struct attribute *rdev_default_attrs[] = {
 	&rdev_ppl_size.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(rdev_default);
 static ssize_t
 rdev_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
@@ -3651,7 +3652,7 @@ static const struct sysfs_ops rdev_sysfs_ops = {
 static struct kobj_type rdev_ktype = {
 	.release	= rdev_free,
 	.sysfs_ops	= &rdev_sysfs_ops,
-	.default_attrs	= rdev_default_attrs,
+	.default_groups	= rdev_default_groups,
 };
 
 int md_rdev_init(struct md_rdev *rdev)
-- 
2.34.1

