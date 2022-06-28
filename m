Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D826B55CBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbiF1Iev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiF1Ieq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C7DB2DAA5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656405284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=G3OVg0/+USZTuncktGnY+Rt80pNYe8Z8u40tYvJiacA=;
        b=TRoIhQ1TDKDKdCDULA9LvSeRE4ETKYl0V/NYKSmqAOgERsBmkoskPBuR9QlD5bAtZg6rIx
        GEvdATCSQB+PowlRFcfVqJqHzpWFrEA6x7SnIIXmtkgBsAz8RUDM094XUp3yl/o29na+y3
        NhtrkqkaJjW3JzAGJvxxpUs41+agfkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-1qg0e1ArNbq317LgoOjj4g-1; Tue, 28 Jun 2022 04:34:38 -0400
X-MC-Unique: 1qg0e1ArNbq317LgoOjj4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1942A8FE6CE;
        Tue, 28 Jun 2022 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-87.pek2.redhat.com [10.72.13.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40D20C15D40;
        Tue, 28 Jun 2022 08:34:32 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PATCH V3 1/2] virtio_pmem: initialize provider_data through nd_region_desc
Date:   Tue, 28 Jun 2022 16:34:29 +0800
Message-Id: <20220628083430.61856-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to initialize the provider_data manually after
nvdimm_pemm_region_create(). This seems to be racy if the flush is
issued before the initialization of provider_data[1]. Fixing this by
initializing the provider_data through nd_region_desc to make sure the
provider_data is ready after the pmem is created.

[1]:

[   80.152281] nd_pmem namespace0.0: unable to guarantee persistence of writes
[   92.393956] BUG: kernel NULL pointer dereference, address: 0000000000000318
[   92.394551] #PF: supervisor read access in kernel mode
[   92.394955] #PF: error_code(0x0000) - not-present page
[   92.395365] PGD 0 P4D 0
[   92.395566] Oops: 0000 [#1] PREEMPT SMP PTI
[   92.395867] CPU: 2 PID: 506 Comm: mkfs.ext4 Not tainted 5.19.0-rc1+ #453
[   92.396365] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   92.397178] RIP: 0010:virtio_pmem_flush+0x2f/0x1f0
[   92.397521] Code: 55 41 54 55 53 48 81 ec a0 00 00 00 65 48 8b 04
25 28 00 00 00 48 89 84 24 98 00 00 00 31 c0 48 8b 87 78 03 00 00 48
89 04 24 <48> 8b 98 18 03 00 00 e8 85 bf 6b 00 ba 58 00 00 00 be c0 0c
00 00
[   92.398982] RSP: 0018:ffff9a7380aefc88 EFLAGS: 00010246
[   92.399349] RAX: 0000000000000000 RBX: ffff8e77c3f86f00 RCX: 0000000000000000
[   92.399833] RDX: ffffffffad4ea720 RSI: ffff8e77c41e39c0 RDI: ffff8e77c41c5c00
[   92.400388] RBP: ffff8e77c41e39c0 R08: ffff8e77c19f0600 R09: 0000000000000000
[   92.400874] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e77c0814e28
[   92.401364] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8e77c41e39c0
[   92.401849] FS:  00007f3cd75b2780(0000) GS:ffff8e7937d00000(0000)
knlGS:0000000000000000
[   92.402423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.402821] CR2: 0000000000000318 CR3: 0000000103c80002 CR4: 0000000000370ee0
[   92.403307] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   92.403793] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   92.404278] Call Trace:
[   92.404481]  <TASK>
[   92.404654]  ? mempool_alloc+0x5d/0x160
[   92.404939]  ? terminate_walk+0x5f/0xf0
[   92.405226]  ? bio_alloc_bioset+0xbb/0x3f0
[   92.405525]  async_pmem_flush+0x17/0x80
[   92.405806]  nvdimm_flush+0x11/0x30
[   92.406067]  pmem_submit_bio+0x1e9/0x200
[   92.406354]  __submit_bio+0x80/0x120
[   92.406621]  submit_bio_noacct_nocheck+0xdc/0x2a0
[   92.406958]  submit_bio_wait+0x4e/0x80
[   92.407234]  blkdev_issue_flush+0x31/0x50
[   92.407526]  ? punt_bios_to_rescuer+0x230/0x230
[   92.407852]  blkdev_fsync+0x1e/0x30
[   92.408112]  do_fsync+0x33/0x70
[   92.408354]  __x64_sys_fsync+0xb/0x10
[   92.408625]  do_syscall_64+0x43/0x90
[   92.408895]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   92.409257] RIP: 0033:0x7f3cd76c6c44

Fixes 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Add calltrace to explain the issue in detail
---
 drivers/nvdimm/virtio_pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 995b6cdc67ed..48f8327d0431 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -81,6 +81,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	ndr_desc.res = &res;
 	ndr_desc.numa_node = nid;
 	ndr_desc.flush = async_pmem_flush;
+	ndr_desc.provider_data = vdev;
 	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
 	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
 	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
@@ -89,7 +90,6 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		err = -ENXIO;
 		goto out_nd;
 	}
-	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
 	return 0;
 out_nd:
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
-- 
2.25.1

