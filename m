Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7548461F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiADQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:43:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53242 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiADQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:43:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 671DEB81763;
        Tue,  4 Jan 2022 16:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8510EC36AED;
        Tue,  4 Jan 2022 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641314635;
        bh=xfaQ4ZzPEkHlGDP1oPu71K7zPIoKMUYF4oJjqhQj2pw=;
        h=From:To:Cc:Subject:Date:From;
        b=nWUIdWB3cI72NVFVjkUK5lU9QXAU1fDECfFIcLQ9AKL/lUVJRnmGdGYjTJ+j9Lpdz
         OWPrHwQaOrMB5alB6XS7aQkulNwyVgCDaREcBDzXEAS9L7YQ9SOGjX27kc0QDoBi34
         Oglpq9z/kdCRdpP69a58uiSUEC5f/4YfbGSrOFFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 17:43:51 +0100
Message-Id: <20220104164351.1360316-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; h=from:subject; bh=xfaQ4ZzPEkHlGDP1oPu71K7zPIoKMUYF4oJjqhQj2pw=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXKl1f3rv+T2yBddPG9zbyewL6bO+vse0+k732Vsj2ALkH sty/OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAimyMZ5opM+mDhf/6Xf99Jr+KcU5 4eUq0bBRnmlxzlSL0Rq/303Prg2HCnqpQT1dN4AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the cpuidle sysfs code to use default_groups field which
has been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 469e18547d06..565ed005833a 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -335,6 +335,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_default_status.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(cpuidle_state_default);
 
 struct cpuidle_state_kobj {
 	struct cpuidle_state *state;
@@ -448,7 +449,7 @@ static void cpuidle_state_sysfs_release(struct kobject *kobj)
 
 static struct kobj_type ktype_state_cpuidle = {
 	.sysfs_ops = &cpuidle_state_sysfs_ops,
-	.default_attrs = cpuidle_state_default_attrs,
+	.default_groups = cpuidle_state_default_groups,
 	.release = cpuidle_state_sysfs_release,
 };
 
@@ -591,10 +592,11 @@ static struct attribute *cpuidle_driver_default_attrs[] = {
 	&attr_driver_name.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(cpuidle_driver_default);
 
 static struct kobj_type ktype_driver_cpuidle = {
 	.sysfs_ops = &cpuidle_driver_sysfs_ops,
-	.default_attrs = cpuidle_driver_default_attrs,
+	.default_groups = cpuidle_driver_default_groups,
 	.release = cpuidle_driver_sysfs_release,
 };
 
-- 
2.34.1

