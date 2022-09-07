Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CC35AF9F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiIGChh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIGChg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:37:36 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D598295ADD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:37:34 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id BBR00144;
        Wed, 07 Sep 2022 10:36:44 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.12; Wed, 7 Sep 2022 10:36:44 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <sudipm.mukherjee@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] ppdev: check ida_simple_get() return value
Date:   Tue, 6 Sep 2022 22:36:42 -0400
Message-ID: <20220907023642.2333-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20229071036446c2a4de84941118e750bb759be51b721
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

As ida_simple_get() can fail, we should check the return value.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/char/ppdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 38b46c7d1737..13b58b6823ee 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -300,6 +300,11 @@ static int register_device(int minor, struct pp_struct *pp)
 	}
 
 	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
+	if (index < 0) {
+		rc = index;
+		goto err;
+	}
+
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
-- 
2.27.0

