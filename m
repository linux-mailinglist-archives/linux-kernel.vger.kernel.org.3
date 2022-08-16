Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3C595832
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiHPK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiHPK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:27:49 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE35B3ECF7;
        Tue, 16 Aug 2022 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660637313;
  x=1692173313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f15M4ROfi3aBFowmtyD/gpauYdh/AIN2C9cnaYaVUwA=;
  b=WjllbMNnQd0TGy5XvoMi3n/VRJtu6mMWPfVlwdzXItwExmof7uGFlum5
   j8GqXngWnKQ2XD6E+0WugoKJJl9NpS72gJFt3IuSYxTkNEdxVfIzM0uI0
   dOgaMkTEKKo2Irif+PBrJygMJK4u4Lv62U4wt457XwGx1An3afd217cAZ
   kTf5UJaCRsuOoqvKFnzYvWgbq0VJ5oJ2O9BwlMJoobDtYI5Hygu81Yydy
   430V2Kz2+N/IZNHF7RhPoV7h4E6ko7AHIbyUV0MYIl0bTR8nvFRWaDmv0
   ZD6G1QkdAtKdNyhepQEWa5ebHw1dN4U/Tdjit2s1FtX5GL0gRuvuhQ+CR
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: buffer: Silence lock nesting splat
Date:   Tue, 16 Aug 2022 10:08:28 +0200
Message-ID: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
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
lmp91000.  Since the locks are being taken on different IIO devices,
there is no actual deadlock, so add lock nesting annotation to silence
the spurious warning.

 ============================================
 WARNING: possible recursive locking detected
 6.0.0-rc1+ #10 Not tainted
 --------------------------------------------
 python3/23 is trying to acquire lock:
 0000000064c944c0 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers+0x62/0x180

 but task is already holding lock:
 00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&indio_dev->mlock);
   lock(&indio_dev->mlock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 5 locks held by python3/23:
  #0: 00000000636b5420 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x67/0x100
  #1: 0000000064c19280 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x13a/0x270
  #2: 0000000064c3d9e0 (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x149/0x270
  #3: 00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
  #4: 0000000064c945c8 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers+0x4f/0x180

 stack backtrace:
 CPU: 0 PID: 23 Comm: python3 Not tainted 6.0.0-rc1+ #10
 Call Trace:
  dump_stack+0x1a/0x1c
  __lock_acquire.cold+0x407/0x42d
  lock_acquire+0x1ed/0x310
  __mutex_lock+0x72/0xde0
  mutex_lock_nested+0x1d/0x20
  iio_update_buffers+0x62/0x180
  iio_channel_start_all_cb+0x1c/0x20 [industrialio_buffer_cb]
  lmp91000_buffer_postenable+0x1b/0x20 [lmp91000]
  __iio_update_buffers+0x50b/0xd80
  enable_store+0x81/0x100
  dev_attr_store+0xf/0x20
  sysfs_kf_write+0x4c/0x70
  kernfs_fop_write_iter+0x179/0x270
  new_sync_write+0x99/0x120
  vfs_write+0x2c1/0x470
  ksys_write+0x67/0x100
  sys_write+0x10/0x20

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index acc2b6c05d57..27868ed092d0 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1255,7 +1255,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock_nested(&indio_dev->mlock, SINGLE_DEPTH_NESTING);
 
 	if (insert_buffer && iio_buffer_is_active(insert_buffer))
 		insert_buffer = NULL;
-- 
2.34.1

