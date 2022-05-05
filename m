Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0651B5D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiEEC1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiEEC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:27:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A470D4C788
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:23:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d22so3106681plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q38L+5vJ92fuvVynN1L7WfjgLwHAa0h+20EWg5+2ZbA=;
        b=P1Sax+qeu8zu7OldU9p7tZCHML7RqVZDZ+OohB5xa0quMwTa//Q/W5bBINaeWZmMTA
         FNJmexTiachc8+FGGTh66kh6yvjOGrWhpfLpfCvux0Fk3q6kcj5Q812TPjuNKtJ4Yumm
         iTH3Fxv1LELwtuUGByweo5R3busBdI5CHPkGTXOlZTaEIfiz/vvAF69mv3T4HtB7xz/f
         Qb6666sIgEqjxvooH1Dg+KfY4UFOFyHz9w4P3LxNi/+fmQOlpCH312Kv/3iYoJyxSFxS
         BWYGwhUkOWAnG/g/hxfevnSIcqHOOlkrLSiKr05W3i/RCSZ9L2z+UWODHGKG1gQ80jwe
         vavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q38L+5vJ92fuvVynN1L7WfjgLwHAa0h+20EWg5+2ZbA=;
        b=4m3F3k/pWiJSCQot66BcXz3e+RYkNh/cqvXS1YqhkXZphQSaA1hG6wAaiL3YyjkNr2
         aZ0OwrzaXZPCyqrzTl5GLkGVnDRN8hmhsS6gpxliAlW+4nLvuGmCo1ucbWHuHpxJTsoI
         yc9HHVcM+i7xVYletMTxSkVJrMHb5JVYk/wGSVhUmzOLcYcZLDb1onmIfrzOxUUCASYN
         je9vZgSQO9eoHffUQQoCMTlLREESVtXlFSll1HcZ/U3tbBVDrwSTiiMGmE030e96fKP9
         yFk08XQAmdeoculUl4VNyRh23Gv/dYxb+jk1ejmN9vvYHAopkeaPLMv+o9f0TLevc/Ux
         jlHg==
X-Gm-Message-State: AOAM531YIrx9Rm20HUqaN7h/xAw7BZBT79CaWVsrOMOO1QUEIBbn4v5P
        9sJ1fanxPe8zT4xiYNJ7Q4s=
X-Google-Smtp-Source: ABdhPJx3T+F8sg9zQWRkrt6YeWsYaOfA1Oh/4dVFRxavhm+mWavC+T8fNbpZyDH0w/5d6xql/TEwbQ==
X-Received: by 2002:a17:902:ccc1:b0:15a:24df:a7cc with SMTP id z1-20020a170902ccc100b0015a24dfa7ccmr24973092ple.42.1651717438190;
        Wed, 04 May 2022 19:23:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902700c00b0015eb200cc00sm188663plk.138.2022.05.04.19.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:23:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mtd: rawnand: cs553x: simplify the return expression of cs553x_write_ctrl_byte()
Date:   Thu,  5 May 2022 02:23:54 +0000
Message-Id: <20220505022354.61458-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/mtd/nand/raw/cs553x_nand.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 6edf78c16fc8..f0a15717cf05 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -104,17 +104,12 @@ static int cs553x_write_ctrl_byte(struct cs553x_nand_controller *cs553x,
 				  u32 ctl, u8 data)
 {
 	u8 status;
-	int ret;
 
 	writeb(ctl, cs553x->mmio + MM_NAND_CTL);
 	writeb(data, cs553x->mmio + MM_NAND_IO);
-	ret = readb_poll_timeout_atomic(cs553x->mmio + MM_NAND_STS, status,
+	return readb_poll_timeout_atomic(cs553x->mmio + MM_NAND_STS, status,
 					!(status & CS_NAND_CTLR_BUSY), 1,
 					100000);
-	if (ret)
-		return ret;
-
-	return 0;
 }
 
 static void cs553x_data_in(struct cs553x_nand_controller *cs553x, void *buf,
-- 
2.25.1


