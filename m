Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535905017B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359495AbiDNPpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344538AbiDNP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39E43F55E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649948951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtGebAgbSA9lYbaI57i+Rxn48XdJu/DmmwsLsGsA5XE=;
        b=h4E1dznwiky0aO7TPmmVB8bA51he+XsSUqEVkHoZJD9DvrJxaQsMtySW3Ea5rSgePuEexQ
        IKTx90BRBzUr6TaaIx3OT4RBsL04qrpeeuCGl4JGmKXzG7SSBDnC55r9i+Py5XvhUwDZix
        cDBVl18s4bk2AohzrlZMc64anZmKUBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-C04J5NPBMgWBva7j5I52gA-1; Thu, 14 Apr 2022 11:09:08 -0400
X-MC-Unique: C04J5NPBMgWBva7j5I52gA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B015185A7BA;
        Thu, 14 Apr 2022 15:09:07 +0000 (UTC)
Received: from turbo.dinechin (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8B5FC07F51;
        Thu, 14 Apr 2022 15:09:04 +0000 (UTC)
From:   Christophe de Dinechin <dinechin@redhat.com>
To:     trivial@kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] virtio-pci: Use cpumask_available to fix compilation error
Date:   Thu, 14 Apr 2022 17:08:55 +0200
Message-Id: <20220414150855.2407137-4-dinechin@redhat.com>
In-Reply-To: <20220414150855.2407137-1-dinechin@redhat.com>
References: <20220414150855.2407137-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With GCC 12 and defconfig, we get the following error:

|   CC      drivers/virtio/virtio_pci_common.o
| drivers/virtio/virtio_pci_common.c: In function ‘vp_del_vqs’:
| drivers/virtio/virtio_pci_common.c:257:29: error: the comparison will
|  always evaluate as ‘true’ for the pointer operand in
|  ‘vp_dev->msix_affinity_masks + (sizetype)((long unsigned int)i * 8)’
|  must not be NULL [-Werror=address]
|   257 |                         if (vp_dev->msix_affinity_masks[i])
|       |                             ^~~~~~

This happens in the case where CONFIG_CPUMASK_OFFSTACK is not defined,
since we typedef cpumask_var_t as an array. The compiler is essentially
complaining that an array pointer cannot be NULL. This is not a very
important warning, but there is a function called cpumask_available that
seems to be defined just for that case, so the fix is easy.

Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d724f676608b..5c44a2f13c93 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -254,7 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 	if (vp_dev->msix_affinity_masks) {
 		for (i = 0; i < vp_dev->msix_vectors; i++)
-			if (vp_dev->msix_affinity_masks[i])
+			if (cpumask_available(vp_dev->msix_affinity_masks[i]))
 				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
 	}
 
-- 
2.35.1

