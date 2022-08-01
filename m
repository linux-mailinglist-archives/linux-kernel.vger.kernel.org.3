Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8626586AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiHAM2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiHAM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:27:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FC33A25;
        Mon,  1 Aug 2022 05:07:24 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LxGyL3qRHzlVvX;
        Mon,  1 Aug 2022 20:04:42 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 20:07:22 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <guohanjun@huawei.com>, <weiyongjun1@huawei.com>,
        <xuqiang36@huawei.com>
Subject: [PATCH -next] of/fdt: declared return type does not match actual return type
Date:   Mon, 1 Aug 2022 12:05:06 +0000
Message-ID: <20220801120506.11461-2-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220801120506.11461-1-xuqiang36@huawei.com>
References: <20220801120506.11461-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 649cab56de8e (“of: properly check for error returned
by fdt_get_name()”) changed the return value type from bool to int,
but forgot to change the return value simultaneously.

populate_node was only called in unflatten_dt_nodes, and returns
with values greater than or equal to 0 were discarded without further
processing. Considering that return 0 usually indicates success,
return 0 instead of return true.

Fixes: 649cab56de8e (“of: properly check for error returned by fdt_get_name()”)
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 22b3d35a5e76..4fe448d8d2ae 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -246,7 +246,7 @@ static int populate_node(const void *blob,
 	}
 
 	*pnp = np;
-	return true;
+	return 0;
 }
 
 static void reverse_nodes(struct device_node *parent)
-- 
2.17.1

