Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9823A567F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiGFHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiGFHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:07:34 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29BCED5A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MTmpm
        kq8lDlzmI1AGwwyXBmrZuDcMrfzXvE6vkHoGjo=; b=BLtB0PQH9RP0W4rOvHpmJ
        qB7yPIrDgbWgFdm6YYTwpA+iiJYsIroXUQrUtWMQYfIxx7CyuUiKQTypbAOKSlSz
        yQvUGMbX4c+50BPUmtkg8SbSlEpjOLcpq6mJKT0lmCFc/8QBw+VMH+5SVpTCn9id
        M0f9/0Q2d8q54MgAzivB10=
Received: from bf-rmsz-11.ccdomain.com (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowABHYHJ6NMViehn3Lw--.12184S2;
        Wed, 06 Jul 2022 15:06:35 +0800 (CST)
From:   Zhongjun Tan <hbut_tan@163.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhongjun Tan <tanzhongjun@coolpad.com>
Subject: [PATCH] ALSA: usb-audio: Fix unsigned expression compared with zero
Date:   Wed,  6 Jul 2022 15:06:27 +0800
Message-Id: <20220706070627.16764-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABHYHJ6NMViehn3Lw--.12184S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyxKryxGFykArykZFWxCrg_yoW3Cwb_G3
        yIvrWkKa45tF9agryUG3y7JFyjya47tr4UWa1rtrW5J3yqyrW5urn5Zrn7GFWxWF4rurn3
        XwnIqrySqFyjgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnsNVPUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBdBs2xlgi3MmagwAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongjun Tan <tanzhongjun@coolpad.com>

Fix unsigned expression compared with zero

Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
---
 sound/usb/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e692ae04436a..e461715a43bd 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -766,8 +766,8 @@ static int hw_rule_rate(struct snd_pcm_hw_params *params,
 	struct snd_usb_audio *chip = subs->stream->chip;
 	const struct audioformat *fp;
 	struct snd_interval *it = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	unsigned int rmin, rmax, r;
-	int i;
+	unsigned int rmin, rmax;
+	int i, r;
 
 	hwc_debug("hw_rule_rate: (%d,%d)\n", it->min, it->max);
 	rmin = UINT_MAX;
-- 
2.29.0

