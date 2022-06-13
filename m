Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A991547F93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiFMGfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiFMGfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6892BC81;
        Sun, 12 Jun 2022 23:35:27 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LM1wp1jX5zgYXn;
        Mon, 13 Jun 2022 14:33:30 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 13 Jun
 2022 14:35:25 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <quic_tdas@quicinc.com>, <sboyd@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: qcom: clk-rpmh: Remove redundant if statement
Date:   Mon, 13 Jun 2022 14:33:27 +0800
Message-ID: <20220613063327.89320-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the clk framework already reference counts prepare/unprepare,
this if statement should be never true.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
Previous threads: 
https://lore.kernel.org/all/20220531094539.252642-1-lizhengyu3@huawei.com/

 drivers/clk/qcom/clk-rpmh.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index aed907982344..249146947923 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -195,10 +195,6 @@ static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
 {
 	int ret;
 
-	/* Nothing required to be done if already off or on */
-	if (enable == c->state)
-		return 0;
-
 	c->state = enable ? c->valid_state_mask : 0;
 	c->aggr_state = c->state | c->peer->state;
 	c->peer->aggr_state = c->aggr_state;
-- 
2.17.1

