Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFBE552A75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbiFUFam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFUFak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:30:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E201AF1A;
        Mon, 20 Jun 2022 22:30:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso12274354pjk.0;
        Mon, 20 Jun 2022 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcv35DaYaLgEWO7GuEub/nuw7JLHG6pQnqj0PyOA+hQ=;
        b=bARO0ogGSgRxtBWrsEnZNirjEcP5YEYjHoKrkzJy+MXTqBK+YwmEwOyAioZakqbR2c
         NlUI9t8+gDa6jfzI4tc/kyqkcUG9mEpi4xVnwxpgei7xJIcp2XkTkqA8ykGv+2kjVsbX
         HakR09+snsYfxn9FA2RiJjZbzm0Otyjq1qzzboDGovnFB9f19tPV8hfVxGUP+tY1DxkT
         MY4AL/f3LlILJ5kpVI8UnARq7oBo6Auv5MwTnFciHmQeogH+H/0KfYTh4a1IBSK5TuXh
         bzW9SpJwpmFtLVSvW94NUWapAfQ2egef2TleVZoPbMEonAEzfji8CnNWpguYcRLT8gCT
         KBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcv35DaYaLgEWO7GuEub/nuw7JLHG6pQnqj0PyOA+hQ=;
        b=smYDkubrq/tTeU9xTGY4bkezngwXC/dPjopusCTvDxRRIW8eaGkn7fcG1AQZtTb0hO
         zHvztr7079czlAO5IZWbjiXoo5yqLIAulEaWMPvaMeB5uM+jKpHYf2/k4uoOHpOrj8tW
         aCp6Je1jzV5KSig70EtmqGSV7UNVY1NAL2rCT+irdt0glw/31yiUKDpez3PGov66Saje
         D59WrHNbby6M//x3dLPsjU0AqEpVT1NqLZsT2mf2Wt8qHMUP/1lCGuRZUFprXyMyd2zz
         ImOVOpLq9hKYWsGF9MwxsYLJbYshC1xPK57PlRSs4PPR317DyvpLWHXTg9yhTyC5FLC7
         nYxw==
X-Gm-Message-State: AJIora/mX8Wimnv8+DfrIF5w0We8K9g+Ptn6mB2AqkFPO/C+gqUCU1Wy
        75Su90V82Vd/6RAuf1ic8hm4hgAzHQa9f/Lm
X-Google-Smtp-Source: AGRyM1sQRpIYijmco2TLELh7JSveUC+AYP20CGGqmvgscYugeA+ZTiBQ+DvX2wFfgvrTBMHLrOhMkA==
X-Received: by 2002:a17:90a:b797:b0:1e0:ad13:ef39 with SMTP id m23-20020a17090ab79700b001e0ad13ef39mr31181444pjr.8.1655789439755;
        Mon, 20 Jun 2022 22:30:39 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id gm19-20020a17090b101300b001ec7954ae08sm7444534pjb.2.2022.06.20.22.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 22:30:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] media: tw686x: Fix memory leak in tw686x_video_init
Date:   Tue, 21 Jun 2022 09:30:30 +0400
Message-Id: <20220621053030.6747-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

video_device_alloc() allocates memory for vdev,
when video_register_device() fails, it doesn't release the memory and
leads to memory leak, call video_device_release() to fix this.

Fixes: 704a84ccdbf1 ("[media] media: Support Intersil/Techwell TW686x-based video capture cards")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/pci/tw686x/tw686x-video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
index 6344a479119f..3ebf7a2c95f0 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -1280,8 +1280,10 @@ int tw686x_video_init(struct tw686x_dev *dev)
 		video_set_drvdata(vdev, vc);
 
 		err = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
-		if (err < 0)
+		if (err < 0) {
+			video_device_release(vdev);
 			goto error;
+		}
 		vc->num = vdev->num;
 	}
 
-- 
2.25.1

