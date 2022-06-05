Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240F53DB6D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiFEMn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 08:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 08:43:55 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B548B248C2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=KPfJ09WlgY2YQKDQ1L
        P6rJs+yK3vnrBlKY9+sJDfkL8=; b=hBFm+bdxMgHn4j3r4/fpQ921uOhFhNhr3i
        VUlLx0R8mr4KIdRMY0bczv7ioxXyK8ao5g9yL/b88sT2Q5qR00TQlov/fCXXedVo
        s80b7WSFflCAVe1biqMOVvGnDB5tWnOocwbvIlqidxPIWOeONQ/FXGMNaIeqTn+7
        6ccGnnGqA=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp12 (Coremail) with SMTP id EMCowAAHpmrspJxilcQtAA--.6005S4;
        Sun, 05 Jun 2022 20:43:35 +0800 (CST)
From:   Xiaohui Zhang <ruc_zhangxiaohui@163.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] comedi: ni_usb6501: fix transfer-buffer overflows
Date:   Sun,  5 Jun 2022 20:43:22 +0800
Message-Id: <20220605124322.33148-1-ruc_zhangxiaohui@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowAAHpmrspJxilcQtAA--.6005S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWDKFy3tFW7uFW7WFW8tFb_yoW8WF4rpF
        4ruFy0kr45J3yIk3WDJwnrAF15Wa12qFW7KFWUuwnxZF43Awnakr1rtFyrtF95AF1SqF40
        vwnrZFy5uF15AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRKii-UUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: puxfs6pkdqw5xldrx3rl6rljoofrz/1tbipRcXMFUMkGia3AAAsy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiaohuizhang98 <ruc_zhangxiaohui@163.com>

We detected a suspected bug with our code clone detection tool.

Similar to the handling of vmk80xx_alloc_usb_buffers in commit
a23461c47482("comedi: vmk80xx: fix transfer-buffer overflows"),
we thought a patch might be needed here as well.

The driver uses endpoint-sized USB transfer buffers but up until
recently had no sanity checks on the sizes.

Signed-off-by: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
---
 drivers/comedi/drivers/ni_usb6501.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/ni_usb6501.c b/drivers/comedi/drivers/ni_usb6501.c
index 0dd9edf7bced..3e2b9f4d840b 100644
--- a/drivers/comedi/drivers/ni_usb6501.c
+++ b/drivers/comedi/drivers/ni_usb6501.c
@@ -90,6 +90,7 @@
 #include <linux/comedi/comedi_usb.h>
 
 #define	NI6501_TIMEOUT	1000
+#define MIN_BUF_SIZE	64
 
 /* Port request packets */
 static const u8 READ_PORT_REQUEST[]	= {0x00, 0x01, 0x00, 0x10,
@@ -459,12 +460,12 @@ static int ni6501_alloc_usb_buffers(struct comedi_device *dev)
 	struct ni6501_private *devpriv = dev->private;
 	size_t size;
 
-	size = usb_endpoint_maxp(devpriv->ep_rx);
+	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
 	devpriv->usb_rx_buf = kzalloc(size, GFP_KERNEL);
 	if (!devpriv->usb_rx_buf)
 		return -ENOMEM;
 
-	size = usb_endpoint_maxp(devpriv->ep_tx);
+	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
 	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
-- 
2.17.1

