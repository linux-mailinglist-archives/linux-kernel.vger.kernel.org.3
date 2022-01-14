Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6604348E884
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbiANKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:48:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47366 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiANKs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:48:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E06EB82591
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C2C36AEA;
        Fri, 14 Jan 2022 10:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642157306;
        bh=Juz0pY8LSJErwzrSSYzBtkgWGFYcSVutMWjyQ8i708I=;
        h=From:To:Cc:Subject:Date:From;
        b=NlrF9rbt2g1bnk+A1BHC2MomkZu1nzlePi6dqEs8gpIOPP185DvrNFuccbb46vE3+
         g+y+gDbtReNUt5/v3ovJeygmD8ymZnHcQkRIN5Kn0VfZpofddeWw7u2ubFVdBVfrTk
         Fw2NhvbOV/RJYqfgjssGiv3FBHWLDpmi6fRvKwW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>,
        Stefan Schaeckeler <schaecsn@gmx.net>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2] ubifs: use default_groups in kobj_type
Date:   Fri, 14 Jan 2022 11:48:20 +0100
Message-Id: <20220114104820.1340879-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; h=from:subject; bh=Juz0pY8LSJErwzrSSYzBtkgWGFYcSVutMWjyQ8i708I=; b=owGbwMvMwCRo6H6F97bub03G02pJDIkPQ95OvBMkcfb+JIEU/f81j06m3VRK1gmY4q9ltvW2/PrV lT9edsSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEZhszzE+PPNTxKyR3wZpH+c8S+d ad2v3O/QzDglX14estS7KyHWKzzLvTlJ937W1pAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the ubifs sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Richard Weinberger <richard@nod.at>
Cc: Stefan Schaeckeler <schaecsn@gmx.net>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: fix up the changelog text to properly refer to the ubifs code
    instead of some other subsystem as pointed out by Michael Walle

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

