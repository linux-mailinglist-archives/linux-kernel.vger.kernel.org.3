Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747CE52478C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351292AbiELIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiELIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:01:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4706D3B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:01:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p12so4150636pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dj+MY7TVUG7YYlF96sOIX1/Xkd2WTjl3qbMNcTVGbY=;
        b=CZkFRbSp/Rk60f9tno8+etGpGRKD6OMbn89hoACWVv3BOba1v0jPFWrqwYtyJEwGng
         VLwqj9OEw0yrmisT7WJf1Dq2zqzWy4Qsb8Ul3UxTQs00v1j8c514SQeJYUtVO8yrI1KP
         SfSYhdoGLzoreN/tJWsnhx+Sx64LKDNMKD4UoNjjLbyYRj/grXgnF3QuPnP+m8LEFVsA
         k6tf4cEqHNrGzbzZXDcjpxz/5CFuxzM0lnOz0WlCGcdgtIiTQmH4aO053/cG7Y/uIaqi
         Vhor7zAzngp9g4EOjNq/JklGerSkhP93GD3x0QRFWxX0Je9KPrNDfZNKcNDPy3lcNNT0
         ddAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dj+MY7TVUG7YYlF96sOIX1/Xkd2WTjl3qbMNcTVGbY=;
        b=lh4mXTVgUn/yavrb/OCTdH0meIUs015ANlntMQiqoUSquFcal8GyPkKAIgghV7plYB
         FoGhotRcAISXgLqfpsJhtn+ckUR/emQY4rxTZ3Pv4M0jsF7/h8j3L+6zMuKuFKpdEQz2
         EP1AWvCgk/Pcvvx01dI51LBcmdz4HUH82j5Gn/U/E4vBp/eeP4jEPBA0yJySoymLA9xW
         ZTdOVMQRkZ2DzGnqstl17EdTkKgQKp7IcQBnmszVZ+y+MlKA66qX9Mpdm1idft4UCMif
         +3kbBbTE7ZMZ+FqE0vvjNO4PwN5tO5T/MBW+5LS3skIo87NSUksDayFPY0HANiPJDzQA
         WEgg==
X-Gm-Message-State: AOAM531I1n7rYr0otimDGodDnxvagcNnCBpp0KUA3pGMcbgkfcIJsy7t
        qt0HursB47zv2raSNJ9ar4I=
X-Google-Smtp-Source: ABdhPJzF7pwE1O6H64JMb4XxkQaRnY+MhwNvbklpsOaM71M6o4JTk9mqHUlzFKCq6GwZKMTlSusRPg==
X-Received: by 2002:a63:5211:0:b0:3db:1c36:fc37 with SMTP id g17-20020a635211000000b003db1c36fc37mr6384919pgb.572.1652342498793;
        Thu, 12 May 2022 01:01:38 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id az9-20020a170902a58900b0015e8d4eb1bcsm3264531plb.6.2022.05.12.01.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:01:38 -0700 (PDT)
From:   Genjian Zhang <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian Zhang <zhanggenjian@kylinos.cn>
To:     hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH] ep93xx: clock: Do not return the address of the freed memory
Date:   Thu, 12 May 2022 15:59:43 +0800
Message-Id: <20220512075943.2397833-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there will be basic judgments of IS_ERR() on this return value
elsewhere,but I think it can be replaced by the actual error return
value of clk_register.

Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/arm/mach-ep93xx/clock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 4fa6ea5461b7..762328de4bce 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -345,9 +345,10 @@ static struct clk_hw *clk_hw_register_ddiv(const char *name,
 	psc->hw.init = &init;
 
 	clk = clk_register(NULL, &psc->hw);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
 		kfree(psc);
-
+		return (struct clk_hw *)clk;
+	}
 	return &psc->hw;
 }
 
@@ -452,9 +453,10 @@ static struct clk_hw *clk_hw_register_div(const char *name,
 	psc->hw.init = &init;
 
 	clk = clk_register(NULL, &psc->hw);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
 		kfree(psc);
-
+		return (struct clk_hw *)clk;
+	}
 	return &psc->hw;
 }
 
-- 
2.25.1

