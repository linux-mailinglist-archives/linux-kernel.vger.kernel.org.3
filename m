Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607F0480A76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhL1OpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhL1OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:45:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:45:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175476120F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02116C36AE8;
        Tue, 28 Dec 2021 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640702720;
        bh=AdmCkg1Q5igTM2IOejM4lF5V1/tPIkgeLGQAEFlo7I0=;
        h=From:To:Cc:Subject:Date:From;
        b=nq/eQiCsPcuWHKvNdWmAi1ddR1rU8PGvnFmq44oz7iiW+Hj2vpC/obJUiRZrRhEhY
         8pZZZtaDGEVM2io//T19Nio64kRAjHRHgOfOZfAQYn10FV6mYILYBXY1g1K1cKNnT3
         np/dS5PFxFi+hEfrhdylHZmFG3uaCt0omnMkgk8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH] ocfs2: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 15:45:17 +0100
Message-Id: <20211228144517.391660-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; h=from:subject; bh=AdmCkg1Q5igTM2IOejM4lF5V1/tPIkgeLGQAEFlo7I0=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnlf5yHOUzLWqL1K04tzQ7oLuVWbll0vQpIrdT3G/t2uHY qKfUEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABO51cwwV3j3kaX/WAScm9u3mAhtZv mUI1DbyrBgUiAvX8Gd8/w/N2ckdLH3LinYccoRAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the ocfs2 code to use default_groups field which has been
the preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@oss.oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/filecheck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index de56e6231af8..1ad7106741f8 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -94,6 +94,7 @@ static struct attribute *ocfs2_filecheck_attrs[] = {
 	&ocfs2_filecheck_attr_set.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(ocfs2_filecheck);
 
 static void ocfs2_filecheck_release(struct kobject *kobj)
 {
@@ -138,7 +139,7 @@ static const struct sysfs_ops ocfs2_filecheck_ops = {
 };
 
 static struct kobj_type ocfs2_ktype_filecheck = {
-	.default_attrs = ocfs2_filecheck_attrs,
+	.default_groups = ocfs2_filecheck_groups,
 	.sysfs_ops = &ocfs2_filecheck_ops,
 	.release = ocfs2_filecheck_release,
 };
-- 
2.34.1

