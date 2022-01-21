Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72124966F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiAUVEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiAUVEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:02 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300FFC061401;
        Fri, 21 Jan 2022 13:04:02 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ka4so3334224ejc.11;
        Fri, 21 Jan 2022 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=clnqaNqyzpxcBB6mJhgn58xxBFPn79gkEl2JvXBz70c=;
        b=OOH9ocpXMafyNcmPxn8I1HcnS7JCORDOLvZKmoeiyMMJ92ELuW9RJr/+G77KhUy2F2
         8NR47mvrMEQDVJknr+cpFQYk9Dn3tbBk/eCw1kTWKuQMG2DA7qV+XuCM9+qAUnc0+plJ
         SaUouILc8tyobC+ZirMmVW7r86M2jPCHAbhCCyc59HMZecE+Q+4N1Yf7ejcmaBoDnXLe
         Gl2d2u/F0PcooPCpLw1JWZzmyjPacfeJ4tQFCpiFGULgR2dmaQ5UlJ0wOTGW2/zStRYc
         9G+vojpwU5oglIIwBD4fqruugrRQIAqT9G6qRzj2i0QJivR7OTjQh0MEFWKnbyctmvlw
         N7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clnqaNqyzpxcBB6mJhgn58xxBFPn79gkEl2JvXBz70c=;
        b=F7twbwDzU/0pfoEWnK0MwOuhh2W+pqs96+eLC5UmUc0o/zq6DqHtqiFx+hGRXzIchs
         0PT86+zL8Jf9SpMjxqGtsmUneiQwsgYFcU1gUeV0Q8WdQFfjH9qGo3D4Q/Y6uhhltDnQ
         FRHBx7wgTVqNJ5BudzkvmCgnmIATDzi9cFesrlGYYsq+w5l+sh5ztBk3JQLLwPxy4vx7
         XzdEAVJsRXaRhSpdhqqeVDDE98b2FlwIkEBG3YqtBwCpQJbHF8TYAXsIf++AYSDsBR9e
         9n47fUZS6UwVPtsCzxr5RRfpEeNuKMBAl7WC40I3iYYMmD5Dvm92BWgZLHe1Rukrp/eQ
         jrDw==
X-Gm-Message-State: AOAM530GiyzAqedRwjguRLfQCLtUxZS2YrzCKFCJSuISt3IWd490iHGc
        +Qoo93szqmONLuTkthQjDxk=
X-Google-Smtp-Source: ABdhPJxh9JWMfnq6qGWgfnJ4mvaKe3SfbWHN60KbNA3Fqoy8b2Df3/WaoMX9PmUtMJlHkTa6t6u+cw==
X-Received: by 2002:a17:906:4d18:: with SMTP id r24mr4596501eju.451.1642799040638;
        Fri, 21 Jan 2022 13:04:00 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:04:00 -0800 (PST)
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
Subject: [PATCH v3 09/15] drivers: clk: qcom: gcc-ipq806x: add unusued flag for critical clock
Date:   Fri, 21 Jan 2022 22:03:34 +0100
Message-Id: <20220121210340.32362-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks are used by other devices present on the SoC. For example
the gsbi4_h_clk is used by RPM and is if disabled cause the RPM to
reject any regulator change command. These clock should never be
disabled.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 53a61860063d..77bc3d94f580 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -798,7 +798,7 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -816,7 +816,7 @@ static struct clk_branch gsbi4_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -900,7 +900,7 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -969,7 +969,7 @@ static struct clk_branch gsbi7_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -1015,6 +1015,7 @@ static struct clk_branch gsbi4_h_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_h_clk",
 			.ops = &clk_branch_ops,
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.33.1

