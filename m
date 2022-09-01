Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8835A9114
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiIAHsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiIAHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:47:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BDFB99DE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:46:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l65so6382168pfl.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=f+g0o24Bq1QlHnqPog3te537VQPNq8LRPIdLIL8D32c=;
        b=nY561n9IGkHiCzHKGAUM2mXfNlQWuYMO05ssj+N+DSCenlXulDVP+VsorkhF5Hz6h8
         qnAtVUyiN7nd121VLlD7CUfYtwZYVihi3SNPuujGwvT/hXw3bBo4Jvha01CTg4JGWjsk
         WY1V549X2mEdEkUf8Mlr0Jgrr7u88D9LgUrE7vw/vICs4XuGghubmDjDxHw61zRl/kZ4
         O8OAPDFPyjIMHlpt42z6WTya3gD8ykvCW/sJOUabJF5Sp7Q8knz7FKJ6deiqCi/I0DJe
         hpoNVYlwQpAL9D+fARw/OzP2kp4WcPLzrtFsJQ931n/qJW3mTfFP5YbvT8BcT2dj2I7+
         lUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=f+g0o24Bq1QlHnqPog3te537VQPNq8LRPIdLIL8D32c=;
        b=LucY8P1DTA1SOtpuXfzJcaC3peQ/9rE5sZtjdAk1Z0Z9gocNmEKEx1wOqP9RlHLUBZ
         wRyb6SS9USuUd244UTiLh9eEWlWPmnLjXaZdMWXqIIKhzj7QG4+QSFIGSqNFZTp/rlcx
         rDmCQ2GJBBKhB2OHv8qn9uTHUQGyKi9esf35we11YM0ai/aqwlDJvtmt0ryObNJvIvvA
         PugK/p3qK/3yruXYTnhHOPp4fCQw6+i6lzYSIjx80DLD12kxBt0lucb5x+Fkl8wZx6xm
         0OX50dp/Hnj8tKL4krimYf+jAQBpvP/PGNzM+8jB7anlALC6+jO2dXStgXqHjVbv6ehw
         QO7w==
X-Gm-Message-State: ACgBeo3BtQZq5JqYROVzXFlQ5BtCSEdKj3belYkqneMJ1lXlagH0mH0s
        DPjW9auL1uUfzhtwsaguqAg=
X-Google-Smtp-Source: AA6agR7NpALDnpCh8C2wzv0TW03iLpnJ89JOsqm+XbmyxgKvt/RHfDnexfF0ne36o5Pxxy1cWD7Aqg==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:666a with SMTP id t2-20020a056a0021c200b0052bff44666amr30324333pfj.83.1662018359753;
        Thu, 01 Sep 2022 00:45:59 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7990f000000b00536b2483aedsm12653099pff.199.2022.09.01.00.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:45:59 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, yangyingliang@huawei.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] mtd: rawnand: Remove the unneeded result variable
Date:   Thu,  1 Sep 2022 07:45:54 +0000
Message-Id: <20220901074555.313266-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value cadence_nand_set_access_width16() directly instead of
storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 0d72672f8b64..9dac3ca69d57 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -1979,7 +1979,6 @@ static int cadence_nand_force_byte_access(struct nand_chip *chip,
 					  bool force_8bit)
 {
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
-	int status;
 
 	/*
 	 * Callers of this function do not verify if the NAND is using a 16-bit
@@ -1990,9 +1989,7 @@ static int cadence_nand_force_byte_access(struct nand_chip *chip,
 	if (!(chip->options & NAND_BUSWIDTH_16))
 		return 0;
 
-	status = cadence_nand_set_access_width16(cdns_ctrl, !force_8bit);
-
-	return status;
+	return cadence_nand_set_access_width16(cdns_ctrl, !force_8bit);
 }
 
 static int cadence_nand_cmd_opcode(struct nand_chip *chip,
-- 
2.25.1
