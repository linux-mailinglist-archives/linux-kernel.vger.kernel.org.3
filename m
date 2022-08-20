Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664BE59AFD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiHTTHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHTTH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:07:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D63F1DF
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85B84B80AAD
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 19:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08DBC433D6;
        Sat, 20 Aug 2022 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661022444;
        bh=stTxl3TjHABFzC0L3I/66L8wQuAor5Arb2kJ4m3gUtQ=;
        h=From:To:Cc:Subject:Date:From;
        b=p+qVmwUVcZnQ40lSXspYH2AZu1vZRygVjd/L95nfzcOvCJR5i1RplOHtTdqRNOiN0
         IqrJMB6tTQH1MIa6oOS+x17DwAjxHVY4a+emXFf7XnnTF5cIuZCN7FYsrrslZmL/XT
         VFYDFeguj6mafSdGFRWUeMzErosrz5e/u/0ncpgttyxzOaWiZNQlcBeBr38PHGe9XI
         RSQGxg+EkXHjXs1ZrfVEs4Kk+JOsmBVT8yk+kkHE+03MHuH4rCXpsI7f/jUIXYrRNT
         CQiVIklMswA8olR6lfhrnDhZI9rkv0rDZpJ0Gmr+ytiqpT3gECCPKA67d0guZ61kLJ
         jYFAcGpLpZXPQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm-unstable] kernel/sched/fair: include missed header file, memory-tiers.h
Date:   Sat, 20 Aug 2022 19:07:20 +0000
Message-Id: <20220820190720.248704-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f66f3c261487 ("mm/demotion: update node_is_toptier to work with
memory tiers") of the 'mm-unstable' tree moved the declaration of
'node_is_toptier()' from 'node.h' to 'memory-tiers.h' but didn't include
the header in a source file using the function, 'kernel/sched/fair.c'.
As a result, build fails as below:

    linux/kernel/sched/fair.c: In function ‘should_numa_migrate_memory’:
    linux/kernel/sched/fair.c:1571:7: error: implicit declaration of function ‘node_is_toptier’ [-Werror=implicit-function-declaration]
     1571 |      !node_is_toptier(src_nid)) {
          |       ^~~~~~~~~~~~~~~
    cc1: some warnings being treated as errors

This commit fixes the error by including the missed header file.

Fixes: f66f3c261487 ("mm/demotion: update node_is_toptier to work with memory tiers") on mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d642e9ff2829..0e3e08a093d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -40,6 +40,7 @@
 
 #include <linux/cpuidle.h>
 #include <linux/interrupt.h>
+#include <linux/memory-tiers.h>
 #include <linux/mempolicy.h>
 #include <linux/mutex_api.h>
 #include <linux/profile.h>
-- 
2.25.1

