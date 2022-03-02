Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA074CA83B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiCBOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiCBOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:34:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E41FCFE;
        Wed,  2 Mar 2022 06:33:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y11so2109538pfa.6;
        Wed, 02 Mar 2022 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sIENRZvxILtmvpY4H4oNP3TaQLHomMUS/EjkRlWEo8=;
        b=aol4B1k/NR7H0lhb2aPaSbwdRJNl8jNg/g1vcAmDhpcSyKE5QDIZdZh23rsQ0TsqQ9
         6QA2mj9pDf5q9eBB3AIeV15e7A1Q9339UPENfA1OhY/9boxvk7/3Ws6hoDWj8YZP2AIs
         ExjfRNI0wT2SOp2NF8rYdSFz22Ue152DWH1hI74x6XlcU2gLCekbvbz/1e9hUDJLE1lT
         6lz/sl6vu6QX7pIAEOgq2KlZZcOeqnUA4bAoVP285SsvVdCVikPmtLgHMuSwoS2z50BF
         z0yiUzyVAFJ3WeNKmrG2AwCctJX5Fa9MDgcGRbNbLGnRWmZkkOwzO2qYFNu+OqJDVqf4
         JvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sIENRZvxILtmvpY4H4oNP3TaQLHomMUS/EjkRlWEo8=;
        b=IN/Vzw+gUhim9Gb0N1780xSk/hZOQwtZMTzf3Lw0ipVWAct4q8dkVEVvd2+Jr1fxnJ
         alaWYQoF/3H6gAwWpS7UemuHWYwEUZTUfkuni6lmiH3ZhQn+RubS50Ql954IxJRJQ9y2
         /zbw9iLgcf1J2gMxrTKnA6Gz7Ur8kZue+Jk5U+fJlmBGvdjhU4WNnjxuEFUrbOuRXYma
         e7GMeVGHfTTqAowT+epzAmNi+2KHiCKu4PU/ImUUdM0h3wFPg2qNIm5jeHpntv3Rqc7P
         iFYJzQrkBMOeCvfYRFqBqvCJ226MoXcfa/lpwnSOXpmyfJJX9bLvp8j3kXHbq+D+af/1
         qcRQ==
X-Gm-Message-State: AOAM532YpiQyM91D8uWY8mKLUAq0kA5IDkVFghveXRKsNd2TkY13mpxZ
        2FetJ5i/VL5oroq9XXfSk4zIiQCoZuqa6jc5qg==
X-Google-Smtp-Source: ABdhPJwVAq9h3Tk5Iy7LJyj1GVFFUQ3PCW83XnkZ7TGnhHFTRH2di3DlYnTToAw6ChjCdsF2+6vqBw==
X-Received: by 2002:a65:6803:0:b0:378:9366:3849 with SMTP id l3-20020a656803000000b0037893663849mr13663277pgt.484.1646231605645;
        Wed, 02 Mar 2022 06:33:25 -0800 (PST)
Received: from localhost.localdomain ([2a09:bac0:23::815:bfc])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001bedddf2000sm5275176pjb.14.2022.03.02.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:33:25 -0800 (PST)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] video: fbdev: sm712fb: Fix crash in smtcfb_write()
Date:   Wed,  2 Mar 2022 22:33:11 +0800
Message-Id: <20220302143311.2109322-1-zheyuma97@gmail.com>
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

When the sm712fb driver writes three bytes to the framebuffer, the
driver will crash:

    BUG: unable to handle page fault for address: ffffc90001ffffff
    RIP: 0010:smtcfb_write+0x454/0x5b0
    Call Trace:
     vfs_write+0x291/0xd60
     ? do_sys_openat2+0x27d/0x350
     ? __fget_light+0x54/0x340
     ksys_write+0xce/0x190
     do_syscall_64+0x43/0x90
     entry_SYSCALL_64_after_hwframe+0x44/0xae

Fix it by removing the open-coded endianness fixup-code.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/sm712fb.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 0dbc6bf8268a..e355089ac7d6 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1130,7 +1130,7 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 		count = total_size - p;
 	}
 
-	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -1148,24 +1148,11 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 			break;
 		}
 
-		for (i = c >> 2; i--;) {
-			fb_writel(big_swap(*src), dst++);
+		for (i = (c + 3) >> 2; i--;) {
+			fb_writel(big_swap(*src), dst);
+			dst++;
 			src++;
 		}
-		if (c & 3) {
-			u8 *src8 = (u8 *)src;
-			u8 __iomem *dst8 = (u8 __iomem *)dst;
-
-			for (i = c & 3; i--;) {
-				if (i & 1) {
-					fb_writeb(*src8++, ++dst8);
-				} else {
-					fb_writeb(*src8++, --dst8);
-					dst8 += 2;
-				}
-			}
-			dst = (u32 __iomem *)dst8;
-		}
 
 		*ppos += c;
 		buf += c;
-- 
2.25.1

