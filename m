Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2959818D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbiHRKoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiHRKof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:44:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F5B7FE5B;
        Thu, 18 Aug 2022 03:44:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so4310438pjj.4;
        Thu, 18 Aug 2022 03:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zfVmtS6KYvfWod3rab4fz6qOWga4E5X5CB2HKYlhhHQ=;
        b=jEGIS+8SyNLsj44iJPWD2f6FwCHwEq/YUUlEAN64vyrvH8958MyzjjRJy7Xs5wV5r6
         yL+mLLihw3u8AirH32WN4aHlfqLvLeR0pkGRQUSV0+Og3cmWs56c4IAPLZqG3k2Uzc7s
         /PTEahfh3u7jQfr5N6adgTjW91FkhXlwBN9Y09Dv3pT+SYxff16KvZ2mw52NkiOB1kc7
         IwWBuTak94mPXTbgsjSB7TRIED/Ouc5GJNUphLIarEj7dqYLKNah/poNTPj8TIJ89h0a
         pydqUVEtW5VYZWrDd12y+X5WFZCuPx27553kmBvnHqQvoVZ1XU1y6S0g1MkKX2z6TkId
         QnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zfVmtS6KYvfWod3rab4fz6qOWga4E5X5CB2HKYlhhHQ=;
        b=iWGWStj6orX1rvCTgRPeUO2CXQQ26G5lzXMTrpQpqFshHYAY35eEp+FnLCa4yci73Q
         4MObBFhltzq2BLoRabszjlZ9q3Muk6MU8zzSBxqJpWC/VyDtepABG1prYWOuBV6y+Tk9
         JRTZFhYVtmahVudRH4KKuOH9bOjYSDcEPnohiiEtleJk0FRvhzF9/9Sqv9H7Cr/smZdV
         lDqdlPlhaRscLW9pdtitJXxJXUsnDUmQXns0WSpby1K2bY5U+8QN40uEpXl41yVR4JAF
         yxir9AsC30U1VB9oKC7ru6Kb2tf/w8RRyVEfQiTMacKVXiVVMFfv2lxjz7iGs+j78s7I
         j1iQ==
X-Gm-Message-State: ACgBeo2eJgK3JsCLTe2qg9XLVeQePKAQh2fVqHv8qvWgiELdscFVKPKu
        +JA3zvEi5uDCFqAKfG7JzHI=
X-Google-Smtp-Source: AA6agR7lHZ3823Lmmh7dr6wvftnHHB2dspDf/ds2s8lvMtBRMBOEv42heUT6coknD3MT4cHhYH7hyQ==
X-Received: by 2002:a17:902:6b82:b0:16d:d268:3842 with SMTP id p2-20020a1709026b8200b0016dd2683842mr2194918plk.16.1660819472611;
        Thu, 18 Aug 2022 03:44:32 -0700 (PDT)
Received: from fanta-arch.localdomain (ec2-35-78-114-158.ap-northeast-1.compute.amazonaws.com. [35.78.114.158])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7990c000000b0052d36feb7fcsm1263220pff.198.2022.08.18.03.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:44:32 -0700 (PDT)
From:   Letu Ren <fantasquex@gmail.com>
To:     deller@gmx.de, baihaowen@meizu.com
Cc:     fantasquex@gmail.com, zheyuma97@gmail.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fb_pm2: Add a check to avoid potential divide by zero error
Date:   Thu, 18 Aug 2022 18:44:24 +0800
Message-Id: <20220818104425.35573-1-fantasquex@gmail.com>
X-Mailer: git-send-email 2.37.2
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

In `do_fb_ioctl()` of fbmem.c, if cmd is FBIOPUT_VSCREENINFO, var will be
copied from user, then go through `fb_set_var()` and
`info->fbops->fb_check_var()` which could may be `pm2fb_check_var()`.
Along the path, `var->pixclock` won't be modified. This function checks
whether reciprocal of `var->pixclock` is too high. If `var->pixclock` is
zero, there will be a divide by zero error. So, it is necessary to check
whether denominator is zero to avoid crash. As this bug is found by
Syzkaller, logs are listed below.

divide error in pm2fb_check_var
Call Trace:
 <TASK>
 fb_set_var+0x367/0xeb0 drivers/video/fbdev/core/fbmem.c:1015
 do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1110
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1189

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Letu Ren <fantasquex@gmail.com>
---
 drivers/video/fbdev/pm2fb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index d3be2c64f1c0..8fd79deb1e2a 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -617,6 +617,11 @@ static int pm2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		return -EINVAL;
 	}
 
+	if (!var->pixclock) {
+		DPRINTK("pixclock is zero\n");
+		return -EINVAL;
+	}
+
 	if (PICOS2KHZ(var->pixclock) > PM2_MAX_PIXCLOCK) {
 		DPRINTK("pixclock too high (%ldKHz)\n",
 			PICOS2KHZ(var->pixclock));
-- 
2.37.2

