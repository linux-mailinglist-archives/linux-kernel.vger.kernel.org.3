Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C753468FBB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhLFDiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236429AbhLFDh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638761671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDEbARRsqM2o01c5H85NSuz9lyNx5JpTLejFQo2L414=;
        b=hNZ9Z4YsFfbZIGpoeoyzadO6lSL1PcOoF03Ab55uDRrfMm3HVEG1CPDKkyhHhevL2+k1HU
        WC33R+OoR5LoeCaFrvMhuq19VBfMW1BjOxf774NEzizaceuxzWjUjCdMQfN6DtOQ46PK+s
        W9zFCFcCIKgKvxS1E97TXAK3jaz1BHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-OIryR0B9O46NBJaoc2Ei1Q-1; Sun, 05 Dec 2021 22:34:30 -0500
X-MC-Unique: OIryR0B9O46NBJaoc2Ei1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA7B100CCC1;
        Mon,  6 Dec 2021 03:34:29 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 667C61B472;
        Mon,  6 Dec 2021 03:34:24 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, Rafael Aquini <aquini@redhat.com>
Subject: [RFC PATCH 1/2] include/linux/gfp.h: Do not allocate pages on a offlined node
Date:   Sun,  5 Dec 2021 22:33:37 -0500
Message-Id: <20211206033338.743270-2-npache@redhat.com>
In-Reply-To: <20211206033338.743270-1-npache@redhat.com>
References: <20211206033338.743270-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't allocate pages on a unavailable node. Add a check for this
in __alloc_pages_node and return NULL to avoid issues further down the
callchain.

Also update the VM_WARN_ON in __alloc_pages_node which could skip this
warn if the gfp_mask is not GFP_THISNODE.

Co-developed-by: Rafael Aquini <aquini@redhat.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/gfp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b976c4177299..e7e18f6d0d9d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -565,7 +565,10 @@ static inline struct page *
 __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
+	VM_WARN_ON(!node_online(nid));
+
+	if (!node_online(nid))
+		return NULL;
 
 	return __alloc_pages(gfp_mask, order, nid, NULL);
 }
-- 
2.33.1

