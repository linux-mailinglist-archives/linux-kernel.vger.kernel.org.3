Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDB5A5792
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH2X3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2X3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:29:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE28895D6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:29:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33ef3e5faeeso144778527b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=j0gZBmzE7Sfjkj3fK19vZEmRLHOzPYXYudfu9W22ef0=;
        b=bPb1auIgPo3/2J+mfMaXDZh871410KrBXJQKMytf0FgAgs/F+ya3O96wKhX6DhLaSr
         K1HrNyGRVh9mjnzpRRE0QVld7uhji6zvmw9kPtVcYWV0J1WLkwMUSgLgH/+idRKwDGMu
         WVZfVhWawN5TNKG4FdwdLTMjqIh43NhSGiCImZigj7H6xUm5tTtcvOz4e1r729TrUHci
         3PrqorGayOVeVtdIiLLIw0S+u17p+j3HreT1kmnW41h1WNTIfC4M/GAlP8teQTYTjhSC
         OkOvFiXEpkzFQw5ZcjmylMDAet9+rTxXgAUVysqhl1c/mnzag/9955zWGc3jwpIPF6av
         2BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=j0gZBmzE7Sfjkj3fK19vZEmRLHOzPYXYudfu9W22ef0=;
        b=mpJcQuhuivaAGLZnfmQXOhfyj3Lv+MrKOrsugzhNhSDVKaC5/LezirH+9FUhCmXdQO
         PawiYfvdYp61TYqsbUPjPiCdy80OSpZkLHmquQhljKC165DKij4TIBz6NNZE7RdBCtdh
         d8vMY530xTdGkLUdMoZQk4UDiUVSfxnSzsvkFau+22aV1CXsrdVUISTKyumME9UW1B9b
         SUORqrdZoSkvWIeMBlhW9HAZiyOwzl586YSlOStENGGbSfOvThg9/39dumP+QrM9rfiI
         Pn0Wh+ufVKdsJPP3QReEe9B7lR6PqyjwAIXU5fKtSAvzsuwc4rq1G9nYomCNpo6gtQnr
         Pmrg==
X-Gm-Message-State: ACgBeo2fVcnEeF9mREAteNVtWJwJuTJUjL7G3mRafDh5fVMk1DT8Gr7i
        Dsm6wYucl0ojzI4IUqBk/OnAOe/6XII=
X-Google-Smtp-Source: AA6agR57Qelr+wyNISYMYbU6D1FmO6PFtmVX7v1UCupeRr3ikw+DVEQhtxuiNuF/Y/wSno25spds6UFXDBk=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:3049:2153:3017:38c9])
 (user=yuzhao job=sendgmr) by 2002:a81:b04d:0:b0:340:b55c:9b1f with SMTP id
 x13-20020a81b04d000000b00340b55c9b1fmr10198796ywk.212.1661815777286; Mon, 29
 Aug 2022 16:29:37 -0700 (PDT)
Date:   Mon, 29 Aug 2022 17:29:34 -0600
Message-Id: <20220829232934.3277747-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH] Revert "swiotlb: panic if nslabs is too small"
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0bf28fc40d89b1a3e00d1b79473bad4e9ca20ad1.

Reasons:
  1. new panic()s shouldn't be added [1].
  2. It does no "cleanup" but breaks MIPS [2].

[1]: https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com/
[2]: https://lore.kernel.org/r/20220820012031.1285979-1-yuzhao@google.com/

Fixes: 0bf28fc40d89b ("swiotlb: panic if nslabs is too small")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 kernel/dma/swiotlb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..b3ede72eba5d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -325,10 +325,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
-	nslabs = default_nslabs;
-	if (nslabs < IO_TLB_MIN_SLABS)
-		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
-
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
@@ -341,8 +337,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb) {
-		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
-			__func__, bytes);
+		pr_warn("%s: failed to allocate tlb structure\n", __func__);
 		return;
 	}
 

base-commit: c40e8341e3b3bb27e3a65b06b5b454626234c4f0
-- 
2.37.2.672.g94769d06f0-goog

