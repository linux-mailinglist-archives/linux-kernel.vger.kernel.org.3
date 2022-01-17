Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14319490C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiAQQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiAQQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:18:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B5C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c71so67793869edf.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGanoGVnUA7ogI50sGef8k6e4+3YsWfksfB0nBzF5U4=;
        b=riRGZqlkwAHgCtFuquE9dgZtNhN3ch3F56qRaqv1FAPuqEfrMBXSq/8s58k/9ZcUlj
         nkPnt/9Wn2TYAkmZzWhJI4fFv2JKf8avnv1574uQdPs9HosWZ+I+sKz3DQBOI2d91ugs
         IuS+BK7TNl8yffJslZwqTzN3tWh/cyUFRu2wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGanoGVnUA7ogI50sGef8k6e4+3YsWfksfB0nBzF5U4=;
        b=nqVQokI5qwAOvI3P9Jq0hEsb3TWLR4H61KOP4/mnC9I9IUi+bbjChS1g33BZFzCviU
         aCZCXiyeegCwITwiGr5e6AOMrgMd83YlnssWWxGk1SQ0nRCcCybrilHM43CHpbTuXQ2+
         secpGWodSdcCGMdyPKqDQIuQ4EEvKPQuDIyrGcMATYsXHhHnl7mh7hUIACukNp44RPgM
         wsXOPsi0MaN82lalMwjdGk3gzF92x6S6dSqtFbmreiCcwunvvxNlgpszFFc7ZDa/8hi3
         yL3vgUA/FoMyjw7LX/+wmSLiNNzdTgBznuAqJDWCZA11PJ9yQo7Y+RBTYurr+e5EtuU5
         Xw5Q==
X-Gm-Message-State: AOAM532Yzk1wBXepbDt39EpZ1jqC9L0kGj6vk7rj/yVvt2C7nLBxxQT1
        Q3QELvGcN3ojyw9G+RQoblggQ/QZUz9ZAw==
X-Google-Smtp-Source: ABdhPJwS1xgJ2aU3JW86nj1q1s23inQuC/RyS5X6gxK/3Q8TAmFzdCX6xM2FYHDRMW7f2/Ti8Wi6RA==
X-Received: by 2002:a05:6402:2282:: with SMTP id cw2mr12661577edb.161.1642436291827;
        Mon, 17 Jan 2022 08:18:11 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id s4sm4147652ejm.146.2022.01.17.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 08:18:11 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 1/4] ARM: dts: imx28: reparent gpmi clock to ref_gpmi
Date:   Mon, 17 Jan 2022 17:17:52 +0100
Message-Id: <20220117161755.1863579-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
References: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ref_gpmi is sourced from pll0 (480MHz), It allows the GPMI
controller to manage High-Speed ​​NAND Timing (edo mode 3,4 and 5).

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>


---

(no changes since v2)

Changes in v2:
- Reparent by device tree instead of code (drivers/clk/mxs/clk-imx28.c).
  Suggested by Stephen Boyd.

 arch/arm/boot/dts/imx28.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 84d0176d5193..130b4145af82 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -110,6 +110,8 @@ gpmi: nand-controller@8000c000 {
 				interrupt-names = "bch";
 				clocks = <&clks 50>;
 				clock-names = "gpmi_io";
+				assigned-clocks = <&clks 13>;
+				assigned-clock-parents = <&clks 10>;
 				dmas = <&dma_apbh 4>;
 				dma-names = "rx-tx";
 				status = "disabled";
-- 
2.32.0

