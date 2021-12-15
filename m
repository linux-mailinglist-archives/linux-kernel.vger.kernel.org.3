Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1314B475378
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhLOHCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:02:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:56530 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232339AbhLOHCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639551722; x=1671087722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Iq/PvTmi9VoDk9hdlIFUzBjydT7EveRl9egLvBSCd0I=;
  b=jdQnV/aA/ei+X5Rh80D/Qp9lCVHRSU/ws1dWXF+9iTLKUIl9whcv5TJ9
   gNURz62jKH91jQiNHBMz7ZA1yNzQEhHs7fKvn4TY05j+XDvbjNuYxGrPw
   snovzVuk2y3YHEvzf1AVrOMUQAKhqS4nxtAsG3buZ0n0MvKCt+1K06clW
   aYIZ/FkGDp6iZwOnupMT7gsNWxyRWlSEIhKY2csj64nR3eYNynFn1fmq7
   XY7sSghI7HKT9PKoVfz9ft6LIpisIPqdTauEtsTmNOxmcgoDr/BK9wq1B
   oCkvdBhAkvMi1RZP1rg3MRHUrAa9HPR5vs699uAy4RrEOR4rzb8U39t8b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219848606"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219848606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 23:02:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518633849"
Received: from unknown (HELO zq-VirtualBox.bj.intel.com) ([10.238.130.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 23:02:00 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rtmutex: Fix incorrect usage of rt_mutex_waiter_is_top_waiter()
Date:   Wed, 15 Dec 2021 15:01:51 +0800
Message-Id: <20211215070151.8025-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition for exiting spin is that the rt_mutex_waiter_is_top_waiter()
return false rather than return true.

Fixes: c3123c431447 ("locking/rtmutex: Dont dereference waiter lockless")
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0c1f2e3f019a..8555c4efe97c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1383,7 +1383,7 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 		 *  - the VCPU on which owner runs is preempted
 		 */
 		if (!owner_on_cpu(owner) || need_resched() ||
-		    rt_mutex_waiter_is_top_waiter(lock, waiter)) {
+		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
 			res = false;
 			break;
 		}
-- 
2.25.1

