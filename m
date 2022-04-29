Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE71351505F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378827AbiD2QKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378839AbiD2QJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE56A205E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE207622B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DF2C385AF;
        Fri, 29 Apr 2022 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248382;
        bh=Oi5YPw35pCM0H1yoToBMyhd1ntPljhU//AY7haTrCfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhtECIgY8ZMYrrHl261/0xbf6DOjz81DP8MNeb72huKJT5QFq7KYG7aEXseGq03Af
         wENuOXhJ4pIES3egmb80BSND4Z5RU6Y83nLJyAwpp2Iv8iJgo7emEsl1O10JfsTvFj
         Wy60piExeYT/O34i9y9uOkoFXesrDzCWwsE9Y1nY0uftCfEdnOiPfQDtmPS7Wze3XR
         ickLAsU1Q1GySb+ASnUC/JhTEjZ1ogLQzgoxAFasKAYv/SHFJtKW4wXSau568wmpEc
         4NQOgYYn1hebyBqFcNS4yePmhFrTWsQN+Vrwcw7cYjyj9vH0KfJub91DDPdrQJ1K1I
         cSy5HSSKqcJUw==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 12/14] Docs/{ABI,admin-guide}/damon: Update for 'state' sysfs file input keyword, 'commit'
Date:   Fri, 29 Apr 2022 16:06:04 +0000
Message-Id: <20220429160606.127307-13-sj@kernel.org>
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

This commit documents the newly added 'state' sysfs file input keyword,
'commit', which allows online tuning of DAMON contexts.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 ++++---
 Documentation/admin-guide/mm/damon/usage.rst    | 9 +++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index fab97ea22569..08b9df323560 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -23,9 +23,10 @@ Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		stops, respectively.  Reading the file returns the keywords
-		based on the current status.  Writing 'update_schemes_stats' to
-		the file updates contents of schemes stats files of the
-		kdamond.
+		based on the current status.  Writing 'commit' to this file
+		makes the kdamond reads the user inputs in the sysfs files
+		except 'state' again.  Writing 'update_schemes_stats' to the
+		file updates contents of schemes stats files of the kdamond.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9c67311a79d8..1bb7b72414b2 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -121,10 +121,11 @@ In each kdamond directory, two files (``state`` and ``pid``) and one directory
 
 Reading ``state`` returns ``on`` if the kdamond is currently running, or
 ``off`` if it is not running.  Writing ``on`` or ``off`` makes the kdamond be
-in the state.  Writing ``update_schemes_stats`` to ``state`` file updates the
-contents of stats files for each DAMON-based operation scheme of the kdamond.
-For details of the stats, please refer to :ref:`stats section
-<sysfs_schemes_stats>`.
+in the state.  Writing ``commit`` to the ``state`` file makes kdamond reads the
+user inputs in the sysfs files except ``state`` file again.  Writing
+``update_schemes_stats`` to ``state`` file updates the contents of stats files
+for each DAMON-based operation scheme of the kdamond.  For details of the
+stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
-- 
2.25.1

