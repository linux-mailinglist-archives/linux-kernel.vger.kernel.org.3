Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D949481D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbhL3PEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbhL3PD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29002C061756;
        Thu, 30 Dec 2021 07:03:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so51052595wrg.1;
        Thu, 30 Dec 2021 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38/yrVuWSAfCYSbaKGGrfM8L6s+RDj4K4yPYyiKvNiI=;
        b=GWLNgiwUblJV0XxdpM0BHtrR0T9SWGhFZtuJgSIJR00tliSRguVOWwfqB8AofC4QZJ
         IeiQLrtSxAuIEB7fZqlWNnYHWW9qXaeUCTIdoAo3VjDs4EZGEKNsVKyT3dF5q+gX1jGN
         Yg1l1FjIXh0lfthfcQKf0fqnb7QXWUK+c0plhJ6tFzq8w78GUfVf6mohUfCKKh7LW9dV
         TF/SRfhTA0IbZnGeB55ogvoN16amdo+ZGS4UDevb7KW5FmP8UY8pAeWjxXA+taDm0XXw
         Vgdj7wNDWkC8sQPZxA9O+3Q5P32s4e/+lLmZwd9egvY39GeCZ5LQSR7ydeCe1V4VtRdC
         7KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38/yrVuWSAfCYSbaKGGrfM8L6s+RDj4K4yPYyiKvNiI=;
        b=MpNm14b/KXgRbDdmmKPp+olgkhTf/u5Igq9WRgZqnwTNTDsU7MDcDi4rBrQd2wpXYl
         Utt6pscWbhX5GhHziG66zZ+Z2aMaIuqCc7ibfWVxZvvVblxbzgBGhv3Zg7wGP9ohf19Y
         NPdUWzcx98E6a3ZEfBNVB9ofNRCXnJDlYSrzR1tnA7CjYXR925MZ+rzzlaFz05ijGri6
         PuulG2okAw9QM5edYsUlJbcDf26dZ0Vu5LLE+jQ//Ik+9sZNx0uFO2TO8PHjSFD9PLk1
         szuGvddBoAQYCm9dQvOHWlei0FNDp0/BwD58AFpWp0EGm4R57bqVl7NY9f/QOn3Bj1f8
         zJ0w==
X-Gm-Message-State: AOAM532QUgwD1h5UNB+U/1vo2Et5Zu8LboWDjEDSN3gFcVi9dfURh+Aa
        DLOP3atDd+Ibyc7j0QyUF2c=
X-Google-Smtp-Source: ABdhPJzJFblslRqe6k6soT6bYdtvRM6FNykV+vZhVFF5Q6xgwEU2Lbu9NgObdfMxP3WnVFj4GCN+YQ==
X-Received: by 2002:adf:aa93:: with SMTP id h19mr25146605wrc.293.1640876602739;
        Thu, 30 Dec 2021 07:03:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bg12sm30555171wmb.5.2021.12.30.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:03:22 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: socfpga: remove redundant assignment after a mask operation
Date:   Thu, 30 Dec 2021 15:03:21 +0000
Message-Id: <20211230150321.167576-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assignment operation after a & mask operation is redundant, the
variables being assigned are not used afterwards. Replace the &=
operator with just & operator.

Cleans up two clang-scan warnings:
drivers/clk/socfpga/clk-gate.c:37:10: warning: Although the value stored
to 'l4_src' is used in the enclosing expression, the value is never
actually read from 'l4_src' [deadcode.DeadStores]
                return l4_src &= 0x1;
                       ^         ~~~
drivers/clk/socfpga/clk-gate.c:46:10: warning: Although the value stored
to 'perpll_src' is used in the enclosing expression, the value is never
actually read from 'perpll_src' [deadcode.DeadStores]
                return perpll_src &= 0x3;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/socfpga/clk-gate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 1ec9678d8cd3..53d6e3ec4309 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -34,7 +34,7 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 
 	if (streq(name, SOCFPGA_L4_MP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		return l4_src &= 0x1;
+		return l4_src & 0x1;
 	}
 	if (streq(name, SOCFPGA_L4_SP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
@@ -43,7 +43,7 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 
 	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
 	if (streq(name, SOCFPGA_MMC_CLK))
-		return perpll_src &= 0x3;
+		return perpll_src & 0x3;
 	if (streq(name, SOCFPGA_NAND_CLK) ||
 	    streq(name, SOCFPGA_NAND_X_CLK))
 		return (perpll_src >> 2) & 3;
-- 
2.33.1

