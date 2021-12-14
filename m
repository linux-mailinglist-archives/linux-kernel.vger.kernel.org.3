Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD31474938
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhLNRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:24:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46078 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhLNRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:24:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C850C61628;
        Tue, 14 Dec 2021 17:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9DDC34601;
        Tue, 14 Dec 2021 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639502684;
        bh=WCpdMlr09747wukXO9N7qLEZ5HbSefqpma5Yu0yVFA0=;
        h=From:To:Cc:Subject:Date:From;
        b=AXNk7ZMV6JkTvVY9JrfyZ0s2cDOV1EJ7j/AES5ObUpTva9Xgr5WGqU79lJqwG9OnU
         0x7UnaKhI1ZtN77N1TRHHK7r89CBm1VToG7xiyStzFIPCdJeqVDfCWLhf7bkR+mxMU
         I063LBH0dH7W6Tt2HDLjDLX3XU5u3dW8UPVl8U9ny6np8M31qqTpevt0uLYmY+/5rw
         +8iSQHhHtuNh00emPx6KEUKNYfrpPNv83jIdkvk+zR7TlZkBwgBL6Zcf883TBDMl1b
         dntv1v1glKFeBw8abY6dKJGsrh2NGlO2UNqAbG1ondMqDFKXCHbQoHjWyV2icB2XK4
         aHJvnsMjYigAA==
From:   broonie@kernel.org
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the dmaengine tree with the dmaengine-fixes tree
Date:   Tue, 14 Dec 2021 17:24:37 +0000
Message-Id: <20211214172437.1552740-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the dmaengine tree got a conflict in:

  drivers/dma/idxd/submit.c

between commit:

  8affd8a4b5ce3 ("dmaengine: idxd: fix missed completion on abort path")

from the dmaengine-fixes tree and commit:

  5d78abb6fbc97 ("dmaengine: idxd: rework descriptor free path on failure")

from the dmaengine tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/dma/idxd/submit.c
index 83452fbbb168b,569815a84e95b..0000000000000
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@@ -134,20 -120,32 +125,43 @@@ static void llist_abort_desc(struct idx
  	spin_unlock(&ie->list_lock);
  
  	if (found)
- 		complete_desc(found, IDXD_COMPLETE_ABORT);
+ 		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
 +
 +	/*
- 	 * complete_desc() will return desc to allocator and the desc can be
- 	 * acquired by a different process and the desc->list can be modified.
- 	 * Delete desc from list so the list trasversing does not get corrupted
- 	 * by the other process.
++	 * completing the descriptor will return desc to allocator and
++	 * the desc can be acquired by a different process and the
++	 * desc->list can be modified.  Delete desc from list so the
++	 * list trasversing does not get corrupted by the other process.
 +	 */
 +	list_for_each_entry_safe(d, t, &flist, list) {
 +		list_del_init(&d->list);
- 		complete_desc(d, IDXD_COMPLETE_NORMAL);
++		idxd_dma_complete_txd(d, IDXD_COMPLETE_NORMAL, false);
 +	}
  }
  
+ /*
+  * ENQCMDS typically fail when the WQ is inactive or busy. On host submission, the driver
+  * has better control of number of descriptors being submitted to a shared wq by limiting
+  * the number of driver allocated descriptors to the wq size. However, when the swq is
+  * exported to a guest kernel, it may be shared with multiple guest kernels. This means
+  * the likelihood of getting busy returned on the swq when submitting goes significantly up.
+  * Having a tunable retry mechanism allows the driver to keep trying for a bit before giving
+  * up. The sysfs knob can be tuned by the system administrator.
+  */
+ int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc)
+ {
+ 	int rc, retries = 0;
+ 
+ 	do {
+ 		rc = enqcmds(portal, desc);
+ 		if (rc == 0)
+ 			break;
+ 		cpu_relax();
+ 	} while (retries++ < wq->enqcmds_retries);
+ 
+ 	return rc;
+ }
+ 
  int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
  {
  	struct idxd_device *idxd = wq->idxd;
