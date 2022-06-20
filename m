Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD438551477
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiFTJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiFTJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:36:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559DE13D7B;
        Mon, 20 Jun 2022 02:36:58 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LRPbL0P6dz928x;
        Mon, 20 Jun 2022 17:33:34 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 17:36:56 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <wupeng58@huawei.com>
Subject: [PATCH] bus: ti-sysc: Add missing of_node_put() in sysc_add_named_clock_from_child()
Date:   Mon, 20 Jun 2022 09:31:07 +0000
Message-ID: <20220620093107.73809-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_next_available_child() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
---
 drivers/bus/ti-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 9a7d12332fad..73fd42dd25b3 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -333,6 +333,7 @@ static int sysc_add_named_clock_from_child(struct sysc *ddata,
 		return -ENODEV;
 
 	clock = devm_get_clk_from_child(ddata->dev, child, name);
+	of_node_put(child);
 	if (IS_ERR(clock))
 		return PTR_ERR(clock);
 
-- 
2.17.1

