Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0314354DA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359024AbiFPGN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358989AbiFPGNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:13:54 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D057533883
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:13:50 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id KCD00144;
        Thu, 16 Jun 2022 14:13:44 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2308.27; Thu, 16 Jun 2022 14:13:45 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <johan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] gnss: Remove usage of the deprecated ida_simple_xxx API
Date:   Thu, 16 Jun 2022 00:47:33 -0400
Message-ID: <20220616044733.3605-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20226161413449a8fcf6a1089cae2fb28a060a6c8d695
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/gnss/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index e6f94501cb28..1e82b7967570 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -217,7 +217,7 @@ static void gnss_device_release(struct device *dev)
 
 	kfree(gdev->write_buf);
 	kfifo_free(&gdev->read_fifo);
-	ida_simple_remove(&gnss_minors, gdev->id);
+	ida_free(&gnss_minors, gdev->id);
 	kfree(gdev);
 }
 
@@ -232,7 +232,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
 	if (!gdev)
 		return NULL;
 
-	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
+	id = ida_alloc_max(&gnss_minors, GNSS_MINORS - 1, GFP_KERNEL);
 	if (id < 0) {
 		kfree(gdev);
 		return NULL;
-- 
2.27.0

