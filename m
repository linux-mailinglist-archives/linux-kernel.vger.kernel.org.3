Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857D95993F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbiHSEMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242374AbiHSEMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:12:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4CDD41BC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2575EB825A9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F9BC433D6;
        Fri, 19 Aug 2022 04:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660882332;
        bh=plPUZEi7gc9933Zm7xZLunqPtKaOCQ5hi0QL2k34NHk=;
        h=From:To:Cc:Subject:Date:From;
        b=pAd8j7GymJ3OOqOBRfqkrghT2RIqSNjx4KbfJWuF8coQopaDHzTfK484hzYXP8C9U
         npkFZZoEpzz/IpAho+FcQjKc+IcmGBbeesM9QouWxut2J8d5qcSLHmzbGvJGYFrt2S
         lkmCibHwMR3G6wdWZxdbfUbW1vL5WJAjygMjzAc0VpvREdQ7VY2w9sXyOOqqBId1Q+
         EOANn6K7/jxmPtU5JcMTx2GwE1e/srHfP+b0uOGvzYoDwr1zHsm8Vf0Hf0RSHqvAh4
         tEXhG96G5dSda3OGbwwE6uMKpWcyF2sp+74MU7R1so6x/DxiEakhplFqxmQ6aTqAf5
         +eQjeiZUeoMKA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <mike.rapoport@gmail.com>
Subject: [PATCH 0/5] arm64/mm: remap crash kernel with base pages even if rodata_full disabled
Date:   Fri, 19 Aug 2022 07:11:51 +0300
Message-Id: <20220819041156.873873-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
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

From: Mike Rapoport <mike.rapoport@gmail.com>

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

RFC: https://lore.kernel.org/all/20220801080418.120311-1-rppt@kernel.org

Mike Rapoport (5):
  arm64: rename defer_reserve_crashkernel() to have_zone_dma()
  arm64/mmu: drop _hotplug from unmap_hotplug_* function names
  arm64/mmu: move helpers for hotplug page tables freeing close to callers
  arm64/mm: remap crash kernel with base pages even if rodata_full disabled
  arm64/mmu: simplify logic around crash kernel mapping in map_mem()

 arch/arm64/include/asm/memory.h   |   2 +-
 arch/arm64/include/asm/mmu.h      |   3 +
 arch/arm64/kernel/machine_kexec.c |   6 ++
 arch/arm64/mm/init.c              |  69 +++++++++++---
 arch/arm64/mm/mmu.c               | 152 ++++++++++++++++--------------
 5 files changed, 147 insertions(+), 85 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.35.3

