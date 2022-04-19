Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A51506B75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351932AbiDSLzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiDSLzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:55:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF07A35AB6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:52:22 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KjMbF2F0vzfYt2;
        Tue, 19 Apr 2022 19:51:37 +0800 (CST)
Received: from container.huawei.com (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 19:52:20 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>,
        <daniel.thompson@linaro.org>, <cocci@inria.fr>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cocinelle: iterators: optimize device_node_continue rule
Date:   Tue, 19 Apr 2022 20:10:13 +0800
Message-ID: <20220419121013.1290398-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Execute the device_node_continue.cocci for kernel source. Get an error
report as following:
./drivers/pci/hotplug/pnv_php.c:161:2-13: ERROR: probable double put.

After analysis, we can find that it is false positive, because it is to
detach the node from device tree. And we can abstract out an exception.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 scripts/coccinelle/iterators/device_node_continue.cocci | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scripts/coccinelle/iterators/device_node_continue.cocci
index f8cd14dfa604..4b8ee3316a8c 100644
--- a/scripts/coccinelle/iterators/device_node_continue.cocci
+++ b/scripts/coccinelle/iterators/device_node_continue.cocci
@@ -49,9 +49,11 @@ for_each_node_with_property(n,e1) S
 &
 i@p1(...) {
    ... when != of_node_get(n)
+       when != of_detach_node(n)
        when any
    of_node_put@p2(n);
-   ... when any
+   ... when != of_detach_node(n)
+       when any
 }
 )
 
-- 
2.25.1

