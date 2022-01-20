Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D2B494C31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiATKxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:53:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiATKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F243121122;
        Thu, 20 Jan 2022 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642675969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSOo1+rwn1CnpGKUDDxh+1sbvSOAcn5Txsya3RuMRGw=;
        b=rnuES2r6z59MT98lrQB+U+SW9CnVO8Xdm+0Lb1/aws0QR+Cm4eBJ8Qd60MWhBmoVwYyH94
        Pwo2/9qpKLBQlpIOK0RQeMBxoCza4nEDCZbpo6TxK1/wPk/PLWCNsn2t6x//5oFmR0xaaL
        f9kIsOBM2yA++d9NaRaYMkcaANWYcME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642675969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSOo1+rwn1CnpGKUDDxh+1sbvSOAcn5Txsya3RuMRGw=;
        b=oEDGPRPuVzYZdmQlPfBUmE/PnoeoOTA0sS5Czk2oP396Usow4fMZ5LfmNKD/262phqDnkB
        +qTjs4jP43AusXDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 157B1A3B87;
        Thu, 20 Jan 2022 10:52:44 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id DF7FA5192BF6; Thu, 20 Jan 2022 11:52:49 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 1/2] block: remove commented out code from diskstats_show
Date:   Thu, 20 Jan 2022 11:52:47 +0100
Message-Id: <20220120105248.117025-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220120105248.117025-1-dwagner@suse.de>
References: <20220120105248.117025-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diskstats format is ABI, so we just can't add a new header. The
code snippet has been commented out since at least v2.6.12-rc2.
Remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/genhd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..c9d4386dd177 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1162,14 +1162,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct disk_stats stat;
 	unsigned long idx;
 
-	/*
-	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
-		seq_puts(seqf,	"major minor name"
-				"     rio rmerge rsect ruse wio wmerge "
-				"wsect wuse running use aveq"
-				"\n\n");
-	*/
-
 	rcu_read_lock();
 	xa_for_each(&gp->part_tbl, idx, hd) {
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
-- 
2.29.2

