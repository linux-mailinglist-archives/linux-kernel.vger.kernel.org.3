Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2258378B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiG1Dbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiG1Dbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:31:31 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BBF852DD9;
        Wed, 27 Jul 2022 20:31:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B4A441E80D72;
        Thu, 28 Jul 2022 11:31:31 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ANGcd-Ku-b8R; Thu, 28 Jul 2022 11:31:29 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4D8BE1E80CF5;
        Thu, 28 Jul 2022 11:31:28 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH v2] drm/amdkfd: use time_is_before_jiffies(a + b) to replace "jiffies - a > b"
Date:   Thu, 28 Jul 2022 11:30:26 +0800
Message-Id: <20220728033026.15952-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220727025917.22477-1-yuzhe@nfschina.com>
References: <20220727025917.22477-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

time_is_before_jiffies deals with timer wrapping correctly.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index a9466d154395..34772fe74296 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -146,7 +146,7 @@ static void interrupt_wq(struct work_struct *work)
 	struct kfd_dev *dev = container_of(work, struct kfd_dev,
 						interrupt_work);
 	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
-	long start_jiffies = jiffies;
+	unsigned long start_jiffies = jiffies;
 
 	if (dev->device_info.ih_ring_entry_size > sizeof(ih_ring_entry)) {
 		dev_err_once(dev->adev->dev, "Ring entry too small\n");
@@ -156,7 +156,7 @@ static void interrupt_wq(struct work_struct *work)
 	while (dequeue_ih_ring_entry(dev, ih_ring_entry)) {
 		dev->device_info.event_interrupt_class->interrupt_wq(dev,
 								ih_ring_entry);
-		if (jiffies - start_jiffies > HZ) {
+		if (time_is_before_jiffies(start_jiffies + HZ)) {
 			/* If we spent more than a second processing signals,
 			 * reschedule the worker to avoid soft-lockup warnings
 			 */
-- 
2.11.0

