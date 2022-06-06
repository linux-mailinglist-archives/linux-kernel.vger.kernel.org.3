Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E353DF67
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351996AbiFFBj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351981AbiFFBjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:39:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884504CD46
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:39:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j6so11539379pfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blp8QR6+pv4cfsiOBJIBVZUTesn4LU5MyrzFetgJvMo=;
        b=lYQNpcOvl7O7XFKGldBsZauzWbrF5gV7bO2tC9FJ6xk/kG3dp300eArolrqjPPjusH
         hzBnGl4HAGQyibt08ufLySgscjdx24YUBqnZbUalBf/LiZxyRglVezgkidXLobjMKZND
         Goub32GKdKsIddVGDlKY0AfS+RAHU18K6OUqyhUMAmJ0YS0rNqaXNKEmBICzRbe43b7n
         /6NvuvH6JiOI9j8LnJS5z7XVfwV+cfvLc+p6twFc1mD/I854E0JhCfTYWFDdsmXatzL3
         /E/SIwIJsqqS/sOsEpwom8d2QDgx4ZbwsdzfAPwL2EvMWOzroL93G7b3T18fTyNCZnLV
         STfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blp8QR6+pv4cfsiOBJIBVZUTesn4LU5MyrzFetgJvMo=;
        b=AFs+FjoFOb1AmZmXpwlQeDCgXc95MoKpddP8Kq+a9MB401ZpsEGLy1/0Kd8GWSRH80
         xcpfvFaLkL6d39fSGLIdGdU11i6Rg4qLWXfE8I9LEGZTnXcMOgmtMbsXyHVHzDpDsCy6
         A94I7vsfel3HWf5MKxBR9rpgPY+HW+1xJ7NvYeCJZHL6OBnN+QUnL7Vm6IO1y3OeU7VH
         vsPFOJoMwaJXTHYE/TcyunrWMs6HZftSztqGJC4f+xYUPnaEgeQeRsCTu9S+8XSDwz9f
         7yHMF35k/24zA0PhmBwk0aK0e9Qb9dG9l+a5BP8AyE4+CrfQ6hmy1z65XXm/fItK2oam
         RdnQ==
X-Gm-Message-State: AOAM5337hAfkPylc/9Ov53Ul06Q61cx4o6a8MQhq5SWhvzbuD3l3LEOv
        tZ8CfiMNqRwxrlSJwIhCN5tw2HQAZV0=
X-Google-Smtp-Source: ABdhPJwFYrP5esHgQvOJCyeQFcFYd0RAzW47p2o2yhWnlmpabfsh3MwNYIvlNAzykgi0MUfPMmfa0A==
X-Received: by 2002:a63:5a58:0:b0:3fb:b455:ed15 with SMTP id k24-20020a635a58000000b003fbb455ed15mr18899426pgm.228.1654479561010;
        Sun, 05 Jun 2022 18:39:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ku12-20020a17090b218c00b001e31feb7383sm8795793pjb.49.2022.06.05.18.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 18:39:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: wm_adsp: Remove redundant NULL check before release_firmware() call
Date:   Mon,  6 Jun 2022 01:39:16 +0000
Message-Id: <20220606013916.290387-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

release_firmware() checks for NULL pointers internally so checking
before calling it is redundant.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/codecs/wm_adsp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7973a75cac05..4c4344b21c2e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -739,12 +739,10 @@ static void wm_adsp_release_firmware_files(struct wm_adsp *dsp,
 					   const struct firmware *coeff_firmware,
 					   char *coeff_filename)
 {
-	if (wmfw_firmware)
-		release_firmware(wmfw_firmware);
+	release_firmware(wmfw_firmware);
 	kfree(wmfw_filename);
 
-	if (coeff_firmware)
-		release_firmware(coeff_firmware);
+	release_firmware(coeff_firmware);
 	kfree(coeff_filename);
 }
 
-- 
2.25.1


