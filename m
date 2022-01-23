Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6D497604
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiAWWeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiAWWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:34:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB6C06173B;
        Sun, 23 Jan 2022 14:34:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v123so21735039wme.2;
        Sun, 23 Jan 2022 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCNGUDQSGH9xNCol2x80NKTo+CZUhhFOnPlnY5tZ8U4=;
        b=O09zGu4YJvsZVDLdpbYBixQ9Q01D+m8PO80S2oO7EimAj6T8/ojDty/tqx7VEUDCQ4
         jlvqs9r4XBLOcVpl3E5m9krBnI9BuNHo3bAImqInXEBy5U/OGmVeUI2mToceOsuDXVm0
         oqSyIZEvnAWKCznuOu0lZb010kmzxZvaFwJp2hoNgAf/Z9U1uEnxqeSeRy85U6c+qn43
         D7xa2Wgu+oZ15PYhD+qZc+TM2NILKNEUod7Al4ZRX+JRLv3rvFtSm2XaxfOfh//vLotG
         MrMQXAu+21B8dbu79Tf2kaAIBEH4p+/k+E5si5Ql9yBPa+mPakV16OyJtObAVqfZJjYE
         m+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCNGUDQSGH9xNCol2x80NKTo+CZUhhFOnPlnY5tZ8U4=;
        b=NnxjLOQSvoJRdvxH0gjCXsC/EaYxpo4yZwJkwXw7BezFLN+KwYCiwynHm/FbqIfylL
         Bb/Y25geJVcySfjlcFM7i1OSLnFW4IW4Cl6BFhlwvWOvw9M8Oi6CRUICf4jEO2V0nYnz
         sBgubsPHqUduzI0tRj/9Q9AEaaRRbeSxK3UOW8mtljpfJJ1pWO2FsA59TWlLmU3gdb68
         WlWX+4BKpQdASANMLCRBTQzrcM947Z0thda9XGJY+1scbyjo2jM7XesM5L6B5ydCocze
         uo6F9UGYWUC6LFps5UVxDrMlct2UAkBR/kQKKnMcFzVBK5YUIVche0dE2zTWPfMER1SC
         FotA==
X-Gm-Message-State: AOAM530ljGFbJpdFEuq7tdigik00xMoKLbIxY+LCfTsJteNdZQ67SVrA
        adcbo8NkXIfXABVuYFlkk5E=
X-Google-Smtp-Source: ABdhPJyRaNf2iwoq+Ye3fLdAxsVjpnS+gubpY+VSE0HaMIOQ2x9sh04f0onyuvQdU6o5q5XMUQiquA==
X-Received: by 2002:a1c:256:: with SMTP id 83mr9487342wmc.166.1642977258810;
        Sun, 23 Jan 2022 14:34:18 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o5sm17681375wmq.21.2022.01.23.14.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:34:18 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: make static read-only array channel_offsets const
Date:   Sun, 23 Jan 2022 22:34:17 +0000
Message-Id: <20220123223417.6244-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array channel_offsets is read-only so it make sense to make
it const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-dc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-dc.c b/drivers/gpu/ipu-v3/ipu-dc.c
index ca96b235491a..b038a6d7307b 100644
--- a/drivers/gpu/ipu-v3/ipu-dc.c
+++ b/drivers/gpu/ipu-v3/ipu-dc.c
@@ -344,8 +344,9 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 		unsigned long base, unsigned long template_base)
 {
 	struct ipu_dc_priv *priv;
-	static int channel_offsets[] = { 0, 0x1c, 0x38, 0x54, 0x58, 0x5c,
-		0x78, 0, 0x94, 0xb4};
+	static const int channel_offsets[] = {
+		0, 0x1c, 0x38, 0x54, 0x58, 0x5c, 0x78, 0, 0x94, 0xb4
+	};
 	int i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-- 
2.33.1

