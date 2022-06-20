Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3723A550FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiFTFcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiFTFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:32:00 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C395B8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:31:57 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 3A0woCV0J0JIm3A0xoG8j4; Mon, 20 Jun 2022 07:31:55 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 20 Jun 2022 07:31:55 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Zheyu Ma <zheyuma97@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH v2] media: tw686x: Fix an error handling path in tw686x_probe()
Date:   Mon, 20 Jun 2022 07:31:53 +0200
Message-Id: <d72feaa655944420d052e4157bc1d804bd214a66.1655673905.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes: is incomplete. It has moved some code in the probe but
not all error handling paths have been updated.

Now, if request_irq() fails, we must release some resources.

Fixes: c8946454ed96 ("media: tw686x: Register the irq at the end of probe")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Fix a typo in the log message
    Fix a typo in the label s/868/686/
---
 drivers/media/pci/tw686x/tw686x-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/tw686x/tw686x-core.c b/drivers/media/pci/tw686x/tw686x-core.c
index 384d38754a4b..af83ebf8eea4 100644
--- a/drivers/media/pci/tw686x/tw686x-core.c
+++ b/drivers/media/pci/tw686x/tw686x-core.c
@@ -337,12 +337,15 @@ static int tw686x_probe(struct pci_dev *pci_dev,
 			  dev->name, dev);
 	if (err < 0) {
 		dev_err(&pci_dev->dev, "unable to request interrupt\n");
-		goto iounmap;
+		goto tw686x_free;
 	}
 
 	pci_set_drvdata(pci_dev, dev);
 	return 0;
 
+tw686x_free:
+	tw686x_video_free(dev);
+	tw686x_audio_free(dev);
 iounmap:
 	pci_iounmap(pci_dev, dev->mmio);
 free_region:
-- 
2.34.1

