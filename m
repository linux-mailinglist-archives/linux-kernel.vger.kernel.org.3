Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421752CF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiESJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiESJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:19:34 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D745D655;
        Thu, 19 May 2022 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1652951973;
  x=1684487973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OxYs8AQ/Yf40t/h1rx2ef4PqcePFEJfDf4nYbKKVXi0=;
  b=JU/7KakKeLarzlor2/jJqZMAVqz4j9l5YAxY5dMpiP3rgEhWA6fYvpjT
   jSVbFrVC/dwNy/j6b1sK7WKTLxeRZL4A5RdsQ5Eocv87P+kyI8pxaZcZ/
   tG6+EZc6cimuAtEhXwO5fGNKq7ehbySqTjnbGeyi1u8sciC8NUBowKV2D
   zHBeWZRBSFfWXw9KojJGUL9Cg4rb6D3LrG+QidBeh2foRaKyeBvePp0jJ
   +iH3prZLaWE8/uiWy9R4nG1Cd8vrmfvsImJbOPzFVlb5uDomNMPpfF9Ih
   KcnOHK3h5uOFOs8LMsdXeYXUN3JDM9c//BIGBu9VXA9arvUOIJ3xrkbvp
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: trigger: sysfs: fix use-after-free on remove
Date:   Thu, 19 May 2022 11:19:25 +0200
Message-ID: <20220519091925.1053897-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the irq_work has completed before the trigger is freed.

 ==================================================================
 BUG: KASAN: use-after-free in irq_work_run_list
 Read of size 8 at addr 0000000064702248 by task python3/25

 Call Trace:
  irq_work_run_list
  irq_work_tick
  update_process_times
  tick_sched_handle
  tick_sched_timer
  __hrtimer_run_queues
  hrtimer_interrupt

 Allocated by task 25:
  kmem_cache_alloc_trace
  iio_sysfs_trig_add
  dev_attr_store
  sysfs_kf_write
  kernfs_fop_write_iter
  new_sync_write
  vfs_write
  ksys_write
  sys_write

 Freed by task 25:
  kfree
  iio_sysfs_trig_remove
  dev_attr_store
  sysfs_kf_write
  kernfs_fop_write_iter
  new_sync_write
  vfs_write
  ksys_write
  sys_write

 ==================================================================

Fixes: e64e7d5c8c86e ("iio:trigger:sysfs Move out of staging.")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/trigger/iio-trig-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 2a4b75897910..3d911c24b265 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -191,6 +191,7 @@ static int iio_sysfs_trigger_remove(int id)
 	}
 
 	iio_trigger_unregister(t->trig);
+	irq_work_sync(&t->work);
 	iio_trigger_free(t->trig);
 
 	list_del(&t->l);
-- 
2.34.1

