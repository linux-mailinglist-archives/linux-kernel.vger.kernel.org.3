Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF359951A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345819AbiHSGIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344671AbiHSGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE4C6CC4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so4435673edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d7GvD5Hf8tzx2V16UHtbEc4zSmsYhgs5namwMdUKQPg=;
        b=MhZXIA8I23JAIDOSl3TCJR3q/kt7QCewH4booO6zJhMTlRoCIj2YrHJWmRntoYmFZ4
         cCICmyZD35lqNDMMhceY0JFfaabpWnJJf2qmkH/FO63KEApecHeOjFH+Yqbl7Q/bQxkf
         uLH/JfGQIXPyqlBKdA8KLnyZdTuzSGv9208i2ifxxEKU8FuiK4B9KqzLAz2tAXqGA5M7
         sWbY+tDBkBDFpsMlzfGIclABRJdCNM3ql+JKkqi1EI6GzViOKCqcYMqRlps+VtuhLoD5
         UWz/NpnKfCt2qatasN41qjKo3BlIT1OVofSK6spGJfpB5yruAfcuyp/F2uvD4qupU9MU
         5YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d7GvD5Hf8tzx2V16UHtbEc4zSmsYhgs5namwMdUKQPg=;
        b=7k14jvqA82/MpDIq7cvmwBZDDYOm2t/fE2FALCi/9xgPl8H4G9edgKIZpzA9WABAFb
         LxS40Ro98qprWRkR8/+43ww8uGQi4An6FPJ5qQs5tTyXOwO7C82OZ9F8m8ID4kvARHNK
         A+kRQ+YyYleG/GzMKkzenIJEXGl9iNlo0MkzMP/9ylUje/aEvXpNQK8ParwcytYoCgcW
         T7qH0NIlFneHs1vDQz0WziBnUaRuaNIvCnNIfD4m4EZLRupQDWmVxiwICBvCy/wg3IjF
         576z3N1dPBXFTNyJc0tP5cczpqMzcBA5V6ibWkUdV5xUZ2qDH9Q5c9GNgHEinv/SrW4p
         Vo9w==
X-Gm-Message-State: ACgBeo0Jq0fxL+RhjRrpnV4xgZYtLZ6Y8KArQks0MoIe4EyXsvR2GceA
        FfLbb/B6/yI+gfnd8C6Av2slt1gQ3f8bog==
X-Google-Smtp-Source: AA6agR6VOX0FP5IFx9rLPlxKuktifaZCc/3o6UZBEaQfuWiyiMm5mBEw4iXoGvfBDwtrfxXU17dgYQ==
X-Received: by 2002:aa7:dd42:0:b0:440:916e:9a38 with SMTP id o2-20020aa7dd42000000b00440916e9a38mr4842487edw.302.1660889284012;
        Thu, 18 Aug 2022 23:08:04 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:03 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v1 01/19] mailbox: bcm-ferxrm-mailbox: Fix error check for dma_map_sg
Date:   Fri, 19 Aug 2022 08:07:43 +0200
Message-Id: <20220819060801.10443-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, fix the error check, and return -EIO
to caller.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index fda16f76401e..bf6e86b0ed09 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -622,15 +622,15 @@ static int flexrm_spu_dma_map(struct device *dev, struct brcm_message *msg)
 
 	rc = dma_map_sg(dev, msg->spu.src, sg_nents(msg->spu.src),
 			DMA_TO_DEVICE);
-	if (rc < 0)
-		return rc;
+	if (!rc)
+		return -EIO;
 
 	rc = dma_map_sg(dev, msg->spu.dst, sg_nents(msg->spu.dst),
 			DMA_FROM_DEVICE);
-	if (rc < 0) {
+	if (!rc) {
 		dma_unmap_sg(dev, msg->spu.src, sg_nents(msg->spu.src),
 			     DMA_TO_DEVICE);
-		return rc;
+		return -EIO;
 	}
 
 	return 0;
-- 
2.34.1

