Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E484BFF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiBVRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiBVRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:01:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1D516E7E1;
        Tue, 22 Feb 2022 09:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEE86611ED;
        Tue, 22 Feb 2022 17:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A545EC340F8;
        Tue, 22 Feb 2022 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549268;
        bh=zczrBUwLoWWJDqN/LSpEpzKjXn8SCxPYGivrQ5ZiP8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwL5+TbBccR6OcEoiUZfWmcmA8QotsmGv4C2wgrrwoEQxR7w2LxbqvV6A2U3IfoIv
         D0EIEGHjZuO8O90pyyiVSUtMm9yOg5jBkQyJ0C4SrUywjtWZ31/2vyutVDCPdYtrDy
         rrA9WUwTY3nkZ1GeVKhZFyFehuvUEYcVk26YiL3V8tgDNKvOJUCzhCVq+7PSrGDzif
         e7ipovYGaP0eeq1cCWDuKcCVqkjv9Tg3FsouJuLM/w2SBn551ut2mwQ6ABAixth47n
         RIJnw+SMGxA4eoEodU6eFoeQ9cqC9zuweae8ckpuRkw6pdw9bwjjZ+agj3YEaS3dTO
         u4qUOFx0IwJBQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/3] Docs/vm/damon/design: Update DAMON-Idle Page Tracking interference handling
Date:   Tue, 22 Feb 2022 17:00:59 +0000
Message-Id: <20220222170100.17068-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222170100.17068-1-sj@kernel.org>
References: <20220222170100.17068-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In DAMON's early development stage before it be merged in the mainline,
it was first designed to work exclusively with Idle page tracking to
avoid any interference between each other.  Later, but still before
be merged in the mainline, because Idle page tracking is fully under the
control of sysadmins, we made the resolving of conflict as the
responsibility of sysadmins.  The document is not updated for the
change, though.  This commit updates the document for that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/vm/damon/design.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/damon/design.rst b/Documentation/vm/damon/design.rst
index c406983aeb31..bba89632e924 100644
--- a/Documentation/vm/damon/design.rst
+++ b/Documentation/vm/damon/design.rst
@@ -84,9 +84,10 @@ table having a mapping to the address.  In this way, the implementations find
 and clear the bit(s) for next sampling target address and checks whether the
 bit(s) set again after one sampling period.  This could disturb other kernel
 subsystems using the Accessed bits, namely Idle page tracking and the reclaim
-logic.  To avoid such disturbances, DAMON makes it mutually exclusive with Idle
-page tracking and uses ``PG_idle`` and ``PG_young`` page flags to solve the
-conflict with the reclaim logic, as Idle page tracking does.
+logic.  DAMON does nothing to avoid disturbing Idle page tracking, so handling
+the interference is the responsibility of sysadmins.  However, it solves the
+conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
+as Idle page tracking does.
 
 
 Address Space Independent Core Mechanisms
-- 
2.17.1

