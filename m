Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED121583621
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiG1BC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG1BC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:02:26 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F435B796
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:02:24 -0700 (PDT)
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26S12G69019191;
        Thu, 28 Jul 2022 10:02:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Thu, 28 Jul 2022 10:02:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26S12Fsv019186
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Jul 2022 10:02:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8347375e-29fd-cd45-2b07-5504c9ddbd0c@I-love.SAKURA.ne.jp>
Date:   Thu, 28 Jul 2022 10:02:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 (REPOST)] rapidio/tsi721: Replace flush_scheduled_work()
 with flush_work().
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "struct tsi721_device" is per a device struct, I assume that
tsi721_remove() needs to wait for only two works associated with that
device. Therefore, wait for only these works using flush_work().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Use flush_work() instead of introducing a dedicated WQ.

Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
using a macro") for background.

 drivers/rapidio/devices/tsi721.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index b3134744fb55..0a42d6a2af24 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2941,7 +2941,8 @@ static void tsi721_remove(struct pci_dev *pdev)
 
 	tsi721_disable_ints(priv);
 	tsi721_free_irq(priv);
-	flush_scheduled_work();
+	flush_work(&priv->idb_work);
+	flush_work(&priv->pw_work);
 	rio_unregister_mport(&priv->mport);
 
 	tsi721_unregister_dma(priv);
-- 
2.18.4
