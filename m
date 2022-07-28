Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD78B583BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiG1KMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiG1KMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:12:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0EE6554A;
        Thu, 28 Jul 2022 03:12:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g12so1547581pfb.3;
        Thu, 28 Jul 2022 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1i65+wYAMGoremMIr0Xi0boO4ehYs1X3ksPFjCjKlXI=;
        b=SwMM/drpJubu02Tra+8kE7yhZJyL8/5X0d7MY/hUUAt4oYLrQxRthbaPw2aN8QFPer
         /HisqsF//mDpmCBoz7Ucanzz9uo4ce9pOy1hcbLhJt7NusblWx/kiPkYulpLN4ryHJ2O
         pd9G4m3qPxK66C9QTCMDy06eapfbs+rccQ5rMldfzwRgHmDqdsjta0n1uCVndhGqcu5j
         ZMHJ2ucN710+nGZiF+rlXXG86Blb2r9yYo7RtCh1KTlY18pg8MeOdGYmscXNz3mALKP3
         6BrHbrBQAW6LFqy3m0r4rpy5cZSXSMWfRF5LLtByej7vygNBKMFxNlurnBshXMYs2oeS
         YsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1i65+wYAMGoremMIr0Xi0boO4ehYs1X3ksPFjCjKlXI=;
        b=D0N3GS7MmWbOO9ZLFfLg3oCXfztbzZYg/yz1lmm2ngCdzZ+/98clQ/vIhFPjhve/QT
         VKPTPH1lZUo8M0H4FxUI7fzWqXdtEQnMe7U4BThsQ+l2cCpBY449HH9Bv0IEQswZ/muJ
         VtBiDMa3FlgDJu/u6/ShcmrF7mcgT8vOZnyDEAdFjAmVwmkjK3NrUnuZDgQ1AxVbCVOS
         Ve+wW6IFqe50BV5xM02e3jOp9/ZdHMDAiNwHMoa0btW+DObKQ4OaTEg3xuukBJANQZgv
         MsF4+WvDkWyyTV9OlgSk3tAFo+JU4zl/a8QZFmNjuAHsltJUtc6qJ6j+AOgVEgAkQP4O
         9xlg==
X-Gm-Message-State: AJIora8OYhed374mavtORj/XxFy3DWy9/kcgwlhq40T0AQTUEElfFkl7
        YBDNk4Ci7dzMxQZdZmA3kdWWjoopLEVtCA==
X-Google-Smtp-Source: AGRyM1s1dEeCxotLll2OjwShE0rt45Q1Hm4f0IKSawKJCSwl09sKvHJO+xFGl/6ylX5SowceQYxwqA==
X-Received: by 2002:a63:4820:0:b0:41b:4a4c:5504 with SMTP id v32-20020a634820000000b0041b4a4c5504mr5570892pga.538.1659003165427;
        Thu, 28 Jul 2022 03:12:45 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b0016cbb46806asm741084pln.278.2022.07.28.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:12:45 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     mchehab@kernel.org, keescook@chromium.org,
        hverkuil-cisco@xs4all.nl, mailhol.vincent@wanadoo.fr
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] [media] tm6000: Fix unused value in vidioc_try_fmt_vid_cap()
Date:   Thu, 28 Jul 2022 18:12:36 +0800
Message-Id: <20220728101236.1909269-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
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

From: Zeng Jingxiang <linuszeng@tencent.com>

Coverity warns uf an unused value:

assigned_value: Assign the value of the variable f->fmt.pix.field
to field here,  but that stored value is overwritten.
before it can be used.
919	field = f->fmt.pix.field;
920

value_overwrite: Overwriting previous write to field with
the value of V4L2_FIELD_INTERLACED.
921	field = V4L2_FIELD_INTERLACED;

Fixes: ed57256f6fe8 ("[media] tm6000: fix G/TRY_FMT")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 drivers/media/usb/tm6000/tm6000-video.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/usb/tm6000/tm6000-video.c b/drivers/media/usb/tm6000/tm6000-video.c
index d855a19551f3..e06ed21edbdd 100644
--- a/drivers/media/usb/tm6000/tm6000-video.c
+++ b/drivers/media/usb/tm6000/tm6000-video.c
@@ -916,8 +916,6 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	field = f->fmt.pix.field;
-
 	field = V4L2_FIELD_INTERLACED;
 
 	tm6000_get_std_res(dev);
-- 
2.27.0

