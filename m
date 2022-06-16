Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF98054DB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358826AbiFPHMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiFPHMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:12:24 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415135BD34
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:12:19 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id KDC00116;
        Thu, 16 Jun 2022 15:12:16 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2308.27; Thu, 16 Jun 2022 15:12:16 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] firmware: arm_scmi: Remove usage of the deprecated ida_simple_xxx API
Date:   Thu, 16 Jun 2022 01:50:52 -0400
Message-ID: <20220616055052.4559-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202261615121680575a135cc1fb6a44243d32fd659860
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
 drivers/firmware/arm_scmi/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index f6fe723ab869..d4e23101448a 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -181,7 +181,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 		return NULL;
 	}
 
-	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
+	id = ida_alloc_min(&scmi_bus_id, 1, GFP_KERNEL);
 	if (id < 0) {
 		kfree_const(scmi_dev->name);
 		kfree(scmi_dev);
@@ -204,7 +204,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 put_dev:
 	kfree_const(scmi_dev->name);
 	put_device(&scmi_dev->dev);
-	ida_simple_remove(&scmi_bus_id, id);
+	ida_free(&scmi_bus_id, id);
 	return NULL;
 }
 
@@ -212,7 +212,7 @@ void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
 	kfree_const(scmi_dev->name);
 	scmi_handle_put(scmi_dev->handle);
-	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
+	ida_free(&scmi_bus_id, scmi_dev->id);
 	device_unregister(&scmi_dev->dev);
 }
 
-- 
2.27.0

