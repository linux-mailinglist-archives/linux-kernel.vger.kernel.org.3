Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495F5A45E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiH2JSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH2JSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:18:47 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FD5AA13;
        Mon, 29 Aug 2022 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661764726;
  x=1693300726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HrikD+LuR2sVPUHOU5CUMyrG4nJVEC9Rl5WE5VrgimU=;
  b=kPFnjXHdA5RpRZpFuC98vG+v9UqdVIVudmi92ozMpQhpBAfTYdVpyL6Y
   7VP8BvNQAVlUlxdRWM85DpcG8RJIrhtEb0YNUmKHSpC+28CpaneRueVLM
   HRmNDzs2I/LtPxJ2PAY823xjcuJg4zfzZYy3kiNz4MEPs/EjHyZKtdckV
   wlvTmCOABmDUqIGdTEUIc1HLj+38CtjV3pEfJoTcktMXeRHrt8v+4MfKR
   74yDFs87CSRX9kCmuTZYnhPeqPHePJzyUGh/eTEbBr1XQflL1gKB7N2rx
   RYGZ3Ykngf8j7ppYdVKmwb673RZjYV36ov7e3zGPqTHjmTLB8k5CXegef
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <kernel@axis.com>, <andy.shevchenko@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <mranostay@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: Use per-device lockdep class for mlock
Date:   Mon, 29 Aug 2022 11:18:40 +0200
Message-ID: <20220829091840.2791846-1-vincent.whitchurch@axis.com>
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

If an IIO driver uses callbacks from another IIO driver and calls
iio_channel_start_all_cb() from one of its buffer setup ops, then
lockdep complains due to the lock nesting, as in the below example with
lmp91000.

Since the locks are being taken on different IIO devices, there is no
actual deadlock.  Fix the warning by telling lockdep to use a different
class for each iio_device.

 ============================================
 WARNING: possible recursive locking detected
 --------------------------------------------
 python3/23 is trying to acquire lock:
 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers

 but task is already holding lock:
 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&indio_dev->mlock);
   lock(&indio_dev->mlock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 5 locks held by python3/23:
  #0: (sb_writers#5){.+.+}-{0:0}, at: ksys_write
  #1: (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter
  #2: (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter
  #3: (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store
  #4: (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers

 Call Trace:
  __mutex_lock
  iio_update_buffers
  iio_channel_start_all_cb
  lmp91000_buffer_postenable
  __iio_update_buffers
  enable_store

Fixes: 67e17300dc1d76 ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2:
    - Use a different lockdep class for each iio_device, instead of using
      mutex_lock_nested.
    - Add fixes tag pointing to first IIO driver which used this API.
    - Trim call stack in commit message.

 drivers/iio/industrialio-core.c | 5 +++++
 include/linux/iio/iio-opaque.h  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0f4dbda3b9d3..921d8e8643a2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1621,6 +1621,8 @@ static void iio_dev_release(struct device *device)
 
 	iio_device_detach_buffers(indio_dev);
 
+	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
+
 	ida_free(&iio_ida, iio_dev_opaque->id);
 	kfree(iio_dev_opaque);
 }
@@ -1680,6 +1682,9 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
+	lockdep_register_key(&iio_dev_opaque->mlock_key);
+	lockdep_set_class(&indio_dev->mlock, &iio_dev_opaque->mlock_key);
+
 	return indio_dev;
 }
 EXPORT_SYMBOL(iio_device_alloc);
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 6b3586b3f952..d1f8b30a7c8b 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -11,6 +11,7 @@
  *				checked by device drivers but should be considered
  *				read-only as this is a core internal bit
  * @driver_module:		used to make it harder to undercut users
+ * @mlock_key:			lockdep class for iio_dev lock
  * @info_exist_lock:		lock to prevent use during removal
  * @trig_readonly:		mark the current trigger immutable
  * @event_interface:		event chrdevs associated with interrupt lines
@@ -42,6 +43,7 @@ struct iio_dev_opaque {
 	int				currentmode;
 	int				id;
 	struct module			*driver_module;
+	struct lock_class_key		mlock_key;
 	struct mutex			info_exist_lock;
 	bool				trig_readonly;
 	struct iio_event_interface	*event_interface;
-- 
2.34.1

