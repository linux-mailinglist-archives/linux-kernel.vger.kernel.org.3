Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5676B4813D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhL2OJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbhL2OJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:09:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFB9C061574;
        Wed, 29 Dec 2021 06:09:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F447614AF;
        Wed, 29 Dec 2021 14:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916FCC36AE9;
        Wed, 29 Dec 2021 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640786952;
        bh=88kqdA+xI+3rnGnYil6mHZwNPE8XhAFpQsO+Eb69dkw=;
        h=From:To:Cc:Subject:Date:From;
        b=mgildSj+syIkCn2EB5ubNeekfH9JyapYwFeWIs5OTHXDOZVRp5hwQFonoz0Fo6EYl
         obYRfFO9poUHL2YhNfT37s8IN0hlm+CiA9gF+8tAnhXFbN/DVNRVJwqqDmllTjfLGZ
         N4o048JH2y1ISv7Tcg6BGGlM9y04Q+zH6s+zT050=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power_supply: ab8500: use default_groups in kobj_type
Date:   Wed, 29 Dec 2021 15:09:08 +0100
Message-Id: <20211229140908.2523513-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; h=from:subject; bh=88kqdA+xI+3rnGnYil6mHZwNPE8XhAFpQsO+Eb69dkw=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlnchg7THLiUiv2MrZ9zt6UKPiq9ej76slHZIN+/us72yP2 XH5ORywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkag/DPBV26WnSbQt9t//qPbGRf+ 0635l3NzIsuLh5Z/qNmf2blRpTImICJ74UYJ3zBgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the ab8500 power supply sysfs code to use default_groups
field which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/ab8500_chargalg.c | 5 +++--
 drivers/power/supply/ab8500_fg.c       | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index ff4b26b1ceca..42689ac2d898 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1865,11 +1865,12 @@ static ssize_t ab8500_chargalg_sysfs_charger(struct kobject *kobj,
 	return entry->store(di, buf, length);
 }
 
-static struct attribute *ab8500_chargalg_chg[] = {
+static struct attribute *ab8500_chargalg_attrs[] = {
 	&ab8500_chargalg_en_charger.attr,
 	&ab8500_chargalg_curr_step.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(ab8500_chargalg);
 
 static const struct sysfs_ops ab8500_chargalg_sysfs_ops = {
 	.show = ab8500_chargalg_sysfs_show,
@@ -1878,7 +1879,7 @@ static const struct sysfs_ops ab8500_chargalg_sysfs_ops = {
 
 static struct kobj_type ab8500_chargalg_ktype = {
 	.sysfs_ops = &ab8500_chargalg_sysfs_ops,
-	.default_attrs = ab8500_chargalg_chg,
+	.default_groups = ab8500_chargalg_groups,
 };
 
 /**
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 05fe9724ba50..6820e19380b5 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2514,10 +2514,11 @@ static struct attribute *ab8500_fg_attrs[] = {
 	&charge_now_attr.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(ab8500_fg);
 
 static struct kobj_type ab8500_fg_ktype = {
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
-	.default_attrs = ab8500_fg_attrs,
+	.default_groups = ab8500_fg_groups,
 };
 
 /**
-- 
2.34.1

