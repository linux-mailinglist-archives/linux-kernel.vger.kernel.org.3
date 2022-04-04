Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199E4F15D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351711AbiDDN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352518AbiDDN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:27:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457AC0B;
        Mon,  4 Apr 2022 06:26:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso403055pjz.4;
        Mon, 04 Apr 2022 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FlBsVFEKh4j3VAt6LeTKFsoKsuruo0DcZ5wQSPKgGVo=;
        b=gZxNZUcVpHlb+PC0mU029qi8y3yaBV33LkmOZB+zCVqsXIYEND5s0ftLAFjpG+DSvG
         3fre2ImlaHs0IToAEnvx8Ge+DDk9/z+wpD4ZGw38SCtRfsEbEO4pjAklfsQgrWcCtlq+
         /NChUBrxhCdkVoxZCR6VfOXHeSigso1sRZ7Fc/pZ1khBXeg8xEX1EpjsMh7+AVabZYn2
         8yv09bnMza+Qfv1P1GRodT8QGwJ1rbgkjTpmC0siV2jwaa8Rslz2GWkomEftev/V7mHa
         ewRE3nXenMD+InkvCKfXlyVm/K04usRxrRtQbfpqdnt9H2c9hJBLDrzbLpkOlOI6OBTZ
         IbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FlBsVFEKh4j3VAt6LeTKFsoKsuruo0DcZ5wQSPKgGVo=;
        b=rQLpjFALmkhmS1/49E/nqSYWvAcdDnsufbH9Bc6slIsBpZNpj5d290oNE5fHxUKAUk
         HkBVEuXqcQ1Z/sgK0o5ytiz5QxTBq/5GsCR14YrTSKU/IBACkZNrTwtkSOlyiJH9/xBT
         PGawEr472JJStNUfA/lMuXP705f6SafmjVutCnW4SYkF7Zv85+zIW8ARzfpjz/C9s14d
         u28D7Fk+MZm1E8jb+smS4krkGMjfIAq6l18fBrZ9MJ5qktWN1xyI+c3wh3I3p3hlohGE
         t1Khvl/G4qme3UeEZVFIzStWxaenQroxwiDktUdswIyXsrHdwYcXzq2Gf6Xp0YjQ4YEf
         FAXw==
X-Gm-Message-State: AOAM532L2ivPLpW7mRQv2jvd4QkoqtB3JHx5CTYg1S/u8nx37ncvidc9
        XVQlN4WFVescEBDDSgVuyMyu6LCD7sAv2R5VN58=
X-Google-Smtp-Source: ABdhPJx3+zSJdu5DehSeyrC7q6wpVT/4HVSBzcFwjxsrzsTyJC0b4HFVuDHkH2ecj14ojRx2BF95tA==
X-Received: by 2002:a17:903:2285:b0:154:c94:c5b7 with SMTP id b5-20020a170903228500b001540c94c5b7mr22253plh.64.1649078759509;
        Mon, 04 Apr 2022 06:25:59 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j3-20020a056a00234300b004faabba358fsm12617039pfj.14.2022.04.04.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:25:59 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] rtc: mt6397: Fix potential NULL dereference in mtk_rtc_probe
Date:   Mon,  4 Apr 2022 13:25:53 +0000
Message-Id: <20220404132553.28064-1-linmq006@gmail.com>
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

platform_get_resource() may return NULL, add proper check to
avoid potential NULL dereferencing.

Fixes: fc2979118f3f ("rtc: mediatek: Add MT6397 RTC driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/rtc/rtc-mt6397.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 80dc479a6ff0..07c6679366e0 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -269,6 +269,9 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
 	rtc->addr_base = res->start;
 
 	rtc->data = of_device_get_match_data(&pdev->dev);
-- 
2.17.1

