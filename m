Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D998A4CF297
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiCGHbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiCGHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:31:05 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258B72559B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:30:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id f8so2513486pfj.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xKxlOxWfrmgXn5SkJ9aDfWlv4XICNMC1SPIGCB1K5to=;
        b=Yh8A6+bzem3stvMecYeEPYwCnT85/VpriMI8No9Hh8ZtwetOetqpoonF2+OcsZEds+
         Mc340hEbtKAGO945F6NrdNV6hjyoq7/CWKzBR+aX1Kbloy8JAkfI7EVIwO5KFYDQxa9r
         l90hGXosH/5C4ha/LAW/MLsKa+S/uQHqjFdFx4u6bQMc/HEARsWXIfa0XUJbqCZdAT1l
         M8GiUJk0Y7yWQaIOXB+TxI4LgnJ5EzaEPKfTt4VKgP6HZWHS6isXbNTVvnaIrta+lzKG
         txponFY5oGEW18sejXK2PnYZmuywpZDRjHRjQHfAppEad+6zmapi4LwpBQYWMgW0JWG2
         GpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xKxlOxWfrmgXn5SkJ9aDfWlv4XICNMC1SPIGCB1K5to=;
        b=V9Byg+lIsVNvFFKKyQ9k55PBTeNo3q4L6syidbS5/jzBGKSIpgAXcP73C8i17fQGWS
         ogNRvAo8Q11gmf7Y+wHby5svGZ1/ztSOmBQPZqs0v88q8EUJs3h3F99M9arJ/GMSccCR
         DZrmjFFtyN6AckbPgUQPMhMaiYF2sbTHhxU1n4HfHV9+2z1mNvPTy9qEl72MmLctSsP+
         PoiDr80H78ZbeDFa4hjhb2tiUWvujvDXsIAMHe/MuYBbRJgGCDBOWAiS1wlqMri/sWS+
         NK5hfaZRu6/66HChdRVYVCm/RRyXCpKk5m9SB7/oXRBAW+YqEBPAQR9ogBNG6ptmVbr7
         BrCw==
X-Gm-Message-State: AOAM5324PzfZhH9Qtk3MClnPxq7GS5rKvqVdidUt22vvm131HIEgetVR
        MzUZOCWxWNsmWKJzgmWxUqc=
X-Google-Smtp-Source: ABdhPJyHaqgnKw1KIqNGqr9CbeBTqHGFGXTfWkmRWSby68YI1HFcGRbwebDPTzohMGMzWT/vMJumIg==
X-Received: by 2002:a05:6a00:a06:b0:4f6:aa23:edaa with SMTP id p6-20020a056a000a0600b004f6aa23edaamr11451892pfh.8.1646638211601;
        Sun, 06 Mar 2022 23:30:11 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h2-20020a056a00218200b004f6519ce666sm15049504pfi.170.2022.03.06.23.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 23:30:11 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Magnus Damm <damm@opensource.se>,
        Ian Molton <ian@mnementh.co.uk>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] mfd: asic3: Add missing iounmap() on error asic3_mfd_probe
Date:   Mon,  7 Mar 2022 07:29:47 +0000
Message-Id: <20220307072947.5369-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing iounmap() before return from asic3_mfd_probe
in the error handling case.

Fixes: 64e8867ba809 ("mfd: tmio_mmc hardware abstraction for CNF area")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mfd/asic3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 8d58c8df46cf..56338f9dbd0b 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -906,14 +906,14 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 		ret = mfd_add_devices(&pdev->dev, pdev->id,
 			&asic3_cell_ds1wm, 1, mem, asic->irq_base, NULL);
 		if (ret < 0)
-			goto out;
+			goto out_unmap;
 	}
 
 	if (mem_sdio && (irq >= 0)) {
 		ret = mfd_add_devices(&pdev->dev, pdev->id,
 			&asic3_cell_mmc, 1, mem_sdio, irq, NULL);
 		if (ret < 0)
-			goto out;
+			goto out_unmap;
 	}
 
 	ret = 0;
@@ -927,8 +927,12 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 		ret = mfd_add_devices(&pdev->dev, 0,
 			asic3_cell_leds, ASIC3_NUM_LEDS, NULL, 0, NULL);
 	}
+	return ret;
 
- out:
+out_unmap:
+	if (asic->tmio_cnf)
+		iounmap(asic->tmio_cnf);
+out:
 	return ret;
 }
 
-- 
2.17.1

