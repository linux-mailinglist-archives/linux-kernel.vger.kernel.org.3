Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8E4B06BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiBJG6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:58:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiBJG6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:58:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683E10A6;
        Wed,  9 Feb 2022 22:58:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s18so7762254wrv.7;
        Wed, 09 Feb 2022 22:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u78B18o9gcsc4cL6IkzErLE1PeBzNrlXsUNhAfo/eQA=;
        b=Z+CyvLG7KD/HpWPAArX/wKn2XNrlxk7iy8frG7an2ljCw2UYm4L+d2nlDwDzVHi3lP
         jFbwovb1dRqTM/2101G1HUM/8mtO8uLvQ0gVqEf3ulnKJeMOY6IJVtgcy35mntS9byQy
         alpXiBuP+DJ5fBtj4gakO1YdgI1d2qoUG5bvX2ecVuzvRQZkkl7FOGaxxOeyvuAXZpsa
         Cmss2vfY1cWUZu/F+ggYvG6vOhgeVCyXVfM820UicCMYzO15VyUl9/aH3zciHnzreBM6
         GuOrzWPgzGxeROCjQqdoDth5TVAsYGaY6KRNT/CU6VNNsoVZsMWbHG4/qIdEXwyFqVcQ
         zIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u78B18o9gcsc4cL6IkzErLE1PeBzNrlXsUNhAfo/eQA=;
        b=7hQC74p9wrnPHl090WuYi3ahoM5g4Z96XBRKq3MA8yWl8ASFqKZABGB8ab1ajuFKtq
         L4abT5xbAtG3CvnKVgoOBhXDpm24bLzT3oWCvWkbCRYRsEKEfJXBR2osEOFnx2zDKE+/
         f9f3GphJEVuYgvbpDgCp5LZvwUHWjp1mdNCxFs4gRaWKdBZJWLu72EPOoAmmpg4fMEJj
         VoOZeFOak1U5u4Tpqnkd5vfIOE4lR9rS7VudbTskFLy6y4GI5qNTXr4j622/wbI0UHlj
         Xze8dThYKTyTtvE5aVpUyrySCeKQSSq59lkrQiZvp1AbMH57url3FeFAI9/Kx4s9V7k9
         a7Cg==
X-Gm-Message-State: AOAM5306zu3pR1xbwZx03Am2sUF4IfcgqjoPmIQkrZOadUltZPhohb1L
        0gPfqh0apENiWffzl99RW3+JqztSp33T7q4R
X-Google-Smtp-Source: ABdhPJwe+XGoIjBrzTJSHQ7oKv5mlppiFkBHW6003ML4aU0ugi6ehTht+78ijXA2D7tO+Ul/JUwQrA==
X-Received: by 2002:a05:6000:178f:: with SMTP id e15mr5133719wrg.439.1644476324368;
        Wed, 09 Feb 2022 22:58:44 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.24])
        by smtp.gmail.com with ESMTPSA id v9sm6621456wrw.84.2022.02.09.22.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:58:44 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, sam@ravnborg.org,
        linux@roeck-us.net, willy@infradead.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rcu@vger.kernel.org, pmenzel@molgen.mpg.de
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] video: fbdev: fbmem: fix pointer reference to null device field
Date:   Thu, 10 Feb 2022 14:58:24 +0800
Message-Id: <20220210065824.368355-1-zhouzhouyi@gmail.com>
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

In function do_remove_conflicting_framebuffers, if device is NULL, there
will be null pointer reference. The patch add a check to the if expression.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear Linux folks

I discover this bug in the PowerPC VM provided by
Open source lab of Oregon State University:

https://lkml.org/lkml/2022/2/8/1145

I found that the root cause of null device field is in offb_init_fb:
info = framebuffer_alloc(sizeof(u32) * 16, NULL);

I have tested the patch in the PowerPC VM. Hope my patch can be correct.

Many Thanks
Zhouyi
--
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 34d6bb1bf82e..422b1fc01722 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1579,7 +1579,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			 * If it's not a platform device, at least print a warning. A
 			 * fix would add code to remove the device from the system.
 			 */
-			if (dev_is_platform(device)) {
+			if (device && dev_is_platform(device)) {
 				registered_fb[i]->forced_out = true;
 				platform_device_unregister(to_platform_device(device));
 			} else {
-- 
2.25.1

