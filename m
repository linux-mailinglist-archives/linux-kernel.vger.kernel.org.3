Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0837B47B181
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhLTQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:44:26 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:24915 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239395AbhLTQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:44:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1640018665; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=vqCplsHvlnC6fEX3Jhnv/6hd7RozQTFk7a0/51ifzFg=; b=aHVCRLGV+f0Wu9BrK73otoDYajrWjM7qw0mf86xEWUMdnj+tTehiu/V6BHCk0ZiF0YmSthC8
 w1P5VV01qX5Wgd/1Li9WFvOGRKVubfoQeMGRClunRyBENxUJrmpRGan/88n1TPuzxRbNh9gD
 sILdQPbBm0ANORLfdRu4eJ1gXts=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61c0b2e97a42cec70893582e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Dec 2021 16:44:25
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40696C4361C; Mon, 20 Dec 2021 16:44:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40CD6C43619;
        Mon, 20 Dec 2021 16:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 40CD6C43619
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
Subject: [PATCH v2 2/5] clk: Enable/Disable runtime PM for clk_summary
Date:   Mon, 20 Dec 2021 22:13:55 +0530
Message-Id: <1640018638-19436-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640018638-19436-1-git-send-email-tdas@codeaurora.org>
References: <1640018638-19436-1-git-send-email-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The registers for some clocks in the SOC area, which are under the power
domain are required to be enabled before accessing them. During the
clk_summary if the power-domains are not enabled they could result into
NoC errors.

Thus ensure the register access of the clock controller is done with
pm_untime_get/put functions.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 963f56f..8de6a22 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2966,7 +2966,9 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 {
 	struct clk_core *child;

+	clk_pm_runtime_get(c);
 	clk_summary_show_one(s, c, level);
+	clk_pm_runtime_put(c);

 	hlist_for_each_entry(child, &c->children, child_node)
 		clk_summary_show_subtree(s, child, level + 1);
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

