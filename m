Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B65253CA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiFCNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiFCNAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:00:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65A37A22
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:00:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so6797411plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDw9t4WQXBcrtm7/VRTOmbffEdum1gmVJhhAnb5FFC0=;
        b=PKDS2oid/SEnsDgRAAcqVjf9EgAgvLTTwi5JGSL4hW+NCdz+ZZrT/NxoPWsyeaC6rq
         s/j70TodR1+WlOCG4aY7mqgUFygIVqyJPgTt85f65L5ur6by4Jj5+8mE0048vNnVPcsN
         L3eMVdCU62gMZ2SsxnPyvA0SgYAnBwh011108NPw5dajaksMsojSiAX1iDy5vYS1JBKq
         izvesCLgnmThqlbW439u60rwRw6wphwk12+8nJkNinuwzWZx+7k6ApU5XxwVtQtSKuna
         zcjsZUyaZ6bfKUtRCsWJe7Jmr0UAo/2M8N7RQwrPWnzWa7ltDh5BeOKqsN5kKbOFlJcD
         GIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDw9t4WQXBcrtm7/VRTOmbffEdum1gmVJhhAnb5FFC0=;
        b=WyBWoag9DedUFsXGHwlC3Njxy4xFnJ/p+kqpU5cb8ncapekqUCKXxhj1h2Nx407IGG
         MgDiUCgXsleH4pqSIwhzL8YmKgMM16euPYemeTIQS0Mc03Iic3x7SLq+jvbeDnZrh/A0
         vozWMs5qQPDZQJWfs0ukAiycgkIocj9jhN7e9lNLmmEBqa6JDkNHG//4kKPIMv3FNXMR
         Sw0UsCOJjbSgUqaE+RrTB4AWTRV13hy8t/QxiFDisBaf/ymF4e7/3WbIGiZwjiN6uX4U
         vF0Htov602BA/uYJOiSsWJVU51FwGSJgs9qPRzFoQ/jk2fX6ejitkG8tav83wTYlXUAp
         BLog==
X-Gm-Message-State: AOAM5311sgGO2p859lCRLDGpHQb5tPA/xKAxOZVkdXAxKMKXGNkz4OzZ
        PTazpNfPz4GjSJMt61Z4sls=
X-Google-Smtp-Source: ABdhPJyk87NTR6aw08mfmi4uJ5A7HWe4I1KK7PCmbjDQvSbtcGhI0Vh5aWzvGcRmKFh8zuFgdzXdvg==
X-Received: by 2002:a17:90b:20d4:b0:1e2:fadf:3f09 with SMTP id ju20-20020a17090b20d400b001e2fadf3f09mr11003794pjb.236.1654261248745;
        Fri, 03 Jun 2022 06:00:48 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902a41400b00163f7935772sm5327553plq.46.2022.06.03.06.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:00:48 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 2/2] char: lp: remove redundant initialization of err
Date:   Fri,  3 Jun 2022 18:30:40 +0530
Message-Id: <20220603130040.601673-2-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603130040.601673-1-sshedi@vmware.com>
References: <20220603130040.601673-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <sshedi@vmware.com>

err is getting assigned with an appropriate value before returning,
hence this initialization is unnecessary.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 drivers/char/lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index d474d02b6..536ceb111 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -1019,7 +1019,7 @@ static struct parport_driver lp_driver = {

 static int __init lp_init(void)
 {
-	int i, err = 0;
+	int i, err;

 	if (parport_nr[0] == LP_PARPORT_OFF)
 		return 0;
--
2.36.1

