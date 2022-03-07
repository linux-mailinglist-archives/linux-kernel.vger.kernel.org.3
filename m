Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD2A4CF2C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiCGHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiCGHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:44:07 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5962EE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:43:13 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KBr0w6cvxz1GC3Z;
        Mon,  7 Mar 2022 15:38:24 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 15:43:10 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH -next] soundwire: stream: Fix error return code in do_bank_switch()
Date:   Mon, 7 Mar 2022 07:40:39 +0000
Message-ID: <20220307074039.117488-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/soundwire/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 980f26d49b66..553131597af6 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -822,6 +822,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 		} else if (multi_link) {
 			dev_err(bus->dev,
 				"Post bank switch ops not implemented\n");
+			ret = -EINVAL;
 			goto error;
 		}
 
-- 
2.17.1

