Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEAC508822
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378543AbiDTMbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345412AbiDTMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:31:32 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2528980
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:28:42 -0700 (PDT)
X-QQ-mid: bizesmtp62t1650457710ty2nusha
Received: from wuhui-virtual-machine.localdoma ( [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 20 Apr 2022 20:28:21 +0800 (CST)
X-QQ-SSF: 01400000002000D0P000B00A0000000
X-QQ-FEAT: HoyAXBWgskmb17xLThAO/UhE8ApA9rt87o1wacSgeMqyxZibQ/RpRqM3EHV9Z
        GM/uuS1cZ15adninUBggPpwOc6QRJ6uVDWYxtQt73VXOrICzRUwohhtKlo7dTHk7WmzE5M5
        zB5k+l6H9OHjl3BKq9bQE5bkWRSGnTP25GMRH/oTKbN+91Ux7BiuMv0W5NaD4RTiEg7y6uN
        wo63Em96OEdlBu0Q3lOsKgEcObO1KCJ/RtQbD8swt+ONskLFM9s/oJcgrtx/7XEDlFnKG1l
        6PRfWJ9AE8J3w7hJLIAsc4CRylljOZQeSzbxsetpKpy7VXDn9wBgzXU+6+o1EYckjfoLBU/
        6GRReIYqKnYmJgREv7bIXRY3l6How==
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhangyinan2019@email.szu.edu.cn, yejiajian2018@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn,
        zhaochongxi2019@email.szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm/page_owner.c: use get_task_comm() to record task command name with the protection of task_lock()
Date:   Wed, 20 Apr 2022 20:28:17 +0800
Message-Id: <20220420122817.67181-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that it is advised to access task command name with
[gs]et_task_comm() in the comment of task_struct->comm,
which is safer with the protection of task_lock().

Relative comment in include/linux/sched.h is as follows:

/*
 * executable name, excluding path.
 *
 * - normally initialized setup_new_exec()
 * - access it with [gs]et_task_comm()
 * - lock it with task_lock()
*/

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/page_owner.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2743062e92c2..bda8fe2660c0 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -171,8 +171,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->pid = current->pid;
 		page_owner->tgid = current->tgid;
 		page_owner->ts_nsec = local_clock();
-		strlcpy(page_owner->comm, current->comm,
-			sizeof(page_owner->comm));
+		get_task_comm(page_owner->comm, current);
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 
-- 
2.17.1



