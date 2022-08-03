Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EDD58873E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiHCGRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiHCGRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:17:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73C2C122
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:17:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso1005870pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Jlv66Vke6l8SYjueTnqS1mdIvxjlr2VRAIqrKVb1kto=;
        b=WEvmmSZzPBk5pgi20n1KHhSr4m0/uV5Gp/E10LInyrGNM5KdfCx/lCWizepPxUuaD4
         AgKPVrf2wr59DyEhXIPtWLBNIdEpHiPeAN1Jc0VZIL08L8siZ/yz7fdxCvhtUyuFuz8G
         hY2xd+nnbc6FEcLJxmMemWavAGQUQfCqa9GderCVzegyX0Rbf2fNrr3blz/0vpMKtV81
         fkA/ZRX/UmLTkB/1ssvViXY1GFsymmmaAj6D9GVoxMrb7yu8pctQKxroB1BkO2fAf4D5
         yy49Guqi41IG+ZA7srtGumj9ZvZHZ+XtbIFsx7/F7eZxkvgTGimc0ApDZ/4k60dMUHAx
         +LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Jlv66Vke6l8SYjueTnqS1mdIvxjlr2VRAIqrKVb1kto=;
        b=ZoJSEr51yBqi0Y/nFu0xOR9A9UcLTki+73nFGWrJoTE1td33HvceNClva1WEA/VPSG
         vPGo4AG6Q6rNOvc2Tem1Tm574M9MSo4D9i+3azLy/jpuJIwFXE6scgF97JaFKPzHdz2n
         KjXF0thLazEWVDPirnMsMk0kSaTD7C/s1Fh0Yb0HPFwB/+wDuIX+pE6tYirk2uxKTtjh
         hswOAH4AdnMffTzoFVUGBfp59qhzMCJcW4BX0nZjvyuaebs/B/64ALlLNJPx+qiqpI/a
         Jg+7WTEtJ+dwaDaqxfuflwI5g7HpgOdc0dPeVaIlmidddAGuwcNhYdTsUP0mEhaHqOIU
         MiTw==
X-Gm-Message-State: ACgBeo1bb7Ye6d/iCq//RlJ82Blq4/FhO+e7igGxjC0GRtOz72F6moTi
        mqqPwyqE9KCwygdzD+grS3M=
X-Google-Smtp-Source: AA6agR5gwzAONw8jejdaO+54xyeQ2fkw6EGCJC+kNk5R3U7hy6Da9RcVOJfBYcckeuLmTUg6Pdau0w==
X-Received: by 2002:a17:90a:430e:b0:1f2:33ee:75da with SMTP id q14-20020a17090a430e00b001f233ee75damr3352958pjg.140.1659507457879;
        Tue, 02 Aug 2022 23:17:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902710900b0016dbce87aecsm852115pll.182.2022.08.02.23.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 23:17:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-phy@lists.infradead.org
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] phy: mapphone-mdm6600:using the pm_runtime_resume_and_get to  simplify the code
Date:   Wed,  3 Aug 2022 06:17:34 +0000
Message-Id: <20220803061734.1650606-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 3cd4d51c247c..c1a1b8b0a13b 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -253,9 +253,8 @@ static irqreturn_t phy_mdm6600_wakeirq_thread(int irq, void *data)
 		return IRQ_NONE;
 
 	dev_dbg(ddata->dev, "OOB wake on mode_gpio1: %i\n", wakeup);
-	error = pm_runtime_get_sync(ddata->dev);
+	error = pm_runtime_resume_and_get(ddata->dev);
 	if (error < 0) {
-		pm_runtime_put_noidle(ddata->dev);
 
 		return IRQ_NONE;
 	}
@@ -601,10 +600,9 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(ddata->dev,
 					 MDM6600_MODEM_IDLE_DELAY_MS);
 	pm_runtime_enable(ddata->dev);
-	error = pm_runtime_get_sync(ddata->dev);
+	error = pm_runtime_resume_and_get(ddata->dev);
 	if (error < 0) {
 		dev_warn(ddata->dev, "failed to wake modem: %i\n", error);
-		pm_runtime_put_noidle(ddata->dev);
 		goto cleanup;
 	}
 
-- 
2.25.1
