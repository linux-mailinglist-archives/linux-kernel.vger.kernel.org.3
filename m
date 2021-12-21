Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285CF47B678
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhLUAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhLUAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:37:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DCBC061574;
        Mon, 20 Dec 2021 16:37:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so23364455wrr.8;
        Mon, 20 Dec 2021 16:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sai+FRfLAC21RqeotQwmM4g5WhkYih1zY7k6TbpD9zY=;
        b=kNoHaBd3f9H8CMTsuX4XMcvg5XPS24FVMpg50J34YDqUMAqZeL6q+ogSoX34noPHen
         evp9pm01M2Z3zSUjwVx4r1wl/ilOIiWxfQ/3/NFb4hHl4Evl1/ElDOFQ6Y+zDSQ52Bsn
         qSNeDR4+sGsLBSqknHU0vCt0gwepuHarLn7AWAFaiArf09AqVmPos8ycSV+3WPQ6Tq7z
         DoBv/KwJCvno9ifzM7hNLcJYd4mZHGnl4Rdak5BLjmrn+2a/yLyFGx+PrmyJAUvVAtch
         d6cNaAWO6f89fbXaywWQrQ2uWpktl+MO+G2AZ1+MGAV5/GUqKXf3Y+fhl+Ws6E+al8OD
         ugzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sai+FRfLAC21RqeotQwmM4g5WhkYih1zY7k6TbpD9zY=;
        b=WBqFOowC3HTK+dg9UFKBVoyXC08yiR+l7R15Qkfronljp8NFnEjlHxDdzuY2FaeFno
         ozj0YYyV6EuH9lEd6/ngIXzSUgHQbtwJUdv4cLMfOF7dVIDJyoiJljgm9pbo4PYCk6QL
         fDFos26g2OpgtGQddAw8ddhgVa2+V1H2ph+gSUqfi5vGlOD4EbJDonr3YNOuk+T6G/uS
         3jEe/sRkjt7JfAgA7dKcrooTKvmrnJfa2c1rMK8nDop0xcmEQparkYZHR00nK2bT8dZR
         SKgazFnG2U/D+ewVjUPTxw0wnCKuS8Y9z7nOsk4e4c0EwnLA6j1TLh1cSRl9y2t7+t8b
         Wd3w==
X-Gm-Message-State: AOAM531pXlFndKnxKw56EyMDalH/jHutULXWbEEJxkCY4qjFxtICWHtj
        7ZznbLPaz63f7SJupMzCf3E=
X-Google-Smtp-Source: ABdhPJxvi0e4X2XdsQLBIXx6pFktoqT/w0kwFYA9p9ld4UjhtwaDzdnTR2jgLA7QxuJzKU3F3pbwPg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr446612wrl.67.1640047071228;
        Mon, 20 Dec 2021 16:37:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g198sm899965wme.23.2021.12.20.16.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 16:37:50 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: socfpga: remove redundant assignment on division
Date:   Tue, 21 Dec 2021 00:37:50 +0000
Message-Id: <20211221003750.212780-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable parent_rate is being divided by div and the result
is re-assigned to parent_rate before being returned. The assignment
is redundant, replace /= operator with just / operator.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/socfpga/clk-pll-s10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index 70076a80149d..e444e4a0ee53 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -113,7 +113,7 @@ static unsigned long clk_boot_clk_recalc_rate(struct clk_hw *hwclk,
 		SWCTRLBTCLKSEL_MASK) >>
 		SWCTRLBTCLKSEL_SHIFT);
 	div += 1;
-	return parent_rate /= div;
+	return parent_rate / div;
 }
 
 
-- 
2.32.0

