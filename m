Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDD53FCDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbiFGLFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbiFGLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24FC060D2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654599616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uBpnVqgcJOFWLuohPGx+SoAF7D/2Ubnp34dnbaPDjs=;
        b=PnMlfzlGnkgLsZsaBFallyH37LgmJM0OTOlk7T/UFhUnHwKYzpgiVgZSmtrp2jNNxOEJpk
        pfpvdxGgKhW+d3JbpfsO6+yG5nAFqjPa6Yz4uqZyoUgoZgVkD8bzx8XOHBwHcTZMJwGIZR
        uEp/7CEiFZFgzDGPNpcZZDIC6E6dISo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-3cDmdNlANbKZTPkErSmrAA-1; Tue, 07 Jun 2022 07:00:13 -0400
X-MC-Unique: 3cDmdNlANbKZTPkErSmrAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 764328027EE;
        Tue,  7 Jun 2022 11:00:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-113.pek2.redhat.com [10.72.13.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EB921121314;
        Tue,  7 Jun 2022 11:00:09 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, urezki@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/4] mm/vmalloc: remove the redundant boundary check
Date:   Tue,  7 Jun 2022 18:59:56 +0800
Message-Id: <20220607105958.382076-3-bhe@redhat.com>
In-Reply-To: <20220607105958.382076-1-bhe@redhat.com>
References: <20220607105958.382076-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function find_va_links(), when traversing the vmap_area tree, the
comparing to check if the passed in 'va' is above or below 'tmp_va'
is redundant, assuming both 'va' and 'tmp_va' has ->va_start <= ->va_end.

Here, to simplify the checking as code change.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f9d45aa90b7c..b711bf82fd5d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -874,11 +874,9 @@ find_va_links(struct vmap_area *va,
 		 * Trigger the BUG() if there are sides(left/right)
 		 * or full overlaps.
 		 */
-		if (va->va_start < tmp_va->va_end &&
-				va->va_end <= tmp_va->va_start)
+		if (va->va_end <= tmp_va->va_start)
 			link = &(*link)->rb_left;
-		else if (va->va_end > tmp_va->va_start &&
-				va->va_start >= tmp_va->va_end)
+		else if (va->va_start >= tmp_va->va_end)
 			link = &(*link)->rb_right;
 		else {
 			WARN(1, "vmalloc bug: 0x%lx-0x%lx overlaps with 0x%lx-0x%lx\n",
-- 
2.34.1

