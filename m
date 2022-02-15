Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D074B779C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiBOSrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiBOSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9EC2B1B7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5367BB8124E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDABC340EB;
        Tue, 15 Feb 2022 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950798;
        bh=IZEEeaeimH1toBqTQkv4T6a9UDa2v1gE60oPYpQOfCo=;
        h=From:To:Cc:Subject:Date:From;
        b=QyuLo9dERdzYrBbj+GyH7OMzdQBtKYObQWFuu0yIGrTVQZGnvojlchU9PfjTFZqIm
         6QLHzq5icSdtNI8B1b4TvZlacfVHHrtLKP8rdp9MUvl9HaiWkLumqooz5VDw3voK02
         uw4xWkFGTq48MM0mX7VnIFI1iqGugV2iH6fsAARlisVyeVC0YlwjhKwjXXCs/VHXKU
         aucFEQ6ImQKcCJtZlTOc+WO9vcT0uIfjdDOnSG3cgxxMYtUYia9d06HbBpCuCjFAcC
         MXHYTf5cub6ud2/xshfOIUugeAv1kLa0YW4+OmBd0WnL9eIuPEeLTIxaiQ4Xac5vTM
         4pr4H/G/hCwrQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/8] Allow DAMON user code independent of monitoring primitives
Date:   Tue, 15 Feb 2022 18:45:55 +0000
Message-Id: <20220215184603.1479-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel DAMON user code is required to configure the monitoring
context (struct damon_ctx) with proper monitoring primitives (struct
damon_primitive).  This makes the user code dependent to all supporting
monitoring primitives.  For example, DAMON debugfs interface depends on
both DAMON_VADDR and DAMON_PADDR, though some users have interest in
only one use case.  As more monitoring primitives are introduced, the
problem will be bigger.

To minimize such unnecessary dependency, this patchset makes monitoring
primitives can be registered by the implemnting code and later
dynamically searched and selected by the user code.

In addition to that, this patchset renames monitoring primitives to
monitoring operations, which is more easy to intuitively understand what
it means and how it would be structed.

SeongJae Park (8):
  mm/damon: Rename damon_primitives to damon_operations
  mm/damon: Let monitoring operations can be registered and selected
  mm/damon/paddr,vaddr: Register themselves to DAMON in subsys_initcall
  mm/damon/reclaim: Use damon_select_ops() instead of
    damon_{v,p}a_set_operations()
  mm/damon/dbgfs: Use damon_select_ops() instead of
    damon_{v,p}a_set_operations()
  mm/damon/dbgfs: Use operations id for knowing if the target has pid
  mm/damon/dbgfs-test: Fix is_target_id() change
  mm/damon/paddr,vaddr: Remove
    damon_{p,v}a_{target_valid,set_operations}()

 include/linux/damon.h                     |  72 ++++++------
 mm/damon/Kconfig                          |  12 +-
 mm/damon/Makefile                         |   4 +-
 mm/damon/core.c                           | 131 ++++++++++++++++------
 mm/damon/dbgfs-test.h                     |   4 +-
 mm/damon/dbgfs.c                          |  20 +++-
 mm/damon/{prmtv-common.c => ops-common.c} |   2 +-
 mm/damon/{prmtv-common.h => ops-common.h} |   0
 mm/damon/paddr.c                          |  36 +++---
 mm/damon/reclaim.c                        |   4 +-
 mm/damon/vaddr-test.h                     |   2 +-
 mm/damon/vaddr.c                          |  33 +++---
 12 files changed, 209 insertions(+), 111 deletions(-)
 rename mm/damon/{prmtv-common.c => ops-common.c} (99%)
 rename mm/damon/{prmtv-common.h => ops-common.h} (100%)

-- 
2.17.1

