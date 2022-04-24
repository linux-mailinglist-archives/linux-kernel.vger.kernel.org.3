Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6311E50D011
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiDXGcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiDXGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:32:04 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8FF184F1B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:29:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hh4so8371343qtb.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPpoWIDfl3jIhP9q6d7XhbI2A7YymanhdXc9XbXpxL0=;
        b=bO3DGLtmpWVdPwQHVHkfpA6dwxkc28EDMwmB641p5H4JL3YAuq+GHRPwKt1IDJNlXp
         2tE81jWR/npMO6EhuHt1/q0wNm7hS25KqPHUw9GqAiVo3mQSMZYmakzp3zCG512ed27j
         uhMVMuSrtU0UCWYeaNKeSrgGR8JPA2bFaiCo5DTLESdcKb/jY2XC4loYv8Oi3i+3vclc
         1YI+9QbROfvXY1Ahe64pYJHbGcscRDOXIjQJQsZE349ysEaAq6Q+VcQOax33lrdDQ3dB
         yyCIYlLU6szNZ91bF+19D/xoZ1adsySs8Uf6LOoV+upMvaTkbcZrvrllcIzExAtd1BFV
         JHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPpoWIDfl3jIhP9q6d7XhbI2A7YymanhdXc9XbXpxL0=;
        b=Ki5U/gol550nWnX789jRR0+mIaeTigIlWVpi1xc6NT6cmIHj0NwDvfMtm2/bcjrGP2
         9oBl7FX3dliTXcBeP4ujb5j2g1Q1fuz3bEz1lr5VX722Ywj0QbPtNXKAq/fTP1aBHnOQ
         DHi52+1UBZm2m+U2MLHNHmLBe7YxsADFBNP3dIBLfiQhlcAPi3QuvF+MNh6otXcL03E4
         nPv9WrkuRKB6uL6lxE5j0ON6/c+KqHKBGOh0+FfkO/uJUTADVIMUJZCSoV9GZf+8Kv/y
         0pYBef5tCkPbD8T7yu73PmPX4infMfpYtU3TMz3yQDcihAeAB2luzdL5Cp3xid+HUhbm
         evtQ==
X-Gm-Message-State: AOAM531RX50BlCAp0rwl8rxweHw1TGNYpPa5vprilhP6u+craFa+yvNs
        SEUaPulYxpieN+obneqiS5VyjeGSNOM=
X-Google-Smtp-Source: ABdhPJwjhQ1BMRL7u4uZpLTyOEy6ag403q2P+OxjcZ0LIQbTGvh/wrMs5g8bKSczKjz2uB60Y6+qOQ==
X-Received: by 2002:a05:622a:1647:b0:2f3:6077:bffb with SMTP id y7-20020a05622a164700b002f36077bffbmr3664110qtj.462.1650781741984;
        Sat, 23 Apr 2022 23:29:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v67-20020a376146000000b0069ec181a0c6sm3283226qkb.10.2022.04.23.23.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:29:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     mporter@kernel.crashing.org
Cc:     alex.bou9@gmail.com, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] rapidio: remove unneeded flush_workqueue
Date:   Sun, 24 Apr 2022 06:28:31 +0000
Message-Id: <20220424062831.3221620-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

All work currently pending will be done first by calling destroy_workqueue,
so there is no need to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/rapidio/rio_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index db4c265287ae..f2c0d6aa911f 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2198,7 +2198,6 @@ static void riocm_remove_mport(struct device *dev,
 	if (!found)
 		return;
 
-	flush_workqueue(cm->rx_wq);
 	destroy_workqueue(cm->rx_wq);
 
 	/* Release channels bound to this mport */
-- 
2.25.1

