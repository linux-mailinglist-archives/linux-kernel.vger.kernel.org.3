Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768A24BFF92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiBVRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiBVRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:01:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C316E7D9;
        Tue, 22 Feb 2022 09:01:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60233CE17A9;
        Tue, 22 Feb 2022 17:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D93C340F9;
        Tue, 22 Feb 2022 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549268;
        bh=U1WoaJ7lbnns8naY/1+W0bLu1qPxUeglQsjIh920zbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0f6a+m7QBkb6m90qVbP/bQOXJLehC8assGKbnwnzG2ooCM4dGXeX8GNBtnNjIHNa
         GxFtRJMWSSZzeVZay9Ntg+FgiMvHS83XYziKa80YKhc4JesxqjmML309ul0D7oVpIT
         7Uc9L+NvEhAtjo99Hc9O7/nnqq4Ak32j066QgxSqODSbd85lpwptVuC/OFNgdi12bM
         lEE6cJmAmYtyPsDnzifcqjev5KHMf9bso+KfAK3ZwX3bDOp1zLFv0F9GQDkXiXd89j
         9zaqyHlqyG1wj1qsOYKCyWYNgux8NGalLPzUraP9Vy3P4WsNTX/6iBdFH/KmSiFNtY
         PA0+s26xkEsxA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/3] Docs/damon: Update outdated term 'regions update interval'
Date:   Tue, 22 Feb 2022 17:01:00 +0000
Message-Id: <20220222170100.17068-4-sj@kernel.org>
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

Before DAMON is merged in the mainline, the concept of 'regions update
interval' has generalized to be used as the time interval for update of
any monitoring operations related data structure, but the document has
not updated properly.  This commit updates the document for better
consistency.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst |  6 +++---
 Documentation/vm/damon/design.rst            | 12 +++++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 1e06435b8ff6..b6ec650873b2 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -47,7 +47,7 @@ Attributes
 ----------
 
 Users can get and set the ``sampling interval``, ``aggregation interval``,
-``regions update interval``, and min/max number of monitoring target regions by
+``update interval``, and min/max number of monitoring target regions by
 reading from and writing to the ``attrs`` file.  To know about the monitoring
 attributes in detail, please refer to the :doc:`/vm/damon/design`.  For
 example, below commands set those values to 5 ms, 100 ms, 1,000 ms, 10 and
@@ -128,8 +128,8 @@ ranges, ``20-40`` and ``50-100`` as that of pid 4242, which is the second one
 
 Note that this sets the initial monitoring target regions only.  In case of
 virtual memory monitoring, DAMON will automatically updates the boundary of the
-regions after one ``regions update interval``.  Therefore, users should set the
-``regions update interval`` large enough in this case, if they don't want the
+regions after one ``update interval``.  Therefore, users should set the
+``update interval`` large enough in this case, if they don't want the
 update.
 
 
diff --git a/Documentation/vm/damon/design.rst b/Documentation/vm/damon/design.rst
index bba89632e924..0cff6fac6b7e 100644
--- a/Documentation/vm/damon/design.rst
+++ b/Documentation/vm/damon/design.rst
@@ -95,8 +95,8 @@ Address Space Independent Core Mechanisms
 
 Below four sections describe each of the DAMON core mechanisms and the five
 monitoring attributes, ``sampling interval``, ``aggregation interval``,
-``regions update interval``, ``minimum number of regions``, and ``maximum
-number of regions``.
+``update interval``, ``minimum number of regions``, and ``maximum number of
+regions``.
 
 
 Access Frequency Monitoring
@@ -169,6 +169,8 @@ The monitoring target address range could dynamically changed.  For example,
 virtual memory could be dynamically mapped and unmapped.  Physical memory could
 be hot-plugged.
 
-As the changes could be quite frequent in some cases, DAMON checks the dynamic
-memory mapping changes and applies it to the abstracted target area only for
-each of a user-specified time interval (``regions update interval``).
+As the changes could be quite frequent in some cases, DAMON allows the
+monitoring operations to check dynamic changes including memory mapping changes
+and applies it to monitoring operations-related data structures such as the
+abstracted monitoring target memory area only for each of a user-specified time
+interval (``update interval``).
-- 
2.17.1

