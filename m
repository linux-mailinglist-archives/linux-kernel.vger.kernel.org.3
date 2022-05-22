Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF653057F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350222AbiEVTq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiEVTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:46:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392D2A275;
        Sun, 22 May 2022 12:46:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so18313074wrg.12;
        Sun, 22 May 2022 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHiuUqPQofXVNtOmlbKgS9gvW1ZOU+ziWXGacGyqfnU=;
        b=Wqw7ixDSCQiUlqiBUjLbcdlqFgG0D1NMrx5wJDqD1NENo2MoEihGvDTEgBeA0n9cKy
         BGCBmuCQJPD7pL5i6gwGmdc774TAduxuheQTaL+3qdQuYRnWoq1jRmOktknLWiilOJvK
         7iniCUhbCJdsYMGXDcgbRNEsMWN+xP9VNDOnp7jUBEKCbxfFDUh0wCw1purbeG/GQrv8
         wq2ExyqLN+eWJ+w2sFaGGKx8+RzapyAHh3Bl4wyvPPMFyyMj2ox6YTa3aJV59hVDwL0Y
         F+FEeG4Gc3GrjIGNELtjcEDm1zW7oAvkLrt4u6fWcO8sGfbpRzrnH5Q7agCZzuvLK9rD
         1N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHiuUqPQofXVNtOmlbKgS9gvW1ZOU+ziWXGacGyqfnU=;
        b=AoO0lYWO1HF4jxLQT3dQUB2W0jPMX3ML2W8qdQ6R4LZXgZPmMQ780TGNZWEcHkMFbS
         IZ21jqQ29dKTuHNGCOj3Ef9MeR7t33k2cy9L0q8KpwV4/1kIwjuywDn1tMLJllWomGPI
         miTHa8S8x7wD3Gc4Ce7I4yux4oN3BwcbMpgAloVL8T4j6+TxG2IRGY7ipHQpv8OJau7I
         Bv8szeNkQJcUg7jSSaXDautsq0zNPxQ8wot0PSWQOB4kzGd+y3b4wII8ZYI5q8szchoJ
         +AUdeb0L5s132QIMlMG/PbuokW/6+F4qsshDxiGZfN3VnI68/m3jP3ZQSQ/VgWSUQbiS
         MNdQ==
X-Gm-Message-State: AOAM533dtMxZYA33+4iAfuFY6/qMPCmAvGle1StiSaCAov1Nvu1hXzBr
        Rp7IJg3IatqD0NZe7sGuauPCqE5y3SI=
X-Google-Smtp-Source: ABdhPJz7m1zS1+0VOawboYY3emg62RWneM0bmRRFX9ocb8dLbKQ9xmTU/3SxCxxx4fzKvoa61b3wYQ==
X-Received: by 2002:a05:6000:168a:b0:20f:d6e8:a5b with SMTP id y10-20020a056000168a00b0020fd6e80a5bmr2831116wrd.41.1653248783731;
        Sun, 22 May 2022 12:46:23 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h19-20020adfaa93000000b0020c5253d8f7sm8217026wrc.67.2022.05.22.12.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:46:23 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] w1: ds2438: remove redundant initialization of variable crc
Date:   Sun, 22 May 2022 20:46:22 +0100
Message-Id: <20220522194622.13277-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Variable crc is being initialized with a value that is never read,
it is being re-assigned later on. The initialization is redundant
and can be removed.

Cleans up clang scan build warning:
warning: Value stored to 'crc' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index ca64f99c8f3d..e008c27b3db9 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -66,8 +66,6 @@ static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
 	size_t count;
 
 	while (retries--) {
-		crc = 0;
-
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_RECALL_MEMORY;
-- 
2.35.3

