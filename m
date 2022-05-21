Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4052F9C1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiEUHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiEUHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 03:38:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E84317D39F
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 00:38:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so9523950pjq.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkMvXJm9tybLzln7qdJD/gqc0xuLymY0o1rjrqihDws=;
        b=HCACfDoIZMwiq0g1p5hdAxh01AFEIlIDpu5GSY0wz8xFy2tfxJtosLm5Orq/Sp0RcJ
         dnB2ioOgS6ZLvR2oSHQqezir4wxnkO4NQCjbf/WD68NHZV/mkjFH7iLnWp0Sgft7/OJi
         nJgTk75WzuGUnls0N3fzWpMF104BXhvXAQ7OjxKjxY0f4utGTL80N4TL1MkSbraBuG5J
         AmjWY37g0Z3P+AmQxvDH+RhmY9LJUMw3dag/Gx3IClGDK5XfttDnEtKnJLNLG7AWNwCC
         uH6KZDPlvzhwHRVXUXbvcSXYiGGJtf7zUpd80hmjW8njfpXQHBmHLcsJCXP+IGf94wcW
         N5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkMvXJm9tybLzln7qdJD/gqc0xuLymY0o1rjrqihDws=;
        b=SV18bc6iwB/ZQ/4vmGFKS/ZCdiRd1dnWs4dZY/+q5oVx6eQQcEAiw0Nsajmjl1iM4z
         XY/BredY/1vjLqaq8zaUrGBH1iVgOyep3I6nyUY0ZURkHSHYV1pIesNsHZySz7RVRLdJ
         cWS9yHH2s5VVqu7fh0nn1EB3kBzLQ24in1j1qsFmwLQCHgleWFkkABEDfxhupWGQE/nA
         W6KkhiEDdZ+R9C2piDIhseRfF38oU4DcXpW+iRAoZf81F91fyIyV5PckGZYUkM9D5YHX
         t5sLMsoH8DT6Jk3q0vqA5iR/Itz8GRUFGOUNfalorl+BCjpgRWLZzGD1TN53X3NdxXN1
         vTdA==
X-Gm-Message-State: AOAM5322DdUegsIxXZytxyNGVTCo/7oj9E/39FcQK3cOHzDhrSsJtcM3
        GD0iv5lOv/mOPitKAl1EGXttNcLar7zvuddb
X-Google-Smtp-Source: ABdhPJw/EDkP+UP8b4pKBdI9s6kZNHThvR7u+wngsIbPWL5Bh0lmgSJC5m5iNXaHFDoScfDvpdJI3Q==
X-Received: by 2002:a17:903:32cc:b0:161:9539:fd69 with SMTP id i12-20020a17090332cc00b001619539fd69mr13542216plr.153.1653118733717;
        Sat, 21 May 2022 00:38:53 -0700 (PDT)
Received: from ubuntu.localdomain ([103.230.148.185])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0050dc7628196sm2947497pfo.112.2022.05.21.00.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 00:38:53 -0700 (PDT)
From:   Gautam Menghani <gautam.linuxkernel@gmail.com>
To:     airlied@linux.ie
Cc:     Gautam Menghani <gautam.linuxkernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/agp: Fix divide by zero warning in isoch.c
Date:   Sat, 21 May 2022 00:38:48 -0700
Message-Id: <20220521073848.4052-1-gautam.linuxkernel@gmail.com>
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

Add a check to ensure ndevs is not zero. This was found by clang scan
warning: Division by zero [core.DivideZero]
        mrq = trq / ndevs;

Signed-off-by: Gautam Menghani <gautam.linuxkernel@gmail.com>
---
 drivers/char/agp/isoch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/agp/isoch.c b/drivers/char/agp/isoch.c
index 7ecf20a6d19c..da0d2681225b 100644
--- a/drivers/char/agp/isoch.c
+++ b/drivers/char/agp/isoch.c
@@ -289,6 +289,9 @@ static void agp_3_5_nonisochronous_node_enable(struct agp_bridge_data *bridge,
 	u32 trq, mrq, rem;
 	unsigned int cdev = 0;
 
+	if (ndevs == 0)
+		return;
+
 	pci_read_config_dword(bridge->dev, bridge->capndx+AGPSTAT, &tstatus);
 
 	trq = (tstatus >> 24) & 0xff;
-- 
2.25.1

