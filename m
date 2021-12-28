Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C692F480A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhL1Oqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:46:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36438 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhL1Oqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:46:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F8561206;
        Tue, 28 Dec 2021 14:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C649FC36AE7;
        Tue, 28 Dec 2021 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640702806;
        bh=7QmQFTuH0XTu0e1hnmgspwVA25nkTIM2NllnaBShhUo=;
        h=From:To:Cc:Subject:Date:From;
        b=yiXPeZXy8tKOGrjMzxK2vBAeju64zY0yq9HOgAS3v9qLx0XrKPSsMgq2IS14kIPGw
         swPR+7RK20i6b/TYj37MOKG01mLErC38PsItdt+Vb0fRvS04elGZ1lb1Ds0bgyTHcK
         RcQsGf0IpCqzECCnaTMARLkvMwMvFIR97oHJTOR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH] xfs: sysfs: use default_groups in kobj_type
Date:   Tue, 28 Dec 2021 15:46:41 +0100
Message-Id: <20211228144641.392347-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; h=from:subject; bh=7QmQFTuH0XTu0e1hnmgspwVA25nkTIM2NllnaBShhUo=; b=owGbwMvMwCRo6H6F97bub03G02pJDImnlQN3vtJ4FRoc+m5C6aKbmf8/Kzib7k+o8V946/jt345x WtyPOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiLp8Z5hnMXVF5T3HOZJeZh71n3f 7j7NBZ2sYwP02yMGdWtO/6zc93bmNW/2uRae70FQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the xfs sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_error.c |  3 ++-
 fs/xfs/xfs_sysfs.c | 16 ++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 81c445e9489b..749fd18c4f32 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -213,11 +213,12 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(ag_resv_fail),
 	NULL,
 };
+ATTRIBUTE_GROUPS(xfs_errortag);
 
 static struct kobj_type xfs_errortag_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_errortag_sysfs_ops,
-	.default_attrs = xfs_errortag_attrs,
+	.default_groups = xfs_errortag_groups,
 };
 
 int
diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
index 8608f804388f..574b80c29fe1 100644
--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -67,11 +67,12 @@ static const struct sysfs_ops xfs_sysfs_ops = {
 static struct attribute *xfs_mp_attrs[] = {
 	NULL,
 };
+ATTRIBUTE_GROUPS(xfs_mp);
 
 struct kobj_type xfs_mp_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
-	.default_attrs = xfs_mp_attrs,
+	.default_groups = xfs_mp_groups,
 };
 
 #ifdef DEBUG
@@ -239,11 +240,12 @@ static struct attribute *xfs_dbg_attrs[] = {
 #endif
 	NULL,
 };
+ATTRIBUTE_GROUPS(xfs_dbg);
 
 struct kobj_type xfs_dbg_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
-	.default_attrs = xfs_dbg_attrs,
+	.default_groups = xfs_dbg_groups,
 };
 
 #endif /* DEBUG */
@@ -296,11 +298,12 @@ static struct attribute *xfs_stats_attrs[] = {
 	ATTR_LIST(stats_clear),
 	NULL,
 };
+ATTRIBUTE_GROUPS(xfs_stats);
 
 struct kobj_type xfs_stats_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
-	.default_attrs = xfs_stats_attrs,
+	.default_groups = xfs_stats_groups,
 };
 
 /* xlog */
@@ -381,11 +384,12 @@ static struct attribute *xfs_log_attrs[] = {
 	ATTR_LIST(write_grant_head),
 	NULL,
 };
+ATTRIBUTE_GROUPS(xfs_log);
 
 struct kobj_type xfs_log_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
-	.default_attrs = xfs_log_attrs,
+	.default_groups = xfs_log_groups,
 };
 
 /*
@@ -534,12 +538,12 @@ static struct attribute *xfs_error_attrs[] = {
 	ATTR_LIST(retry_timeout_seconds),
 	NULL,
 };
-
+ATTRIBUTE_GROUPS(xfs_error);
 
 static struct kobj_type xfs_error_cfg_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
-	.default_attrs = xfs_error_attrs,
+	.default_groups = xfs_error_groups,
 };
 
 static struct kobj_type xfs_error_ktype = {
-- 
2.34.1

