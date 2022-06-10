Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B5546FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347508AbiFJWfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiFJWfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FB6F391803
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654900526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=brhqSH0cfxiVMdkhaA/t1am/po1k847+vpjU5c9Z/Ic=;
        b=Dqgp7c2b6YoThDb7y22GLOY3oiRKaohzjNR+MMO2MPK/078dFnlVDuXI6l0aZ/q64Lc1cM
        GIZvfHoFGYxwo/RzTdwy9J5iSzDne5RCUobnBEM05PIX6VuwuAYZ0isOm2g3j9uz9FrxVy
        IL1LbG9X2GynvkMf8nf+IxJGjyvqMak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-ERtf0sUvPCO1L59yA4nI4Q-1; Fri, 10 Jun 2022 18:35:15 -0400
X-MC-Unique: ERtf0sUvPCO1L59yA4nI4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F32FE801755;
        Fri, 10 Jun 2022 22:35:14 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.35.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B37EC23DBF;
        Fri, 10 Jun 2022 22:35:14 +0000 (UTC)
Subject: [PATCH] mm: Re-allow pinning of zero pfns
From:   Alex Williamson <alex.williamson@redhat.com>
To:     akpm@linux-foundation.org, minchan@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, jhubbard@nvidia.com, joaodias@google.com,
        jgg@ziepe.ca, david@redhat.com
Date:   Fri, 10 Jun 2022 16:35:13 -0600
Message-ID: <165490039431.944052.12458624139225785964.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit referenced below subtly and inadvertently changed the logic
to disallow pinning of zero pfns.  This breaks device assignment with
vfio and potentially various other users of gup.  Exclude the zero page
test from the negation.

Fixes: 1c563432588d ("mm: fix is_pinnable_page against a cma page")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

At least I assume this was inadvertent...  If there's a better fix,
please run with it as I'm out of the office the 1st half of next
week and would like to see this fixed ASAP.  Thanks!

 include/linux/mm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..781fae17177d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1600,7 +1600,7 @@ static inline bool is_pinnable_page(struct page *page)
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
-	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
+	return !is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)


