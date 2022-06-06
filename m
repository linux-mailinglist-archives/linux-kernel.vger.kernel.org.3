Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26553E860
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbiFFNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiFFNso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:48:44 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 911CB9EB52;
        Mon,  6 Jun 2022 06:48:42 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CB56B1E80D76;
        Mon,  6 Jun 2022 21:48:30 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bqrMqcGi6c96; Mon,  6 Jun 2022 21:48:28 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 96AA61E80D27;
        Mon,  6 Jun 2022 21:48:27 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pandruvada@lists.nfsmail.com,
        Srinivas <srinivas.pandruvada@intel.com>,
        Ye Xiang <xiang.ye@intel.com>, Even Xu <even.xu@intel.com>,
        Li Qiong <liqiong@nfschina.com>
Cc:     linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com, linux-input@vger.kernel.org
Subject: [PATCH 1/2] HID: intel-ish-hid: ipc: use time_before to replace "jiffies < a"
Date:   Mon,  6 Jun 2022 21:47:50 +0800
Message-Id: <20220606134750.20736-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

time_before deals with timer wrapping correctly.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 8ccb246b0114..15e14239af82 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -578,7 +578,7 @@ static void _ish_sync_fw_clock(struct ishtp_device *dev)
 	static unsigned long	prev_sync;
 	uint64_t	usec;
 
-	if (prev_sync && jiffies - prev_sync < 20 * HZ)
+	if (prev_sync && time_before(jiffies, prev_sync + 20 * HZ))
 		return;
 
 	prev_sync = jiffies;
-- 
2.25.1

