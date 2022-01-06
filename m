Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4EE4862D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiAFKUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:20:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38064 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiAFKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:20:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C148B82027
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8ADC36AE3;
        Thu,  6 Jan 2022 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641464431;
        bh=W9u8F+egG7FJT2/aw81C8uDLm3ZwqvfOJn6J5z/Jd3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=gGY6KgsrLpLgla+eN+5WgKdMkTjJGQIpcB1g1A9mSDmA9l3WGrytXxWsql6zk/PU5
         xD++mpPci/kq9fGtUTzLXbgp+iaU8nNjb3M1eOHLIUe7H53oi1lwVoiHmIjeDu2qbH
         nWGqkjm3SYMtSrLJIe3mxq83fYx68zHZplROyB3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH] ocfs2: cluster: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 11:20:28 +0100
Message-Id: <20220106102028.3345634-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; h=from:subject; bh=W9u8F+egG7FJT2/aw81C8uDLm3ZwqvfOJn6J5z/Jd3Q=; b=owGbwMvMwCRo6H6F97bub03G02pJDInXDuVo7ey6n/KjoHDJd/7fCexs7PFCGwStrm8NbSgK+/Pp 9k3vjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhI6i2G+QGXdhg/1EsusE/bwaES82 dn7oSekwzzPcuaBUIjfgfUXzt5vfGTAltVQAwbAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the ocfs2 cluster sysfs code to use default_groups field
which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ocfs2-devel@oss.oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/cluster/masklog.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 810d32815593..563881ddbf00 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -120,7 +120,8 @@ static struct mlog_attribute mlog_attrs[MLOG_MAX_BITS] = {
 	define_mask(KTHREAD),
 };
 
-static struct attribute *mlog_attr_ptrs[MLOG_MAX_BITS] = {NULL, };
+static struct attribute *mlog_default_attrs[MLOG_MAX_BITS] = {NULL, };
+ATTRIBUTE_GROUPS(mlog_default);
 
 static ssize_t mlog_show(struct kobject *obj, struct attribute *attr,
 			 char *buf)
@@ -144,8 +145,8 @@ static const struct sysfs_ops mlog_attr_ops = {
 };
 
 static struct kobj_type mlog_ktype = {
-	.default_attrs = mlog_attr_ptrs,
-	.sysfs_ops     = &mlog_attr_ops,
+	.default_groups = mlog_default_groups,
+	.sysfs_ops      = &mlog_attr_ops,
 };
 
 static struct kset mlog_kset = {
@@ -157,10 +158,10 @@ int mlog_sys_init(struct kset *o2cb_kset)
 	int i = 0;
 
 	while (mlog_attrs[i].attr.mode) {
-		mlog_attr_ptrs[i] = &mlog_attrs[i].attr;
+		mlog_default_attrs[i] = &mlog_attrs[i].attr;
 		i++;
 	}
-	mlog_attr_ptrs[i] = NULL;
+	mlog_default_attrs[i] = NULL;
 
 	kobject_set_name(&mlog_kset.kobj, "logmask");
 	mlog_kset.kobj.kset = o2cb_kset;
-- 
2.34.1

