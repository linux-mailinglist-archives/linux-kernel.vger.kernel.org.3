Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926214F0D84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376897AbiDDC1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 22:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiDDC1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 22:27:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13939825
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:25:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d15so1657179pll.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 19:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zc8F1O8AMZwy+suRWlAfauAc49+2wfvQoa4MDCey320=;
        b=n/qUoYvyvWkXr4Uhh98s/5URTAd7DySEceWVmkQ2F+Nm3NOUGZXWqYnegOk5SXZpyc
         dS33WkG/lgeS5dfhlbbJuXxkSRHPX4s6hx9l21rbzjRJEU6QZBk33ZcpheQuNsYOXKjd
         X9t2ZZTJ+CedW7R85bq+UZPQ9uyk24U3Bf2xXtSoYTk4JcaJX23Wj0wIuKS2u5+Ka5z6
         sir1hSINxUMnGALd6G5fiCmJWO28eDaqp3cU2Ich6fSdCuUpENghxtQAFbVjVqxgoT2w
         N3qySd3BfopZ/FDaCxH1ET5L+BWczeesu/9TAfWyBrKBtWzbZ5CBYXm6yCb7J0e7oOzK
         Gu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zc8F1O8AMZwy+suRWlAfauAc49+2wfvQoa4MDCey320=;
        b=2X1T1jgmJiWFUObAkrizAAmcsdBSJAb9ZMR00p5fMmy2sghiPLoHAqDJbl2bZaEEaP
         W0uUqAVZ/Q92bkWftDRs1tPtkWi+r2J/7iA1Ej2BCjiOjCcU1r4+kRybZJ77gEK+ZUHV
         8fx4XJXJO4DCiqbjs88aKoujzkefqnTLRPvg7NFpz/XLklOScaXpMfwvazsNLJ3i6rBw
         mOZbJczHNv2lO5a9ctHWcNyGRZhDGnjIf5j/mRXj+lrdN6x4CWmEaJJYt5776RunfnZ5
         p+TrDhLo49aDPnR07qLAMWoD3LpH9ge22ocm5bYf1FSOnJScmN+NQt0d2wkW3oWBtwYO
         lb+A==
X-Gm-Message-State: AOAM530ebkb8WU9SjP3lLc2UvCuhTf5+4p+ANy/EeKgu6m+jCeDuYfuV
        BZB7u+4PpiA1Px5Um6UbxKvhyT37VenHPQ==
X-Google-Smtp-Source: ABdhPJyQlogUWMitCIX8q42HIDAQANJWrxQlm3wzNnvvqi2soVV9P86dIYsJKo8QGds6nrEoLQoyTA==
X-Received: by 2002:a17:902:c94c:b0:154:45c6:fbea with SMTP id i12-20020a170902c94c00b0015445c6fbeamr21323592pla.117.1649039153462;
        Sun, 03 Apr 2022 19:25:53 -0700 (PDT)
Received: from alpha.. (122-117-179-2.hinet-ip.hinet.net. [122.117.179.2])
        by smtp.googlemail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm10239540pfu.202.2022.04.03.19.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 19:25:52 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rtq2134: Fix missing active_discharge_on setting
Date:   Mon,  4 Apr 2022 10:25:14 +0800
Message-Id: <20220404022514.449231-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.32.0
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

The active_discharge_on setting was missed, so output discharge resistor
is always disabled. Fix it.

Fixes: 0555d41497de ("regulator: rtq2134: Add support for Richtek RTQ2134 SubPMIC")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rtq2134-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rtq2134-regulator.c b/drivers/regulator/rtq2134-regulator.c
index f21e3f8b21f2..8e13dea354a2 100644
--- a/drivers/regulator/rtq2134-regulator.c
+++ b/drivers/regulator/rtq2134-regulator.c
@@ -285,6 +285,7 @@ static const unsigned int rtq2134_buck_ramp_delay_table[] = {
 		.enable_mask = RTQ2134_VOUTEN_MASK, \
 		.active_discharge_reg = RTQ2134_REG_BUCK##_id##_CFG0, \
 		.active_discharge_mask = RTQ2134_ACTDISCHG_MASK, \
+		.active_discharge_on = RTQ2134_ACTDISCHG_MASK, \
 		.ramp_reg = RTQ2134_REG_BUCK##_id##_RSPCFG, \
 		.ramp_mask = RTQ2134_RSPUP_MASK, \
 		.ramp_delay_table = rtq2134_buck_ramp_delay_table, \
-- 
2.32.0

