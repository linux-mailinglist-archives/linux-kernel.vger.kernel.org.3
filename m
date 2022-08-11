Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7496158FAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiHKKep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiHKKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0700C8D3D8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660214081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=an3p2vRBCNhdQAftf25xhynVjMF4AB0RUtp1WMhr2t0=;
        b=PeC88H/wOpXdnx4enEl96WsEucHeCCVqW8bgZo8SWdg6ufxKtfymRAFE/x5AL4POiy2GG/
        FxssNjKnyF6ouonDHT3mpn2AwrcKtC77ud8awHm+uShhcpcNbZ2Ys5VtdUBpfUjhgf9o/L
        v0rSuK25AkanR099YYASgTYyUHJPXlA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-plB18okxNPi5H03wVO9k6g-1; Thu, 11 Aug 2022 06:34:38 -0400
X-MC-Unique: plB18okxNPi5H03wVO9k6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B67F22919EA7;
        Thu, 11 Aug 2022 10:34:37 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEA42492C3B;
        Thu, 11 Aug 2022 10:34:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/2] mm/hugetlb: fix write-fault handling for shared mappings
Date:   Thu, 11 Aug 2022 12:34:33 +0200
Message-Id: <20220811103435.188481-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I observed that hugetlb does not support/expect write-faults in shared
mappings that would have to map the R/O-mapped page writable -- and I
found two case where we could currently get such faults and would
erroneously map an anon page into a shared mapping.

Reproducers part of the patches.

I propose to backport both fixes to stable trees. The first fix needs
a small adjustment.

v1 -> v2:
- "mm/hugetlb: fix hugetlb not supporting softdirty tracking"
-> Restrict to softdirty tracking
- "mm/hugetlb: support write-faults in shared mappings"
-> Add reproducer and adjust description
-> Move VM_WRITE sanity check out from MAYSHARE handling

David Hildenbrand (2):
  mm/hugetlb: fix hugetlb not supporting softdirty tracking
  mm/hugetlb: support write-faults in shared mappings

 mm/hugetlb.c | 26 +++++++++++++++++++-------
 mm/mmap.c    |  7 +++++--
 2 files changed, 24 insertions(+), 9 deletions(-)


base-commit: ffcf9c5700e49c0aee42dcba9a12ba21338e8136
-- 
2.35.3

