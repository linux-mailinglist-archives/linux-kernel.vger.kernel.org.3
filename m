Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E915B05B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIGNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIGNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:51:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544CDA99C3;
        Wed,  7 Sep 2022 06:51:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so7592052wrb.4;
        Wed, 07 Sep 2022 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=X0NRHzznEcchSri4bCoSt9nkeOdHiBAQ/5Pmte/Gyz8=;
        b=ZPGwmIXS/RcexDoa8uMC7Qrips3KiSqFH87cKBNHhTwrJyIbh+Gf46xHCuFlLz+D3r
         QJzjxWDnL/3wJ7vvsBEY1Rran3hIRJ8T7Apfg60js9xFLWTwZC8gcSHlapGLt6euwmcP
         wgNbvaxAKs/vl4DLQhzcnhAGxCj/OE1Nk8s5SsnoNQWY6ejjOfEbQcy1ij3+q6g7/rNs
         TGJ58yWg6fzHraOr7SAeKQyA5u0e1YJddwnU+sTLMYwvUCsuWPWsUM8CsZYsjyyqnDWT
         yBluKmdQc2i0pGvqpwH6/P1b+GDm9tvhHj33kDMuK8pjZ951VJygmrra4x9ZDpFAx2Dq
         S92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=X0NRHzznEcchSri4bCoSt9nkeOdHiBAQ/5Pmte/Gyz8=;
        b=PAFxZx2/kiiDouWB0+Fx/J82o9DDwoVsXjVpROJ+EFC4IGYFbEI/ar1SRGIcup0JT5
         5TVeXztfyWH8T1PxMUUy8LH98tau7Qu2Mw5H3WdgI55vMx1ebVGZ5E6HA1EhF4fJESqq
         7/gff0xzkM94x9Wqahyiu/3S5/JTK2raBmzFwKgCCO8LTfW9LvKx8j3E25h/Fsi56uO6
         Mx73dOj0Gh/pt0gfpKjvmsNag7zytRtPlKs7wmhd1gnYVpQn0qxc7LcFrS3u8l6K3q06
         YHE/UDZ8oroGBlhNDHA8Oilj9zKcTYIoygO3mIolSdENlHzkOWuFJO4d+AF4vwXiOGnS
         j+uA==
X-Gm-Message-State: ACgBeo0kCfzN0ardTj9uyj8c/lY+9VU54bfZZTsoy+8K/T8gBnvZ+698
        7vb31h8eGR/wX4eeJD0RVaM=
X-Google-Smtp-Source: AA6agR4RIMi9kvzI07nLVq88uJNBG/3Xnr/HatQQvRnewBFmASe0IG6eGxKCiJYiFkdZ1OToecCSkg==
X-Received: by 2002:a05:6000:1867:b0:21f:f2cf:74a8 with SMTP id d7-20020a056000186700b0021ff2cf74a8mr2224870wri.344.1662558657922;
        Wed, 07 Sep 2022 06:50:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w3-20020a05600018c300b002206203ed3dsm18379698wrq.29.2022.09.07.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:50:57 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Bernie Thompson <bernie@plugable.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: remove redundant initialization to variable identical
Date:   Wed,  7 Sep 2022 14:50:56 +0100
Message-Id: <20220907135056.679617-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable identical is being initialized with a value that is never
read. The variable is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up clang scan-build warning:
drivers/video/fbdev/udlfb.c:373:6: warning: Value stored to 'identical'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index c863244ef12c..216d49c9d47e 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -370,7 +370,7 @@ static int dlfb_trim_hline(const u8 *bback, const u8 **bfront, int *width_bytes)
 	const unsigned long *back = (const unsigned long *) bback;
 	const unsigned long *front = (const unsigned long *) *bfront;
 	const int width = *width_bytes / sizeof(unsigned long);
-	int identical = width;
+	int identical;
 	int start = width;
 	int end = width;
 
-- 
2.37.1

