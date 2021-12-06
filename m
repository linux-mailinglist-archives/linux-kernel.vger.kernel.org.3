Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553FF46934F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhLFKXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbhLFKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:23:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501BC061746;
        Mon,  6 Dec 2021 02:19:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np3so7336729pjb.4;
        Mon, 06 Dec 2021 02:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHiQF5KcZbTv3Qqm535H5M3DFvNPj9KMau4f6OVUWv4=;
        b=gQu1F9uRKL5U1u+WTSRGquMaxFwy0fYtJdWtXGRoQ2WXrdl+OgeoO4XJ1U5Q+QFNH3
         vU7YuOoN02u2NV1t3sWCbC3z0GzCQBPKxwFgm9jbGo0nn2CKsyFwZINWmx7Uk1Vnkq0q
         hpYnnRO5p1d4+vwIkG50k2/AQNZEj8zKG5osMvuoLcdIWU8QA1DOCe6MrSJnxNGs2V51
         GP4Tg91eiZURpZDO5ilUjwfpwb3t/qc+XehR5eb+bzw9HSgNdsAqihYJKuuI54RNIJ+I
         nbwCaKT7uZrFXbXrBI0DUGJE1omD1szZzMTHxzx2ofEHNtYn2W1wrCNnJeyiLC2K38jf
         myjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHiQF5KcZbTv3Qqm535H5M3DFvNPj9KMau4f6OVUWv4=;
        b=1wxG781bnPWWfZ/M3GwUTj6WP8zuIYq6WhpogD4ZcleYOK1OjYCm5XUpw6f8j68EyH
         n6dhagLtQiaCWwBV+038E4G+mPcN37bY2hOybB0WG9C+2UpzIXkrFIXraqEmJCtQNjkZ
         OVqUqULba3Od/hpKUOuOxT67JTgKiPdbP8qmacIvXSDWPh8hsJGqYDYsT1ON5bDP0rzV
         7gqa6ptAA7FohKr3vI9KFmu7CEnIdk578BmSDZzPqyKEvS/0oC+vK6Y2KxnI0+P3nblF
         +9Nziqh8M6yxn0UBfQ+zSdcsCZKfwbc07XaxafiaG1ha3Z0k1WlrAr5yxZ9ozYWdwGqd
         wzog==
X-Gm-Message-State: AOAM531mm+HFeDwSzMCizbskC2pcyucyBWFpNjZe+nwRzkCajc0A6JB6
        2/DTqgahhZkQZJ+hoNymJts=
X-Google-Smtp-Source: ABdhPJzEHG3loiSWcOl+laN0WgxshO0veKOHiZhb5CFmx+qDYXu6qYWDGl8qiU11GvgPvyHyTXJPUA==
X-Received: by 2002:a17:90a:6b44:: with SMTP id x4mr36109851pjl.27.1638785987545;
        Mon, 06 Dec 2021 02:19:47 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.54])
        by smtp.gmail.com with ESMTPSA id j17sm11559441pfe.174.2021.12.06.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:19:47 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Romain Perier <romain.perier@free-electrons.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver:spi: change clk_disable_unprepare to clk_unprepare
Date:   Mon,  6 Dec 2021 18:19:31 +0800
Message-Id: <20211206101931.2816597-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corresponding API for clk_prepare is clk_unprepare, other than
clk_disable_unprepare.

Fix this by changing clk_disable_unprepare to clk_unprepare.

Fixes: 5762ab71eb24 ("spi: Add support for Armada 3700 SPI Controller")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/spi/spi-armada-3700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 46feafe4e201..d8cc4b270644 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -901,7 +901,7 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	return 0;
 
 error_clk:
-	clk_disable_unprepare(spi->clk);
+	clk_unprepare(spi->clk);
 error:
 	spi_master_put(master);
 out:
-- 
2.25.1

