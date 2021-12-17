Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7FC4785AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhLQHmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:42:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:41153 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLQHmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639726934; x=1671262934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ihr/UeVcwH+/UbgClCubV8h0JbZ+Jwe/QpDzJPDzJ0o=;
  b=Vru0HX9XfI8cHrACicJ57mf0YTqT5WzpsadTRxrSiVk/wBNlvVZk6cCx
   lSe2fnH7w9dpoEBqNNxVehesZEHx9y23VTvLLrLpDXKX0WcWeLtBfTKUR
   BUfEUA9Lm3VbKysKtkajrISU73F8U3TtXwEeh3t6ZXHJAIWlbQlBADrZp
   Rqp+WUdadDAs680yJQtBlNqKvSb9wQzx9cD95CSJPmAVOFXwMCngR4DzH
   9q5b8nY676EG+DOzMayc4S/vD4WpzENSjGSDpW7zARYtkF1PKgNmT1OrR
   YfNxNkNz1pIL/TnFtszoxKHtLm0apexrEfD6qJwRz7/LxlA8pjo1rYOh/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239651135"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="239651135"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:42:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="519641766"
Received: from unknown (HELO zq-VirtualBox.bj.intel.com) ([10.238.128.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:42:10 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com
Cc:     linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
Date:   Fri, 17 Dec 2021 15:42:07 +0800
Message-Id: <20211217074207.77425-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the lock owner is on CPU and not need resched, the current waiter
need to be checked, if it not longer top the waiter, stop spinning.

Fixes: c3123c431447 ("locking/rtmutex: Dont dereference waiter lockless")
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Modify description information.

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

