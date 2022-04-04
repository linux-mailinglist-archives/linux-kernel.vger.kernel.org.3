Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A086E4F114D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiDDIuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbiDDItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B63BA6C;
        Mon,  4 Apr 2022 01:47:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso1224672pjj.1;
        Mon, 04 Apr 2022 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Dp26xvo/OWBw1ANhAEXpc1rNkAlB/vfXe93IpIqI6Y=;
        b=N7B4YUdHA5X14Z98xRic3ph/TDam03J6r+SaLio3r0NOrD/uN9H48sTbuxImkJLW6I
         E8YSiitNg3JBfvyiLYk0iX5RhtHSWP8CCCzGIxGBUIjIVEDMkhTXu66s5tVJt4nXf77d
         fnW3+qY01p2fv5GqiFsqluOe0hfxdqab2PqDznLJ/IsyhuwRHxm2nx9FFq0aYTHvH1Iy
         r357HRXMjj2B2PkwGIoMFVRn4nGBsZ2qS/VczSqSQoVcO38+AyBhGhlApWOns/NUXmII
         /imIbWKUoE62Q1s1yjN+kpBOaZzHqCvzg2F4JLGaO2i5roWGM8IuN1RUbmNuehZfZDGQ
         a88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Dp26xvo/OWBw1ANhAEXpc1rNkAlB/vfXe93IpIqI6Y=;
        b=pKhP/9loDEbBH0p0OJqh14c0wnzd8nszvL3medAq0M6rLyInvCsVW24MsPzWUVJkAX
         yDv5ps661NsMZKzK5/Z1bhsVgc1FkqDjSuIiE2MGJtAjykMaNZkMU5+co4kpgb4eaNRr
         MJhsD+8Bn0/Rs1fUMbhJx/XYRwTbcwyCKtOVq3sN6QHhkxpgRqdUpn1sdtl536SE8WqC
         9WrsUaeaGGEqnepP/ao9fVPkikFxpYkMsCt+hwZDNyHHoMjc1xQFRIOXDb5UuuU8rSz8
         I1xliPBFKJH16QaTyqgHl8vLQ1HNAkDorla2IMFnzV9BngeJbbTEhkqWEur5KTwhDFND
         nhwQ==
X-Gm-Message-State: AOAM531SClznbtTCtv1wvsrlRuqnoUhfGBcRiWx5gRyJxbMya7TTyfjs
        N9b3Ef/3PnmDfpWIJAmMFg==
X-Google-Smtp-Source: ABdhPJy72jA/2st/G//51PTWh7W6OWC4XiZ2I9BsaCCF+sqVXaF/3AWziOFSL05+SBew/BNAaFPMKQ==
X-Received: by 2002:a17:902:e746:b0:156:9eed:d2d6 with SMTP id p6-20020a170902e74600b001569eedd2d6mr4849504plf.144.1649062073047;
        Mon, 04 Apr 2022 01:47:53 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:47:52 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 3/7] video: fbdev: kyro: Error out if 'lineclock' equals zero
Date:   Mon,  4 Apr 2022 16:47:19 +0800
Message-Id: <20220404084723.79089-4-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404084723.79089-1-zheyuma97@gmail.com>
References: <20220404084723.79089-1-zheyuma97@gmail.com>
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

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of 'lineclock',
it may cause divide error.

Fix this by checking whether 'lineclock' is zero.

The following log reveals it:

[   33.404918] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   33.404932] RIP: 0010:kyrofb_set_par+0x30d/0xd80
[   33.404976] Call Trace:
[   33.404978]  <TASK>
[   33.404987]  fb_set_var+0x604/0xeb0
[   33.405038]  do_fb_ioctl+0x234/0x670
[   33.405083]  fb_ioctl+0xdd/0x130
[   33.405091]  do_syscall_64+0x3b/0x90

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 25801e8e3f74..d57772f96ad2 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -494,6 +494,8 @@ static int kyrofb_set_par(struct fb_info *info)
 				    info->var.hsync_len +
 				    info->var.left_margin)) / 1000;
 
+	if (!lineclock)
+		return -EINVAL;
 
 	/* time for a frame in ns (precision in 32bpp) */
 	frameclock = lineclock * (info->var.yres +
-- 
2.25.1

