Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0054B6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbiFNQsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349778AbiFNQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:47:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A72A272
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:47:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u18so8230300plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=129WjS6ew4f6MdB7b/M4kO0Bha3LRuES78hDcODKT8U=;
        b=c5/7Vx7Zmv5TO553+3uBN1i423Qic2cHJdBpOuoB0r7RBPwUmcxWNtZiKtCDJkGFyv
         KnjXYDP/WMxlX2gwdg0PAivfT+WdD18P6o36oJId2cLsMcp2F1VT/b7utfqE9+OhZtVR
         1vpAcXxFQd2UwypV8n0svpJcupPMrpb5QQzjj8lNfx3ZHTp29VqiijEQDkI8m4dKe1qk
         O0ZEEgOhE/N3XJJJSHREgF5jE2g24ZKX265CCkMuMGdfKhmRpZJf1mTGgMlGlsdYmp73
         TpyPFRsEgCmCdM1/Mm+wpiJgZWnCPI0YGfY4WeRNt21B0/9SXYaIb1jQoXjhOwX+briD
         Bl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=129WjS6ew4f6MdB7b/M4kO0Bha3LRuES78hDcODKT8U=;
        b=s5kGw9DogFT2XdtAEjTnQIW6IJirlS5C10LnbCplnvpxncrnX3rMH3OBAUbvsgioVo
         A9DoE5wyZaDuARzrySPREmL1KTN+LKnrFDnAnDhtzqbA9nCzj/Xc1joh6Oh4eQW2J19q
         iYTOO9SZp90v4HII1OnNIPQQBsAdwWwULAnPvI0SMFIxnQ3CAamRz/Ajo7YHlZ9IKYgU
         nMnVt2OnP+lA1GJaXUoL3hu6ulq13Bvic5tXkJyU7nEswgnShCw3jm89M5TRLtMop2vM
         lqEtcXef460+J8fEpOTh7Hr8zJDPvvsb11chqBSAc40REG7Fx43iC/PAdrQDa2z/EHGO
         8hDA==
X-Gm-Message-State: AJIora+Mqfm2wgd111u9IvWrtSrCjxQ2bBNg/2ztcnyOw6Ps2mUcFQdD
        gahrHr6QUGOH46rVjR2pd+gtQQ==
X-Google-Smtp-Source: AGRyM1vvSQOe5i+3ufNEJnLp5MEKfiubz7ftYT3g6jz4wGpbmgd/mmzXoM36pQ+iGatO88cU7fSPIA==
X-Received: by 2002:a17:90b:48cf:b0:1e8:9438:ce13 with SMTP id li15-20020a17090b48cf00b001e89438ce13mr5452042pjb.235.1655225236072;
        Tue, 14 Jun 2022 09:47:16 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.216])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b0015e8d4eb243sm7505266plb.141.2022.06.14.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:47:15 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     vilhelm.gray@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH v2] isa: put_device after failing to device_register
Date:   Wed, 15 Jun 2022 00:47:10 +0800
Message-Id: <20220614164710.1744680-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() is used to register a device with the system.
We need to call put_device() to give up the reference initialized
in device_register() when it returns an error and this will clean
up correctly.

Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
V1 -> V2: Fix up the changelog text correct.
---
 drivers/base/isa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index 55e3ee2da98f..cf88f3d77b7d 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -173,8 +173,10 @@ static int __init isa_bus_init(void)
 	error = bus_register(&isa_bus_type);
 	if (!error) {
 		error = device_register(&isa_bus);
-		if (error)
+		if (error) {
+			put_device(&isa_bus);
 			bus_unregister(&isa_bus_type);
+		}
 	}
 	return error;
 }
-- 
2.30.2

