Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841FE56559B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiGDMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiGDMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:41:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D71115E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:41:04 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lc52w2BMXzkWkF;
        Mon,  4 Jul 2022 20:39:04 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 20:41:03 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 20:41:02 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <fei1.li@intel.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH -next] virt: acrn: using for_each_set_bit to simplify the code
Date:   Mon, 4 Jul 2022 20:50:44 +0800
Message-ID: <20220704125044.2192381-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

It's more cleanly to use for_each_set_bit() instead of opencoding it.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/virt/acrn/ioreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 5ff1c53740c0..d75ab3f66da4 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -246,12 +246,8 @@ void acrn_ioreq_request_clear(struct acrn_vm *vm)
 	spin_lock_bh(&vm->ioreq_clients_lock);
 	client = vm->default_client;
 	if (client) {
-		vcpu = find_first_bit(client->ioreqs_map, ACRN_IO_REQUEST_MAX);
-		while (vcpu < ACRN_IO_REQUEST_MAX) {
+		for_each_set_bit(vcpu, client->ioreqs_map, ACRN_IO_REQUEST_MAX)
 			acrn_ioreq_complete_request(client, vcpu, NULL);
-			vcpu = find_next_bit(client->ioreqs_map,
-					     ACRN_IO_REQUEST_MAX, vcpu + 1);
-		}
 	}
 	spin_unlock_bh(&vm->ioreq_clients_lock);
 
-- 
2.25.1

