Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989E551CEE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiEFCI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiEFCIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:08:22 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4330633A5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:04:40 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 6 May
 2022 10:04:40 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 6 May
 2022 10:04:38 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Haowen Bai <baihaowen@meizu.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amdkfd: Return true/false (not 1/0) from bool functions
Date:   Fri, 6 May 2022 10:04:37 +0800
Message-ID: <1651802677-10154-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index c3919aaa76e6..1431f0961769 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -241,14 +241,14 @@ static bool event_interrupt_isr_v11(struct kfd_dev *dev,
 	if (/*!KFD_IRQ_IS_FENCE(client_id, source_id) &&*/
 	    (vmid < dev->vm_info.first_vmid_kfd ||
 	    vmid > dev->vm_info.last_vmid_kfd))
-		return 0;
+		return false;
 
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
 
 	if ((source_id == SOC15_INTSRC_CP_END_OF_PIPE) &&
 	    (context_id0 & AMDGPU_FENCE_MES_QUEUE_FLAG))
-		return 0;
+		return false;
 
 	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
 		 client_id, source_id, vmid, pasid);
@@ -258,7 +258,7 @@ static bool event_interrupt_isr_v11(struct kfd_dev *dev,
 
 	/* If there is no valid PASID, it's likely a bug */
 	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
-		return 0;
+		return false;
 
 	/* Interrupt types we care about: various signals and faults.
 	 * They will be forwarded to a work queue (see below).
-- 
2.7.4

