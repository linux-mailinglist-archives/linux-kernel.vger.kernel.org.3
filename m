Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5DE540248
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiFGPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiFGPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:20:06 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727FF66ADE;
        Tue,  7 Jun 2022 08:20:05 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 257FIhb0015394;
        Wed, 8 Jun 2022 00:18:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 257FIhb0015394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654615124;
        bh=LIQRolKJUy5EgtlTCuYPI57ux74QTIvAUnxIqYWqrlc=;
        h=From:To:Cc:Subject:Date:From;
        b=CaLs/kJ01/rgCoCm8BVFkd73Mc6d4vewxfkABOPm6hyicQVsd3ke2P1wGZCPm7f22
         Me1tksnhDPZprP3M5P6ATB8HbiO3LBwsje7N3NecSpjtNHucl1d5+ntZesivQ9l9pN
         Xp4kA2B6I79IBo2uGYQIe3Ez50/GhLBhIvFaEonaO6m2eIxorRl+FHrsAWlwkExR80
         Q88dk2b1+3KzdpG+mt4lrp3vBofWNaUyssqvkNsCvMkTY4U+3BWERcN86Ab8Z5LD7R
         tYPc7LMsX/XRduLrR6MnvI1IeLsUPFMqu8VDfO1N8YjlJo9SOR7dKQsDjoyhABFIdD
         75+iEOsQFPgHw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/nsdeps: adjust to the format change of *.mod files
Date:   Wed,  8 Jun 2022 00:18:40 +0900
Message-Id: <20220607151840.437500-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

Commit 22f26f21774f ("kbuild: get rid of duplication in *.mod files")
changed the format of *.mod files to put one object per line, but missed
to adjust scripts/nsdeps.

Fixes: 22f26f21774f ("kbuild: get rid of duplication in *.mod files")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/nsdeps | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index 04c4b96e95ec..f1718cc0d700 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -34,9 +34,8 @@ generate_deps() {
 	local mod=${1%.ko:}
 	shift
 	local namespaces="$*"
-	local mod_source_files="`cat $mod.mod | sed -n 1p                      \
-					      | sed -e 's/\.o/\.c/g'           \
-					      | sed "s|[^ ]* *|${src_prefix}&|g"`"
+	local mod_source_files=$(sed "s|^\(.*\)\.o$|${src_prefix}\1.c|" $mod.mod)
+
 	for ns in $namespaces; do
 		echo "Adding namespace $ns to module $mod.ko."
 		generate_deps_for_ns $ns "$mod_source_files"
-- 
2.32.0

