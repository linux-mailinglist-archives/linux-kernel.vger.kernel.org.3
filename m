Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD71487D43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiAGTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:45:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:6110 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbiAGTpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641584700; x=1673120700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WorxCgWr17sbvtgPDsd+RkxFOR14VabgFtJ+fZNZTp4=;
  b=ls2mK9XYc9c/uhEKjnFSgpbugIwgHLjR/o9AGLaGgDS7YbQNcjwQT49M
   wdPDFCWS/7MhgoQo1DjMzKcK9MpbOvxNbYR4oWJFUz4m+ONI9BO/WFjXH
   T2GVsOoNWJe3MEuDgNzKJx6I49J9lMrqAqYeK/2WJ8vRyhrnyS2YX/XGi
   0hPL6PRfodrLKSfbn33kzRskLJJeLDiNQAqR1vcUlEJuxkTflbd0ogD5j
   Wh3BDSUuEwTc8Lx7aEBJI4nWCmwjokk8b56AxmU4548IB0LG0BpE6Ox6q
   vcHjbN+aBknuXROU8pQ9OOq6l6IbMYJKGhHx5l+HD/q05RTxhEceV02Rz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="306295457"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="306295457"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:44:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="513914043"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:44:59 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] mm/hwpoison: Fix error page recovered but reported "not recovered"
Date:   Fri,  7 Jan 2022 11:44:50 -0800
Message-Id: <20220107194450.1687264-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

When an uncorrected memory error is consumed there is a race between
the CMCI from the memory controller reporting an uncorrected error
with a UCNA signature, and the core reporting and SRAR signature
machine check when the data is about to be consumed.

If the CMCI wins that race, the page is marked poisoned when
uc_decode_notifier() calls memory_failure() and the machine
check processing code finds the page already poisoned. It calls
kill_accessing_process() to make sure a SIGBUS is sent. But
returns the wrong error code.

Console log looks like this:

[34775.674296] mce: Uncorrected hardware memory error in user-access at 3710b3400
[34775.675413] Memory failure: 0x3710b3: recovery action for dirty LRU page: Recovered
[34775.690310] Memory failure: 0x3710b3: already hardware poisoned
[34775.696247] Memory failure: 0x3710b3: Sending SIGBUS to einj_mem_uc:361438 due to hardware memory corruption
[34775.706072] mce: Memory error not recovered

Fix kill_accessing_process() to return -EHWPOISON to avoid the noise
message "Memory error not recovered" and skip duplicate SIGBUS.

[Tony: Reworded some parts of commit message]

Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

This code is very subtle ... the fix makes the "not recovered" message
go away ... but I'm not more than 75% confident that this is the right
fix. Please check carefully :-)

 mm/memory-failure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3a274468f193..a67f558b08ea 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -707,7 +707,8 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
 	mmap_read_unlock(p->mm);
-	return ret ? -EFAULT : -EHWPOISON;
+
+	return (ret < 0) ? -EFAULT : -EHWPOISON;
 }
 
 static const char *action_name[] = {
-- 
2.31.1

