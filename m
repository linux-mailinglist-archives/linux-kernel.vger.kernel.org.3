Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B474F1148
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbiDDIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbiDDItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644B3B56D;
        Mon,  4 Apr 2022 01:47:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s11so3160240pla.8;
        Mon, 04 Apr 2022 01:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=se5gGj4gIJ4vBWROJp5FA4oTC1hFkItwaNy9Koid500=;
        b=FAWD5yFE3Vc1iB03y75UnpfQijI3kB8ErWFbZSX3sTvLpWWs8B9bNUKAqt1J9AUjua
         +8qiSwoCtM81wPcqTXMLNWNi51npg2coAdhvntqlt8jzubrZcqpdPAzkPEP+df7LxRF6
         SU/2nl+b/D/Gfs5CGKOKbs5elEtIeGAeh1vYKYwyk5CpJxaYBG8ynXrXQISO+XQXwJNX
         oE8ZKXL7BUqPKahtHTTiFy1jsLmyVr/BiTJP0GWcFgyCkIBCLNn18/nIU9Zwz5uqdArj
         DfJQTbq4JSXt26CYu/+j4MreZdnQKpxzeh6b3w+GBv8DtX0UKPkv1dSkxJmCK0ViTutb
         oKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=se5gGj4gIJ4vBWROJp5FA4oTC1hFkItwaNy9Koid500=;
        b=CobhGj/r+mwThlSgE8fzOmLa+kg4Uil3KZ+fymShwYPENEv1ayMN4Y4niHJEVQsVvW
         23Hd6bXkFDtU3UBvYwehKa9lbO+q9ODPfoilEjl5F/ZM+nHXr8k8OAw/9J04ECOatRk2
         JDBLNuaW21PzGS+Hvz8aPSfLJ28QxpL1FPivQVBcsPCc7aXp0JhpO4GLb3/6MKoL4HbM
         MI2GIiLvucd+f4SSur3sJ5ImMdGRLskwzaaLQw9D2OiPCWp8kG4NIdy7z9q5DDROKzdt
         jyE9vnoFy8oMyGe86UjEy1tyFqnhq/GOAO7owEwm68OeBpVxeXYY9W6vqFc/qG7vzDrk
         CWpA==
X-Gm-Message-State: AOAM5316LIcphnbxG3eStPKw+ybpO2b1XKxi74xOCCZS7lVz5MfgENK9
        +jYKjZ2JXzA4cMH+YQu2pkFPA9tFupimSmVkzg==
X-Google-Smtp-Source: ABdhPJymLqxgqm2NQFE6WKf9I6xeVeCxVVNJO1ePEFu5Dx3u2IlfUF8NYPn6xZ6W5qBnlwa3LUtr8w==
X-Received: by 2002:a17:902:ecd2:b0:156:9992:5892 with SMTP id a18-20020a170902ecd200b0015699925892mr5803329plh.7.1649062067669;
        Mon, 04 Apr 2022 01:47:47 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:47:47 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 1/7] video: fbdev: i740fb: Error out if 'pixclock' equals zero
Date:   Mon,  4 Apr 2022 16:47:17 +0800
Message-Id: <20220404084723.79089-2-zheyuma97@gmail.com>
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

Fix this by checking whether 'pixclock' is zero in the function
i740fb_check_var().

The following log reveals it:

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
RIP: 0010:i740fb_decode_var drivers/video/fbdev/i740fb.c:444 [inline]
RIP: 0010:i740fb_set_par+0x272f/0x3bb0 drivers/video/fbdev/i740fb.c:739
Call Trace:
    fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1036
    do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1112
    fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1191
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:874 [inline]

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/i740fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 52cce0db8bd3..b595437a5752 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -657,6 +657,9 @@ static int i740fb_decode_var(const struct fb_var_screeninfo *var,
 
 static int i740fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
+	if (!var->pixclock)
+		return -EINVAL;
+
 	switch (var->bits_per_pixel) {
 	case 8:
 		var->red.offset	= var->green.offset = var->blue.offset = 0;
-- 
2.25.1

