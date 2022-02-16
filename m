Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566B4B842C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiBPJPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:15:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiBPJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:15:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6717219224
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:15:16 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JzC282pQNzcbhC;
        Wed, 16 Feb 2022 17:14:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 17:15:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 3/8] mm/memory-failure.c: rework the signaling logic in kill_proc
Date:   Wed, 16 Feb 2022 17:14:26 +0800
Message-ID: <20220216091431.39406-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220216091431.39406-1-linmiaohe@huawei.com>
References: <20220216091431.39406-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUS_MCEERR_AR code is only sent when MF_ACTION_REQUIRED is set and the
target is current. Rework the code to make this clear.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index eaa241058401..7e205d91b2d7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -258,16 +258,13 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
 			pfn, t->comm, t->pid);
 
-	if (flags & MF_ACTION_REQUIRED) {
-		if (t == current)
-			ret = force_sig_mceerr(BUS_MCEERR_AR,
-					 (void __user *)tk->addr, addr_lsb);
-		else
-			/* Signal other processes sharing the page if they have PF_MCE_EARLY set. */
-			ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
-				addr_lsb, t);
-	} else {
+	if ((flags & MF_ACTION_REQUIRED) && (t == current))
+		ret = force_sig_mceerr(BUS_MCEERR_AR,
+				 (void __user *)tk->addr, addr_lsb);
+	else
 		/*
+		 * Signal other processes sharing the page if they have
+		 * PF_MCE_EARLY set.
 		 * Don't use force here, it's convenient if the signal
 		 * can be temporarily blocked.
 		 * This could cause a loop when the user sets SIGBUS
@@ -275,7 +272,6 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		 */
 		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
 				      addr_lsb, t);  /* synchronous? */
-	}
 	if (ret < 0)
 		pr_info("Memory failure: Error sending signal to %s:%d: %d\n",
 			t->comm, t->pid, ret);
-- 
2.23.0

