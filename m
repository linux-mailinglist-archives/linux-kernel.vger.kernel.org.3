Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B189254E5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377888AbiFPP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377466AbiFPP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:26:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06752E09A;
        Thu, 16 Jun 2022 08:25:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 20so2735020lfz.8;
        Thu, 16 Jun 2022 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZuOwtq+9/VZTy3ADMx01Z5TJDecADF7IqscILS0mik=;
        b=UpuPv1+qHiaeoBAs0xq2geW/piGdYhV79fhXrIXnZK6hzwORi8+yDhUNvIFCZbBAY7
         W/d4GwXJAHWEdjxkQN8M6vw+9OGo1XHxXNP952NiyVyAFfAm/3pHSrpwxGBUuJupyEQy
         U1ViGSyDAW56Au/YCMrcwo5cC8HGN+yKj49jC5wrBTOTX3iujMBifuFUI30tmH7AkGXb
         tHIHW/+wUTbldWGvSZpO+iK0+JaIa0VsZleIGia4qruIM02pjSJGJo/oXbk0X6HYQWVV
         r+umFUHOujGvtKTtDKuqiy2J6KeoYFIGRQK5dV5gfhmEPCY/2lcg9CZcoXzuR79KZ0hx
         Mvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZuOwtq+9/VZTy3ADMx01Z5TJDecADF7IqscILS0mik=;
        b=Dawb9dBILlXFn8ghAm2OzSh27b9FbKKw+0/z530DigtkCfceLPg/ZKbNlTvQLFOXgj
         WBfl6F/29jfF+cToNm/VUCyTMzRVlbINKfO0qkjX/3+IVgZxQCbWnGJFj9nddVqzQ9f5
         LbianYlnmiuK/Sf9moHyXs+aE8EE9UR8mAuT0/YpUvgEkBMMAPrQuETXFAV4xy91WorT
         kqty4TEnKBCqwO9WG8qL+1qGdY/2SsUZcrR9PdLeU5w9m9sHXR7BRbluYstULyYkMpPy
         2jTbi5Nc20HS4wzOI91EDxOQIqYHc0J7VHpoL9BeHobSsHebqfo4jdsHRm1/ePer1n8b
         xwUA==
X-Gm-Message-State: AJIora9rglcQHcO5VRjpB3yNSJ/5YXK8/EQEM9nAipGECnniqgs4di2L
        /BVlmKiqjS9GmmcOKfwCi9w=
X-Google-Smtp-Source: AGRyM1swYi8yLV5/KLt9zHbj7cSXbJfccEEblBu6x3wtEFG6lr+CfAaV+P0StJVkAcVnu2+Qtluupw==
X-Received: by 2002:a05:6512:1050:b0:47d:c714:10ba with SMTP id c16-20020a056512105000b0047dc71410bamr2962362lfb.165.1655393158203;
        Thu, 16 Jun 2022 08:25:58 -0700 (PDT)
Received: from localhost.localdomain (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id a10-20020a19660a000000b0047e789b9700sm272794lfc.118.2022.06.16.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:25:57 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] Input: twl4030-vibra - Drop legacy, non DT boot support
Date:   Thu, 16 Jun 2022 18:33:23 +0300
Message-Id: <20220616153323.29464-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Legacy or non DT boot is no longer possible on systems where the
tw4030/5030 is used.

Drop the support for handling legacy pdata.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/input/misc/twl4030-vibra.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index e0ff616fb857..5619996da86f 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -163,14 +163,10 @@ static int __maybe_unused twl4030_vibra_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
 			 twl4030_vibra_suspend, twl4030_vibra_resume);
 
-static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
-			      struct device_node *parent)
+static bool twl4030_vibra_check_coexist(struct device_node *parent)
 {
 	struct device_node *node;
 
-	if (pdata && pdata->coexist)
-		return true;
-
 	node = of_get_child_by_name(parent, "codec");
 	if (node) {
 		of_node_put(node);
@@ -182,13 +178,12 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
 
 static int twl4030_vibra_probe(struct platform_device *pdev)
 {
-	struct twl4030_vibra_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *twl4030_core_node = pdev->dev.parent->of_node;
 	struct vibra_info *info;
 	int ret;
 
-	if (!pdata && !twl4030_core_node) {
-		dev_dbg(&pdev->dev, "platform_data not available\n");
+	if (!twl4030_core_node) {
+		dev_dbg(&pdev->dev, "twl4030 OF node is missing\n");
 		return -EINVAL;
 	}
 
@@ -197,7 +192,7 @@ static int twl4030_vibra_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->dev = &pdev->dev;
-	info->coexist = twl4030_vibra_check_coexist(pdata, twl4030_core_node);
+	info->coexist = twl4030_vibra_check_coexist(twl4030_core_node);
 	INIT_WORK(&info->play_work, vibra_play_work);
 
 	info->input_dev = devm_input_allocate_device(&pdev->dev);
-- 
2.36.1

