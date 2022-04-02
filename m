Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5114EFDC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiDBBfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 21:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDBBfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 21:35:20 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25705C1CAD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:33:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d142so3505792qkc.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 18:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLWion0WCWSkquD591asRO6YeUmhw3poQH4Z8c7saLc=;
        b=AS5E31wWp8dtOG+Ko/3LoMKkYtXTOdAEJU2Qu96ynB/NskCvZkBk6VPgbN19h8GCLt
         De1f0l8I8bOFMqBiwmiSlLR1yggy4tgPYFfvlT61gbZRl/yK3MhvSjQF/cDbMMt6oA54
         NvqH9tzbqoJXU56LU1Fu58yk9uC/h+dw9jUnNp3QK6NGjNmcefsdGa8uQLDxkQ92lPFs
         9HKrE5cq6zUFAsY9GRPiCx696/suc++ZsHnw2dh9OKxZ5Pl/9n2wskwGsvIkNHfha797
         BGYm5Cp4ZBXlevonyf1pmvT2enAGBn0ieE1k5levVI1kmodvSqtM33HL7DkziDqO91q1
         M5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLWion0WCWSkquD591asRO6YeUmhw3poQH4Z8c7saLc=;
        b=5VZRzl5G77Z57DBKWNxVZn3yrchbY/XUvBeEp79J+u3MjBnWwDCNGnvLPqLsQKsgNz
         pRiLmlN9cDCD6NDoz/w640NkyyzsSXsg76wHdXqpn3cyfJNIS8/617er6PL9fwW4q3Qr
         yTbuI/cDLbxSVhw3UlW8bgPzgbava0c/RcCtJth04imT/92RMeRI/QCyOEcQp7CMwoDf
         2EzlPHo3KmC08D6Nwd6t29DBDruBAnH9DHjPlRGKKthFAMWnJJ26yJQq3q8B99VkFBxk
         OZdF4/ArOh2YTwbiQ9zXcpanFNMXII1MERuBSk12qQu4sIYxql2QOBtQlcnvWvszVcUs
         YmsA==
X-Gm-Message-State: AOAM5301zVR4A5Q2DneDZi5vCv3YshvIvb4eT0FCYf90b3rHIXVXAcr1
        QHC67dWD97/ODwSu7bpmyr4=
X-Google-Smtp-Source: ABdhPJz2SRTRv7nbuDJAZndFiet4TJg9EdzD2xnBacNnU2ZyilSwMGe86m0ftqxPY+xfEmDd1scC+A==
X-Received: by 2002:a37:2717:0:b0:680:b3ea:cff3 with SMTP id n23-20020a372717000000b00680b3eacff3mr8273564qkn.573.1648863209329;
        Fri, 01 Apr 2022 18:33:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87d04000000b002e06b4674a1sm3120968qtb.61.2022.04.01.18.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 18:33:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, lv.ruyi@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fix refcount leak in mxs_get_ocotp()
Date:   Sat,  2 Apr 2022 01:33:22 +0000
Message-Id: <20220402013322.2410228-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The of_find_compatible_node() function returns a node pointer with
refcount incremented, use of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/arm/mach-mxs/mach-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 25c9d184fa4c..6eb731f38727 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -98,6 +98,7 @@ static const u32 *mxs_get_ocotp(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,ocotp");
 	ocotp_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!ocotp_base);
 
 	mutex_lock(&ocotp_mutex);
-- 
2.25.1

