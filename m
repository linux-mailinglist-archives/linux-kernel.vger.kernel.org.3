Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39AF4BFF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiBVRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiBVRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:01:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B3B16E7DC;
        Tue, 22 Feb 2022 09:01:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 131F6611EF;
        Tue, 22 Feb 2022 17:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6580C340F3;
        Tue, 22 Feb 2022 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549267;
        bh=39aGM7NlOoLZpgmNi6MB1SzF9U7sSJm7tFXEV8C9jgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpeSxOdgieBpb2HuJ2xeqElm5eBKelijp+KKuEHrsZVQf2uVih8WkryyO5VjnHslG
         xhG1Ipx94wrXOt3k5GiH+oaL0ai0Cna2OdVMpphGkNqNdWOaZeMxcfRgIiIkbXJywM
         oBjAO3qVoJMEqj8h5XU6/LVZjYyvQV0NI/p4Kqv+4eJaeb/ZYI/+0vPVAhICqC6DQg
         kOlyjy6cELoOpT54nyXNx29QZMFk6U3y9JYG9ZBv5Wrzbp6m6OY6WwDiLaUd7a1yOr
         iPtvNslEfFykVS0lHm0JT5Vp9sK52Xf+GwJDvQaADFJPn9AUKLgmevv+v/hU6QKMFC
         vtoGfRQLae27w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/3] Docs/vm/damon: Call low level monitoring primitives the operations
Date:   Tue, 22 Feb 2022 17:00:58 +0000
Message-Id: <20220222170100.17068-2-sj@kernel.org>
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

DAMON code calls the low level monitoring primitives implementations the
monitoring operations.  The documentation would have no problem at still
calling those primitives implementation because there is no real
difference in the concepts, but making it more consistent with the code
would make it better.  This commit therefore convert sentences in the
doc specifically pointing the implementations of the primitives to call
it monitoring operations.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/vm/damon/design.rst | 24 ++++++++++++------------
 Documentation/vm/damon/faq.rst    |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/vm/damon/design.rst b/Documentation/vm/damon/design.rst
index 210f0f50efd8..c406983aeb31 100644
--- a/Documentation/vm/damon/design.rst
+++ b/Documentation/vm/damon/design.rst
@@ -13,12 +13,13 @@ primitives that dependent on and optimized for the target address space.  On
 the other hand, the accuracy and overhead tradeoff mechanism, which is the core
 of DAMON, is in the pure logic space.  DAMON separates the two parts in
 different layers and defines its interface to allow various low level
-primitives implementations configurable with the core logic.
+primitives implementations configurable with the core logic.  We call the low
+level primitives implementations monitoring operations.
 
 Due to this separated design and the configurable interface, users can extend
-DAMON for any address space by configuring the core logics with appropriate low
-level primitive implementations.  If appropriate one is not provided, users can
-implement the primitives on their own.
+DAMON for any address space by configuring the core logics with appropriate
+monitoring operations.  If appropriate one is not provided, users can implement
+the operations on their own.
 
 For example, physical memory, virtual memory, swap space, those for specific
 processes, NUMA nodes, files, and backing memory devices would be supportable.
@@ -26,25 +27,24 @@ Also, if some architectures or devices support special optimized access check
 primitives, those will be easily configurable.
 
 
-Reference Implementations of Address Space Specific Primitives
-==============================================================
+Reference Implementations of Address Space Specific Monitoring Operations
+=========================================================================
 
-The low level primitives for the fundamental access monitoring are defined in
-two parts:
+The monitoring operations are defined in two parts:
 
 1. Identification of the monitoring target address range for the address space.
 2. Access check of specific address range in the target space.
 
-DAMON currently provides the implementations of the primitives for the physical
+DAMON currently provides the implementations of the operations for the physical
 and virtual address spaces. Below two subsections describe how those work.
 
 
 VMA-based Target Address Range Construction
 -------------------------------------------
 
-This is only for the virtual address space primitives implementation.  That for
-the physical address space simply asks users to manually set the monitoring
-target address ranges.
+This is only for the virtual address space monitoring operations
+implementation.  That for the physical address space simply asks users to
+manually set the monitoring target address ranges.
 
 Only small parts in the super-huge virtual address space of the processes are
 mapped to the physical memory and accessed.  Thus, tracking the unmapped
diff --git a/Documentation/vm/damon/faq.rst b/Documentation/vm/damon/faq.rst
index 11aea40eb328..dde7e2414ee6 100644
--- a/Documentation/vm/damon/faq.rst
+++ b/Documentation/vm/damon/faq.rst
@@ -31,7 +31,7 @@ Does DAMON support virtual memory only?
 =======================================
 
 No.  The core of the DAMON is address space independent.  The address space
-specific low level primitive parts including monitoring target regions
+specific monitoring operations including monitoring target regions
 constructions and actual access checks can be implemented and configured on the
 DAMON core by the users.  In this way, DAMON users can monitor any address
 space with any access check technique.
-- 
2.17.1

