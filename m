Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8AA4ADD19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380228AbiBHPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380052AbiBHPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:25:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AE6BC061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:25:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCD1811FB;
        Tue,  8 Feb 2022 07:25:33 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F43E3F73B;
        Tue,  8 Feb 2022 07:25:32 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     sudeep.holla@arm.com, mst@redhat.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 2/4] tools/virtio: Add missing spin_lock_init on virtio_test
Date:   Tue,  8 Feb 2022 15:25:18 +0000
Message-Id: <20220208152520.52983-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208152520.52983-1-cristian.marussi@arm.com>
References: <20220208152520.52983-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A missing spin_lock_init() call can cause the test to hang indefinitely on
spin_lock() at virtqueue creation time.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/virtio/virtio_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index d882075c097f..d9cb3d22d52f 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -133,6 +133,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->vdev.dev.driver = &dev->vdriver.driver;
 	dev->vdev.features = features;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
+	spin_lock_init(&dev->vdev.vqs_list_lock);
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-- 
2.17.1

