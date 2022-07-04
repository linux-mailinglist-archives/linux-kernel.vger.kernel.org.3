Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83CE564B28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiGDB11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDB10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:27:26 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC39B638E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B3lQ1
        ungwLGYaWosqZLRgi8gmLF9ZYSBE7PmxcGVuFU=; b=h/tFZ1WwErmtUDYQDTIDc
        H53fpJ/bD2xBT9yw+GJlGj8Zw7sqmSPHdzhfJ2MvsQCbcuejqps/crXGHQayaBue
        YGaroZ/bvjK2sEfUm7V5ggq1kjLPtWf/vexJY0dh8DUpNPLaOcvbbu4mer8W/wUY
        poglN2vZuwFDH6L+MnznUA=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp3 (Coremail) with SMTP id G9xpCgCXEnTuQcJivRkRNQ--.6799S4;
        Mon, 04 Jul 2022 09:27:18 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] auxdisplay: hd44780: Fix potential memory leak in hd44780_remove()
Date:   Mon,  4 Jul 2022 09:27:09 +0800
Message-Id: <20220704012709.2217923-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCXEnTuQcJivRkRNQ--.6799S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryfAFy8tr4fury5KF48Zwb_yoWDJrc_Ga
        4ruFWkAF1UJws7tw1ktr1furWIkrsFvrnYvanIqaySqryUZFsI9r4UXan7Wa4DCFW0yFn0
        kFn8WFWUCan8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAkux5UUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMhY0jFWBzytsCwAAsL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hd44780_probe() allocates a memory chunk for hd with kzalloc() and
makes "lcd->drvdata->hd44780" point to it. When we call hd44780_remove(),
we should release all relevant memory and resource, but "lcd->drvdata
->hd44780" is not released, which will lead to a memory leak.

We should release the "lcd->drvdata->hd44780" in hd44780_remove() to fix
the memory leak bug.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/auxdisplay/hd44780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 8b2a0eb3f32a..8940a93d2d4d 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -324,6 +324,7 @@ static int hd44780_remove(struct platform_device *pdev)
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 
 	charlcd_unregister(lcd);
+	kfree(lcd->drvdata->hd44780);
 	kfree(lcd->drvdata);
 
 	kfree(lcd);
-- 
2.25.1

