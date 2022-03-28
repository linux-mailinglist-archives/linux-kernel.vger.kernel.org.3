Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A824E90A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiC1JBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiC1JBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:01:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1A52E1D;
        Mon, 28 Mar 2022 01:59:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB3DA210E0;
        Mon, 28 Mar 2022 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648457971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JjTRUXEsWdiWo+pOfUOR0gpFvCCT2Q/VJ9kcvZZ1do4=;
        b=v4KIQz8oemUWPSiJN3H0UU9h5NBsKSFxHv7qEG5vYoHOAhlJ77aAh7gcF6AgCa3WPu3UmK
        b036F/TWvFOPtPCKR4jhwGnDkzx3jo5gWY6EQx+IVZ2i6jXWDZB1y+vGQngPxTgoRObE4T
        yLtlCFzyk+KIfF13D3H7paa8VjGRrmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648457971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JjTRUXEsWdiWo+pOfUOR0gpFvCCT2Q/VJ9kcvZZ1do4=;
        b=7d60lZ8o0VMPUJfpRRhFdGNkspj1ivHV1JZ/Q4NSYuZ0Xsd33NtPT/hT/uKDMgWB+mji+G
        g8Dyo6gTwoeOAXCw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97F4FA3B88;
        Mon, 28 Mar 2022 08:59:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] block: restore the old set_task_ioprio() behaviour wrt PF_EXITING
Date:   Mon, 28 Mar 2022 10:59:28 +0200
Message-Id: <20220328085928.7899-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PF_EXITING tasks were silently ignored before the below commits.
Continue doing so. Otherwise python-psutil tests fail:
  ERROR: psutil.tests.test_process.TestProcess.test_zombie_process
  ----------------------------------------------------------------------
  Traceback (most recent call last):
    File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/build/lib.linux-x86_64-3.9/psutil/_pslinux.py", line 1661, in wrapper
      return fun(self, *args, **kwargs)
    File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/build/lib.linux-x86_64-3.9/psutil/_pslinux.py", line 2133, in ionice_set
      return cext.proc_ioprio_set(self.pid, ioclass, value)
  ProcessLookupError: [Errno 3] No such process

  During handling of the above exception, another exception occurred:

  Traceback (most recent call last):
    File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/psutil/tests/test_process.py", line 1313, in test_zombie_process
      succeed_or_zombie_p_exc(fun)
    File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/psutil/tests/test_process.py", line 1288, in succeed_or_zombie_p_exc
      return fun()
    File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/build/lib.linux-x86_64-3.9/psutil/__init__.py", line 792, in ionice
      return self._proc.ionice_set(ioclass, value)
    File "/home/abuild/rpmbuild/BUILD/psutil-5.9.0/build/lib.linux-x86_64-3.9/psutil/_pslinux.py", line 1665, in wrapper
      raise NoSuchProcess(self.pid, self._name)
  psutil.NoSuchProcess: process no longer exists (pid=2057)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Fixes: 5fc11eebb4 (block: open code create_task_io_context in set_task_ioprio)
Fixes: a957b61254 (block: fix error in handling dead task for ioprio setting)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 block/blk-ioc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 11f49f78db32..df9cfe4ca532 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -280,7 +280,6 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 
 		task_lock(task);
 		if (task->flags & PF_EXITING) {
-			err = -ESRCH;
 			kmem_cache_free(iocontext_cachep, ioc);
 			goto out;
 		}
@@ -292,7 +291,7 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 	task->io_context->ioprio = ioprio;
 out:
 	task_unlock(task);
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(set_task_ioprio);
 
-- 
2.35.1

