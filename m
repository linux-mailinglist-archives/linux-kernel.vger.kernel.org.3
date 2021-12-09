Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2953646ED3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbhLIQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:41:17 -0500
Received: from box.trvn.ru ([194.87.146.52]:43347 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239675AbhLIQlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:41:14 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id E472241F22;
        Thu,  9 Dec 2021 21:37:33 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639067855; bh=4UAl5FlZiuT0MWj7WWv0Ooo6qEkHhQ4HRAJs5eOrKXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7f28H7Y8aZipmfd5LDWI5mN/ln4IINxJGEs3eUHyPXwPOW6/w+4smmLBz7SXgKPc
         Xy8qL0V9c1B9jkduMbGutTg/U9C2AQ7jsQdT4wBiGWRDeCvnUqVl8BAbQ4t+zw/cUR
         4lBxAVL57QZvXOrU0H6ghYnQkZudxDsQ4YEA+oLwmVL7+fOlxkBed76BxLDvT45l76
         4E9tL5ZID5PSMkRQIt2ZjJQY8T476tEx6aAfeBRvDpCaYq+H5ej406bkrgKy6U8tdc
         woBhenn6laVgTf7aYAZxCj8tqyx/28t2V8FgKfzCYbNAAajZS1YPrwDzj0uCZtldPf
         jqoLGuS7eKJwg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 2/4] clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
Date:   Thu,  9 Dec 2021 21:37:18 +0500
Message-Id: <20211209163720.106185-3-nikita@trvn.ru>
In-Reply-To: <20211209163720.106185-1-nikita@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes calculation of d value may result in 0 because of the
rounding after integer division. This causes the following error:

[  113.969689] camss_gp1_clk_src: rcg didn't update its configuration.
[  113.969754] WARNING: CPU: 3 PID: 35 at drivers/clk/qcom/clk-rcg2.c:122 update_config+0xc8/0xdc

Make sure that D value is never zero.

Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for RCG")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/clk/qcom/clk-rcg2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 6964cf914b60..fdfd43e2a01b 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -424,6 +424,10 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 	if (d > mask)
 		d = mask;
 
+	/* Hardware can't handle d=0, make sure it's at least 1 */
+	if (!d)
+		d = 1;
+
 	if ((d / 2) > (n - m))
 		d = (n - m) * 2;
 	else if ((d / 2) < (m / 2))
-- 
2.30.2

