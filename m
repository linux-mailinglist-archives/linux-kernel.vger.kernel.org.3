Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2EC504AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiDRCEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiDRCEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:04:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD58C13EA5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 19:01:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a186so7616952qkc.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 19:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7l5SLD+t2OmZibsuHe43tBECrv1rCTgWJ1r74SftDE=;
        b=fw2BAIh124ZZDotgatMgogdbCaLgFSA+RIMjHrI98G013zIxjUELzLBhUxpBzc93tW
         Gm+tnttJxdXq87ShOrlupaOXdEM1JaHTmd1ahqiWm3sdQ33HzvALrmJuXYLDkjW0j04o
         XCwagQhWI5mt7QIwxmxbC49H51XFk9ntS45ADvHQV6fdFFY2H4OXe6+wiBuHz6I/Ivfm
         3DSbcT1UuPNXGctzvtUYbTQEiGi5zQ+QFzS9zXJg1XBXBUgwOuUHpvYkKyRc4WYVWg8c
         nVWnpLqDESDPNuTdijXkoLCB4UPwQscKFfUzv7GErA7/b8ODJ5e7N2HOmVM2kAk07yNj
         uvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7l5SLD+t2OmZibsuHe43tBECrv1rCTgWJ1r74SftDE=;
        b=FckVima9P2otCotBfB1sDzbFu6cJz/ev/TUvcmAM0bW/zzgr5c0v6kiHd8vVWr7jkS
         BTMGi3FQVK8i1yA867c1wazjindviZn8nexIEfxRPFCMrNdZUu+9lL0OUJz34ZGelkf4
         ba6cOj381Ci3W/fxsGE5/6gjk9DjsJq49DhkV9ihvm/LxCY2kBGAMjFGDVkajI7Vccq0
         bBeIOaf4LUh3dPtamOnPIfWkSciSiijsntPFeIVxkV28idl0o9adMpFU3Z39c7e+Y9Sy
         wpmBxzfOl72iip/IZeEXMznEDgYk8fdV/GXmF4gw1zDyGZ4CnOF7zZIKkQPYYLiofdKi
         km+w==
X-Gm-Message-State: AOAM530EpSXzU+VOwgaqlAxq6U/iPmwJ0xZGsivb651h/WQdbmg7kSDH
        gOaemhay1VzybH0SRBgXVrM=
X-Google-Smtp-Source: ABdhPJx57lsVkne+vwD1uyEgLDL8C10E0aJeRSoCOLaeGzTObIJMWXJ7EbIDiqdITNkSybGG6EwN8Q==
X-Received: by 2002:a37:6801:0:b0:69e:88f8:2ead with SMTP id d1-20020a376801000000b0069e88f82eadmr3073590qkc.39.1650247312981;
        Sun, 17 Apr 2022 19:01:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h19-20020a05622a171300b002f1ef41f912sm4673662qtk.73.2022.04.17.19.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 19:01:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     krzysztof.kozlowski@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] memory: Make use of the helper function devm_platform_ioremap_resource()
Date:   Mon, 18 Apr 2022 02:01:47 +0000
Message-Id: <20220418020147.2556925-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/memory/fsl-corenet-cf.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-cf.c
index f8ea592c9cb5..7fc9f57ae278 100644
--- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -172,7 +172,6 @@ static irqreturn_t ccf_irq(int irq, void *dev_id)
 static int ccf_probe(struct platform_device *pdev)
 {
 	struct ccf_private *ccf;
-	struct resource *r;
 	const struct of_device_id *match;
 	u32 errinten;
 	int ret, irq;
@@ -185,13 +184,7 @@ static int ccf_probe(struct platform_device *pdev)
 	if (!ccf)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
-		return -ENXIO;
-	}
-
-	ccf->regs = devm_ioremap_resource(&pdev->dev, r);
+	ccf->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ccf->regs))
 		return PTR_ERR(ccf->regs);
 
-- 
2.25.1

