Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76A747E0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347537AbhLWJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347552AbhLWJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640252738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S30AMcsWRzj5FbDwBVOYdvq2fsVpYDvDmuFN0e3Wc5g=;
        b=I2KrfkqbktHyGyvmwlzG71ckFdZGM4/JOlD1N01l8pnRogwSV98SSNlcJ7EyrifJmX61hi
        tWNQo+TULecC8hglXZLXY5PMiolxSgpK3QhMJ5BuwwAxrIPttMQeGtb7Mt5XUSxTrwiVGi
        kz+69aJzDPhSSvQBvtxIIY0d8BC+6WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-PHrXd3S8M7aSWUFEt_-BXA-1; Thu, 23 Dec 2021 04:45:35 -0500
X-MC-Unique: PHrXd3S8M7aSWUFEt_-BXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79E1D1853026;
        Thu, 23 Dec 2021 09:45:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-71.pek2.redhat.com [10.72.13.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083585F4E1;
        Thu, 23 Dec 2021 09:45:26 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, bhe@redhat.com, 42.hyeyoo@gmail.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com,
        x86@kernel.org, bp@alien8.de
Subject: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure on zone DMA if no managed pages
Date:   Thu, 23 Dec 2021 17:44:35 +0800
Message-Id: <20211223094435.248523-4-bhe@redhat.com>
In-Reply-To: <20211223094435.248523-1-bhe@redhat.com>
References: <20211223094435.248523-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump kernel of x86_64, page allocation failure is observed:

 kworker/u2:2: page allocation failure: order:0, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
 CPU: 0 PID: 55 Comm: kworker/u2:2 Not tainted 5.16.0-rc4+ #5
 Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
 Workqueue: events_unbound async_run_entry_fn
 Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x5e
  warn_alloc.cold+0x72/0xd6
  __alloc_pages_slowpath.constprop.0+0xc69/0xcd0
  __alloc_pages+0x1df/0x210
  new_slab+0x389/0x4d0
  ___slab_alloc+0x58f/0x770
  __slab_alloc.constprop.0+0x4a/0x80
  kmem_cache_alloc_trace+0x24b/0x2c0
  sr_probe+0x1db/0x620
  ......
  device_add+0x405/0x920
  ......
  __scsi_add_device+0xe5/0x100
  ata_scsi_scan_host+0x97/0x1d0
  async_run_entry_fn+0x30/0x130
  process_one_work+0x1e8/0x3c0
  worker_thread+0x50/0x3b0
  ? rescuer_thread+0x350/0x350
  kthread+0x16b/0x190
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x22/0x30
  </TASK>
 Mem-Info:
 ......

The above failure happened when calling kmalloc() to allocate buffer with
GFP_DMA. It requests to allocate slab page from DMA zone while no managed
pages at all in there.
 sr_probe()
 --> get_capabilities()
     --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);

Because in the current kernel, dma-kmalloc will be created as long as
CONFIG_ZONE_DMA is enabled. However, kdump kernel of x86_64 doesn't have
managed pages on DMA zone since commit 6f599d84231f ("x86/kdump: Always
reserve the low 1M when the crashkernel option is specified"). The failure
can be always reproduced.

For now, let's mute the warning of allocation failure if requesting pages
from DMA zone while no managed pages.

Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
Cc: stable@vger.kernel.org
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c7a0b5de2ff..843bc8e5550a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	va_list args;
 	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
 
-	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
+	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
+		(gfp_mask & __GFP_DMA) && !has_managed_dma())
 		return;
 
 	va_start(args, fmt);
-- 
2.26.3

