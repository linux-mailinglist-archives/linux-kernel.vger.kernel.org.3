Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE757D956
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiGVEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiGVEOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:14:16 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDE0F89AA0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZNFDAh6e57180WKrcb
        RrtAhDuN2uzlkx0xV24F2OWns=; b=EMsanHh6bg4h0tgDvyXvAJw4tIqKly97lJ
        b8YLRnrxH+tWV8FHp6hnDHScAXZxYQX6TBxEEBwW1xQ+vi7uxuD1vky7P6l6Kj+n
        ajdTpOIkjebgjyJi4IcIz90/lMgFvIDQDze8OkF9lvYZ9Vqi2ebZi+jHgqL76dhf
        Idf+5u1xg=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp11 (Coremail) with SMTP id D8CowACniFX5I9piCOM3AQ--.17251S4;
        Fri, 22 Jul 2022 12:14:01 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drivers/clk/keystone: avoid a memory leak
Date:   Fri, 22 Jul 2022 12:13:43 +0800
Message-Id: <20220722041343.39492-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowACniFX5I9piCOM3AQ--.17251S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryrCr1UtFyfXr43GF1DAwb_yoWxCFb_Wa
        yrZr4xWas5Cr1qvFW8uF1ruryFvr15ur1fZ3Wagay3WFyUZr1UCr4DZrZ3Zw1UXrWIyry3
        Kr47JrW3Cwn5AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRRwZ5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQlG5VaEEO1zrwAAsQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ti_syscon_gate_clk_register, priv is allocated by devm_kzalloc.
On the error path, it should be freed before return.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/clk/keystone/syscon-clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index 19198325b909..d8919bdafe34 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -84,6 +84,7 @@ static struct clk_hw
 
 	ret = devm_clk_hw_register(dev, &priv->hw);
 	if (ret)
+		devm_kfree(dev, priv);
 		return ERR_PTR(ret);
 
 	return &priv->hw;
-- 
2.17.1

