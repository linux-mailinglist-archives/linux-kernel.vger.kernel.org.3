Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01364472C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhLMM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:27:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233141AbhLMM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639398463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=22K9MUJhLkdM2hxzj+IO1PvAug0Wxhex9m9iJdE13FM=;
        b=a1kQJK+FWc8jFZfHgHfL73R8Xqkvvp7Rc2GJQsQuBzC3PrtvAz1CaXiULk8v+rKfsT/cec
        6N8F/LYP8s0di/og4DXutQ4gMDzfwhSeVqshzK956TbqhIuf+nlIiB2gXMx2kcH8Xk7SGo
        nMTzOuo0npaa2ApkBgxoNuUbTCHlASs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-0cwds2UPNM2AojxepPYT1w-1; Mon, 13 Dec 2021 07:27:40 -0500
X-MC-Unique: 0cwds2UPNM2AojxepPYT1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A906D10144E3;
        Mon, 13 Dec 2021 12:27:38 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD40777F29;
        Mon, 13 Dec 2021 12:27:35 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, bhe@redhat.com
Subject: [PATCH v3 1/5] docs: kernel-parameters: Update to reflect the current default size of atomic pool
Date:   Mon, 13 Dec 2021 20:27:08 +0800
Message-Id: <20211213122712.23805-2-bhe@redhat.com>
In-Reply-To: <20211213122712.23805-1-bhe@redhat.com>
References: <20211213122712.23805-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
size with memory capacity"), the default size of atomic pool has been
changed to take by scaling with system memory capacity. So update the
document in kerenl-parameter.txt accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d4..ec4d25e854a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -664,7 +664,9 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations, by default set to 256K.
+			allocations. Otherwise the default size will be scaled
+			with memory capacity, while clamped between 128K and
+			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
-- 
2.17.2

