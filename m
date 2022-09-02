Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86BD5AB785
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiIBR2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiIBR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:28:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9A7C52E;
        Fri,  2 Sep 2022 10:28:31 -0700 (PDT)
Date:   Fri, 02 Sep 2022 17:28:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662139709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xx3OODAoe2L1pyBT+Z+A148H3M3nkVkXaFC95mRcN+w=;
        b=d4akwdQdU6qq8/VX6jpnY4MNdYdMvg86Zl1o3KxVD3JkPv2QsYMopZcS3VOkJTAEDBcaPS
        RjfMljR1RhW8tLyg+J6lyEp6uHDyvz36tUk+rardABDyTi0Dz88+cGiSsYeWBRdCxRLhiJ
        /QYrtDY6lhDH1Q/R5FlBazrdC0kwAfA77k+oFe451J/cd7U25nGKn8D+dnd/dAznOyOrG8
        w9OA8GH51SAkIGxZddT2Ouf4i9DUyhUPB9+r8um7MlEPiKz78E7fQWF9P7HGTK/kxH54gk
        N5rE5Jc0bljCK+/2P36LUyIsRXdnfl4ZXrBgVs7GGoYbN7ujwBBjlI87dNjctw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662139709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xx3OODAoe2L1pyBT+Z+A148H3M3nkVkXaFC95mRcN+w=;
        b=TiNR/o10XeABPafHAFqHjCp0uyJOObixQRtzFQ2Vc5c44hFlIKSZkCN2J2Z28T4BH9cvcf
        ngTST7plMSGxYVCQ==
From:   "tip-bot2 for Shang XiaoJing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Move __dl_clear_params out of dl_bw lock
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220827020911.30641-1-shangxiaojing@huawei.com>
References: <20220827020911.30641-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Message-ID: <166213970802.401.13891317892278711135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     33f93525799fa3c841b2ba93a56b2bb32ab11dc9
Gitweb:        https://git.kernel.org/tip/33f93525799fa3c841b2ba93a56b2bb32ab11dc9
Author:        Shang XiaoJing <shangxiaojing@huawei.com>
AuthorDate:    Sat, 27 Aug 2022 10:09:11 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Sep 2022 11:19:55 +02:00

sched/deadline: Move __dl_clear_params out of dl_bw lock

As members in sched_dl_entity are independent with dl_bw, move
__dl_clear_params out of dl_bw lock.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Link: https://lore.kernel.org/r/20220827020911.30641-1-shangxiaojing@huawei.com
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3bf4b12..d0fe6a2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -431,8 +431,8 @@ static void task_non_contending(struct task_struct *p)
 				sub_rq_bw(&p->dl, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
-			__dl_clear_params(p);
 			raw_spin_unlock(&dl_b->lock);
+			__dl_clear_params(p);
 		}
 
 		return;
