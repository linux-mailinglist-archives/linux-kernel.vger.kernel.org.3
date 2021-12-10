Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60446470361
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbhLJPEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:04:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60242 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhLJPEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:04:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D36C4B82875
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFCCC00446;
        Fri, 10 Dec 2021 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148432;
        bh=lDEGQMWVDmFWLU7nhtMBQOiC3Y2jegUWMfqbTHPUBcI=;
        h=From:To:Cc:Subject:Date:From;
        b=m6qsGWDXLfetpUQVeVeyvgWrBrVrZ/WdVSe63/I/yCxa+UUaQiSatTbM12yXBppzQ
         hFpsU4GaROY06GTEbCJIOXRyeiQJwzCWfJP2KmXy5P+i59QvzrmZdBH1XGYKv+0Suy
         1PYGmisjTXvxFx8BJbBcwUU8xWJcMyYoPN+Bl5OS/hHkya1YG7RPtQI1cDJnxy1L89
         9QpaeqsaflOTfShYSTwLHe1wYstPS2az4O5kI+ForVY5ed/rRXSSd+yINle3LUeK1w
         UCx0AfETdLXssihuiyXA9xtonOQ01bsJzK4sSoFR2Q5MaTOAOlzD3GEVTK5KIkokng
         G8cnEGTajUjPw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/6] mm/damon/schemes: Extend stats for better online analysis and tuning
Date:   Fri, 10 Dec 2021 15:00:10 +0000
Message-Id: <20211210150016.35349-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help online access pattern analysis and tuning of DAMON-based
Operation Schemes (DAMOS), DAMOS provides simple statistics for each
scheme.  Introduction of DAMOS time/space quota further made the tuning
easier by making the risk management easier.  However, that also made
understanding of the working schemes a little bit more difficult.

For an example, progress of a given scheme can now be throttled by not
only the aggressiveness of the target access pattern, but also the
time/space quotas.  So, when a scheme is showing unexpectedly slow
progress, it's difficult to know by what the progress of the scheme is
throttled, with currently provided statistics.

This patchset extends the statistics to contain some metrics that can be
helpful for such online schemes analysis and tuning (patches 1-2),
exports those to users (patches 3 and 5), and add documents (patches 4
and 6).

SeongJae Park (6):
  mm/damon/schemes: Account scheme actions that successfully applied
  mm/damon/schemes: Account how many times quota limit has exceeded
  mm/damon/reclaim: Provide reclamation statistics
  Docs/admin-guide/mm/damon/reclaim: Document statistics parameters
  mm/damon/dbgfs: Support all DAMOS stats
  Docs/admin-guide/mm/damon/usage: Update for schemes statistics

 .../admin-guide/mm/damon/reclaim.rst          | 25 ++++++++++
 Documentation/admin-guide/mm/damon/usage.rst  |  9 ++--
 include/linux/damon.h                         | 30 +++++++++---
 mm/damon/core.c                               | 15 ++++--
 mm/damon/dbgfs.c                              |  6 ++-
 mm/damon/paddr.c                              | 13 +++---
 mm/damon/reclaim.c                            | 46 +++++++++++++++++++
 mm/damon/vaddr.c                              | 30 ++++++------
 8 files changed, 136 insertions(+), 38 deletions(-)

-- 
2.17.1

