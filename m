Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DFD4DA7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349457AbiCPCWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiCPCWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:22:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B52427CE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:21:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g19so1872358pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=mpIGdb55Nd4sn/CpKfkQzU0+Ne3ozaz+3vbBHRA2I6U=;
        b=STJJhjhySdxRolMQ6fId8pdd/hZAOz3EpMWlonsXd8vSgXzLo6gP73O9ekBBfrS9wI
         3nsfbhCR+Q6YqWsymo5rs4GMKS51FLBlOZyYmGsucAWFRX3KFmT13t/rbwHSi+jaud3G
         Dyh/+cXbCgtjWD1Ev5Xfg2olYx8TPAISk4lYVUuuJKiCDADcZoH9IaNu1gAjkdJSMGdP
         P3NO2s8eFzTsWHg6sqKQJpC1GpDBYsclPozt9ZmRfQkQbv9Fn43YOgMZfCLaPsudrEuq
         s9BDfBxnJ5sniUbt/+u49qELuen3qi2Ood2hji/DlR1rPP01jFM5F8dY7/52j0gqcTYZ
         +TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mpIGdb55Nd4sn/CpKfkQzU0+Ne3ozaz+3vbBHRA2I6U=;
        b=JYKQHzRwYeJaJmXp1M50JOXDcQdy1lSv8qyql2mMx0ReodxXj/+VmQ3y+Cvc+kQI8n
         KAV3fQs4939gmS5ym2EKUEB4LTFWBAh8iYZqezBKsJZu+j5seZPnuAY5Q3tPRb41jNp9
         O3KVviSxOG0UOOh8rCOQjwYSC8QVgWQLccllKXy6qssZcqesWbs+TLWwAVex7Fr+70UU
         ZYXp0ulWSLohPxAwilmL3Edil/FKxriwDxDSk3Dm6D/WaKklwH4Htk/OEDx5UvBSIxBO
         UBgQo58KgBf6frxGMSgwcM0+HroDWSpwobbXQuzKlqmpwXFAMcMHLKU6zWc7khQQAYe/
         pgeQ==
X-Gm-Message-State: AOAM533M9n0CLDsisEtZArGb6Fyz1p+HnE0B9tetC0jwqfoE9I4l5lPK
        LzN92AuTn7pdI2GwBrKQ1UQ=
X-Google-Smtp-Source: ABdhPJw2oM4iw4X9LdjPldazp7yPJi6PzmHFFz+lxJaiE9molHGTsa7R9nL6wpCNalHa8LzYxaDVBA==
X-Received: by 2002:a63:4e52:0:b0:380:7c35:fc9a with SMTP id o18-20020a634e52000000b003807c35fc9amr26129775pgl.376.1647397299989;
        Tue, 15 Mar 2022 19:21:39 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q10-20020a056a00084a00b004f7ebae5be6sm469764pfk.155.2022.03.15.19.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:21:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Igor Grinberg <grinberg@compulab.co.il>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: pxa: Change clk_disable to clk_disable_unprepare
Date:   Wed, 16 Mar 2022 02:21:22 +0000
Message-Id: <20220316022122.7426-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corresponding API for clk_prepare_enable is clk_disable_unprepare,
other than clk_disable_unprepare.

Fix this by changing clk_disable to clk_disable_unprepare.

Fixes: 7a5d9a913f91 ("ARM: pxa: ulpi: fix ulpi timeout and slowpath warn")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-pxa/cm-x300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 2e35354b61f5..fcf5b8fa5b9f 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -538,7 +538,7 @@ static int cm_x300_u2d_init(struct device *dev)
 
 		err = cm_x300_ulpi_phy_reset();
 		if (err) {
-			clk_disable(pout_clk);
+			clk_disable_unprepare(pout_clk);
 			clk_put(pout_clk);
 		}
 	}
-- 
2.17.1

