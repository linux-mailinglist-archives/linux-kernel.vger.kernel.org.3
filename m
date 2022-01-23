Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92EA49762C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbiAWWxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiAWWw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:52:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09067C06173B;
        Sun, 23 Jan 2022 14:52:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k18so10300265wrg.11;
        Sun, 23 Jan 2022 14:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4t17WuTYWsluW1zOs3IiEjCYxb4AKAQi4OUNkff8DAE=;
        b=nH+VT4hd7L0UzXsvnm1rRFcg3C39mKjnn5vukS5WAX5DK1S/e3bStsG6nsjiaMzR3K
         SR9aZTFaqeDlLPYSb7Qqmo2QrYXfnSSTbwPo3LmhFh3vyKNToI4nZL730y/3H8T3W3hv
         Qbeuz0gs8GV1CGTsJq86hk2TtywKtP6984e3pxpZDQwvfIWdT4zdPiihsGKiLfbo/ZQs
         8eITzUxQ7Uj2StWcjYKiwKH6WaVpq3vOwK9XhrHaob5yBKm8PEcHzRQsyxoxlzIP/oLr
         5cy7g1tCbEwOxTqSgQpEGVZFj0Lr0qdhcP+OcYlmEbGMvLVOCRT4wGWzm3hEARObd3x/
         JRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4t17WuTYWsluW1zOs3IiEjCYxb4AKAQi4OUNkff8DAE=;
        b=GSzHClNGTFLcrxPe5vigF1AG2GYs80PYGdETc3SSXiYCpoD01H+G+3ToPqZ+kTV8Fa
         BClPvJiHc+eT3teah6La1Ls51WaFfsvk9T7B/NqH7OzKaaEk7EquiNiFuYbKmR4HIHW5
         8uNZZMyGeu9/6XpqGPo5x5DlKfqGEplbVRf+6K+CQnusPRsKNzLq+BG4eBqfaNOo3sFs
         /lZTkgOZsO65u1KyZftuv++oFiqXg3VoyG16ohEzBe6xWsHh4aUcnyKO5aRh8U3sAkJj
         ZzPJBtw01khtNutgztRtUqo58fXx0rwlsxFYd4W40iMmjajhSSvwyhuHG3qQJqZ4KYCd
         Ssow==
X-Gm-Message-State: AOAM533Hg2F25jooYIRxT8SWA8fRHJVd1cxsSRWwa8MlAdp1LZ9GS5I1
        q/RpK0T5fYyOePvE0PrTdFkmdyKKVJiY8Q==
X-Google-Smtp-Source: ABdhPJxtuUF+Zzqria785snXgv4ZTm6AOybtSsl2itinWxIPyHjFIhf8EK29KJj+rAmZbzk1hNcDMg==
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr12496564wrc.438.1642978377692;
        Sun, 23 Jan 2022 14:52:57 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m6sm1137912wrw.54.2022.01.23.14.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:52:57 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb_frontend: make static read-only array DIB3000MC_I2C_ADDRESS const
Date:   Sun, 23 Jan 2022 22:52:56 +0000
Message-Id: <20220123225256.7056-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array DIB3000MC_I2C_ADDRESS is read-only so it make sense
to make it const. Also add spaces to clean up checkpatch warnings.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/dvb-frontends/dib3000mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib3000mc.c b/drivers/media/dvb-frontends/dib3000mc.c
index 692600ce5f23..06c95dc99dae 100644
--- a/drivers/media/dvb-frontends/dib3000mc.c
+++ b/drivers/media/dvb-frontends/dib3000mc.c
@@ -859,7 +859,7 @@ int dib3000mc_i2c_enumeration(struct i2c_adapter *i2c, int no_of_demods, u8 defa
 	int k;
 	u8 new_addr;
 
-	static u8 DIB3000MC_I2C_ADDRESS[] = {20,22,24,26};
+	static const u8 DIB3000MC_I2C_ADDRESS[] = { 20, 22, 24, 26 };
 
 	dmcst = kzalloc(sizeof(struct dib3000mc_state), GFP_KERNEL);
 	if (dmcst == NULL)
-- 
2.33.1

