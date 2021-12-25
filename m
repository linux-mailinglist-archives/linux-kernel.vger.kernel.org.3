Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0239C47F45C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 20:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhLYTkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 14:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhLYTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 14:40:05 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9206C061757
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 11:40:04 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so25895451lfk.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 11:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utZQk+YAS+lttlxaMRyQE1cFX9Jp4Ov9ojeopJCh7uI=;
        b=Wd3AacrH6s5n2taBGC+tJ6yNLrTDYcTI7eOpuN2zs3OW/HhDK5waZkZFaZjteX/oul
         ihTzVEJt3/Haasb4hEbD7NkTUdpYO9zWQDUQLAPVX9K1I50xx+ONjrbVqKMpRnvF3waS
         CsnbJhRhm75SmScsXkzuUlasLxTWqu4rM0qcaAXfkBKApK9oL7SAhZ1bE9iT+YzNWMSV
         FEVrCwfyaglpoMnqkMgRtntMIGadmCFMKutAO/tYgdQWSvBGLXjSoZQk55U6+swcB08Y
         hmWr25gt4bd5i/xbhwbUV+d1xYHRfeS7Kxb++tNs6atbwlyq7wUs8MTuOH5XGd4KjcoU
         wXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utZQk+YAS+lttlxaMRyQE1cFX9Jp4Ov9ojeopJCh7uI=;
        b=pr2D92sMq5fH+coU0xJntU9qQ54JTnBF3seogCzD+GrUd4iJrCUT8Z9cxK/1/OAIS/
         aR4OQRivPfNudG0xRFwACOIwoqBbfQt6++Fgbf5bpf9FO1TCmY/1ea27LekDj3nSyvYQ
         JePUhbQGJCeBvZGcP3APgLnILgbO8om3d2aPxugRMFfXRVO9TiiVM957bwiCCOnzJW+F
         UvKFp7S/Sl12glLAnOgFmvM0r385dceJQPl+SX9FN7rBSu2//aBFkwdFVcWxern4C3Z/
         Su4MQZUMN/D8yKAvoLqtKPgrMLQHkMjuzqE1pN7PNY+jHAYG6vYlnnMRGCHhe3vqENsw
         8ldw==
X-Gm-Message-State: AOAM532R6C7us4Izm+WDexKrRqsP+j6VbJPdev5FAR3qvP5JLyl1RyyC
        MFYjOre7ehJ82B9ZDHKC71SeuiNGZE0p1LPXf04=
X-Google-Smtp-Source: ABdhPJxP1+SYZzDAxVSRFg6mJq7fmO8QMzdK5G5U+AcBQvNk5Gln0Z8/wTiy/F5IWhhMzrKrLSNV2g==
X-Received: by 2002:ac2:52b1:: with SMTP id r17mr9311884lfm.425.1640461202952;
        Sat, 25 Dec 2021 11:40:02 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id b20sm1185161lfi.185.2021.12.25.11.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 11:40:02 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] clk: renesas: r8a7799[05]: Add MLP clocks
Date:   Sat, 25 Dec 2021 22:39:57 +0300
Message-Id: <20211225193957.2195012-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks for MLP modules on Renesas R-Car E3 and D3 SoCs.

Similar to other R-Car Gen3 SoC, exact information on parent for MLP
clock on E3 and D3 is not available. However, since parent for this
clocl is not anyhow software-controllable, the only harm from this
is inexact information exported via debugfs. So just keep the parent
set in the same way as with other Gen3 SoCs.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index a582f2ec3294..aaa4eaab9cc3 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -197,6 +197,7 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
 	DEF_MOD("du0",			 724,	R8A77990_CLK_S1D1),
 	DEF_MOD("lvds",			 727,	R8A77990_CLK_S2D1),
 
+	DEF_MOD("mlp",			 802,	R8A77990_CLK_S2D1),
 	DEF_MOD("vin5",			 806,	R8A77990_CLK_S1D2),
 	DEF_MOD("vin4",			 807,	R8A77990_CLK_S1D2),
 	DEF_MOD("etheravb",		 812,	R8A77990_CLK_S3D2),
diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index 81c0bc1e78af..480c130d2b1b 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -159,6 +159,7 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] __initconst = {
 	DEF_MOD("du1",			 723,	R8A77995_CLK_S1D1),
 	DEF_MOD("du0",			 724,	R8A77995_CLK_S1D1),
 	DEF_MOD("lvds",			 727,	R8A77995_CLK_S2D1),
+	DEF_MOD("mlp",			 802,	R8A77995_CLK_S2D1),
 	DEF_MOD("vin4",			 807,	R8A77995_CLK_S1D2),
 	DEF_MOD("etheravb",		 812,	R8A77995_CLK_S3D2),
 	DEF_MOD("imr0",			 823,	R8A77995_CLK_S1D2),
-- 
2.30.2

