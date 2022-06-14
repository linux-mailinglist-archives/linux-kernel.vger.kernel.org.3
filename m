Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42854BD44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354852AbiFNWEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiFNWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA8C72FE6F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655244255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v9dxoAUFdvaKxjatlIHTfIiF/lhvDFU0vdCFYvfgo9U=;
        b=JbKT3w2NfDupaJito6m7UIsXrjnWTW8x9BqkqDcA5qDzbAc89sBLL/osl71Cjvs3bqQCG1
        zs9wQxvZ45LMhNLgq7hzFRHyBmgfjaeN+6gUeVadfdtUx6ivj0N9iQEdf6ktrOF7VHPLtT
        v6cg2Bx6AC2FlRrcSJIfdOvFl4uoBro=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-g4PcdfaWOASxu_lcFaIdqw-1; Tue, 14 Jun 2022 18:04:14 -0400
X-MC-Unique: g4PcdfaWOASxu_lcFaIdqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09BFF381079B;
        Tue, 14 Jun 2022 22:04:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0CC5492CA2;
        Tue, 14 Jun 2022 22:04:12 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/3] mm/kmemleak: Avoid soft lockup in kmemleak_scan()
Date:   Tue, 14 Jun 2022 18:03:56 -0400
Message-Id: <20220614220359.59282-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Update patch 3 to count the objects checked instead of being
    gray for determining when to do cond_resched(). This is more
    reliable.

There are 3 RCU-based object iteration loops in kmemleak_scan(). Because
of the need to take RCU read lock, we can't insert cond_resched() into
the loop like other parts of the function. As there can be millions of
objects to be scanned, it takes a while to iterate all of them. The
kmemleak functionality is usually enabled in a debug kernel which is
much slower than a non-debug kernel. With sufficient number of kmemleak
objects, the time to iterate them all may exceed 22s causing soft lockup.

  watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [kmemleak:625]

This patch series make changes to the 3 object iteration loops in
kmemleak_scan() to prevent them from causing soft lockup.

Waiman Long (3):
  mm/kmemleak: Use _irq lock/unlock variants in kmemleak_scan/_clear()
  mm/kmemleak: Skip unlikely objects in kmemleak_scan() without taking
    lock
  mm/kmemleak: Prevent soft lockup in first object iteration loop of
    kmemleak_scan()

 mm/kmemleak.c | 60 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 11 deletions(-)

-- 
2.31.1

