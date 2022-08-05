Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05058A9DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbiHELDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiHELDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 989BB1DA68
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659697417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=axbvuGfzRKP5qtlYak3e27rTAxoNG/HGZ2Avx7lCAAo=;
        b=SdH3JJgzqjnUOXfUxCTBGBTJc0Nn6C/g1sj9rU8NlfIRwjjLeSbB011zwtoU7/CB698FWl
        N0umDpvBh2idmpbov1btu+lOh8YtIbTCvtKeozOJ0fg4FA0Yqbxhz5JH3trOwWsEWVN9/C
        q0e5LYjX2R262evH68ko6ANUtfNFypI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-Xc_IahtxMmGRBwMFKpIk1A-1; Fri, 05 Aug 2022 07:03:34 -0400
X-MC-Unique: Xc_IahtxMmGRBwMFKpIk1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2EB1101A54E;
        Fri,  5 Aug 2022 11:03:33 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14A6440C1288;
        Fri,  5 Aug 2022 11:03:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v1 0/2] mm/hugetlb: fix write-fault handling for shared mappings
Date:   Fri,  5 Aug 2022 13:03:27 +0200
Message-Id: <20220805110329.80540-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I observed that hugetlb does not support/expect write-faults in shared
mappings that would have to map the R/O-mapped page writable -- and I
found one case where we could currently get such faults and would
erroneously map an anon page into a shared mapping, by triggering
clear_refs to clear soft-dirty tracking at the wrong point in time on a
process.

I propose to backport the fix to stable trees, as the fix for write-notify
should be straight forward.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

David Hildenbrand (2):
  mm/hugetlb: fix hugetlb not supporting write-notify
  mm/hugetlb: support write-faults in shared mappings

 mm/hugetlb.c | 21 ++++++++++++++-------
 mm/mmap.c    |  7 +++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.35.3

