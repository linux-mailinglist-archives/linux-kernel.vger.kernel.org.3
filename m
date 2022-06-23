Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB6557230
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiFWEtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiFWDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:16:00 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8633342
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:15:59 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N2RM30005231;
        Wed, 22 Jun 2022 20:15:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=qG4HmXubqenrV7rsCSJ5bIFW3gGNTtHvovTYcIk7UYw=;
 b=ZHNt7gNZKxa86RG/kPK1P5srqmtj5PGCSL9QQRLKszO+VclZdxYrDzA3tVmDjOFmzTf4
 XD4fg3gcab5b3yNNWu85GOcF7LJg1R/yyRHpWiizPBr63iiHSynbpUEJW7FuIAsiAPgD
 1mCHhlh3mHYnwaqY7Lf5uefRc1VIcMxktEEtu4HXpIbsMblbtIknn/tpZzbupx6ii6om
 Bav6fi8GivHr8Vqq0I7bVhr8t2C+Ax1oQL67d/yiw027sVQ74pQRyveXKSWrfJ+Xkzql
 Bt+BtrG4VQ0Yx1e88hnp66Tifw2MSrz4KeUKTlYc5pr2DzjyNUQe607En1JtZX3sMJDR 1w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3guye7vv3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 20:15:47 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jun
 2022 20:15:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jun 2022 20:15:45 -0700
Received: from hyd1584.marvell.com (unknown [10.29.37.82])
        by maili.marvell.com (Postfix) with ESMTP id 0F4353F7095;
        Wed, 22 Jun 2022 20:15:43 -0700 (PDT)
From:   George Cherian <george.cherian@marvell.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <tglx@linutronix.de>,
        George Cherian <george.cherian@marvell.com>
Subject: [PATCH] genirq: Increase the number of interrupters
Date:   Thu, 23 Jun 2022 08:45:41 +0530
Message-ID: <20220623031541.1716745-1-george.cherian@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CZ9VHBTNR8TG_GQJ_gTAqAB9M2eTVPc2
X-Proofpoint-ORIG-GUID: CZ9VHBTNR8TG_GQJ_gTAqAB9M2eTVPc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_10,2022-06-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the maximum number of interrupters is capped at 8260 (64 +
8196) in most of the architectures were CONFIG_SPARSE_IRQ is selected.
This upper limit is not sufficient for couple of existing SoC's from
Marvell.
For eg: Octeon TX2 series of processors support a maximum of 32K
interrupters.

Bump up the upper limit from 8196 to 65536.

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
 kernel/irq/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index f09c60393e559..9bb42757d4afc 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -12,7 +12,7 @@
 #include <linux/sched/clock.h>
 
 #ifdef CONFIG_SPARSE_IRQ
-# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
+# define IRQ_BITMAP_BITS	(NR_IRQS + 65536)
 #else
 # define IRQ_BITMAP_BITS	NR_IRQS
 #endif
-- 
2.25.1

