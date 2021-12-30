Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84683481B45
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhL3KOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhL3KOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:14:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:14:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABFAB61654
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A54C36AEE;
        Thu, 30 Dec 2021 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640859287;
        bh=t8yQA3j+9q3YreOJjkrRYJ9L4dQUxTSnsaSnS7maVzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etyu8/avKta9I1jDeVvbou0yx5DaBVmneLYnxHDlKnd2rMZ0gjr4RhO57/Ts+KPWb
         LJUDPskthAWQZp+xY8y08wYvkM+c0eMKf/19jtlIem62YiPDsPfftxmrPNfX9XaHjh
         pjhH/nX1jgxqkwbnl8AJZobTIETveVvms7+z+DAwFp+LF77+HRGdRk4CO0EKiz5KfY
         QRHSGQuRjXgdqwmUXjnUplX5UgukkZ5kgFLwVi6v9iYgMulF1av/6+Wldjbn3/PCJ/
         N4ggMbGq2j8EkxUM0AFdRn1FVjwggZu3Ek+fRBnSYy3yrw40+r0fTjrrG9NaQqDx4F
         mlDX7FHKYouTw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/4] Docs/admin-guide/mm/damon/usage: Update for changed initail_regions file input
Date:   Thu, 30 Dec 2021 10:07:21 +0000
Message-Id: <20211230100723.2238-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230100723.2238-1-sj@kernel.org>
References: <20211230100723.2238-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit made init_regions debugfs file to use target index
instead of target id for specifying the target of the init regions.
This commit updates the usage document to reflect the change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 24 ++++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 59b84904a854..1e06435b8ff6 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -108,19 +108,23 @@ In such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the ``init_regions`` file.  Each line
 of the input should represent one region in below form.::
 
-    <target id> <start address> <end address>
+    <target idx> <start address> <end address>
 
-The ``target id`` should already in ``target_ids`` file, and the regions should
-be passed in address order.  For example, below commands will set a couple of
-address ranges, ``1-100`` and ``100-200`` as the initial monitoring target
-region of process 42, and another couple of address ranges, ``20-40`` and
-``50-100`` as that of process 4242.::
+The ``target idx`` should be the index of the target in ``target_ids`` file,
+starting from ``0``, and the regions should be passed in address order.  For
+example, below commands will set a couple of address ranges, ``1-100`` and
+``100-200`` as the initial monitoring target region of pid 42, which is the
+first one (index ``0``) in ``target_ids``, and another couple of address
+ranges, ``20-40`` and ``50-100`` as that of pid 4242, which is the second one
+(index ``1``) in ``target_ids``.::
 
     # cd <debugfs>/damon
-    # echo "42   1       100
-            42   100     200
-            4242 20      40
-            4242 50      100" > init_regions
+    # cat target_ids
+    42 4242
+    # echo "0   1       100
+            0   100     200
+            1   20      40
+            1   50      100" > init_regions
 
 Note that this sets the initial monitoring target regions only.  In case of
 virtual memory monitoring, DAMON will automatically updates the boundary of the
-- 
2.17.1

