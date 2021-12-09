Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AB46E2D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhLIHDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:03:34 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:25986 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhLIHDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:03:32 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 02:03:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yL2dr
        E9LrYFJdmC80fn3NF3BkfEsK3wrZa9/rZM+w9Y=; b=l0OT/Bna29VPy1QXKyzi0
        +elBQMwWVgQ7cUSR0AKR03geZLesk2BVMUINMUbmlQDo33r+IBEdIkUqNBZrSTJO
        Yo7I34FF378/yg74iHcOfZtyoF2eiaNUNJZP5Z9JwZEpqUD84awbhb9omKq2fMxi
        yGnFsYsKFS9DWziJOQGfa0=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp4 (Coremail) with SMTP id HNxpCgC323nMpbFhy7IyAw--.49693S4;
        Thu, 09 Dec 2021 14:44:42 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        niejianglei2021@163.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: csiostor: Fix memory leak in csio_wr_eq_destroy()
Date:   Thu,  9 Dec 2021 14:44:25 +0800
Message-Id: <20211209064425.123950-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgC323nMpbFhy7IyAw--.49693S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4kCw4kKrWfJrW5Kr43Awb_yoW8XF47pF
        WxG34kA3yFq3ZFkry5uanxZF1rta4fX397KFW3Z3sxuF9xXFyDtF1vgrya9ryUKrW8uF15
        tF4kKFyUA3WUAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jk4SrUUUUU=
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiWxtkjFSIsfLAZwAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 715 (#1) calls mempool_alloc() to allocate an element
from a specific memory pool. When some errors occur, line 727 (#2)
frees this memory pool but line 731 (#3) does not free it, which will
lead to a memory leak.

We can fix it by calling mempool_free() when the cbfn is not equal to
NULL and before the function returns 0 in line 732 (#3).

705 static int
706 csio_wr_eq_destroy(struct csio_hw *hw, void *priv, int eq_idx,
707 		   void (*cbfn) (struct csio_hw *, struct csio_mb *))
708 {
710 	struct csio_mb  *mbp;

715 	mbp = mempool_alloc(hw->mb_mempool, GFP_ATOMIC);
	// #1: allocate memory pool
716 	if (!mbp)
717 		return -ENOMEM;

725 	rv = csio_mb_issue(hw, mbp);
726 	if (rv != 0) {
727		mempool_free(mbp, hw->mb_mempool);
		// #2: free memory pool
728		return rv;
729 	}

731 	if (cbfn != NULL)
732 		return 0; // #3: missing free

734 	return csio_wr_eq_destroy_rsp(hw, mbp, eq_idx);
735 }

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/scsi/csiostor/csio_wr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
index fe0355c964bc..7dcc4fda0483 100644
--- a/drivers/scsi/csiostor/csio_wr.c
+++ b/drivers/scsi/csiostor/csio_wr.c
@@ -728,8 +728,10 @@ csio_wr_eq_destroy(struct csio_hw *hw, void *priv, int eq_idx,
 		return rv;
 	}
 
-	if (cbfn != NULL)
+	if (cbfn != NULL) {
+		mempool_free(mbp, hw->mb_mempool);
 		return 0;
+	}
 
 	return csio_wr_eq_destroy_rsp(hw, mbp, eq_idx);
 }
-- 
2.25.1

