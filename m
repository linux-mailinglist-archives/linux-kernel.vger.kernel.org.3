Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3668588954
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiHCJYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHCJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:24:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DE59250;
        Wed,  3 Aug 2022 02:24:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id i71so9065908pge.9;
        Wed, 03 Aug 2022 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tS3mRZvJWrf/7SzFXiZtx7ISgrebWavHAsTW6VGynXM=;
        b=kGTKMTb+HSH6m7jZIuNtSr/DpHHsSeqNYwcU/hQqyEdbStTE+OzwhA/gCRA7dFsw7D
         tq6TRy7KdIzv4Z7DaqwSwO66EylYdHzanmmpY9apntU3unk6Gwigo6GB6VAevwdMJzK8
         SxdlBepdBi3/BbuBhtMWTCZPZuTYRrKwtHKuW+wVKmsLI9PeRsa7gRBuVs9Jh0ipXYFc
         Ew9r3rSj7fZ0VhPQwIpmawzanWPkxAkX0lIiualaMlGfbTVDLSxFoRuTw6NuoQ0pX5q+
         Wz2COtvMLjrUIx1xlFEhnTM64jmW2GuDvrHYVZifRpub7U7OTP5tgudoEbuV8cYDGC/p
         M0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tS3mRZvJWrf/7SzFXiZtx7ISgrebWavHAsTW6VGynXM=;
        b=fAypYqGHQ4bdM85crXOL0DRRipg5GPqscRQKSpYcy0MV9CcHbWc39E/z/TItLSO8yn
         2W0fM9As2IlX49AR2Nn/STXWwkZO7TjQO1SMZurUXvosUt0eKM3aFD1CSvaAw9Lz8LjT
         O0zDraGtnQ+RZRX6whtAScmE5RSUF/o9MyzYKudcx5OXcDNaC/YR0JA6/D5kv7zcYWJv
         fEoLddI8BjWKWzxaJWdAnSTSajYR0bsft3OVo5AHNlJy1QpD5vQ3PQcYvS9ACN0oJCii
         rGqMapH79IlabWJlT0FVmYaxluOUPEGx1AHQCIucrPF/eE5Eg//0NuzI8yIOqIYTz/LC
         mo9Q==
X-Gm-Message-State: AJIora/rtpO2DbQOyUl1qn9+btzVjtI8GpjFG992lSu3L/78XPtmMMOq
        CJMkByeWWudATNvBcQynPA==
X-Google-Smtp-Source: AGRyM1uI2TLufQHOlnZpHYuLzE8YTQKSPWaB/HVJF9Fil5jZlAKjJuydRElg/PzGI69BpZZvg2CMtA==
X-Received: by 2002:a05:6a00:24ce:b0:52b:f337:e2d3 with SMTP id d14-20020a056a0024ce00b0052bf337e2d3mr24805747pfv.36.1659518651537;
        Wed, 03 Aug 2022 02:24:11 -0700 (PDT)
Received: from localhost.localdomain ([166.111.133.51])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090322d200b0016f02fceff4sm1393203plg.57.2022.08.03.02.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 02:24:11 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     Helge Deller <deller@gmx.de>,
        Ondrej Zajicek <santiago@crfreenet.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: arkfb: Fix a divide-by-zero bug in ark_set_pixclock()
Date:   Wed,  3 Aug 2022 17:23:12 +0800
Message-Id: <20220803092313.2492371-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the user can control the arguments of the ioctl() from the user
space, under special arguments that may result in a divide-by-zero bug
in:
  drivers/video/fbdev/arkfb.c:784: ark_set_pixclock(info, (hdiv * info->var.pixclock) / hmul);
with hdiv=1, pixclock=1 and hmul=2 you end up with (1*1)/2 = (int) 0.
and then in:
  drivers/video/fbdev/arkfb.c:504: rv = dac_set_freq(par->dac, 0, 1000000000 / pixclock);
we'll get a division-by-zero.

The following log can reveal it:

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
RIP: 0010:ark_set_pixclock drivers/video/fbdev/arkfb.c:504 [inline]
RIP: 0010:arkfb_set_par+0x10fc/0x24c0 drivers/video/fbdev/arkfb.c:784
Call Trace:
 fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1034
 do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1110
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1189

Fix this by checking the argument of ark_set_pixclock() first.

Fixes: 681e14730c73 ("arkfb: new framebuffer driver for ARK Logic cards")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/arkfb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index eb3e47c58c5f..ed76ddc7df3d 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -781,7 +781,12 @@ static int arkfb_set_par(struct fb_info *info)
 		return -EINVAL;
 	}
 
-	ark_set_pixclock(info, (hdiv * info->var.pixclock) / hmul);
+	value = (hdiv * info->var.pixclock) / hmul;
+	if (!value) {
+		fb_dbg(info, "invalid pixclock\n");
+		value = 1;
+	}
+	ark_set_pixclock(info, value);
 	svga_set_timings(par->state.vgabase, &ark_timing_regs, &(info->var), hmul, hdiv,
 			 (info->var.vmode & FB_VMODE_DOUBLE)     ? 2 : 1,
 			 (info->var.vmode & FB_VMODE_INTERLACED) ? 2 : 1,
-- 
2.25.1

