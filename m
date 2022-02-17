Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDDB4B99AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiBQHQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:16:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiBQHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:16:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA1298AF6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:15:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v4so4767186pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAu6P2QjxVR4VUdAWpGZn10VmuVqrvEvsDKRB7LLSj8=;
        b=ArhKscJZcPm7XQ3BJ7/KN3FPzSOYv/PtM+QKvL00DYpeOEn9zcHQagtwvF82TAgWjn
         syM0c/Wjm0YF7G1i0gSI4U8s6bce8/e8PF2Nv+GIrNHPU7BKa8/JnwvJG+WabCpRWr2K
         6X8oMi8zAl+wu8zEGF0QAMOsNUV1HeDdbJXho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAu6P2QjxVR4VUdAWpGZn10VmuVqrvEvsDKRB7LLSj8=;
        b=WYd3g55Qy45Hns+Gl0iuRGo8K/dQmz4YO94PLc1c612BIFSH5x/2tlYj0+7KzPcALP
         aYih3RjkFAveGz/gUJJZaSt27FDUfov6pEX947pRX/g1RtVYYpnd0IkcFe1XJ+gLMN31
         qkv8chVF6k8mBckU/D9xae4aYWns6NNG84NeJZmgbpIDlveXdgIA7qc/AY+j5ZAgeClm
         eDTrsyssI8wKdS0sl4hz9tGfpcxtP25PWxel2KzdUBMeZndACazpg6ABQLreaqrEz8Y/
         9RUIJC4DPwMtANdb0YTwPL3GXlTmjaXuTLmv+11eG/E5an9kIiFWfXD8U8W0gPeSzLYb
         THUA==
X-Gm-Message-State: AOAM531/hw/BhkhiKey+mWefdqxjb2fMmqfk9pfjKmlk6oYokVWn3PIp
        USeOKnnhWAtLkua2NxqbxaWTQA==
X-Google-Smtp-Source: ABdhPJyij8njo8LHEu3kVSs14z7Mv7QPOJtWnoJ6OszqSof5dd5sEUcVpUbNA9FPDeGyiosL5DqPbA==
X-Received: by 2002:a17:90a:470e:b0:1b9:c33f:cd49 with SMTP id h14-20020a17090a470e00b001b9c33fcd49mr5902879pjg.186.1645082149123;
        Wed, 16 Feb 2022 23:15:49 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cdb:2c0b:b1f8:e426])
        by smtp.gmail.com with ESMTPSA id g21sm5827578pfc.167.2022.02.16.23.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 23:15:48 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Xin Ji <xji@analogixsemi.com>, Robert Foss <robert.foss@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH] drm/bridge: Clear the DP_AUX_I2C_MOT bit passed in aux command.
Date:   Thu, 17 Feb 2022 15:15:41 +0800
Message-Id: <20220217071541.1722057-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's observed that if the previous transfer didn't end with a command
without DP_AUX_I2C_MOT, the next trasnfer will miss the first byte. But
if the command in previous transfer is requested with length 0, anx7625
can't process this command. To make the case simpler, request with
commands without DP_AUX_I2C_MOT bit.

Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through aux channel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 633618bafd75d3..050616c1162128 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1703,7 +1703,7 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_aux *aux,
 		ret = -EINVAL;
 	}
 	if (!ret)
-		ret = anx7625_aux_trans(ctx, msg->request, msg->address,
+		ret = anx7625_aux_trans(ctx, request, msg->address,
 					msg->size, msg->buffer);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
-- 
2.35.1.265.g69c8d7142f-goog

