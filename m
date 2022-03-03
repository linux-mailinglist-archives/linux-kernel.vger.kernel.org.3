Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C534CB9CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiCCJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:05:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DE177740;
        Thu,  3 Mar 2022 01:05:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so2792148wmp.5;
        Thu, 03 Mar 2022 01:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FOBCOKBUOKBrO8yhdXy1yyP31Rv+CE5Az+FJgpuSOw=;
        b=bV0quv7CQHqRsqMuMnYki4NDf3gyminsa8fgh1Tkc09abQfrsbuKCSyIiNQsR89d3M
         kj+RSpp585GVLCBfQZ3ZUb7yAUCpOu/yN7XukhV+udVL/9xkrC2ifWDnMgH5aunLxQTv
         Zi6PGwfDUpWv7DW3l6wEV7x7EgcEk/5Rohqs54CouPvTTS78X4SMsbKnRzfnezg4kr4k
         WWw3+EeOD1QM3tpg0qnkgvHB8rWJrMwRdXG6XyDwzPSwKDOwjxWyBNZVyYTZGShIPIVv
         0hwKaTajT54NLnq6rHttPXXvBjRUKGGVgmaSg1AfIltw0xSOlJQEQr3UiLFI5QE6ygDR
         1UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FOBCOKBUOKBrO8yhdXy1yyP31Rv+CE5Az+FJgpuSOw=;
        b=Moti2u3j8pA95HvPLQRerhGC3sVwbJ2deWif1rCJX6o5CToE4PGXb1bnXVRDYpcIOx
         1W7189vfRtFKSpB1Gxc6rmaYmn4Iqj4fwzRCAKfoDV7U0ukff5Y6zBmsO1Nj6WWduajl
         C/5DTY1pWsCDOSDiBN/9Zu9sJXXTPFVeaG9rIHXjSlxxWSdLWgeUQy2pmsK5QBoAFq51
         iJcNjo3S69ayq8FmUOLWiWZYXQWkkdJIIaZUkkh9nKL3cIMPbgX/3ruyopl5FvZjwvrH
         ZR1ic5uiJVn9FPbdVTc66bpFjGiCG8e6rYtjyniV6F7oyUW7qf9uWptYhAEs5AYRCt+q
         qNAw==
X-Gm-Message-State: AOAM533ddzI4x2phYqVbQYMsP5G6Czu/Se+KUM71ITSBrVkOTq3BK6rp
        RquqHUc4Om2+WYoZh9xJQUc=
X-Google-Smtp-Source: ABdhPJwQfGl2taTo7TZ21DRaALXumXvZYaUbZJ65zGR4LRTDVWP64sLQJSK2ZUxRUaKTbvBt3qe0jw==
X-Received: by 2002:a1c:1907:0:b0:380:f6ec:4daa with SMTP id 7-20020a1c1907000000b00380f6ec4daamr3088912wmz.50.1646298309192;
        Thu, 03 Mar 2022 01:05:09 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm1357768wra.97.2022.03.03.01.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:05:08 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: remove redundant re-assignment of pll->base
Date:   Thu,  3 Mar 2022 09:05:08 +0000
Message-Id: <20220303090508.1125175-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There are two identical assignments of pll->base to the same value,
the second assignment is redundant and can be removed.

Cleans up cppcheck warning:
drivers/clk/imx/clk-sscg-pll.c:528:12: style: Variable 'pll->base' is
reassigned a value before the old one has been used. [redundantAssignment]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/imx/clk-sscg-pll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.c
index 9d6cdff0537f..81f304fae908 100644
--- a/drivers/clk/imx/clk-sscg-pll.c
+++ b/drivers/clk/imx/clk-sscg-pll.c
@@ -525,7 +525,6 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
-	pll->base = base;
 	pll->hw.init = &init;
 
 	hw = &pll->hw;
-- 
2.34.1

