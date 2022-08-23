Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25B59ECC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiHWTsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiHWTrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:47:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF59A78BF9;
        Tue, 23 Aug 2022 11:51:09 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 563D42125976;
        Tue, 23 Aug 2022 11:51:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 563D42125976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1661280669;
        bh=NBFeGJMwCnn/s60bkc/kPbdd0y34vbhoOIUgYJBG02k=;
        h=From:To:Subject:Date:From;
        b=IUxhbzEW7vaVZ4Ng+5wGWzMb9yRhskDwc0vqAVJdcKR1EDxy5lPqeD6yhI5DrAehI
         KCTmfRLw8KGGFkzC3xhyKav2zSZeFJYqRM+EaW53o+8P3o126lHnPkE8eaXwMq/c75
         1Uwz/VCxdHh05yIri3MNwg6cvnFXU1CeLR7upAUs=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     song@kernel.org, shli@fb.com, neilb@suse.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com,
        guoqing.jiang@linux.dev
Subject: [PATCH v2] md : Replace snprintf with scnprintf
Date:   Tue, 23 Aug 2022 11:51:04 -0700
Message-Id: <1661280664-10588-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code produces a warning as shown below when total characters
in the constituent block device names plus the slashes exceeds 200.
snprintf() returns the number of characters generated from the given
input, which could cause the expression “200 – len” to wrap around
to a large positive number. Fix this by using scnprintf() instead,
which returns the actual number of characters written into the buffer.

[ 1513.267938] ------------[ cut here ]------------
[ 1513.267943] WARNING: CPU: 15 PID: 37247 at <snip>/lib/vsprintf.c:2509 vsnprintf+0x2c8/0x510
[ 1513.267944] Modules linked in:  <snip>
[ 1513.267969] CPU: 15 PID: 37247 Comm: mdadm Not tainted 5.4.0-1085-azure #90~18.04.1-Ubuntu
[ 1513.267969] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022
[ 1513.267971] RIP: 0010:vsnprintf+0x2c8/0x510
<-snip->
[ 1513.267982] Call Trace:
[ 1513.267986]  snprintf+0x45/0x70
[ 1513.267990]  ? disk_name+0x71/0xa0
[ 1513.267993]  dump_zones+0x114/0x240 [raid0]
[ 1513.267996]  ? _cond_resched+0x19/0x40
[ 1513.267998]  raid0_run+0x19e/0x270 [raid0]
[ 1513.268000]  md_run+0x5e0/0xc50
[ 1513.268003]  ? security_capable+0x3f/0x60
[ 1513.268005]  do_md_run+0x19/0x110
[ 1513.268006]  md_ioctl+0x195e/0x1f90
[ 1513.268007]  blkdev_ioctl+0x91f/0x9f0
[ 1513.268010]  block_ioctl+0x3d/0x50
[ 1513.268012]  do_vfs_ioctl+0xa9/0x640
[ 1513.268014]  ? __fput+0x162/0x260
[ 1513.268016]  ksys_ioctl+0x75/0x80
[ 1513.268017]  __x64_sys_ioctl+0x1a/0x20
[ 1513.268019]  do_syscall_64+0x5e/0x200
[ 1513.268021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 766038846e875 ("md/raid0: replace printk() with pr_*()")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
V2 :
	- Rebase

 drivers/md/raid0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 78addfe..857c493 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -47,7 +47,7 @@ static void dump_zones(struct mddev *mddev)
 		int len = 0;
 
 		for (k = 0; k < conf->strip_zone[j].nb_dev; k++)
-			len += snprintf(line+len, 200-len, "%s%pg", k?"/":"",
+			len += scnprintf(line+len, 200-len, "%s%pg", k?"/":"",
 				conf->devlist[j * raid_disks + k]->bdev);
 		pr_debug("md: zone%d=[%s]\n", j, line);
 
-- 
1.8.3.1

