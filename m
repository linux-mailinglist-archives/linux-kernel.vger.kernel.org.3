Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0D35A9009
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiIAHYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiIAHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C441257E0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662016890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NlolkOVzROxrmysLyLOweRyR0NiCeVgfH2ZsqTw7uYI=;
        b=F7Esdy/WcrEJ/RxHhD5yHprtYomEa3e6TZhgtm+ldYuoSvm6Hsap9UVFO7Drjq18t/ueNu
        HrrlAvidM8+N1JTgNsUxX5pBnk9y30RElHRw+RMVQUWTeuZAeJuZbOSrSYl0OofHlPoRCE
        kXNipslwm5T7jeenMeXvtWg8b+UR6Y8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-FLn326K1NgqpnOVgPbYwKg-1; Thu, 01 Sep 2022 03:21:25 -0400
X-MC-Unique: FLn326K1NgqpnOVgPbYwKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FC623802127;
        Thu,  1 Sep 2022 07:21:24 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 607891121314;
        Thu,  1 Sep 2022 07:21:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Date:   Thu,  1 Sep 2022 09:21:19 +0200
Message-Id: <20220901072119.37588-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
PMDs") didn't remove all details about the THP split requirements for
RCU GUP-fast.

IPI broeadcasts on THP split are no longer required.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jerome Marchand <jmarchan@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf487460..cfe71f422787 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  *
  * Another way to achieve this is to batch up page table containing pages
  * belonging to more than one mm_user, then rcu_sched a callback to free those
- * pages. Disabling interrupts will allow the fast_gup walker to both block
- * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
- * (which is a relatively rare event). The code below adopts this strategy.
+ * pages. Disabling interrupts will allow the fast_gup walker to block the
+ * rcu_sched callback.
  *
  * Before activating this code, please be aware that the following assumptions
  * are currently made:
-- 
2.37.1

