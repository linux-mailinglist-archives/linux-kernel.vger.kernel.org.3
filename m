Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE74E1DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbiCTUxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCTUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 16:53:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E703B542
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 13:52:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id n16so9197663ile.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amL/UE7zs4t+GbvQwTwptS5fVw1JEGvaoyRruxO2PoI=;
        b=eiN6aoC/d7xBm2fmS6GXLzCSV1cdC+bvO0UXbvOSCwrPRYE61s8JaKKaJDNbW2FbMu
         8Glo/fnK4rXMyl1CN3LJHwGi8UhXd0YRjZ31YM0EotuR8bX+2gCySfbOO2N+1K0ZG/zH
         rHRna/2O3StGolRfDVaahMliom9HdyAehdj9Agju6pV7IsJ3OiWoeCxMKqClTUTpckBx
         fiVm3w1G/aDHlo5WHtk4d9d5NFZJYTZIge09K5Gigaru/koyDq7tUn3v5vW8M2fPsrrT
         M8Hi6+TiempjF8gmk2PX0jiohxlrhWdF54i6pTsGgZkbaMa2BcdrEv4OmnqoVHyf58ue
         RjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amL/UE7zs4t+GbvQwTwptS5fVw1JEGvaoyRruxO2PoI=;
        b=jgicngW0Do+7ZMAz9iXri65Cf6HTHws8CiYTgKFY6XbesohE89tNhALAvXrbOIz1lh
         aRXJnMjkoGElQ8V2ZxxVrkw41legeiD6zyTbmZO8E4/bzrFuiv/fY02FTRshkJyEatTX
         mkJ2AcKIReMtc2e7oLrM7hwbyBJTBTFUJ0mdgI5QEtKsehaEUFPUDDRG2PCVBAfZL4OA
         WyVmnth0yEi6mnaSLCIuHi9nDbn7N31YYORxrwOJUk1sBLIA/mWk+29iIxWAWZJR9zN7
         xW00H3OGOTe0y6UDbid0OBEG0vVnnfl68Y2cAw7uqMm4rRbNH93Bx/Gf0lrd2obUhPOE
         tWEw==
X-Gm-Message-State: AOAM5304CeAShzcKqJV524r3naBOigSSeS8JeKEw/D4ZoIMMzqTuQjXj
        XekRojeRl7YPD44vTEOXoCw=
X-Google-Smtp-Source: ABdhPJxjKvyN438cwi4RqQKo5WRyYxgx5sn5XUjTndVAv47o+eFAdOd5o97GwgvK1Denw5rgMk5b0Q==
X-Received: by 2002:a05:6e02:1986:b0:2c8:2b30:4913 with SMTP id g6-20020a056e02198600b002c82b304913mr723866ilf.81.1647809544451;
        Sun, 20 Mar 2022 13:52:24 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c72f:3c30:c692:940a])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d8ad1000000b00644d51bbffcsm7996318iot.36.2022.03.20.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 13:52:23 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] soc: imx: imx8m-blk-ctrl: Fix IMX8MN_DISPBLK_PD_ISI hang
Date:   Sun, 20 Mar 2022 15:52:12 -0500
Message-Id: <20220320205212.701548-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mn clock list for the ISI lists four clocks, but DOMAIN_MAX_CLKS
was set to 3.  Because of this, attempts to enable the fourth clock failed,
threw some splat, and ultimately hung.

Fixes: 7f511d514e8c ("soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index a0a0d2d7ca4a..7109f0d508e2 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -50,7 +50,7 @@ struct imx8m_blk_ctrl_domain_data {
 	u32 mipi_phy_rst_mask;
 };
 
-#define DOMAIN_MAX_CLKS 3
+#define DOMAIN_MAX_CLKS 4
 
 struct imx8m_blk_ctrl_domain {
 	struct generic_pm_domain genpd;
-- 
2.34.1

