Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31F57127B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiGLGuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiGLGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:50:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4123BDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657608611; x=1689144611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AGn0kJr6Pq73QeUHu6KzC//y57P+/kYnofngPuvFd2M=;
  b=fqSRUJG444JMryRCru90KZKFap3WsekwN2jJ7ZvoSXQmmO6BJ150BfLn
   Bh00wjHvb7lM2RaK+SiAy00Q0GkLHGYWl2GJF5O6ZTp6uzMcmRl7wIrNc
   WBRDFjfOisl8lkZ7CbAhzF27zT46LR7wxV8+dhHfj7t9RhhA5WjG1meKB
   U/Dmo1Zr5sM7lTlhTnfbYIO3xiy3HgGFPe7LGTjSjbZrswn4wH5y1AnyG
   6yH7WCTpljFupGdyCr4yZeNafOBcs7JtdzpCQL4QOaLlNAl+hArDC+SI/
   UtwugVRNZKgrrWAiR52OKErIyU7KeG8osW5yu3n2rAt1EmpBPibsAirMV
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650902400"; 
   d="scan'208";a="309791858"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2022 14:50:10 +0800
IronPort-SDR: D4p9RDK0ZkSfu6hqImE7HT89tq3fLoQYgnT6oUfV71IIPxfCQFOG+X1ni2bykRiawZrrlfp3H7
 vql8XACjB0PTvLzjvbga7TyiSBHNqKep/hCoVPwHh6PYdTTzvHmXkcHKJu3kk9+JRzigK6eWec
 vg7iyD1JmATHAXf6SU8aE+f/hzTcQBmzg9V0KaaAvmAS7OUXQaOskAB2c5TBD5aQ2hXxMcHuvz
 oBXvFTW0gvifVmUhd6JdEF6Ldjysxi4ZlNeM8lA1LYrCWsKQ/c0gOp5t7IFcJod2w5lX7lM+n4
 yjRvBU40Y5Xy2267RT7cYOn7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 23:11:47 -0700
IronPort-SDR: ICLYjrb2DHvfyPe4FadenKIisIgmzeMOPIRhvr2ObxgX0ecpuKfnQ7l0x+CtHGopN0Kx5zyZzi
 vZY1vN+raVUpfuW/J2YMvyZScIP/f+q5OpOrb/jtcXDerMD+7sS+GKNQp3VQNgDZFH7OpqOWUi
 LYzMOTeF/eZeaI4gOf2OFytURM1ANRatgxsW0s2bfO0z8b+DUczB0xGvA5V4IxgIfmdrdwPvck
 6bj7F1s+jHgHPTp1L0HRKPQNX0sx0ve7tKitxLw8fe3zAlbQjg7gY9vAzw4JZNdfHBAdVK9H42
 Gps=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2022 23:50:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Greg Kroah-Hartmann <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/1] drivers: mcb: directly use ida_alloc()/free()
Date:   Mon, 11 Jul 2022 23:50:08 -0700
Message-Id: <480676bee970da16bf1fa8565277240014395ba3.1657607743.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1657607743.git.johannes.thumshirn@wdc.com>
References: <cover.1657607743.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: keliu <liuke94@huawei.com>

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
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
2.35.3

