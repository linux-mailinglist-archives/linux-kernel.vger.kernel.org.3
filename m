Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19E48130C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhL2NKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhL2NKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:10:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408AFC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:10:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48CD0B818FE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61BBC36AE9;
        Wed, 29 Dec 2021 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640783431;
        bh=6gjZQe7t1Tu8HByN+SHLsG3+BkQ8l61PG0mXkGZg1L4=;
        h=From:To:Cc:Subject:Date:From;
        b=qz0OKCqx9+j3TbM0fselt1vhl9fyLiRU7oi1bGxFCRCZBQ2GnJhLa9taV7NgD2cVx
         AXQnyughfBsklWdT6lau2kM6gRtnlB1NrG8AwEKvgkKhajPAbV1oqYQtKROavPH1mM
         1/fS0MfgosyzZcBo/yZrUNlzW7+2aWCp8N+MxAHdPBOQKEeIpMy3MkKa7OilnA5vvt
         tpCiiZmf52A4somq8QLEJ0VY9jtCtapZXadEMl7CMzXkTPRFEYjv3V6lAyXA7kp0N8
         LcNg6qUSU9jz4qlkmz6LdLb7/LlImPrhGZCpO8FvBBXRBek8Xtd8iCxZ89tMfCkhYX
         codNyn4o6La9Q==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/4] mm/damon: Hide unnecessary information disclosures
Date:   Wed, 29 Dec 2021 13:10:12 +0000
Message-Id: <20211229131016.23641-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON is exposing some unnecessary information including kernel pointer
in kernel log and tracepoint.  This patchset hides such information.
The first patch is only for a trivial cleanup, though.

SeongJae Park (4):
  mm/damon/dbgfs: Remove a unnecessary variable
  mm/damon/vaddr: Use pr_debug() for damon_va_three_regions() failure
    logging
  mm/damon/vaddr: Hide kernel pointer from damon_va_three_regions()
    failure log
  mm/damon: Hide kernel pointer from tracepoint event

 include/trace/events/damon.h |  8 ++++----
 mm/damon/core.c              |  4 +++-
 mm/damon/dbgfs.c             |  5 ++---
 mm/damon/vaddr.c             | 10 ++++++++--
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.17.1

