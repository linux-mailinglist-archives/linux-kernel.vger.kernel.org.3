Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822B4B5C77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiBNVSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:18:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiBNVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:18:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53211628B;
        Mon, 14 Feb 2022 13:18:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p14so15806734ejf.11;
        Mon, 14 Feb 2022 13:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=99BahZfDqfQoln2rf6Bj3xU3QXecprDtHuHMCBkgrcQ=;
        b=qhf19N3SLoLekl8nSgEbpHiFYk6ResBtkXfsJl63wafe0VQ0y5uwdcbx4dh7Api/cr
         pq4kpVN3rz8ufkFRa9PQhw12DgU06aBBMlGjIZ82TXZkn5kbidmhueb3xMvAz8cyvLFK
         23OCsQ5snWWXIQrfygum5Ml7tz1ev7oa/U9muYVV8pA1ru4b2uJnVoNiHqJAUlw6HTVD
         4YwuEf7WP8XA/Rm/UEIkIOK+MRnmJTKW4dRGuT49tZEp3Adgnjs0GNTOr22NQe/Yb5r4
         ZRdbMxoYgxE3NBz9Kcl1JoZpZ2VWWqZLEqmaXpiuwLy5eS4Rlf+vH+mqr6eGRoqwxN34
         hTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=99BahZfDqfQoln2rf6Bj3xU3QXecprDtHuHMCBkgrcQ=;
        b=8MvPCrp9Qh5VxH2eo86CV29dxKzn8thbL0ONZVBFka85iaKFnH1b0dMWsgzz8zE0mR
         3k9A4OeUByrY9Y1Wni31rKSwFze+yTqTiR4Erd9Tms0t+aKDE527JJ5NfE4tCGKWZ8Le
         AUeUxqyr1hntfjfkxJC3zkTqwgPhEmQfNOM8hvmK3cv7EmqASyRdo6uWc7GRvBM1jahg
         UVDkpTtN0gnqR+GEpCP+cTpEW+akEFA8qb5QWdfqovmSubzEmknQqY1UPgCSX4DqE+QO
         jENLitKRUII5Rimq2jZ7vgeHYHrSTWqDJyZDd+L7fGKl+J8SuFufKK6ns6B+MLaM3Ui3
         P+GQ==
X-Gm-Message-State: AOAM5322brr9yqyWrOx1rmIPNZS5W+a3qnOxarsVgsGYVHpXDNeAIBKw
        +koQZSToxcZVQ2eHjHiKL3v5Q6LMfyjS/g==
X-Google-Smtp-Source: ABdhPJwiFYCfncVtqTqjdVCBhQycol1aX209bItLXOycZar8UGc4dq3/BcvtHafFwyhS52svnZjIdA==
X-Received: by 2002:a17:907:16aa:: with SMTP id hc42mr167762ejc.307.1644865723011;
        Mon, 14 Feb 2022 11:08:43 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id m17sm2316338ejn.118.2022.02.14.11.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:08:42 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, wens@csie.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: cedrus: h264: Fix neighbour info buffer size
Date:   Mon, 14 Feb 2022 20:08:39 +0100
Message-Id: <20220214190839.707889-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
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

According to BSP library source, H264 neighbour info buffer size needs
to be 32 kiB for H6. This is similar to H265 decoding, which also needs
double buffer size in comparison to older Cedrus core generations.

Increase buffer size to cover H6 needs. Since increase is not that big
in absolute numbers, it doesn't make sense to complicate logic for older
generations.

Issue was discovered using iommu and cross checked with BSP library
source.

Fixes: 6eb9b758e307 ("media: cedrus: Add H264 decoding support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index b4173a8926d6..d8fb93035470 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -38,7 +38,7 @@ struct cedrus_h264_sram_ref_pic {
 
 #define CEDRUS_H264_FRAME_NUM		18
 
-#define CEDRUS_NEIGHBOR_INFO_BUF_SIZE	(16 * SZ_1K)
+#define CEDRUS_NEIGHBOR_INFO_BUF_SIZE	(32 * SZ_1K)
 #define CEDRUS_MIN_PIC_INFO_BUF_SIZE       (130 * SZ_1K)
 
 static void cedrus_h264_write_sram(struct cedrus_dev *dev,
-- 
2.35.1

