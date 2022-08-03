Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CE588570
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiHCBbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiHCBbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:31:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42F558F9;
        Tue,  2 Aug 2022 18:31:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso496579pjo.1;
        Tue, 02 Aug 2022 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WhzCt7ZgW+LKbQwQvPVI6t++DQIekCJZ1n72lgrdeEc=;
        b=UfMtI5F0A32q8jVuYnhDA27lKBMWQ/8qOiUvDdoMk8XTjT+AHwCj3UumiD5U9MMxOv
         twpE3WsfikZnc9kUv3KbPA277def1HlItmhTT/aBAgvEG9aglUxpecD3TprBvxE0+zNN
         ZQaR+epa7rC0VZG5uR645bscnWRAQKSrkINuC7wpAkw8XpzGr+4H6NXOYcZUPuOP4tAX
         5G3W7jNS9EHcm0v4AE7tQXPoXF9244qIdi40twGjxb3Dr46RDYMqv8smNHsMhfX1dKmB
         3/GaoEfOGdC4w2y58ksD+sG7fmgTWD/1bFOAR+bTZnvc+tlAq64GJtsTn+nyWlmlmkpA
         CV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WhzCt7ZgW+LKbQwQvPVI6t++DQIekCJZ1n72lgrdeEc=;
        b=vgudXcbzdt4pd4KfwOU86oc72/b+TWuz/HUpHnD3evIrcv4T2zQBO7koAauQdPRAT1
         YOkGKcV+ZZSC1NPAvDOi9UDlxblS9OcMh2s68jo98K7Hamet4DvJXPBAGp+ju1k4kPXz
         vmyHbHNnrH7BtlY12VIFtK7Dh0eqL0Z4owqTiyQeLYS0Au5LrYgq3TH5sXOngMSimMBY
         fNmnE5OOn0xM4jshFkpTmGXxPr14rKg/T53AknWPuQ0k3PPQ7SPpoa/HnY4YExvFrGph
         MXLXEIsRTztwtfKk/PK5e8H0NNasJJuKxHJkLsDCKpsqzuV1SSJcIwz+v4OGlKUnCeut
         QJAA==
X-Gm-Message-State: ACgBeo07w6EgTQYCNFDZ7XsFn4at3gURbrOQSJLMyqoenGQA6Dj1GPFM
        PsadlrGJmJSZ2vr5vtee4ZdeOIkivYvn2sO9
X-Google-Smtp-Source: AA6agR6XMDZHANAU7kA10nIDngUNjppbpRgEcfvum+qrO6pwYM9MdYrvKAGxNN2NIifQGCGyLZIi/A==
X-Received: by 2002:a17:90a:a401:b0:1f2:19a0:2874 with SMTP id y1-20020a17090aa40100b001f219a02874mr2383446pjp.146.1659490291131;
        Tue, 02 Aug 2022 18:31:31 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.148.20.125])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709027c0300b0016edb59f670sm369240pll.6.2022.08.02.18.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 18:31:30 -0700 (PDT)
From:   Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     mailmesebin00@gmail.com, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next] rtc: synqmp: uninitialized variable error
Date:   Wed,  3 Aug 2022 07:01:17 +0530
Message-Id: <20220803013117.318611-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fract_tick is uninitialized and can lead to uninitialized read which can
result in any arbitrary value from previous computations. If the code
flow doesnt execute the `if (fract_offset > (tick_mult /
RTC_FR_MAX_TICKS)) { ` block, fract_tick is left uninitialized.
Initializing with zero fixes the issue.

Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 drivers/rtc/rtc-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 1dd389b891fe..c9b85c838ebe 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -203,7 +203,7 @@ static int xlnx_rtc_set_offset(struct device *dev, long offset)
 	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
 	unsigned long long rtc_ppb = RTC_PPB;
 	unsigned int tick_mult = do_div(rtc_ppb, xrtcdev->freq);
-	unsigned char fract_tick;
+	unsigned char fract_tick = 0;
 	unsigned int calibval;
 	short int  max_tick;
 	int fract_offset;
-- 
2.34.1

