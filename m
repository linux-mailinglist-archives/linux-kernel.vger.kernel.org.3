Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888E54DAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358950AbiFPGmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359002AbiFPGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:42:37 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0931E25
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:42:29 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id KCG00125;
        Thu, 16 Jun 2022 14:42:25 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2308.27; Thu, 16 Jun 2022 14:42:18 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] drm/connector: Remove usage of the deprecated ida_simple_xxx API
Date:   Thu, 16 Jun 2022 01:18:29 -0400
Message-ID: <20220616051829.4071-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20226161442258a626e91cc77798f89a1e77992f45337
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc_xxx()/ida_free() instead of
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/gpu/drm/drm_connector.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 1c48d162c77e..e3484b115ae6 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -250,7 +250,7 @@ int drm_connector_init(struct drm_device *dev,
 	connector->funcs = funcs;
 
 	/* connector index is used with 32bit bitmasks */
-	ret = ida_simple_get(&config->connector_ida, 0, 32, GFP_KERNEL);
+	ret = ida_alloc_max(&config->connector_ida, 31, GFP_KERNEL);
 	if (ret < 0) {
 		DRM_DEBUG_KMS("Failed to allocate %s connector index: %d\n",
 			      drm_connector_enum_list[connector_type].name,
@@ -262,7 +262,7 @@ int drm_connector_init(struct drm_device *dev,
 
 	connector->connector_type = connector_type;
 	connector->connector_type_id =
-		ida_simple_get(connector_ida, 1, 0, GFP_KERNEL);
+		ida_alloc_min(connector_ida, 1, GFP_KERNEL);
 	if (connector->connector_type_id < 0) {
 		ret = connector->connector_type_id;
 		goto out_put_id;
@@ -322,10 +322,10 @@ int drm_connector_init(struct drm_device *dev,
 	connector->debugfs_entry = NULL;
 out_put_type_id:
 	if (ret)
-		ida_simple_remove(connector_ida, connector->connector_type_id);
+		ida_free(connector_ida, connector->connector_type_id);
 out_put_id:
 	if (ret)
-		ida_simple_remove(&config->connector_ida, connector->index);
+		ida_free(&config->connector_ida, connector->index);
 out_put:
 	if (ret)
 		drm_mode_object_unregister(dev, &connector->base);
@@ -479,10 +479,10 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	list_for_each_entry_safe(mode, t, &connector->modes, head)
 		drm_mode_remove(connector, mode);
 
-	ida_simple_remove(&drm_connector_enum_list[connector->connector_type].ida,
+	ida_free(&drm_connector_enum_list[connector->connector_type].ida,
 			  connector->connector_type_id);
 
-	ida_simple_remove(&dev->mode_config.connector_ida,
+	ida_free(&dev->mode_config.connector_ida,
 			  connector->index);
 
 	kfree(connector->display_info.bus_formats);
-- 
2.27.0

