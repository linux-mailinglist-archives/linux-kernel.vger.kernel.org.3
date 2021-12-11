Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAC54713A0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhLKLaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:30:17 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16366 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhLKLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:30:10 -0500
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JB5CC0Lv2z91VG;
        Sat, 11 Dec 2021 19:29:27 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:08 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:07 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 3/6] crypto: hisilicon/qm - modify the handling method after abnormal interruption
Date:   Sat, 11 Dec 2021 19:25:16 +0800
Message-ID: <20211211112519.21201-4-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211211112519.21201-1-qianweili@huawei.com>
References: <20211211112519.21201-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After processing an interrupt event and the interrupt function is
enabled by writing the QM_DOORBELL_CMD_AEQ register, the hardware
may generate new interrupt events due to processing other user's task
when the subsequent interrupt events have not been processed. The new
interrupt event will disrupt the current normal processing flow and
cause other problems.

Therefore, the operation of writing the QM_DOORBELL_CMD_AEQ doorbell
register needs to be placed after all interrupt events processing
are completed.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index d124800b67e6..beea3a0fd0a5 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1015,10 +1015,10 @@ static irqreturn_t qm_aeq_irq(int irq, void *data)
 			aeqe++;
 			qm->status.aeq_head++;
 		}
-
-		qm_db(qm, 0, QM_DOORBELL_CMD_AEQ, qm->status.aeq_head, 0);
 	}
 
+	qm_db(qm, 0, QM_DOORBELL_CMD_AEQ, qm->status.aeq_head, 0);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.33.0

