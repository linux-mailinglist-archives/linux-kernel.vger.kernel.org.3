Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B075877FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiHBHiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiHBHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:38:03 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24296E008;
        Tue,  2 Aug 2022 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=l0q+Q
        YiG/Eqa3mATE+vLJIuo/ItC1B0Gui0igDzgwt4=; b=UuR1oIOZkpDf12FOYjgYW
        RIddEflkNmVKmZRjpsA5uPYeWwlAMLZs8ys8V/uv9ENXEx6ipjji8FKO1jJqCq6L
        hNx4FQ8a0i1e/05vATssKO7SEWGXnhNgfJkU4APJYpXsbI6aiXz18Wh4W+7ISt8W
        IYxcjeZEWyX9ePq+EoF08k=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp1 (Coremail) with SMTP id GdxpCgCXJZbw0+hiFYdnSA--.5473S2;
        Tue, 02 Aug 2022 15:36:18 +0800 (CST)
From:   studentxswpy@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] scsi: sun3x_esp: check the return value of ioremap() in esp_sun3x_probe()
Date:   Tue,  2 Aug 2022 15:36:14 +0800
Message-Id: <20220802073614.3213171-1-studentxswpy@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgCXJZbw0+hiFYdnSA--.5473S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4DCrW8tF47XFW8JryfXrb_yoWfWwc_Wa
        1Svrs7WF4Yyw1xtF17Cwn8Z34Ikr1kZr4kuF1FqFy3Cw1UZ3WDXa9F9rn7ua45WaykGayF
        y3s0vF4Fv34SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8JGYJUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xvwxvv5qw024ls16il2tof0z/xtbB0wpRJFXlwVHQtwAAsr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Shaowen <studentxswpy@163.com>

The function ioremap() in esp_sun3x_probe() can fail, so
its return value should be checked.

Fixes: 4bdc0d676a643 ("remove ioremap_nocache and devm_ioremap_nocache")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: Xie Shaowen <studentxswpy@163.com>
---
 drivers/scsi/sun3x_esp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sun3x_esp.c b/drivers/scsi/sun3x_esp.c
index d3489ac7ab28..cc670b50a357 100644
--- a/drivers/scsi/sun3x_esp.c
+++ b/drivers/scsi/sun3x_esp.c
@@ -199,6 +199,8 @@ static int esp_sun3x_probe(struct platform_device *dev)
 		goto fail_unmap_regs;
 
 	esp->dma_regs = ioremap(res->start, 0x10);
+	if (!esp->dma_regs)
+		goto fail_unmap_regs;
 
 	esp->command_block = dma_alloc_coherent(esp->dev, 16,
 						&esp->command_block_dma,
-- 
2.25.1

