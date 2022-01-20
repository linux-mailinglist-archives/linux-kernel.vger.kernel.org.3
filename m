Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA821494C32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiATKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:53:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56112 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiATKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 04F5E1F76A;
        Thu, 20 Jan 2022 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642675970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRntaQvQnRRKs8Q9fD7/O4tfQUl0HeggvKHheBBFdio=;
        b=Jf0HcFw3c8FQJ9zNNyF4FRXtMG7+0rNJptDq3vrBmWZ+F84NcWK8XUmIw5D8t9bF8+fQth
        +TANA4NuGgPqBUXHxSXZvgcxWPy3AY/oeKBfwhreGufRxswrjnxATGxhuXYVNubMFBBf+i
        VvIfsTaKcNGLqe81GFPOABe7wIQ5VCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642675970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRntaQvQnRRKs8Q9fD7/O4tfQUl0HeggvKHheBBFdio=;
        b=tL9mPxbp8JZLAftheBJd++yhdFkb1xE9PikvgcAJrkLtjfdLB7djCqUPAQ5oP1dPpalfT4
        j23ECmKjNRruzPCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1B6B7A3B88;
        Thu, 20 Jan 2022 10:52:44 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id E4DC95192BF8; Thu, 20 Jan 2022 11:52:49 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 2/2] block: hold queue lock while iterating in diskstats_show
Date:   Thu, 20 Jan 2022 11:52:48 +0100
Message-Id: <20220120105248.117025-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220120105248.117025-1-dwagner@suse.de>
References: <20220120105248.117025-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The request queues can be freed while we operate on them. Make sure we
hold a reference when using blk_mq_queue_tag_busy_iter.

RIP: blk_mq_queue_tag_busy_iter
Call Trace:
 ? blk_mq_hctx_mark_pending
 ? diskstats_show
 ? blk_mq_hctx_mark_pending
 blk_mq_in_flight
 diskstats_show
 ? klist_next
 seq_read
 proc_reg_read
 vfs_read
 ksys_read
 do_syscall_64
 entry_SYSCALL_64_after_hwframe

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/genhd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index c9d4386dd177..0e163055a4e6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1167,10 +1167,13 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
 			continue;
 		part_stat_read_all(hd, &stat);
+		if (blk_queue_enter(gp->queue, BLK_MQ_REQ_NOWAIT))
+			continue;
 		if (queue_is_mq(gp->queue))
 			inflight = blk_mq_in_flight(gp->queue, hd);
 		else
 			inflight = part_in_flight(hd);
+		blk_queue_exit(gp->queue);
 
 		seq_printf(seqf, "%4d %7d %pg "
 			   "%lu %lu %lu %u "
-- 
2.29.2

