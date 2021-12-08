Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95DE46CA53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhLHB5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:57:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28285 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhLHB5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:57:12 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J80Yz2mmtzbhvZ;
        Wed,  8 Dec 2021 09:53:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 09:53:39 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Wudi Wang <wangwudi@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] irqchip/irq-gic-v3-its.c: Return its_invall_cmd.col when building INVALL
Date:   Wed, 8 Dec 2021 09:54:29 +0800
Message-ID: <20211208015429.5007-1-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wudi Wang <wangwudi@hisilicon.com>

INVALL CMD specifies that the ITS must ensure any caching associated with
the interrupt collection defined by ICID is consistent with the LPI
configuration tables held in memory for all Redistributors. SYNC is
required to ensure that INVALL is executed.

Currently, LPI configuration data may be inconsistent with that in the
memory within a short period of time after the INVALL command is executed.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Wudi Wang <wangwudi@hisilicon.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index eb0882d15366..0cb584d9815b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -742,7 +742,7 @@ static struct its_collection *its_build_invall_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return NULL;
+	return desc->its_invall_cmd.col;
 }
 
 static struct its_vpe *its_build_vinvall_cmd(struct its_node *its,
-- 
2.33.0

