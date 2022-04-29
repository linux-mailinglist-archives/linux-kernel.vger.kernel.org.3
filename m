Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B616515058
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378806AbiD2QJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378476AbiD2QJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB0AA27D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAB3622B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FFEC385A4;
        Fri, 29 Apr 2022 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248375;
        bh=kX9wsxrQF5lo48sgREIAhlQjmVHS6gEUXUOxmfhc2II=;
        h=From:To:Cc:Subject:Date:From;
        b=YTO3+Oe23DUpJby3UQFt6WQjolYvkbKIlw89mqrhDDdaCVv4nwL6QFV3oWJRed/8s
         9EEDmRuXfUL172NyzyO1UdvIHu/6yktJrRYik3aUFb09BKWT0+8XypBwx6NZOILOEP
         OHf55HbePzWVybtM/jiQKMZQBUiAkM4/oXmKGnfFf0lzAfA7YNYkcbOEl6ZSxEayJ2
         29GKZkA5/KccwgKjg26flvFuBN5+0ApmWsaOSCsIvRtbfZRIcjjNAP+ElbXLsJwggr
         eRWMjgXul/LAbJeREhtZlZobSG3YpcILygXUwak783ccmhyIDr0i9rFBVHF5Cr3+eb
         tnUywfvPBOpYw==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 00/14] mm/damon: Support online tuning
Date:   Fri, 29 Apr 2022 16:05:52 +0000
Message-Id: <20220429160606.127307-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: SeongJae Park <sj@kernel.org>

Effects of DAMON and DAMON-based Operation Schemes highly depends on the
configurations.  Wrong configurations could even result in unexpected
efficiency degradations.  For finding a best configuration, repeating
incremental configuration changes and results measurements, in other
words, online tuning, could be helpful.

Nevertheless, DAMON kernel API supports only restrictive online tuning.
Worse yet, the sysfs-based DAMON user interface doesn't support online
tuning at all.  DAMON_RECLAIM also doesn't support online tuning.

This patchset makes the DAMON kernel API, DAMON sysfs interface, and
DAMON_RECLAIM supports online tuning.

Sequence of patches
-------------------

First two patches enhance DAMON online tuning for kernel API users.
Specifically, patch 1 let kernel API users to be able to do DAMON online
tuning without a restriction, and patch 2 makes error handling easier.

Following seven patches (patches 3-9) refactor code for better
readability and easier reuse of code fragments that will be useful for
online tuning support.

Patch 10 introduces DAMON callback based user request handling structure
for DAMON sysfs interface, and patch 11 enables DAMON online tuning via
DAMON sysfs interface.  Documentation patch (patch 12) for usage of it
follows.

Patch 13 enables online tuning of DAMON_RECLAIM and finally patch 14
documents the DAMON_RECLAIM online tuning usage.

SeongJae Park (14):
  mm/damon/core: add a new callback for watermarks checks
  mm/damon/core: finish kdamond as soon as any callback returns an error
  mm/damon/vaddr: generalize damon_va_apply_three_regions()
  mm/damon/vaddr: move 'damon_set_regions()' to core
  mm/damon/vaddr: remove damon_va_apply_three_regions()
  mm/damon/sysfs: prohibit multiple physical address space monitoring
    targets
  mm/damon/sysfs: move targets setup code to a separated function
  mm/damon/sysfs: reuse damon_set_regions() for regions setting
  mm/damon/sysfs: use enum for 'state' input handling
  mm/damon/sysfs: update schemes stat in the kdamond context
  mm/damon/sysfs: support online inputs update
  Docs/{ABI,admin-guide}/damon: Update for 'state' sysfs file input
    keyword, 'commit'
  mm/damon/reclaim: support online inputs update
  Docs/admin-guide/mm/damon/reclaim: document 'commit_inputs' parameter

 .../ABI/testing/sysfs-kernel-mm-damon         |   7 +-
 .../admin-guide/mm/damon/reclaim.rst          |  11 +
 Documentation/admin-guide/mm/damon/usage.rst  |   9 +-
 include/linux/damon.h                         |   9 +
 mm/damon/core.c                               |  89 +++-
 mm/damon/reclaim.c                            |  95 +++--
 mm/damon/sysfs.c                              | 382 +++++++++++++++---
 mm/damon/vaddr-test.h                         |   6 +-
 mm/damon/vaddr.c                              |  73 +---
 9 files changed, 500 insertions(+), 181 deletions(-)

-- 
2.25.1

