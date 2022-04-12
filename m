Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31FD4FD087
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350669AbiDLGrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351017AbiDLGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:43:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D80739148
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:37:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so15933403plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=z9KCSsSOTorZ297IRaNBlVXKYcv73Yi8iB+F+B3CCNQ=;
        b=JmmcP1AtLg3fbaMnX+VVeF4cZ4XJEHNbYmBA124tHtTaz7JLrPIaoAmVjTv6WwP1lS
         yHVzSeQ4kZSs8V8Jqpvqd74EJ1cs7rdj/0KVQI9eTokFX3y+eBfRPtwSckN1oZgHR3Wl
         RsYgZwIhxmKI3pC0JNARPPOj8y5Vhb9Elxu9Y/nUqFu1dzndBz8f9JSYSC71euSjzFzo
         UObmYrjsaa/q8LknB3BSu0gZQPRp7nUBwgctAZlhxP02pJkORvNLAolvZ8NONJPWCWQ9
         k6aUXTmGfmOMBJ4k61QdA/ZWLd18YoiUIgLQYdXxIrgckWETDQ1ZEdkXVe+2PQJZhChW
         lB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=z9KCSsSOTorZ297IRaNBlVXKYcv73Yi8iB+F+B3CCNQ=;
        b=8MJ07pCXAg1M+ZjfJKjhw+W5xWS/v5pPblGgODZVgFFb+vT+o8QI5OUEDL5PdgEM2W
         d4amsa5yKhX6ikQcUUlpclej/clzJLW7qAAq1/dZWTS8oqNaFhcG54K1eKW2cZg2unA8
         spTuhNIM9/tMPjdvu+S+Jw8dKcSBsqys++KBdZLraZIsYgVagIcdC6VK8LK5L2mbDO0w
         EDd/wV2X6bP6WRUrA1et8SIbfDSNCux8PL28yfwvNL/7jKV6KqWWqWAQ+fUTi6qtm/7I
         MoS+xhHWRMQbF3F3lijBzJ/KYHox0If5piMI3y5+eLjbDcCN4PBzg0cx1h0uxEqk3FTU
         fjAw==
X-Gm-Message-State: AOAM531SlejCvEDLeS6fuDmBqaKL4WEQzPxowDaa1Y6Cnp/VwL6OLirn
        jbjD9KCrXGzX46Jm6h8vSAs=
X-Google-Smtp-Source: ABdhPJxbRo2HxccOLyjPF69o/uFLKLEC2j4IdcjTAgHfPDXjQ0DQp/HOEXokeWC72a2MvL80rsvHbQ==
X-Received: by 2002:a17:902:8e82:b0:151:6f68:7088 with SMTP id bg2-20020a1709028e8200b001516f687088mr37030839plb.11.1649745430901;
        Mon, 11 Apr 2022 23:37:10 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id nv11-20020a17090b1b4b00b001c71b0bf18bsm1618768pjb.11.2022.04.11.23.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 23:37:10 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: Fix return value check of wait_for_completion_timeout
Date:   Tue, 12 Apr 2022 06:36:52 +0000
Message-Id: <20220412063703.8537-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202204121253.NcZifMQi-lkp@intel.com>
References: <202204121253.NcZifMQi-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long not int.
It returns 0 if timed out, and positive if completed.
The check for <= 0 is ambiguous and should be == 0 here
indicating timeout which is the only error case.

Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
change in v2:
- initialize ret to 1.
---
 drivers/mtd/nand/raw/sh_flctl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index b85b9c6fcc42..2373251f585b 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -384,7 +384,8 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 	dma_addr_t dma_addr;
 	dma_cookie_t cookie;
 	uint32_t reg;
-	int ret;
+	int ret = 1;
+	unsigned long time_left;
 
 	if (dir == DMA_FROM_DEVICE) {
 		chan = flctl->chan_fifo0_rx;
@@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
 		goto out;
 	}
 
-	ret =
+	time_left =
 	wait_for_completion_timeout(&flctl->dma_complete,
 				msecs_to_jiffies(3000));
 
-	if (ret <= 0) {
+	if (time_left == 0) {
 		dmaengine_terminate_all(chan);
 		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
+		ret = -ETIMEDOUT;
 	}
 
 out:
-- 
2.17.1

