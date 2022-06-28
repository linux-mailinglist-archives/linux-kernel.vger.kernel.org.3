Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629CE55E279
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbiF1Gmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343544AbiF1Gm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:42:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F12654D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:42:26 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXFL63WMrzTgDh;
        Tue, 28 Jun 2022 14:38:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 14:42:23 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 14:42:23 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <op-tee@lists.trustedfirmware.org>
CC:     <sumit.garg@linaro.org>, <jens.wiklander@linaro.org>
Subject: [PATCH] optee: smc_abi.c: fix wrong pointer passed to IS_ERR/PTR_ERR()
Date:   Tue, 28 Jun 2022 14:52:16 +0800
Message-ID: <20220628065216.901194-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be 'rpc_arg' pass to IS_ERR/PTR_ERR().

Fixes: ed8faf6c8f8c ("optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tee/optee/smc_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 385cb0aee610..a1c1fa1a9c28 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -884,8 +884,8 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 
 		rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
 		rpc_arg = tee_shm_get_va(shm, offs + rpc_arg_offs);
-		if (IS_ERR(arg))
-			return PTR_ERR(arg);
+		if (IS_ERR(rpc_arg))
+			return PTR_ERR(rpc_arg);
 	}
 
 	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
-- 
2.25.1

