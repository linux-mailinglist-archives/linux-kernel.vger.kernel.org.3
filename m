Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732F54EF12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379535AbiFQCEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFQCEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:04:43 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B161633
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:04:40 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id LYV00035;
        Fri, 17 Jun 2022 10:04:35 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2308.27; Fri, 17 Jun 2022 10:04:34 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <fujita.tomonori@lab.ntt.co.jp>, <axboe@kernel.dk>
CC:     <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] scsi: Remove usage of the deprecated ida_simple_xxx API
Date:   Thu, 16 Jun 2022 22:04:30 -0400
Message-ID: <20220617020430.2300-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022617100435427b25fa09428565519558434c2ae0a3
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
 block/bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 882f56bff14f..2ab1351eb082 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -169,7 +169,7 @@ static void bsg_device_release(struct device *dev)
 {
 	struct bsg_device *bd = container_of(dev, struct bsg_device, device);
 
-	ida_simple_remove(&bsg_minor_ida, MINOR(bd->device.devt));
+	ida_free(&bsg_minor_ida, MINOR(bd->device.devt));
 	kfree(bd);
 }
 
@@ -196,7 +196,7 @@ struct bsg_device *bsg_register_queue(struct request_queue *q,
 	bd->queue = q;
 	bd->sg_io_fn = sg_io_fn;
 
-	ret = ida_simple_get(&bsg_minor_ida, 0, BSG_MAX_DEVS, GFP_KERNEL);
+	ret = ida_alloc_max(&bsg_minor_ida, BSG_MAX_DEVS - 1, GFP_KERNEL);
 	if (ret < 0) {
 		if (ret == -ENOSPC)
 			dev_err(parent, "bsg: too many bsg devices\n");
-- 
2.27.0

