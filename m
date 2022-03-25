Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1C4E7923
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376420AbiCYQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356626AbiCYQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BF9E3B038
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648226682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=645Y/OtWrXfu94ghKzgX/CYbJeHjL6KM1tOHVX36Llw=;
        b=gqi31fETvZTVfob8BwFHWktM7Dasp8+2Zwwmp6gz5uIGcPgUNJIc1QcXiP47iHABycu5pT
        3Eer5KeCFn4nIBZMpZ7ejaUbl9Ot307TqlwSVY3wh2N5904Om2fwMoCsUcjLQrLZZxByYD
        N3XAnZ8kLTXtmzyjy0gcyD3jJpBRyhU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-HScAVXZTN_-2Y2yNBxpRZg-1; Fri, 25 Mar 2022 12:44:41 -0400
X-MC-Unique: HScAVXZTN_-2Y2yNBxpRZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34372280D417;
        Fri, 25 Mar 2022 16:44:40 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.33.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33E5640CF8EC;
        Fri, 25 Mar 2022 16:44:39 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Charan Teja Reddy <charante@codeaurora.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/sysctl: document page_lock_unfairness
Date:   Fri, 25 Mar 2022 12:44:37 -0400
Message-Id: <20220325164437.120246-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5ef64cc8987a ("mm: allow a controlled amount of unfairness in the page lock")
introduced a new systctl but no accompanying documentation.

Add a simple entry to the documentation.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f4804ce37c58..747e325ebcd0 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -62,6 +62,7 @@ Currently, these files are in /proc/sys/vm:
 - overcommit_memory
 - overcommit_ratio
 - page-cluster
+- page_lock_unfairness
 - panic_on_oom
 - percpu_pagelist_high_fraction
 - stat_interval
@@ -754,6 +755,14 @@ extra faults and I/O delays for following faults if they would have been part of
 that consecutive pages readahead would have brought in.
 
 
+page_lock_unfairness
+====================
+
+This value determines the number of times that the page lock can be
+stolen from under a waiter. After the lock is stolen the number of times
+specified in this file (default is 5), the "fair lock handoff" semantics
+will apply, and the waiter will only be awakened if the lock can be taken.
+
 panic_on_oom
 ============
 
-- 
2.27.0

