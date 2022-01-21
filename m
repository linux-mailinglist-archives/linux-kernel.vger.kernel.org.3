Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED74966E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiAUVEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiAUVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927EC06173B;
        Fri, 21 Jan 2022 13:04:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s13so3332148ejy.3;
        Fri, 21 Jan 2022 13:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cBE+j0nomJ1s8ZdluzXzBh2EPO3NhAaZtGzkoFt0ias=;
        b=p+OEMoYjp1wmAlYEkkuigWlBg7Zy4CMhAJLn++e5Hk/NRY90CvWuEojecN5xOJFbIs
         EzIwoVoBO2cIMxGoWe08hVc4yAqAgq2eQLzWiRzQIqNz9kkp3FJ1X3/k94wmBbc5IXuc
         mWk8dlf5siCFsfN1kp19oCc9jM7+y03nxZcxuXI6nDFkQ+QSwWQ1WxJN2Jffhp1KVsqt
         hw+cAWqwRr1m1P3eVvsfaS+FXzx1j7uKMFPvAk0Euc38g4DQkS7ddYYwvAhgPolIaaku
         LsYWldCsW98a48tNTAgfN5GhuCxRpgIOfARhiUTnPoFBFTJVBC3qdHsPNFUi0SAH1XTU
         ryCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBE+j0nomJ1s8ZdluzXzBh2EPO3NhAaZtGzkoFt0ias=;
        b=wHtSQ4yBed5bPFJL4JaWozfknx5AdUqzi45SAtwnAq9dBB6/VKTYB5PpLehyqyfglw
         Mf/BbltMy3RXrG1Zw+xT4zIOnTpOB03z63cDVESn8M2jJZ9H677DeSFrtoyxeALN+fLH
         V6pXRiWQxaOQv4Q8X/sjZ+T3KXtK2qqkvBctEEfCex9fAQ1SV9FwWFETSQBhlo1Wlktb
         qIEZgk9+4M8T3VDFdeWOvEWBYFHBbtecL1AeSwQGhmgNSskJfj0VZOvX7R4Y0wL489Qm
         XKiIUmUgJRB4qatH4OZ79aVSvFUs1QeC3BFJg9eQp9basdwvstYrpBYl85kSa9gdefWf
         TjOA==
X-Gm-Message-State: AOAM533xrQ4lqhzUub5u8MoVNtxJpisccv0SCMyg0OCtsezK7VwIYuC7
        wVeNsivk+e609UcwR1L1YGHUGH5x6GU=
X-Google-Smtp-Source: ABdhPJxacA3tLPuYYhhgIpyp64NzbYmlYOno8GnheijYS0XTKfEUrahSrPuf55gpE0+xiN802GLyBQ==
X-Received: by 2002:a17:906:8292:: with SMTP id h18mr4826243ejx.504.1642799039452;
        Fri, 21 Jan 2022 13:03:59 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:59 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/15] drivers: clk: qcom: gcc-ipq806x: add additional freq nss cores
Date:   Fri, 21 Jan 2022 22:03:33 +0100
Message-Id: <20220121210340.32362-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
clocked to 800MHz. Add these missing freq to the gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index a4bf78fe8678..53a61860063d 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -232,7 +232,9 @@ static struct clk_regmap pll14_vote = {
 
 static struct pll_freq_tbl pll18_freq_tbl[] = {
 	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
+	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
 	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
+	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
 };
 
 static struct clk_pll pll18 = {
@@ -2702,7 +2704,9 @@ static const struct freq_tbl clk_tbl_nss[] = {
 	{ 110000000, P_PLL18, 1, 1, 5 },
 	{ 275000000, P_PLL18, 2, 0, 0 },
 	{ 550000000, P_PLL18, 1, 0, 0 },
+	{ 600000000, P_PLL18, 1, 0, 0 },
 	{ 733000000, P_PLL18, 1, 0, 0 },
+	{ 800000000, P_PLL18, 1, 0, 0 },
 	{ }
 };
 
-- 
2.33.1

