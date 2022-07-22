Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1744257D8F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiGVDUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVDU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:20:28 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A58C1D0CC;
        Thu, 21 Jul 2022 20:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7cumI
        2k40Wf2jTZSpS1C8fFLwUssOL1MQc8JznRXgeA=; b=H6wJGJMC7WvNEDD8YHhXS
        mnYfVaUXUQdPVRhEaZjlPTlZirNDOK5hho/V12T9YVD34wRkF3vpbz1q3kLRXO74
        q6ZSWP05WxZcubn4KUCPz34HZqs+NNVCDuJWUPgvnMQxim+Lro5oodXGSyRUOI1J
        ZXsgl5MsAYmXsarcSb/8yw=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp1 (Coremail) with SMTP id GdxpCgCXvZQzF9piBKLzPg--.1899S2;
        Fri, 22 Jul 2022 11:19:16 +0800 (CST)
From:   williamsukatube@163.com
To:     ran.wang_1@nxp.com, balbi@kernel.org, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] usb: phy: check the return value of ioremap() in usb_otg_start()
Date:   Fri, 22 Jul 2022 11:19:13 +0800
Message-Id: <20220722031913.2925655-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgCXvZQzF9piBKLzPg--.1899S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWrZrW3uFW8Jw13XFW7CFg_yoWfuwb_AF
        1rWFyxWrWkGF15Kr17Jryfua4DKw4qvr98XF4vqr98tw1jvF18Xr93Za93WFyUXrWrJFWD
        Gwn8ZFW8ZF1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5uxRDUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiNxRGg1WBo2GhmQAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

The function ioremap() in usb_otg_start() can fail, so
its return value should be checked.

Fixes: 0807c500a1a6d ("USB: add Freescale USB OTG Transceiver driver")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/usb/phy/phy-fsl-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 972704262b02..21b3b2d57358 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -855,6 +855,8 @@ int usb_otg_start(struct platform_device *pdev)
 	 * with host/device */
 
 	usb_dr_regs = ioremap(res->start, sizeof(struct usb_dr_mmap));
+	if (!usb_dr_regs)
+		return -ENOMEM;
 	p_otg->dr_mem_map = (struct usb_dr_mmap *)usb_dr_regs;
 	pdata->regs = (void *)usb_dr_regs;
 
-- 
2.25.1

