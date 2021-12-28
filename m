Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08619480976
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhL1NOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhL1NN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:13:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 05:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9016B811EF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CD6C36AE7;
        Tue, 28 Dec 2021 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640697236;
        bh=TiJYERgTkOBuHag5J9cRvcCxRJfFzQ7xp7H7ART9WtU=;
        h=From:To:Cc:Subject:Date:From;
        b=eVJj/sWNOxKh+IymgJqX3o9iXiHd4yUNydRZsYSYRuSzWpjX/IXBn2PmX3pQo2sGE
         3gHzJQMfBfMP2KMgk9KtBBVrGTKB5o3XDMYVz6TTBqxkXtsDZ1f+hXoEBiJhyW6eEI
         EfKan6/NPLrFypYYVF2D3riDjJ0qsH4oziSixFMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cxl: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 14:13:50 +0100
Message-Id: <20211228131350.249532-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; h=from:subject; bh=TiJYERgTkOBuHag5J9cRvcCxRJfFzQ7xp7H7ART9WtU=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnefte74v+MsWPa96phGXNQj+Cb2gctr0odrJ9ru4MxuPJ B54d74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJ8K5nWHDindK5mF9fbyX81JJvff x28cGomc0M88P2XpnY8GOHgZkZi+K7r5nuTCVZ6gA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the cxl code to use default_groups field which has been the
preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/cxl/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index c173a5e88c91..315c43f17dd3 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -570,6 +570,7 @@ static struct attribute *afu_cr_attrs[] = {
 	&class_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(afu_cr);
 
 static void release_afu_config_record(struct kobject *kobj)
 {
@@ -581,7 +582,7 @@ static void release_afu_config_record(struct kobject *kobj)
 static struct kobj_type afu_config_record_type = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = release_afu_config_record,
-	.default_attrs = afu_cr_attrs,
+	.default_groups = afu_cr_groups,
 };
 
 static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int cr_idx)
-- 
2.34.1

