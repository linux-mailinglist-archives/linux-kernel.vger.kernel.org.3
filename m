Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2F47525A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbhLOGAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhLOGA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:00:27 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78942C061574;
        Tue, 14 Dec 2021 22:00:27 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d21so11740041qkl.3;
        Tue, 14 Dec 2021 22:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X94i9GwAGQdZXxmrKZXUyd71u3DF8Ifr+h6cNaVJuPo=;
        b=amICIEk992AO724YjVsKghniSAM7DGR0e965C6lhwNf4ZsXI3LVeMyMxuLJdzOMiDO
         cDlQ8bMItVKnV8ctON42lsrA5H65Z407eeuUiknUK1YZI6dLnTjGBjMp2uDrp/32xqmw
         iP1u6H6g/+D5Ya0aByPVaqI6Z4aHKBQea0G6IO8st1ZfkuJ30K931qXd4v50JJPbeeGk
         sYPgrVdvTyIRfn0PHzUqk74A/FA6LDbGvM6hmrkEHU2h8lc2GcWdsjfMkFoL/iCY/M7Y
         SnwI9uzkrbxLO65FK29xdwn0GDJN52Cn65Lr4SqWhMo96cVI5V6QFlS7/gUr1gHz/sgv
         mdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X94i9GwAGQdZXxmrKZXUyd71u3DF8Ifr+h6cNaVJuPo=;
        b=JRUbQzDdhebpujjtY6jL+TBz33LPEW1DqCmJxWvgz1rYCOpYek7YHLzZNDpusmyCuX
         8u+0rclpO9vJMJPvUforiSYPqAyqj+Th+fh5wSaf49/EzLGv7A4wR3t57mFl8gbs8fBg
         FQ/5VqF6ZDvn44zWbmMrQtYDmkThh4e3qjXWMDapuWZL72765+WHOSwFMF1+fVnlEhhI
         Z/Cr8p7KXa+hZAhEmchssCZsRv6nTAXvrhPTsvjO8xT5Gg+O27fD4loV9wuNu0WmaZcp
         zAgyLv2g5U7nmFF1P/pRWDSoLE7o8/MDzQ6ksn1fEiVjGzHaDejoy5Pv8GnwuCCsv5pM
         pfdw==
X-Gm-Message-State: AOAM533mINaowfJUZIciXjqiARO3XWlBe0Ix1Hkax7HndLm2SESw0MKI
        aT358IknkjCi0YyvWQFBBXc=
X-Google-Smtp-Source: ABdhPJwjRhUri+keyasONrwHJcx0gAGe8Su0UuJjARiSq5P6lFSKTLV14PmUKftN7k93lis3tYiYyQ==
X-Received: by 2002:a37:6cf:: with SMTP id 198mr7467379qkg.78.1639548026672;
        Tue, 14 Dec 2021 22:00:26 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u10sm820469qtx.3.2021.12.14.22.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:00:26 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     pdeschrijver@nvidia.com
Cc:     pgaikwad@nvidia.com, mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH clk-next] drivers/clk: remove redundant result variable
Date:   Wed, 15 Dec 2021 06:00:19 +0000
Message-Id: <20211215060019.441549-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from FIELD_GET() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/clk/tegra/clk-tegra210-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra210-emc.c b/drivers/clk/tegra/clk-tegra210-emc.c
index 672ca8c184d2..481fd50a36a0 100644
--- a/drivers/clk/tegra/clk-tegra210-emc.c
+++ b/drivers/clk/tegra/clk-tegra210-emc.c
@@ -52,12 +52,10 @@ static u8 tegra210_clk_emc_get_parent(struct clk_hw *hw)
 {
 	struct tegra210_clk_emc *emc = to_tegra210_clk_emc(hw);
 	u32 value;
-	u8 src;
 
 	value = readl_relaxed(emc->regs + CLK_SOURCE_EMC);
-	src = FIELD_GET(CLK_SOURCE_EMC_2X_CLK_SRC, value);
 
-	return src;
+	return FIELD_GET(CLK_SOURCE_EMC_2X_CLK_SRC, value);
 }
 
 static unsigned long tegra210_clk_emc_recalc_rate(struct clk_hw *hw,
-- 
2.25.1

