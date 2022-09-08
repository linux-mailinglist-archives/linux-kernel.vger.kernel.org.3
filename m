Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6235B1EEB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiIHN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiIHN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:28:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DF5F7D2;
        Thu,  8 Sep 2022 06:28:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6298D336C8;
        Thu,  8 Sep 2022 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662643682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RT1Gz4wymCZ1ojdUPXrz4U4ocZ5NWI6wjKo7CZqGIrs=;
        b=QKUuRXljHkhnThKconKWnu3w89IVetA1k2oIs8aEZNSkSrE47Qt+G40lJI/ROZGIuztw0G
        BsuiQaOKwP46XCQq7HZzidmXeKu6UNHJGRzxGxnQN0Wn2nAO6e5FV92+hr3aByTxbNs/f3
        58gB4cpqaDHx6G7Cdjp6kE+IPoOEsf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662643682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RT1Gz4wymCZ1ojdUPXrz4U4ocZ5NWI6wjKo7CZqGIrs=;
        b=HWfoRL2qVTqZOlpai0zE2nEuChRMg5C97vQGZBO585Vk4z7n92dXDj6tNHDmkO7YL5jskU
        qbNBYfEZMx7+gXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E36A1322C;
        Thu,  8 Sep 2022 13:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OkmNDuLtGWMxPQAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 08 Sep 2022 13:28:02 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hyunwoo Kim <imv4bel@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb-core: Fix UAF due to refcount races at releasing
Date:   Thu,  8 Sep 2022 15:27:54 +0200
Message-Id: <20220908132754.30532-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dvb-core tries to sync the releases of opened files at
dvb_dmxdev_release() with two refcounts: dvbdev->users and
dvr_dvbdev->users.  A problem is present in those two syncs: when yet
another dvb_demux_open() is called during those sync waits,
dvb_demux_open() continues to process even if the device is being
closed.  This includes the increment of the former refcount, resulting
in the leftover refcount after the sync of the latter refcount at
dvb_dmxdev_release().  It ends up with use-after-free, since the
function believes that all usages were gone and releases the
resources.

This patch addresses the problem by adding the check of dmxdev->exit
flag at dvb_demux_open(), just like dvb_dvr_open() already does.  With
the exit flag check, the second call of dvb_demux_open() fails, hence
the further corruption can be avoided.

Also for avoiding the races of the dmxdev->exit flag reference, this
patch serializes the dmxdev->exit set up and the sync waits with the
dmxdev->mutex lock at dvb_dmxdev_release().  Without the mutex lock,
dvb_demux_open() (or dvb_dvr_open()) may run concurrently with
dvb_dmxdev_release(), which allows to skip the exit flag check and
continue the open process that is being closed.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/dvb-core/dmxdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index f6ee678107d3..9ce5f010de3f 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -790,6 +790,11 @@ static int dvb_demux_open(struct inode *inode, struct file *file)
 	if (mutex_lock_interruptible(&dmxdev->mutex))
 		return -ERESTARTSYS;
 
+	if (dmxdev->exit) {
+		mutex_unlock(&dmxdev->mutex);
+		return -ENODEV;
+	}
+
 	for (i = 0; i < dmxdev->filternum; i++)
 		if (dmxdev->filter[i].state == DMXDEV_STATE_FREE)
 			break;
@@ -1448,7 +1453,10 @@ EXPORT_SYMBOL(dvb_dmxdev_init);
 
 void dvb_dmxdev_release(struct dmxdev *dmxdev)
 {
+	mutex_lock(&dmxdev->mutex);
 	dmxdev->exit = 1;
+	mutex_unlock(&dmxdev->mutex);
+
 	if (dmxdev->dvbdev->users > 1) {
 		wait_event(dmxdev->dvbdev->wait_queue,
 				dmxdev->dvbdev->users == 1);
-- 
2.35.3

