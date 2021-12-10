Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187846F94E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhLJCss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhLJCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:48:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F70C061746;
        Thu,  9 Dec 2021 18:45:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m24so5315867pls.10;
        Thu, 09 Dec 2021 18:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR0Sv/RHFjpYBPdNl9D85z+uzaMDDyhH8oNdgJWoQd8=;
        b=Q4PHNtHcCw8VjNpbVTcfLE7u89BSRU00VE94oECO4lq7yzUphXulq/IBM4gT8kj60B
         0LI/VrmDdI40hgkVJUwsncLQftZVSvaMGVtsSaIoiRXyIEB2KelkzYP9t2xjCOGpAYip
         5IEMBWyQ4XfuHZUQlbEj9qfjhsmCaLkGdeAaJheteAtlOW+lim3UJHH9ytG+s7lw0ge3
         dbqXbWfQ2aOHhhLQxnce86wJnU26JitpssXIkCH/G8yqdU7koJmgjJxsuHLvWvBux17r
         wJsWGvvor9O9Hy0z7KL1EU8QAIA9fsqjnaMVTvYTj9lU+n7GuFHKKIRZ24tWJ5JgSPeG
         Xz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR0Sv/RHFjpYBPdNl9D85z+uzaMDDyhH8oNdgJWoQd8=;
        b=XI6mCHJhUg1RDrpV77sTNpnk2bU8Ka+3LL/qnKJTAW81YmDtylkUAf1frqr2c9Yo4y
         UeQl3Cp9Ef/E/s9fxUEoekmppsFQNKiQ+GySJqTsq0q1BsGhpEofugHZ0akcb2vQ8UGk
         xR5Eo5QZ1Yw5/HtIpoJHRkaU4OGsMBiUKwl6hUGA6W4Jlv++/Uafu+pT5lR55tT6GNVK
         dq165oGJvrwah+TD3BXSXIPEBEqzoSzqTfrMgX/aOEM0haC9oO/EtDJ4oCo0L1GEJgz2
         XiHaCmxWRBYVDP9ZBI31JMeDSU7DnPm19CHrue4khQ+nzFoSEfSSRdojtV4FIBW3y/kU
         kS2g==
X-Gm-Message-State: AOAM530dfrP+H22jEZsVnmc3QUd3D1H47nQApnbEXTev7mLfiYFKggRo
        vtsjnX/l8Dj11s8Vjg+KvSc=
X-Google-Smtp-Source: ABdhPJypGBckEw8gWMSmN8AvKaFY2+1GEm9j1UK3AZVois0vmUDOfBeTgWfkwZ7VmWoizq5kRsEvlA==
X-Received: by 2002:a17:90b:3a85:: with SMTP id om5mr20713643pjb.28.1639104313418;
        Thu, 09 Dec 2021 18:45:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z2sm1066860pfh.188.2021.12.09.18.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:45:13 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, chi.minghao@zte.com.cn,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH clk-next] drivers/clk: remove unneeded variable make code cleaner
Date:   Fri, 10 Dec 2021 02:44:46 +0000
Message-Id: <20211210024446.425056-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/clk/mvebu/armada-37xx-tbg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index 585a02e0b330..fc403ad735ad 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -87,7 +87,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct clk *parent;
 	void __iomem *reg;
-	int i, ret;
+	int i;
 
 	hw_tbg_data = devm_kzalloc(&pdev->dev,
 				   struct_size(hw_tbg_data, hws, NUM_TBG),
@@ -123,9 +123,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 			dev_err(dev, "Can't register TBG clock %s\n", name);
 	}
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, hw_tbg_data);
-
-	return ret;
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, hw_tbg_data);
 }
 
 static int armada_3700_tbg_clock_remove(struct platform_device *pdev)
-- 
2.25.1

