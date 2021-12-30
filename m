Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17828481B44
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhL3KOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhL3KOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:14:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC948C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:14:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A508615B0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A472C36AE9;
        Thu, 30 Dec 2021 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640859285;
        bh=nQhsx3NefR1s0VrbzOivpVKLa6kobr744dEgSMnpo7g=;
        h=From:To:Cc:Subject:Date:From;
        b=MnidE3HrIlypk1hZDwBi+8BPitqPgjqqMmhEvXc4ieaQC6j03Vv8gfvZEI0sjAQX4
         iN5LXdEnQmv+bFR+Xo+edmabGRPIQzON3nJMPWH/HeVkmFrVD2zaBAEBs0k8rieREv
         8h2xPz7fMHhkc0W8k8TpPKxuxqdGAp6RPPwaSR/2Omu/bJW3M81cEWiMLEsrHPI1M/
         k5SFZ/sTxCQ1eh3kCp3PrdNz/VdZxYr3NgggrxcLkSz1tDSoSZgoz5N/t7y80kPh51
         nNFD1HekbkNmud1ZgmNkwFKT8TEagpQxyQbh0u8IXsV8T+emHSZc1HOFSc9cKJpoVc
         GSAZwoMmd2l/g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/4] Remove the type-unclear target id concept
Date:   Thu, 30 Dec 2021 10:07:19 +0000
Message-Id: <20211230100723.2238-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON asks each monitoring target ('struct damon_target') to have one
'unsigned long' integer called 'id', which should be unique among the
targets of same monitoring context.  Meaning of it is, however, totally
up to the monitoring primitives that registered to the monitoring
context.  For example, the virtual address spaces monitoring primitives
treats the id as a 'struct pid' pointer.

This makes the code flexible but ugly, not well-documented, and
type-unsafe[1].  Also, identification of each target can be done via its
index.  For the reason, this patchset removes the concept and uses clear
type definition.

[1] https://lore.kernel.org/linux-mm/20211013154535.4aaeaaf9d0182922e405dd1e@linux-foundation.org/

SeongJae Park (4):
  mm/damon/dbgfs/init_regions: Use target index instead of target id
  Docs/admin-guide/mm/damon/usage: Update for changed initail_regions
    file input
  mm/damon/core: Move damon_set_targets() into dbgfs
  mm/damon: Remove the target id concept

 Documentation/admin-guide/mm/damon/usage.rst |  24 ++-
 include/linux/damon.h                        |  13 +-
 mm/damon/core-test.h                         |  21 +-
 mm/damon/core.c                              |  36 +---
 mm/damon/dbgfs-test.h                        |  83 +++-----
 mm/damon/dbgfs.c                             | 202 ++++++++++++-------
 mm/damon/reclaim.c                           |   3 +-
 mm/damon/vaddr-test.h                        |   6 +-
 mm/damon/vaddr.c                             |   4 +-
 9 files changed, 199 insertions(+), 193 deletions(-)

-- 
2.17.1

