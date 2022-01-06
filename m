Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420124861D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiAFJKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:10:43 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:60269 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiAFJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1641460231; x=1672996231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8EjfkMBxgq9OGB9tI0dnsy+jf3uRZb0u3PYnJ6+biAQ=;
  b=IjQBtvSlaxUJwwOl4zNkWgAipOGb9LoDfyz3J/AQv/5ZcSDZ8/Hx1iv/
   ZyTlZInVnZbGC0ueOQma2NB40QaxKSvHkBCF7BDPmfsdjXCDEaPTOGfoJ
   lMlaVV2gAtUAhOQFCdos/msEmRoDAkLH0VdI2ctEE3YDSKatHEobcC1AK
   Y=;
X-IronPort-AV: E=Sophos;i="5.88,266,1635206400"; 
   d="scan'208";a="168173182"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 06 Jan 2022 09:10:20 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com (Postfix) with ESMTPS id 8E3B243128;
        Thu,  6 Jan 2022 09:10:19 +0000 (UTC)
Received: from EX13d09UWA001.ant.amazon.com (10.43.160.247) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 6 Jan 2022 09:10:19 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d09UWA001.ant.amazon.com (10.43.160.247) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 6 Jan 2022 09:10:18 +0000
Received: from dev-dsk-mheyne-1b-c1524648.eu-west-1.amazon.com (10.15.60.66)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.26 via Frontend Transport; Thu, 6 Jan 2022 09:10:19 +0000
Received: by dev-dsk-mheyne-1b-c1524648.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id 838C241148; Thu,  6 Jan 2022 09:10:17 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     Maximilian Heyne <mheyne@amazon.de>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        "SeongJae Park" <sjpark@amazon.de>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] xen, blkback: fix persistent grants negotiation
Date:   Thu, 6 Jan 2022 09:10:13 +0000
Message-ID: <20220106091013.126076-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given dom0 supports persistent grants but the guest does not.
Then, when attaching a block device during runtime of the guest, dom0
will enable persistent grants for this newly attached block device:

  $ xenstore-ls -f | grep 20674 | grep persistent
  /local/domain/0/backend/vbd/20674/768/feature-persistent = "0"
  /local/domain/0/backend/vbd/20674/51792/feature-persistent = "1"

Here disk 768 was attached during guest creation while 51792 was
attached at runtime. If the guest would have advertised the persistent
grant feature, there would be a xenstore entry like:

  /local/domain/20674/device/vbd/51792/feature-persistent = "1"

Persistent grants are also used when the guest tries to access the disk
which can be seen when enabling log stats:

  $ echo 1 > /sys/module/xen_blkback/parameters/log_stats
  $ dmesg
  xen-blkback: (20674.xvdf-0): oo   0  |  rd    0  |  wr    0  |  f    0 |  ds    0 | pg:    1/1056

The "pg: 1/1056" shows that one persistent grant is used.

Before commit aac8a70db24b ("xen-blkback: add a parameter for disabling
of persistent grants") vbd->feature_gnt_persistent was set in
connect_ring. After the commit it was intended to be initialized in
xen_vbd_create and then set according to the guest feature availability
in connect_ring. However, with a running guest, connect_ring might be
called before xen_vbd_create and vbd->feature_gnt_persistent will be
incorrectly initialized. xen_vbd_create will overwrite it with the value
of feature_persistent regardless whether the guest actually supports
persistent grants.

With this commit, vbd->feature_gnt_persistent is set only in
connect_ring and this is the only use of the module parameter
feature_persistent. This avoids races when the module parameter changes
during the block attachment process.

Note that vbd->feature_gnt_persistent doesn't need to be initialized in
xen_vbd_create. It's next use is in connect which can only be called
once connect_ring has initialized the rings. xen_update_blkif_status is
checking for this.

Fixes: aac8a70db24b ("xen-blkback: add a parameter for disabling of persistent grants")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/block/xen-blkback/xenbus.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 914587aabca0c..51b6ec0380ca4 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -522,8 +522,6 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	if (q && blk_queue_secure_erase(q))
 		vbd->discard_secure = true;
 
-	vbd->feature_gnt_persistent = feature_persistent;
-
 	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
 		handle, blkif->domid);
 	return 0;
@@ -1090,10 +1088,9 @@ static int connect_ring(struct backend_info *be)
 		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
 		return -ENOSYS;
 	}
-	if (blkif->vbd.feature_gnt_persistent)
-		blkif->vbd.feature_gnt_persistent =
-			xenbus_read_unsigned(dev->otherend,
-					"feature-persistent", 0);
+
+	blkif->vbd.feature_gnt_persistent = feature_persistent &&
+		xenbus_read_unsigned(dev->otherend, "feature-persistent", 0);
 
 	blkif->vbd.overflow_max_grants = 0;
 
-- 
2.32.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



