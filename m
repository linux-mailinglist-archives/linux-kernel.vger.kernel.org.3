Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826A451505B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378882AbiD2QKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378836AbiD2QJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009DCA66C4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90BC1622B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9292CC385AF;
        Fri, 29 Apr 2022 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248384;
        bh=sIJXJH2OsUzbfrsqqPxpgdbesc2kTA2xxcs6VJcOqzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+taiSDwqrJlK/ARQLYuP4sLTWza+1BlTmXp9MYF2rttBBqG/sIWtUQF9wyKOt0E8
         +Mpq1IT7kT+4OH1LA2tr1NDiuxPxMOWLaHt9NcS0+SMVmkPGRr22e4KRWK27l4qJ8T
         6OGWhsZSPyRbAB/GVMk4xAZ+Lx88Xiv0JQx87QFU2DDwk2fuKTtaE70EoNlpDMYbyj
         uSyL8ImYK1K7oqRQwQVoNb0Tih6oyQjUDIii31N1qW89KPzVZ8cDAKxqE5yj2l489w
         UlzJf930e1JHGZ3ZcgSGW+tT6lVBynuA9aVr9A63ZfrV4PhlA/VtKVRY3XXAHQfmAc
         fWPX1rk+RAaXg==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 14/14] Docs/admin-guide/mm/damon/reclaim: document 'commit_inputs' parameter
Date:   Fri, 29 Apr 2022 16:06:06 +0000
Message-Id: <20220429160606.127307-15-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429160606.127307-1-sj@kernel.org>
References: <20220429160606.127307-1-sj@kernel.org>
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

This commit documents the new DAMON_RECLAIM parameter, 'commit_inputs'
in its usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 0af51a9705b1..46306f1f34b1 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -66,6 +66,17 @@ Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could do
 no real monitoring and reclamation due to the watermarks-based activation
 condition.  Refer to below descriptions for the watermarks parameter for this.
 
+commit_inputs
+-------------
+
+Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
+
+Input parameters that updated while DAMON_RECLAIM is running are not applied
+by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
+of parametrs except ``enabled`` again.  Once the re-reading is done, this
+parameter is set as ``N``.  If invalid parameters are found while the
+re-reading, DAMON_RECLAIM will be disabled.
+
 min_age
 -------
 
-- 
2.25.1

