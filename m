Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9149486289
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiAFJ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:58:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36556 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiAFJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:58:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E49761943
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766B3C36AEB;
        Thu,  6 Jan 2022 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641463119;
        bh=QcUzMHPr+1MNvUtsFUGYSLPUHKionyGyRRTmOXYNNt0=;
        h=From:To:Cc:Subject:Date:From;
        b=O2+Ux9Wu5NoHigNikCswDvkcYVZ1zhHfUzdCBHYfJTEdxRe2Fh8kFrW+u0aYwCR/B
         NC7lIaszVRPrcgfzvdLzLMwWTvpGyVMr/HhPsBcP0Cy5qymHi/l512rH8cNrcyZES5
         tkYT+YwPToT7RZEpFzPO2JzBbCS4rK5giaWWtn+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vmwgfx: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 10:58:35 +0100
Message-Id: <20220106095835.3276797-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; h=from:subject; bh=QcUzMHPr+1MNvUtsFUGYSLPUHKionyGyRRTmOXYNNt0=; b=owGbwMvMwCRo6H6F97bub03G02pJDInX9npLeMjvcgpJ77QNi1ROKJC79c2i/zPD1ebOhbqTD18L WTC3I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbSNYVhwco/1898vmtx707BfdcbS+ Q+3HLPn8AwP+Xs3dbVYRbf7husVC5qCbmvuLCOBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the vmwgfx sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/ttm_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_memory.c b/drivers/gpu/drm/vmwgfx/ttm_memory.c
index 7f7fe35fc21d..f49190aadb08 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_memory.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_memory.c
@@ -162,6 +162,7 @@ static struct attribute *ttm_mem_zone_attrs[] = {
 	&ttm_mem_used,
 	NULL
 };
+ATTRIBUTE_GROUPS(ttm_mem_zone);
 
 static const struct sysfs_ops ttm_mem_zone_ops = {
 	.show = &ttm_mem_zone_show,
@@ -171,7 +172,7 @@ static const struct sysfs_ops ttm_mem_zone_ops = {
 static struct kobj_type ttm_mem_zone_kobj_type = {
 	.release = &ttm_mem_zone_kobj_release,
 	.sysfs_ops = &ttm_mem_zone_ops,
-	.default_attrs = ttm_mem_zone_attrs,
+	.default_groups = ttm_mem_zone_groups,
 };
 
 static struct attribute ttm_mem_global_lower_mem_limit = {
@@ -226,6 +227,7 @@ static struct attribute *ttm_mem_global_attrs[] = {
 	&ttm_mem_global_lower_mem_limit,
 	NULL
 };
+ATTRIBUTE_GROUPS(ttm_mem_global);
 
 static const struct sysfs_ops ttm_mem_global_ops = {
 	.show = &ttm_mem_global_show,
@@ -234,7 +236,7 @@ static const struct sysfs_ops ttm_mem_global_ops = {
 
 static struct kobj_type ttm_mem_glob_kobj_type = {
 	.sysfs_ops = &ttm_mem_global_ops,
-	.default_attrs = ttm_mem_global_attrs,
+	.default_groups = ttm_mem_global_groups,
 };
 
 static bool ttm_zones_above_swap_target(struct ttm_mem_global *glob,
-- 
2.34.1

