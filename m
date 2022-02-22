Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11644C00E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiBVSEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiBVSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:04:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076D35879;
        Tue, 22 Feb 2022 10:03:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q23so239417wra.2;
        Tue, 22 Feb 2022 10:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZA1AEF6WYe53I9xc29Ywox25Ld05hhSuOKpOWRLCD0Q=;
        b=ga5HhF1kzBzWTvKfcvvy2G6pPpg6ZSlIrxkAJbJ6v+ZHmwIpqeVSDShxafKYqADvsD
         yq8c5Vm8FrreBj0AuOhaGzsvaQHpvpXH09xRLPmTecId0D7mR5b0Q5QfjE6jrErigbjv
         VVVTT5kSvy5xYfdJGr4uWS6OtpC7cbb5DXOXTCjiDAybnm4+pJTkZvZjCrRdNONlHgEa
         P+AQ7H9H0+OXErltcVA5VO9AQiJ8YsKgPkoPLwkvqXwMdvToUIr1Idi1wzfR6Yrs5P2N
         VTp+munJbWJ8b9j+H0C8zrdeOKVysbJVHxCtezfJWdAa9UuZS36msAUUHMT1jz2ov/XA
         G2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZA1AEF6WYe53I9xc29Ywox25Ld05hhSuOKpOWRLCD0Q=;
        b=2JQFRIbMInoYvq3a+zxDwZZzUu9Gz4OuQ/2Vg+LAfmHg0BDVhjVCrd1KoapWiMUGz1
         q+XasB+oF9p4oF1DxckX4brSJwFhvSN63Pay2RF4hLS1/py4bN6Z6zhzjtwXUS5XNszR
         LNGyKiIlOPIdG4t08L6F4sVpoO2c1EeaS1AKEGyGdfToZQkHGi0moyWSJjNHpsF8p47l
         ttCpXEzy1iP1NBY2SHVILh7t9OVbUp6utj0ndr2uM/Hk1mrUu6wF0x+FMowqRBqm/PlK
         8zFpBqTEySRkvWGLs6+HAECbvfJ5Mvj8l81kV9baGbYxy60Nv2HSxdwtni2U2yTQEonH
         iflA==
X-Gm-Message-State: AOAM531trpgBZYzANH3ZjkNT2jARq7n0mdVUuckbhg27NvxXtuWgJyvF
        lwqRT4P1JItWBYUOCmy1UHs=
X-Google-Smtp-Source: ABdhPJzNFYx5oAjf3+Rk5ssr7+hioPDrHat9vTUipqzp/XT0YyvI9V4d7cbaImdepV5Gxc87H7QYTw==
X-Received: by 2002:adf:8122:0:b0:1e7:b111:3b92 with SMTP id 31-20020adf8122000000b001e7b1113b92mr21076844wrm.695.1645553011872;
        Tue, 22 Feb 2022 10:03:31 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id w8sm54251377wre.83.2022.02.22.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:03:31 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, mripard@kernel.org,
        wens@csie.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: hantro: sunxi: Fix VP9 steps
Date:   Tue, 22 Feb 2022 19:03:28 +0100
Message-Id: <20220222180328.2097103-1-jernej.skrabec@gmail.com>
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

It turns out that postproc on Allwinner H6 needs width and height to be
multiple of 32.

Fixes: 86790a4fdf4b ("media: hantro: Add support for Allwinner H6")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/sunxi_vpu_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
index 90633406c4eb..c0edd5856a0c 100644
--- a/drivers/staging/media/hantro/sunxi_vpu_hw.c
+++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
@@ -29,10 +29,10 @@ static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
 		.frmsize = {
 			.min_width = 48,
 			.max_width = 3840,
-			.step_width = MB_DIM,
+			.step_width = 32,
 			.min_height = 48,
 			.max_height = 2160,
-			.step_height = MB_DIM,
+			.step_height = 32,
 		},
 	},
 };
-- 
2.35.1

