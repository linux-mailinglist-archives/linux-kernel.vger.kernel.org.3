Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C84F114F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244728AbiDDIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbiDDIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA263BBC1;
        Mon,  4 Apr 2022 01:47:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w7so8298022pfu.11;
        Mon, 04 Apr 2022 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWpUGp4NjV3mF23nQixJRErG81vz0xeRsfDHiseYmFE=;
        b=b0BitWdvZHTGzL4flNceTWdnxQtwSwZY5rAnnRUa1Ml+nFqLcBJ2kKJx/fs6xfPFvl
         CnhHwqlgN/roC4WdLsqaGZsrjw6Ld8wHYNg7TEz0LuvMMuJCYT1osfRnlImjbXzJc5Gj
         9vDQNbKfeIWAgtHngp01v6YPYfxabAvWqaqYHRs2bqWl2kkaRyMwlJu+2ZrhHUj5PLrs
         yjl5sBxSLIL93Y2FN9GX0kX6956qgWteXsvblXuZLS6Fbf4RptxQoU6nDZ3xBJFrZK1w
         V/7LXCAYAJvqjwVBn/J4+KZoqUzskh2ygSUXO4hEz6OnN7FCJ/rzL3/obwNAklbZ0TYN
         kF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWpUGp4NjV3mF23nQixJRErG81vz0xeRsfDHiseYmFE=;
        b=US3FOB8Gtnk1/PBVb5AQnDtER/KrYNkkV5H/VOqKsxiunR5xi+VVVOwkqObSPGGhFY
         KmUHtzrfbvJvYouCAGXTuwNN9759HCQBMDWKNFAR0BgeVxwXZULP/OpsMlGOp2LN16L0
         1wMtjEg5sW6Eok/8C3nTHt31Kb/kzzLipr2d2mX2V1yzA+ZwWQbK9nkzJJfjnDlDV577
         UYdkwpPkWA3jnHH53Uz5rHABiYuB4cDaX3/yRY9GAP5/pssZVYCxjMYtSH0+2gI30ZGP
         Y+uQabOT3GCah8/BFh/ct9Yud4QUw8PfT6D/1pPtDjnHBTlQ60WlmoIwk/1pLwM9za8f
         Lt6Q==
X-Gm-Message-State: AOAM531c2QFmkLERUiz1dsUhZ3Y8a3t9DIb+ZdP1XoA/KdMzHP7dBd81
        T9T6PKlWmz2oFSCbObpAxYlUu4XOxCWdYsBAuw==
X-Google-Smtp-Source: ABdhPJxz/8JcRIXtURoXNzWsyUQjQh/GXQxIkNp1/xI8KkbxCy3Pghw6PtQScHAtt2QEukPM+DPMqg==
X-Received: by 2002:a63:4f08:0:b0:34c:6090:603e with SMTP id d8-20020a634f08000000b0034c6090603emr24435870pgb.15.1649062077959;
        Mon, 04 Apr 2022 01:47:57 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:47:57 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 5/7] video: fbdev: tridentfb: Error out if 'pixclock' equals zero
Date:   Mon,  4 Apr 2022 16:47:21 +0800
Message-Id: <20220404084723.79089-6-zheyuma97@gmail.com>
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
ioctl() interface. If the driver doesn't check the value of 'pixclock',
it may cause divide error.

Fix this by checking whether 'pixclock' is zero.

The following log reveals it:

[   38.260715] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   38.260733] RIP: 0010:tridentfb_check_var+0x853/0xe60
[   38.260791] Call Trace:
[   38.260793]  <TASK>
[   38.260796]  fb_set_var+0x367/0xeb0
[   38.260879]  do_fb_ioctl+0x234/0x670
[   38.260922]  fb_ioctl+0xdd/0x130
[   38.260930]  do_syscall_64+0x3b/0x90

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/tridentfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 4d20cb557ff0..319131bd72cf 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -996,6 +996,9 @@ static int tridentfb_check_var(struct fb_var_screeninfo *var,
 	int ramdac = 230000; /* 230MHz for most 3D chips */
 	debug("enter\n");
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* check color depth */
 	if (bpp == 24)
 		bpp = var->bits_per_pixel = 32;
-- 
2.25.1

