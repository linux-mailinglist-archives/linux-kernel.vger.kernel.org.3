Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E648DD79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiAMSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:09:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47310 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAMSJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:09:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5ACD61D01
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 18:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6173BC36AEB;
        Thu, 13 Jan 2022 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642097351;
        bh=gRt42SMj1lCizKzhlJnYu7AY+4d/+Mx8SK+T64O9Ob0=;
        h=From:To:Cc:Subject:Date:From;
        b=JUy/9Mx62mGlaxkgP6tNkMx9KBYlsQuCHg4mwdwjRu3eg37uFkqZyEPdEkk9vyMlP
         Z/CEC0E1EBB9f2Gn7Sf+9kY2e7QPrY/xiVlJLQqoIwOb7TnH41Ii1s1EmyclkfpB3J
         wyXvBX94rlq/BU31bwbRsbbgvO7+uyopf4O0yl8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>,
        Stefan Schaeckeler <schaecsn@gmx.net>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] ubifs: use default_groups in kobj_type
Date:   Thu, 13 Jan 2022 19:08:57 +0100
Message-Id: <20220113180857.2158974-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; h=from:subject; bh=gRt42SMj1lCizKzhlJnYu7AY+4d/+Mx8SK+T64O9Ob0=; b=owGbwMvMwCRo6H6F97bub03G02pJDIkPsrbtfpdY6byh4cWL3OdPK54u1V2/U15P32txOhf/IelX FSEvOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiLjMY5pmENK7plCkpPGQW8vaKeH v2rmUbOBnmJ16NcYkQ8Nm7bMmboJQN5W9v1ZzsBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the AMD mce sysfs code to use default_groups field which
has been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Richard Weinberger <richard@nod.at>
Cc: Stefan Schaeckeler <schaecsn@gmx.net>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ubifs/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 7acc5a74e5fa..06ad8fa1fcfb 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -42,6 +42,7 @@ static struct attribute *ubifs_attrs[] = {
 	ATTR_LIST(errors_crc),
 	NULL,
 };
+ATTRIBUTE_GROUPS(ubifs);
 
 static ssize_t ubifs_attr_show(struct kobject *kobj,
 			       struct attribute *attr, char *buf)
@@ -74,7 +75,7 @@ static const struct sysfs_ops ubifs_attr_ops = {
 };
 
 static struct kobj_type ubifs_sb_ktype = {
-	.default_attrs	= ubifs_attrs,
+	.default_groups	= ubifs_groups,
 	.sysfs_ops	= &ubifs_attr_ops,
 	.release	= ubifs_sb_release,
 };
-- 
2.34.1

