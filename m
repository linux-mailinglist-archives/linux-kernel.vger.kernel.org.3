Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D168C58D2FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 06:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiHIEmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 00:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiHIEmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 00:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3E31D0C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 21:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660020149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BlkMUNnQfHAAc9Zb2R9TXNs9DLVuz8hzAnIjW1VF8OI=;
        b=SasCES8GCC4Qa2/Lmb81Q84ZTt8gCAOXAFydg+FFIfkIvLO2jX2zhRbQT9J6yNZx5NzHsk
        krfeha9XkfNHqZzlFNBQpgOWJysFMS2pooazHDOagTmQVGE3l9NlVhPK6+GviMDtaLI8mP
        0zfhxCbKEd04tb7kvpRMrK8aOe4FgVg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-kG-sxVehO-qafeikoZmd3Q-1; Tue, 09 Aug 2022 00:42:26 -0400
X-MC-Unique: kG-sxVehO-qafeikoZmd3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35FE73C01D9B;
        Tue,  9 Aug 2022 04:42:26 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.18.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4732026D4C;
        Tue,  9 Aug 2022 04:42:25 +0000 (UTC)
Subject: [PATCH] mm: re-allow pinning of zero pfns (again)
From:   Alex Williamson <alex.williamson@redhat.com>
To:     alex.sierra@amd.com, akpm@linux-foundation.org
Cc:     hch@lst.de, Felix.Kuehling@amd.com, apopple@nvidia.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Aug 2022 22:42:24 -0600
Message-ID: <166002010021.381133.11357879752637949308.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below referenced commit makes the same error as 1c563432588d ("mm: fix
is_pinnable_page against a cma page"), re-interpreting the logic to exclude
pinning of the zero page, which breaks device assignment with vfio.

Link: https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen
Fixes: f25cbb7a95a2 ("mm: add zone device coherent type memory support")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/mm.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 18e01474cf6b..772279ed7010 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1544,9 +1544,8 @@ static inline bool is_longterm_pinnable_page(struct page *page)
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
-	return !(is_device_coherent_page(page) ||
-		 is_zone_movable_page(page) ||
-		 is_zero_pfn(page_to_pfn(page)));
+	return !(is_device_coherent_page(page) || is_zone_movable_page(page)) ||
+	       is_zero_pfn(page_to_pfn(page));
 }
 #else
 static inline bool is_longterm_pinnable_page(struct page *page)


