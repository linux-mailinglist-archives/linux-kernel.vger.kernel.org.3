Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F5558BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiFWXwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiFWXwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095C60C45
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jh14so636865plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guCk9+fmq044uYhThIHO4V934ZX2nYq8f94Emgz8GLM=;
        b=SUGUBrBFD30w/LODLPszAIWFJuyzy0h8yKc3XwFCVTjTpmAqYwYtNybMHRZ+ghsnt6
         oFA4URHrauTUulNAvk0QCM67P/nkIVpijwPqu2IdFqBueiiaMSAQRPwpv6i3r+6CFCg5
         plfgyMDGoKKdV7nNouU2+OWjZzQEV8GM9uqudK4CYp5wzLwGI5Uhh02fmt9opzL/hOuQ
         CHb2xiFPkQFAEUzJn7vUfUw/CjDKDoPj4aI+IY/+fKamjEPVD1pKTCLT8ivMhoUVoJNj
         HHF6gHkYy+hsHX3Jl6+v2yJCbU1tOMvmcYoLzEGZK1goInD5vx4s9WLc/yecqlQhAZqt
         O+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guCk9+fmq044uYhThIHO4V934ZX2nYq8f94Emgz8GLM=;
        b=p1EJjJitwRENom3Z6JKLfo0opFzzfQ1cvYrlr9DAsAWyFhDjs6QcpQL1uY7BnOwf1F
         THoqLC55z7sPrwAo+vRY7jAHTCRIdVuHE4mKUUIMgQP3ydFFZ1G+lwLtQgF5/n9Qp0NN
         UzUvSCfKga9+ppOVwTtks5gkfRYQb4yLE0vEqmfpnh9kXKwQAylsDh1uMlD/jcG1D1R3
         mOuzgcCohb+Lhw/ww1rLGqTsA9YG4k9meywVrsPA+qYUczBKDxccbo6D8AxxyMAMCt7j
         nHFFV8YKfFCZwUMIQSPubb+nFTIvk4EZ6sRipJU3NaGVnUUcHHnv6YvFj5HyOTPII+9+
         HS/Q==
X-Gm-Message-State: AJIora/bDabQFOxZThaRKsT149iibn+EGCDJtg2TonmdfKtVDqgaw+96
        2CcObBZuU0sgvRl/LhIyXw==
X-Google-Smtp-Source: AGRyM1vkLEUzFkCo4X+WONweFksRrl4oFKOzMvGjQX9HHb/bP3CF+/JL7adCPfO4KW6Vp/9kEJ5QLg==
X-Received: by 2002:a17:90b:1a8c:b0:1ed:1afb:7a73 with SMTP id ng12-20020a17090b1a8c00b001ed1afb7a73mr571077pjb.144.1656028351028;
        Thu, 23 Jun 2022 16:52:31 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:30 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic() in return_unused_surplus_pages()
Date:   Fri, 24 Jun 2022 08:51:45 +0900
Message-Id: <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

I found a weird state of 1GB hugepage pool, caused by the following
procedure:

  - run a process reserving all free 1GB hugepages,
  - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
    /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
  - kill the reserving process.

, then all the hugepages are free *and* surplus at the same time.

  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  3
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
  3
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
  0
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
  3

This state is resolved by reserving and allocating the pages then
freeing them again, so this seems not to result in serious problem.
But it's a little surprizing (shrinking pool suddenly fails).

This behavior is caused by hstate_is_gigantic() check in
return_unused_surplus_pages(). This was introduced so long ago in 2008
by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
it seems to me that this check is no longer unnecessary. Let's remove it.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/hugetlb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a57e1be41401..c538278170a2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2432,10 +2432,6 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	/* Cannot return gigantic pages currently */
-	if (hstate_is_gigantic(h))
-		goto out;
-
 	/*
 	 * Part (or even all) of the reservation could have been backed
 	 * by pre-allocated pages. Only free surplus pages.
-- 
2.25.1

