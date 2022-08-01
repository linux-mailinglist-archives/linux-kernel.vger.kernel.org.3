Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6105865F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiHAIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHAIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4AE1DA6A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 197F860F62
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04576C433D6;
        Mon,  1 Aug 2022 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659341074;
        bh=56n+0m+xaHkhO9EercwLYHh4JA36EIdVcoYGgta05LM=;
        h=From:To:Cc:Subject:Date:From;
        b=PBTOQQmjAlS/LOaIiG9gZDpZNG456lN6JjSjXbHBgemcsUCZlcon3FWS3cRznwonl
         jwI8f1YENB0df5Ks3YrRDkO3mzP0TGnYfumoxMS29SzSgh16Pg9LsCeNl1HAjMt0q+
         0qV2CSWGls94Q3xgUU25TVJpf8nD/pmTYrGZrqA2Wfqfewf3CKPF+7yG9jvEgyWse2
         aheSEixbfrrXyCsETH4ojUN1bWsAsnI+hH/YFLGQ69bdvPAE7dXhVoOc22SZXPHHY7
         NrQGbpBDqcX4++iBSyN2UBtap8HzR9uXYhXUAN4My9vE43gPZQdenoipFA09OaR5jh
         kUu6BkdmJ+ROA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 0/4] arm64/mm: remap crash kernel with base pages even if rodata_full disabled
Date:   Mon,  1 Aug 2022 11:04:14 +0300
Message-Id: <20220801080418.120311-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

There were several rounds of discussion how to remap with base pages only
the crash kernel area, the latest one here:

https://lore.kernel.org/all/1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com

and this is my attempt to allow having both large pages in the linear map
and protection for the crash kernel memory.

For server systems it is important to protect crash kernel memory for
post-mortem analysis, and for that protection to work the crash kernel
memory should be mapped with base pages in the linear map. 

On the systems with ZONE_DMA/DMA32 enabled, crash kernel reservation
happens after the linear map is created and the current code forces using
base pages for the entire linear map, which results in performance
degradation.

These patches enable remapping of the crash kernel area with base pages
while keeping large pages in the rest of the linear map.

The idea is to align crash kernel reservation to PUD boundaries, remap that
PUD and then free the extra memory.

For now the remapping does not deal with the case when crash kernel base is
specified, but this won't be a problem to add if the idea is generally
acceptable.

Mike Rapoport (4):
  arm64: introduce have_zone_dma() helper
  arm64/mmu: drop _hotplug from unmap_hotplug_* function names
  arm64/mmu: move helpers for hotplug page tables freeing close to callers
  arm64/mm: remap crash kernel with base pages even if rodata_full disabled

 arch/arm64/include/asm/memory.h |   8 +++
 arch/arm64/include/asm/mmu.h    |   2 +
 arch/arm64/mm/init.c            |  44 ++++++++++--
 arch/arm64/mm/mmu.c             | 116 ++++++++++++++++++++------------
 4 files changed, 122 insertions(+), 48 deletions(-)

-- 
2.35.3

