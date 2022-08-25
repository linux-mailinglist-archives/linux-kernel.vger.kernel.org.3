Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519755A1736
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiHYQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243197AbiHYQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A63BFA9D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661446029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UAAidR6I/yg1Bp+qCE+8MWMgwSzA8AbWWpn7RN6psAA=;
        b=MN7EvOMrGojfJC9ag+YKHc0FSf46n5SnY3njfidKgz67H3k2VAid55JMyfgdeopvL7rwcY
        XHJweAbsoFqApkD3lcsA/+uxSvK94E/whpb2cNIDOrFEvU7il9EJ2x/Ce/8GHrotbYNFpN
        ueDt8hf51bCemQAq4eH5I0ElnHpNGWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-PQYNI7mVO2OSnKqtZZJPGw-1; Thu, 25 Aug 2022 12:47:04 -0400
X-MC-Unique: PQYNI7mVO2OSnKqtZZJPGw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8BB3185A7B2;
        Thu, 25 Aug 2022 16:47:03 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E90F492C3B;
        Thu, 25 Aug 2022 16:47:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 0/3] mm: minor cleanups around NUMA hinting
Date:   Thu, 25 Aug 2022 18:46:56 +0200
Message-Id: <20220825164659.89824-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Working on some GUP cleanups (e.g., getting rid of some FOLL_ flags) and
preparing for other GUP changes (getting rid of FOLL_FORCE|FOLL_WRITE for
for taking a R/O longterm pin), this is something I can easily send out
independently.

Get rid of FOLL_NUMA, allow FOLL_FORCE access to PROT_NONE mapped pages
in GUP-fast, and fixup some documentation around NUMA hinting.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Peter Xu <peterx@redhat.com>

David Hildenbrand (3):
  mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()
  mm/gup: use gup_can_follow_protnone() also in GUP-fast
  mm: fixup documentation regarding pte_numa() and PROT_NUMA

 include/linux/mm.h       | 16 +++++++++++++++-
 include/linux/mm_types.h | 12 ++++++------
 mm/gup.c                 | 26 +++++---------------------
 mm/huge_memory.c         |  2 +-
 4 files changed, 27 insertions(+), 29 deletions(-)

-- 
2.37.1

