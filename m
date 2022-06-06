Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005D53E228
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiFFImD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiFFIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C079340DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MgDILZKDJLFM9v8vOajOt74G/rtOqju5l9xz3EQGok=;
        b=Ou5K0nqednGoAdfyfjzWX7YuGRc7ggCuwa2/g77oQiI80o6DH55+RzK/eEqIpBzz+0bfJY
        xcmKwdoOgQTdiz/NqfNXtIXd9bgET4loSj7mj2cbdncweBjf2OjRe7uib7ExQcpSk90VWo
        dZqxBgyOkMqOaQttsbZ7dbCN5Du3Aw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-c-oMQXzkOoSCQb1I3mozTw-1; Mon, 06 Jun 2022 04:39:29 -0400
X-MC-Unique: c-oMQXzkOoSCQb1I3mozTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4315085A5BC;
        Mon,  6 Jun 2022 08:39:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-14-4.pek2.redhat.com [10.72.14.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B68A1121314;
        Mon,  6 Jun 2022 08:39:25 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     npiggin@gmail.com, urezki@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/5] mm/vmalloc: remove the unnecessary type check
Date:   Mon,  6 Jun 2022 16:39:05 +0800
Message-Id: <20220606083909.363350-2-bhe@redhat.com>
In-Reply-To: <20220606083909.363350-1-bhe@redhat.com>
References: <20220606083909.363350-1-bhe@redhat.com>
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

In function adjust_va_to_fit_type(), it checks all values of passed
in fit type, including NOTHING_FIT in the else branch. In fact, it's
unnecessary to check NOTHING_FIT since the check has been done before
adjust_va_to_fit_type() is called in all call sites. So clean it up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmalloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 07db42455dd4..b7a138ab7b79 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1418,8 +1418,6 @@ adjust_va_to_fit_type(struct vmap_area *va,
 		 * Shrink this VA to remaining size.
 		 */
 		va->va_start = nva_start_addr + size;
-	} else {
-		return -1;
 	}
 
 	if (type != FL_FIT_TYPE) {
-- 
2.34.1

