Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56E4845EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiADQWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiADQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:22:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E89C061761;
        Tue,  4 Jan 2022 08:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6690BB81219;
        Tue,  4 Jan 2022 16:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE1CC36AED;
        Tue,  4 Jan 2022 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641313365;
        bh=wAmOVR9T9kyBtatsOPxWi2y7XzvNVY3MrgYex4P3wCM=;
        h=From:To:Cc:Subject:Date:From;
        b=fylmKqvxzFxnInU8kzn7jQampyiZTVLSzie5jFAIa0yL/k+RqMySaeprVz/UoXT/S
         XYe89jBgRuSzUsYnmch/B7KrnkunJssJQyGt3T557ecB3V7hp956+ncsTd6X/MYyXG
         GoRpXAXn0qHbn9FJnjeiGAZzLe3ofakukWxjkgeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH] sh: sq: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 17:22:40 +0100
Message-Id: <20220104162240.1309639-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; h=from:subject; bh=wAmOVR9T9kyBtatsOPxWi2y7XzvNVY3MrgYex4P3wCM=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXSvwPJ5rHTF2TOGnm7ma1dJaYHD2O158PnDi/1uPN+cMT fvind8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEKr8zzBXVDLymu9FskrYY020zId vY5Xk6bgzzTLQ21Hi2PTXMUBYOvX/1Wofu6u3/AQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the sh sq sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/kernel/cpu/sh4/sq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index d432164b23b7..a76b94e41e91 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -324,6 +324,7 @@ static struct attribute *sq_sysfs_attrs[] = {
 	&mapping_attr.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(sq_sysfs);
 
 static const struct sysfs_ops sq_sysfs_ops = {
 	.show	= sq_sysfs_show,
@@ -332,7 +333,7 @@ static const struct sysfs_ops sq_sysfs_ops = {
 
 static struct kobj_type ktype_percpu_entry = {
 	.sysfs_ops	= &sq_sysfs_ops,
-	.default_attrs	= sq_sysfs_attrs,
+	.default_groups	= sq_sysfs_groups,
 };
 
 static int sq_dev_add(struct device *dev, struct subsys_interface *sif)
-- 
2.34.1

