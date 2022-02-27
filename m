Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDE14C5FED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 00:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiB0Xnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 18:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0Xnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 18:43:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5EE43EC2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 15:43:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B1B3212BB;
        Sun, 27 Feb 2022 23:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646005386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CuV6bZm6+Tvp4Pdji59uVuBLNwa5+Q5hK3f1bpYPxOg=;
        b=fBJrOfJ3EE9mBbUoIvXDE4Tk+DSSVjbjcPZ+uzH41Dcqcdlbmt0DOa9YnIt3v+Q6d9jtIE
        UrBlgginZP6QBNKmeYLVR469Y9xO63Er3vb49RgLfJaS/T6geiDS9Ro8E0343LX+jElrn6
        NT7kQTQeTdehi1q7RnisKmSg6AB2TKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646005386;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CuV6bZm6+Tvp4Pdji59uVuBLNwa5+Q5hK3f1bpYPxOg=;
        b=k7itSJ4L86rBKq33/Q+EPVa4Rrg8O83+X9uEuc0pdG2LBFe/xJhiSq9CDi2s3yM/o3lyWo
        /KfD0PAGky7hMiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFC4912FC5;
        Sun, 27 Feb 2022 23:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ze4gIIkMHGLrKQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Sun, 27 Feb 2022 23:43:05 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: trigger disk activity LED
Date:   Sun, 27 Feb 2022 20:42:58 -0300
Message-Id: <20220227234258.24619-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.34.1
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

Users can enable an LED to indicate I/O activity on NVMe PCIe devices:

  # echo "disk-activity" > /sys/class/leds/<led>/trigger

for the composite activity, or disk-{read,write} for individual
activities/LEDs.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..3e49d5980beb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1037,6 +1038,8 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
+
+	ledtrig_disk_activity(req_op(req) == REQ_OP_WRITE);
 }
 
 static void nvme_pci_complete_rq(struct request *req)
-- 
2.34.1

