Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5352C47B176
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhLTQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:44:12 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:24915 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237078AbhLTQoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:44:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1640018651; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tIjjCFzG7+q1lWtzq42/6y9LRRlcrUYEEWdfimSyY64=; b=UVo3fBV6Lro9ZwkS7NpgPkMFbHUtluWbHvO75gVGUwI8PRsc0Jv1LTsm/zTDxwBn38QLFPhg
 UHQ4dRgMXu/nBgjF954emW9sMJBeF5Ev3PpTrASldoRtguLM8QLhzp6gPxibgR43cR0YARAX
 qXnw8GDB8bHtAfcU/y3HmC9St8c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61c0b2da305fa44552905db3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Dec 2021 16:44:10
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6920BC4360C; Mon, 20 Dec 2021 16:44:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40330C4338F;
        Mon, 20 Dec 2021 16:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 40330C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/5] Add support for LPASS Core and Audio Clock for SC7280
Date:   Mon, 20 Dec 2021 22:13:53 +0530
Message-Id: <1640018638-19436-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v2]
 * Drop code for "Add support for clock voting from GDSC" from
   drivers/clk/qcom/gdsc.c
 * Add support for runtime PM get/put from clk_summary.
 * Update commit message for PLL detect lock timeout increase.
 * Fix documentation bindings errors reported by DT_CHECKER_FLAGS.
 * Update the driver code to take care of the following
    - KCONFIG to add "select QCOM_GDSC"
    - Use of "const" for pll_vco and clk_init_data
    - Use of index instead of fw_name.
    - Fix extra space, remove 'lpass_create_pm_clks' and corresponding code.
    - cleanup 'lpass_hm_core_probe' and 'lpass_hm_sc7280_match_table'.

[v1]
This patchset supports the following.
- Few PLLs might require to a higher time to detect lock, thus increase the
  polling time.
- GDSC which require clocks to be explicitly enabled before access.
- LPASS core and audio clock driver support for SC7280.


Taniya Das (5):
  clk: qcom: clk-alpha-pll: Increase PLL lock detect poll time
  clk: Enable/Disable runtime PM for clk_summary
  clk: qcom: gcc-sc7280: Mark gcc_cfg_noc_lpass_clk always enabled
  dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280
  clk: qcom: lpass: Add support for LPASS clock controller for SC7280

 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    | 169 +++++
 drivers/clk/clk.c                                  |   2 +
 drivers/clk/qcom/Kconfig                           |  10 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   2 +-
 drivers/clk/qcom/gcc-sc7280.c                      |   2 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             | 832 +++++++++++++++++++++
 drivers/clk/qcom/lpasscorecc-sc7280.c              | 433 +++++++++++
 .../dt-bindings/clock/qcom,lpassaudiocc-sc7280.h   |  43 ++
 .../dt-bindings/clock/qcom,lpasscorecc-sc7280.h    |  26 +
 10 files changed, 1518 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
 create mode 100644 drivers/clk/qcom/lpassaudiocc-sc7280.c
 create mode 100644 drivers/clk/qcom/lpasscorecc-sc7280.c
 create mode 100644 include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

