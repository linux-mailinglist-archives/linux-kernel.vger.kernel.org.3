Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF04F4DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1584077AbiDEX5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384124AbiDEM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:11 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13415FFA;
        Tue,  5 Apr 2022 04:35:18 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGr000464;
        Tue, 5 Apr 2022 20:34:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGr000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158456;
        bh=hFcfpaL7dMThduj0I/l+DG6RPreS0NdgRlLeoUw6KmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oA86deSzKQp4qn7KpcbTtUbYzr1Y9SILHPrE2De6UK9BNz3l8Za8jx9N4LcglG1yz
         QEtfmoGh03V1kunbAz4L5WlaQjRbKkKxiUTYLFvfWp1zbCuqbLISMt0UHgp+lGX7+w
         80clyHOE7sEwqKu3+sKV9OeGUd+C3bK5eGaTSYDoIsFQgBHwqrQE92omNx0icEwxth
         bDjTYb3gxIO0DQNQcYHPiMUEwtLiNn4BemeneIVy/GG+t8t0OP2+0OqCDVZf6Ju2LA
         6ziVXE8NtAtSZVgFeY31cGb+lvYI4p5UNgUeEQTZlDKeWYyGx1j/kZHy1Xwq68OaQM
         upnbnG4ShUyNg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 05/10] modpost: remove redundant initializes for static variables
Date:   Tue,  5 Apr 2022 20:33:53 +0900
Message-Id: <20220405113359.2880241-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405113359.2880241-1-masahiroy@kernel.org>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are initialized with zeros without explicit initializes.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New

 scripts/mod/modpost.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f9e54247ae1d..2a202764ff48 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -23,15 +23,15 @@
 #include "../../include/linux/license.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
-static int modversions = 0;
+static int modversions;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
-static int all_versions = 0;
+static int all_versions;
 /* If we are modposting external module set to 1 */
-static int external_module = 0;
+static int external_module;
 /* Only warn about unresolved symbols */
-static int warn_unresolved = 0;
+static int warn_unresolved;
 /* How a symbol is exported */
-static int sec_mismatch_count = 0;
+static int sec_mismatch_count;
 static int sec_mismatch_warn_only = true;
 /* ignore missing files */
 static int ignore_missing_files;
-- 
2.32.0

