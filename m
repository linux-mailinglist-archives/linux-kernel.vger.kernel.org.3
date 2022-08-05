Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DF58A885
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiHEJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiHEJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:11:08 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1832F1EC5E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:11:03 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id AJQ00157;
        Fri, 05 Aug 2022 17:10:57 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.9; Fri, 5 Aug 2022 17:10:58 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <siglesias@igalia.com>, <jens.taprogge@taprogge.org>,
        <gregkh@linuxfoundation.org>
CC:     <industrypack-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] ipack: Check dev_set_name() return value
Date:   Fri, 5 Aug 2022 05:10:57 -0400
Message-ID: <20220805091057.19951-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022805171057bbe340732a631b8a3cdd0dcdeea3b3fc
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

It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/ipack/ipack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
index b1c3198355e7..74d449858a61 100644
--- a/drivers/ipack/ipack.c
+++ b/drivers/ipack/ipack.c
@@ -429,8 +429,11 @@ int ipack_device_init(struct ipack_device *dev)
 	dev->dev.bus = &ipack_bus_type;
 	dev->dev.release = ipack_device_release;
 	dev->dev.parent = dev->bus->parent;
-	dev_set_name(&dev->dev,
+	ret = dev_set_name(&dev->dev,
 		     "ipack-dev.%u.%u", dev->bus->bus_nr, dev->slot);
+	if (ret)
+		return ret;
+
 	device_initialize(&dev->dev);
 
 	if (dev->bus->ops->set_clockrate(dev, 8))
-- 
2.27.0

