Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D62486279
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiAFJ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiAFJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:56:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A9C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 01:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 869A9619C2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ABBC36AE5;
        Thu,  6 Jan 2022 09:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641462974;
        bh=g2OTglO7kNt/1C9rH1eMGfeioryhDpMhIlFqJBCB/nU=;
        h=From:To:Cc:Subject:Date:From;
        b=UtlwpY27Hi40UW/6ZzEqlLUTopJNXx7nPPJwPu9uvIPwIxDEsdfltgYDzEjZeA4qj
         XzunqvFVzviK1PdrHgh+6QoMSwQt7ICq8LuAU4fBY2Df+9UYioSE3a4Knlxjd38WqK
         eXfwRs1E1ohUeE3dl5jyDw1C8dE2+oXY0MxiD1gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 10:56:10 +0100
Message-Id: <20220106095610.3275631-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; h=from:subject; bh=g2OTglO7kNt/1C9rH1eMGfeioryhDpMhIlFqJBCB/nU=; b=owGbwMvMwCRo6H6F97bub03G02pJDInX9uyyrZZY3yDCcVOo9ml7unfUk6gPXxdHa+naSk8RXy1Z /X5VRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyk5yLDgsmGTv967jFYL/sda3Fv1X lRqdKGLoYFWxPWliQ6dKaH+Z1Z97no9s+tm+fJAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the amdgpu sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jonathan Kim <jonathan.kim@amd.com>
Cc: Kevin Wang <kevin1.wang@amd.com>
Cc: shaoyunl <shaoyun.liu@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 567df2db23ac..94dcb004988d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -208,6 +208,7 @@ static struct attribute *amdgpu_xgmi_hive_attrs[] = {
 	&amdgpu_xgmi_hive_id,
 	NULL
 };
+ATTRIBUTE_GROUPS(amdgpu_xgmi_hive);
 
 static ssize_t amdgpu_xgmi_show_attrs(struct kobject *kobj,
 	struct attribute *attr, char *buf)
@@ -237,7 +238,7 @@ static const struct sysfs_ops amdgpu_xgmi_hive_ops = {
 struct kobj_type amdgpu_xgmi_hive_type = {
 	.release = amdgpu_xgmi_hive_release,
 	.sysfs_ops = &amdgpu_xgmi_hive_ops,
-	.default_attrs = amdgpu_xgmi_hive_attrs,
+	.default_groups = amdgpu_xgmi_hive_groups,
 };
 
 static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
-- 
2.34.1

