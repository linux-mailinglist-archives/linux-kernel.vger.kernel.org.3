Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41664B9AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiBQIZO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Feb 2022 03:25:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiBQIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:25:12 -0500
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 00:24:56 PST
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1594297237
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:24:56 -0800 (PST)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 9372D60196;
        Thu, 17 Feb 2022 09:15:34 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/rwsem: mark down_(read|write)_trylock() as  __must_check
Date:   Thu, 17 Feb 2022 09:15:33 +0100
Message-ID: <15670760.jIsrciUiTQ@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you don't look at the return code you can't know if you actually got
the lock.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 include/linux/rwsem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f9348769e558..f62fa3ec95de 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -178,7 +178,7 @@ extern int __must_check down_read_killable(struct rw_semaphore *sem);
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
-extern int down_read_trylock(struct rw_semaphore *sem);
+extern int __must_check down_read_trylock(struct rw_semaphore *sem);
 
 /*
  * lock for writing
@@ -189,7 +189,7 @@ extern int __must_check down_write_killable(struct rw_semaphore *sem);
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
-extern int down_write_trylock(struct rw_semaphore *sem);
+extern int __must_check down_write_trylock(struct rw_semaphore *sem);
 
 /*
  * release a read lock
-- 
2.35.1

-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


