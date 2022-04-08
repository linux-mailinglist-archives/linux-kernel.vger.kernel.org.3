Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE864F975A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiDHNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiDHNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:55:35 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D7E025
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:53:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649426008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W2r3hadHb2ghvLbnBdq0sszcrAONUNR+RmAPKjBEqZc=;
        b=tH3yGnWR+WLSgQRKZFS2/V39ZxZMnDGzUl+9U4g0C8evMnR09lKrasCEEX7riR+1QCZ/yw
        fpTZmaqUChLlJ2bEB3wCSZXf2uCKypfxcL4F5i6nYkNPvQV7ZfsGhCEQYN3Zp+ewt4hVlU
        wImQQPTnwyXiuvk+MUKhQJuATt59BH0=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()
Date:   Fri,  8 Apr 2022 22:53:20 +0900
Message-Id: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated v7 (https://lore.kernel.org/linux-mm/20220407112929.1344748-1-naoya.horiguchi@linux.dev/)
based on the comment from Miaohe Lin.  Now I have a few additional patches.
Any comments and suggestions are welcomed.

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (3):
      mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()
      mm/hwpoison: put page in already hwpoisoned case with MF_COUNT_INCREASED
      Revert "mm/memory-failure.c: fix race with changing page compound again"

 include/linux/hugetlb.h |   6 ++
 include/linux/mm.h      |   9 ++-
 include/ras/ras_event.h |   1 -
 mm/hugetlb.c            |  10 ++++
 mm/memory-failure.c     | 152 ++++++++++++++++++++++++++++++++----------------
 5 files changed, 126 insertions(+), 52 deletions(-)
