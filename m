Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9247895E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhLQLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:00:47 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:14971 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233151AbhLQLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:00:46 -0500
IronPort-SDR: 54QwO7DawNjhoRXQodut2MRed/NWO6FPWuLwjr1NqxVejAzv4gSpgK2nOia1eLk0dHl9fYExGU
 +ZZS2EdmO//WwMWndSV4AzswKeW9XEuD2N1XC0gqsC0MCSS/esm3yXavRBo5iE1iHjQ9Fo9Rm7
 3SwmN8kAVlrBs6l2I3gjCO6mbLSKgexfoyoaHXrK/XV+nxmtqUGxZoprd+BaAbaNSDSCIk0F6r
 6R0RTIr3hxwPizFAV9kVx76s/XIKulIMDFnw1XUkMVARXzMUQz/Zfv6sulJyYR7EEfBOpMlHrU
 zAcM91ZTs+BxY2CjjcIXVqV1
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="56954851"
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; 
   d="scan'208";a="56954851"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 17 Dec 2021 20:00:44 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9DCE3E0407
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 20:00:43 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E6216D99A3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 20:00:42 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id 96221A8;
        Fri, 17 Dec 2021 20:00:42 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, ming.lei@redhat.com, yamamoto.rei@jp.fujitsu.com
Subject: [PATCH v2] irq: consider cpus on nodes are unbalanced
Date:   Fri, 17 Dec 2021 19:44:07 +0900
Message-Id: <20211217104407.2156-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cpus on a node are offline at boot time, there are
difference in the number of nodes between when building affinity
masks for present cpus and when building affinity masks for possible
cpus. This patch fixes a problem caused by the difference of the
number of nodes:

 - The routine of "numvecs <= nodes" condition can overwrite bits of
   masks for present cpus in building masks for possible cpus. Fix this
   problem by making CPU bits, which is not target, not changing.

Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
---
 kernel/irq/affinity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff8919dc9b..d2d01565d2ec 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -269,8 +269,9 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
+			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
 			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
-				   node_to_cpumask[n]);
+				   nmsk);
 			if (++curvec == last_affv)
 				curvec = firstvec;
 		}
-- 
2.27.0

