Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59080510C86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356026AbiDZXVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353817AbiDZXVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:21:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C551D0CC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 100E6B8239F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51486C385A0;
        Tue, 26 Apr 2022 23:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651015075;
        bh=GoGM/TLuTwqlGElUCHXXjQy9qTXe9jqD9Hgkx7Rtkm4=;
        h=From:To:Cc:Subject:Date:From;
        b=pGqTa1IF3rLvEOdd9OfU+9MF2cVAI8FVBQKbBOGL5lkLQHdl3j3ss3sA01ChtwEyZ
         s4Hujo+Y50P+Hmy4UTW2K2gvvnTkUaL7ByDTKHNseVvA7VfSUI0RVt7CcgcVS4zVH0
         FIbiawg4Xi5uKnH3P43cn/ClJKIQdWOY/fHGGrQKKlBrNg5urzijtQ/eGjkXRoi2uU
         jXhslCxpxHh5crk9enoyU3lp9XyanfLpd8Y+vHqLM/sxhuFFtyKC5erX0gKB0/J/YR
         ZQTo0KlUpd/pzqonketMJKnVXSkAhphvSJIjrGSb6EGz2NeVZc1iyopYIo74RoFFuK
         L5MSqzSH+Qm4Q==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/3] support fixed virtual address ranges monitoring
Date:   Tue, 26 Apr 2022 23:17:47 +0000
Message-Id: <20220426231750.48822-1-sj@kernel.org>
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

The monitoring operations set for virtual address spaces automatically
updates the monitoring target regions to cover entire mappings of the
virtual address spaces as much as possible.  Some users could have more
information about their programs than kernel and therefore have interest
in not entire regions but only specific regions.  For such cases, the
automatic monitoring target regions updates are only unnecessary
overhead or distractions.

This patchset adds supports for the use case on DAMON's kernel API
(DAMON_OPS_FVADDR) and sysfs interface ('fvaddr' keyword for
'operations' sysfs file).

SeongJae Park (3):
  mm/damon/vaddr: register a damon_operations for fixed virtual address
    ranges monitoring
  mm/damon/sysfs: support fixed virtual address ranges monitoring
  Docs/{ABI,admin-guide}/damon: update for fixed virtual address ranges
    monitoring

 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++------
 Documentation/admin-guide/mm/damon/usage.rst    | 14 +++++++++++---
 include/linux/damon.h                           |  3 +++
 mm/damon/sysfs.c                                |  4 +++-
 mm/damon/vaddr.c                                | 15 +++++++++++++--
 5 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.25.1

