Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A9558D35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiFXCYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:24:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644555373;
        Thu, 23 Jun 2022 19:24:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u37so1325375pfg.3;
        Thu, 23 Jun 2022 19:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vPsWrQyn/DHJn33o8DYiuvL7DZy6IIkXnDcsRSL3n2o=;
        b=IdTAOHRstUgCde2Of4sqGNFq83pYJi0pUuNIRyaosHPm4UqnX9+veji8vYRk2b5gEV
         Tpg9YNy+xeeHS+U/5e2d7lDWOo5u9KpN6uGLm+9Fd5SiI2VH3MdGGr/xi0Vjh78uMfsT
         gxN86lg+Pdtx6zbcDBZ1KleTi953Kjo06+3x04WyNpJ9QnTHySy7B5BP/kig96m3A0Cg
         Yo/dMHVMM3nU7H3ktBk4QG3I8jy8tM06E3oJcrplg0QPkzfj60dEmTiEfhiFrHsPY17I
         maZYhDlmFq8n2+QaikiVS91vfAtHGd8rjBBGNFriA4EXRETI2G7hQOMwNlqSqfA6MSdl
         3NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vPsWrQyn/DHJn33o8DYiuvL7DZy6IIkXnDcsRSL3n2o=;
        b=jiPQlJl9Bq7v5NomGxXOQjWsxQSHztv78E2a8oUrN+ZuxWbx0xCVGTakZODf0pMNj5
         HL4Do6jh4b1at1xvIunoniI253CHFpA7dTcke7goFFqPAW4JEFLd8Wxe5phPnOX6aDfZ
         EfCmL1zKI/xLWnJufV6LhmYbEedh4ZzmkBFiKvazCnCH2bdCLQuDPS9Bh3/jy+LwA4tY
         Q6vxR1glUYToH7HZ24YRmnGTtv4Wzlld0SDhUCQguAHcAvuXJUom1sJn4+WeGme6oCc4
         EGlR04TzI3JGM+gHGyjHppRALFcEOhGIiNY8CHTaUR6Jf4kRL0arENlDaXy1j8BcdZnT
         DHEg==
X-Gm-Message-State: AJIora/NnjbVzFT7kP2BbfLEu5cg1SUOKG4YU3nLnHJTE526HGE/SWcS
        w8F3paY7XuMExekpSTbdVM2kGKKdHfawqA==
X-Google-Smtp-Source: AGRyM1s3yUbrf5R35qjrrkPBCR4UWfYPHGh8mOSSfGHurKgKlSBbSnI9O1o9mLGUucov4Oev4ZpE+g==
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id q9-20020a056a00088900b0051091e66463mr43880539pfj.58.1656037484962;
        Thu, 23 Jun 2022 19:24:44 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090a640900b001ecb7643c0asm437134pjj.36.2022.06.23.19.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 19:24:44 -0700 (PDT)
From:   Bing Fan <hptsfb@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: sp805_wdt: add arm cmsdk apb wdt support
Date:   Fri, 24 Jun 2022 10:24:42 +0800
Message-Id: <1656037482-19505-1-git-send-email-hptsfb@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bing Fan <tombinfan@tencent.com>

Support arm CMSDK ip apb watchdog device.
Description details of this device can be found in the
document DDI0479D_m_class_processor_system_r1p1_trm.pdf
on the arm's document web. Which periphid is 0x001bb824.
The registers are basically the same as the 805, just a
few more: Periphid4/5/6/7 with offset 0xFD0/0xFD4/0xFD8/0xFDC.
For the register description of arm,sp805, please refer
to the document DDI0270-arm-sp805.pdf.

Signed-off-by: Bing Fan <tombinfan@tencent.com>
---
 drivers/watchdog/sp805_wdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index f9479a3fe2a6..78ba36689eec 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * drivers/char/watchdog/sp805-wdt.c
  *
@@ -341,6 +342,10 @@ static const struct amba_id sp805_wdt_ids[] = {
 		.id	= 0x00141805,
 		.mask	= 0x00ffffff,
 	},
+	{
+		.id     = 0x001bb824,
+		.mask   = 0x00ffffff,
+	},
 	{ 0, 0 },
 };
 
-- 
2.17.1

