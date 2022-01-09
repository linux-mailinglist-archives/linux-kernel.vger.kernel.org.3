Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9B488C06
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiAITYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiAITYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:24:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C955C061751;
        Sun,  9 Jan 2022 11:24:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c66so7416328wma.5;
        Sun, 09 Jan 2022 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7KLjfPHsWfXinvdT9x6SwzVroZgq92QvU7YFU5ZeWM=;
        b=eJ2muUDWeSDar4I1sLFaTGZhcHvqAdSpGMogP4fuj4m5J2xdYuZQPEszkuQHAbE08C
         fy20TVvX4eSaHLy986Oe8RMqcP62rOxSFOpaAvq+SGNKos5U2QTn73e8xJXEUK5TugXp
         BPztQRIxS3ET5kmCq2F8hSY/4zEwfidL2fwngro2M2GsXgGYLa8R10h4tC67IALi9dcJ
         rmvEvIoTD879fADNyXMYKP7xX6rO92qnN5sCdzgfjWVswCg5pOHTbCeuufsZKAoTqrut
         CSQp8CU2czG+ZiucpIEDGWIbeFiWI1xFyhUJvfD9ILlY+6e3Za2UTPxwutRpLTZFFw8y
         ly3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7KLjfPHsWfXinvdT9x6SwzVroZgq92QvU7YFU5ZeWM=;
        b=Eebsqlv88jU2wGM6EAQBkvnUnmqAJDmmFKCmZTgaNsR0md5oI+bLELQyKJfpQFWLRk
         gTLSmgh4eiyhI8aSnCXzfv45i+5HPAW163j2+Nshzc37tUp6MUazYNlb8y7DMzOBgInP
         663lyFwCq+NywplEGQvHqPWP6bNltD5b5N807jWdhSSI+1Ex1o6ieNPVVkpHSoKwwDG9
         Wd/f7M61aPNt2BKBKmuZo+ctMDdEd1kPkXPh8ZMGnwDlHmKvElc1/o+YnBYEeylQIzGt
         CiG9cKR2LDW9tmPWWFtpSYMQVxYSPIR4lKauXn7h+BncIWlCMOfq2lXLi25VkraopBGB
         bsSg==
X-Gm-Message-State: AOAM532BSf7M33dZkw/e53MNw9EelcKeUOM40wC9kc6dRek70JrRiOwe
        v5fLmW2mVW59kIToz4fcaJU=
X-Google-Smtp-Source: ABdhPJxob2kx7PZCoFwkFA0s/AKSHeLZcHwTJ8YZObT7NHoX+c9068fofT99Quzq/1i0wvnVcFJNFQ==
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr1712753wmh.95.1641756281658;
        Sun, 09 Jan 2022 11:24:41 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id w17sm5403831wmc.14.2022.01.09.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 11:24:41 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     kalyan_t@codeaurora.org
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
        abhinavk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/msm/dpu: invalid parameter check in dpu_setup_dspp_pcc
Date:   Sun,  9 Jan 2022 20:24:31 +0100
Message-Id: <20220109192431.135949-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function performs a check on the "ctx" input parameter, however, it
is used before the check.

Initialize the "base" variable after the sanity check to avoid a
possible NULL pointer dereference.

Fixes: 4259ff7ae509e ("drm/msm/dpu: add support for pcc color block in dpu driver")
Addresses-Coverity-ID: 1493866 ("Null pointer dereference")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
index a98e964c3b6f..355894a3b48c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
@@ -26,9 +26,16 @@ static void dpu_setup_dspp_pcc(struct dpu_hw_dspp *ctx,
 		struct dpu_hw_pcc_cfg *cfg)
 {
 
-	u32 base = ctx->cap->sblk->pcc.base;
+	u32 base;
 
-	if (!ctx || !base) {
+	if (!ctx) {
+		DRM_ERROR("invalid ctx %pK\n", ctx);
+		return;
+	}
+
+	base = ctx->cap->sblk->pcc.base;
+
+	if (!base) {
 		DRM_ERROR("invalid ctx %pK pcc base 0x%x\n", ctx, base);
 		return;
 	}
-- 
2.25.1

