Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF74547B79
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiFLSd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiFLSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C7BDD62
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655058792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m23vJo9geFa2iABpqywxyUvQVDxYGKFtt1RrWCUdrGU=;
        b=bKwkDu6dVdjQl0xEPI/oWQwjM2FQKSV5W+/taQ3xq/okP4zhupV1opqoawkl7zuIEhKqbo
        /eDHxoHoD9S7CH9Rj6NopoCiz1prEtVx34YqFejQ2U7WFT6lYzB4gUr7r9Wrch07uwc34P
        B4HH5/9Q6oiw2YAWu8iIZM9LIKb598I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-146-gWxgM3mfL6-igm75Sg-1; Sun, 12 Jun 2022 14:33:09 -0400
X-MC-Unique: 146-gWxgM3mfL6-igm75Sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 949781C04B41;
        Sun, 12 Jun 2022 18:33:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D54E404E4C3;
        Sun, 12 Jun 2022 18:33:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] mm/kmemleak: Avoid soft lockup in kmemleak_scan()
Date:   Sun, 12 Jun 2022 14:32:58 -0400
Message-Id: <20220612183301.981616-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 mm/kmemleak.c | 52 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

-- 
2.31.1

