Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C91A53599F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiE0Guk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbiE0Guh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:50:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB31F134E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:50:29 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8b4Q17wfzbc4L
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:48:54 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:50:27 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:50:27 +0800
From:   keliu <liuke94@huawei.com>
To:     <morbidrsa@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: mcb: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:11:56 +0000
Message-ID: <20220527071156.2359578-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/mcb/mcb-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index cf128b3471d7..338fc889b357 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -254,7 +254,7 @@ static void mcb_free_bus(struct device *dev)
 	struct mcb_bus *bus = to_mcb_bus(dev);
 
 	put_device(bus->carrier);
-	ida_simple_remove(&mcb_ida, bus->bus_nr);
+	ida_free(&mcb_ida, bus->bus_nr);
 	kfree(bus);
 }
 
@@ -273,7 +273,7 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 	if (!bus)
 		return ERR_PTR(-ENOMEM);
 
-	bus_nr = ida_simple_get(&mcb_ida, 0, 0, GFP_KERNEL);
+	bus_nr = ida_alloc(&mcb_ida, GFP_KERNEL);
 	if (bus_nr < 0) {
 		kfree(bus);
 		return ERR_PTR(bus_nr);
-- 
2.25.1

