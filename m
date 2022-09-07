Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5AD5AFD19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIGHH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIGHH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:07:56 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8A26895E9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3BpRO
        WjxprTxa17N0oqLxfeIZKkPU1qZ+jjEJLWGJ9w=; b=ZyHrmBUBegAm9M5Y+o+AF
        2QY3fbsU/Ysd+QnM6sazUVn8Yj2Yq3Y6PqL1BGVZUYut1/AGkh8qZL9h4m03Kv9Q
        tXkU5Swml6vgTtKqmHTVplqPjwfvlwXFobfTKtm+UJ70sf3P6XDXDDGbfBdeqbL+
        Sd55qirCd09qPfMF+24zcI=
Received: from localhost.localdomain (unknown [36.112.3.164])
        by smtp3 (Coremail) with SMTP id G9xpCgAHhXY4QxhjWat4bg--.33168S4;
        Wed, 07 Sep 2022 15:07:42 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] auxdisplay: hd44780: Fix potential memory leak in hd44780_remove()
Date:   Wed,  7 Sep 2022 15:07:35 +0800
Message-Id: <20220907070735.56488-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgAHhXY4QxhjWat4bg--.33168S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryfAF4fuw1UAF4rZw4rAFb_yoWDJrc_Ga
        4ruFWkAF1UJws7tw1ktr1furWIkrsFvrnYqanIqaySqryUZFsI9r4jqan7Wa4DCFW0yFn0
        kFn8WFWUCan8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCKZG5UUUUU==
X-Originating-IP: [36.112.3.164]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFR91jF5mMewgewAAsN
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
we should release all relevant memory and resource. But "lcd->drvdata
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

