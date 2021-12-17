Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DA4786BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhLQJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234028AbhLQJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639732124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRJJuCkVZyOEZbsOujR3uAMVyJ2EnPCTOzk3f46x6zw=;
        b=e0c69PacukQpSlDb9PGlUbxEarx6CvNFc0WjqyqqPhNcviv4QLBog8Ytq9NTrERgsgLb/g
        hh36kDLob6iLTu2knNO9PtIzNgLAHaN7UFAjcqCd5VrwyRzvnCV6s0isrPX7HJcAcJhr0P
        gz9lEo5THbH3Yshez+AWw+7ulv1302Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-HmxlCgYLOFSU00JjNowJaA-1; Fri, 17 Dec 2021 04:08:41 -0500
X-MC-Unique: HmxlCgYLOFSU00JjNowJaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C57EE185303D;
        Fri, 17 Dec 2021 09:08:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0F5D7A483;
        Fri, 17 Dec 2021 09:08:35 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        hch@lst.de, cl@linux.com, bhe@redhat.com
Subject: [PATCH 2/2] dma-pool: allow user to disable atomic pool
Date:   Fri, 17 Dec 2021 17:08:27 +0800
Message-Id: <20211217090827.101938-3-bhe@redhat.com>
In-Reply-To: <20211217090827.101938-1-bhe@redhat.com>
References: <20211217090827.101938-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, three atomic memory pools are always created,
atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
specified in kernel command line. In fact, atomic pool is only
necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
which are needed on few ARCHes.

So change code to allow user to disable atomic pool by specifying
'coherent_pool=0'.

Meanwhile, update the relevant document in kernel-parameter.txt.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 kernel/dma/pool.c                               | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ec4d25e854a8..d7015309614b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -664,7 +664,8 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations. Otherwise the default size will be scaled
+			allocations. A value of 0 disables the three atomic
+			memory pool. Otherwise the default size will be scaled
 			with memory capacity, while clamped between 128K and
 			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5f84e6cdb78e..5a85804b5beb 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -21,7 +21,7 @@ static struct gen_pool *atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
 /* Size can be defined by the coherent_pool command line */
-static size_t atomic_pool_size;
+static unsigned long atomic_pool_size = -1;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
 static struct work_struct atomic_pool_work;
@@ -188,11 +188,14 @@ static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
 
+	if (!atomic_pool_size)
+		return 0;
+
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
-	if (!atomic_pool_size) {
+	if (atomic_pool_size == -1) {
 		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
 		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
 		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
-- 
2.26.0

