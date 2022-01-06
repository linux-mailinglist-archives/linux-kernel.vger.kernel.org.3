Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93276486297
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbiAFKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:02:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59694 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiAFKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:02:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C2FB82019
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1286AC36AEB;
        Thu,  6 Jan 2022 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641463354;
        bh=nWpfhqeUNsMenldA6XtXHKDmNMj1tVKZw2i27a1ToaI=;
        h=From:To:Cc:Subject:Date:From;
        b=PBu2ijQf/hD4a0Kc/qzmPDW/F0/I/+54qiyCdJM+6XVYvdvkjWq4nW86ToGeZIUSv
         kKzPm6VcaGJy5NmFkMvFhxmn7I5VzOZ8IDh34YcYEw9az7ZHGj0itPIC0DipEmoEA8
         9hQ/WD67qlB9nOuEllWrgbKb71ix2uESJV5ZRfAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: [PATCH] dm sysfs: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 11:02:31 +0100
Message-Id: <20220106100231.3278554-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; h=from:subject; bh=nWpfhqeUNsMenldA6XtXHKDmNMj1tVKZw2i27a1ToaI=; b=owGbwMvMwCRo6H6F97bub03G02pJDInX9pm721h9/vCaT99umfH194E8JRMqlPsmNe9dEpbBLOT0 c92XjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIijsM8wxmFtpOe3xvzRfV9SFVt3 qn/Ymc84dhnn7Ql+mXDDKfzqsvV9WWX37drbJpJwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the dm sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
index a05fcd50e1b9..e28c92478536 100644
--- a/drivers/md/dm-sysfs.c
+++ b/drivers/md/dm-sysfs.c
@@ -112,6 +112,7 @@ static struct attribute *dm_attrs[] = {
 	&dm_attr_rq_based_seq_io_merge_deadline.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(dm);
 
 static const struct sysfs_ops dm_sysfs_ops = {
 	.show	= dm_attr_show,
@@ -120,7 +121,7 @@ static const struct sysfs_ops dm_sysfs_ops = {
 
 static struct kobj_type dm_ktype = {
 	.sysfs_ops	= &dm_sysfs_ops,
-	.default_attrs	= dm_attrs,
+	.default_groups	= dm_groups,
 	.release	= dm_kobject_release,
 };
 
-- 
2.34.1

