Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA14E2C77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbiCUPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241116AbiCUPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:40:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEB23525D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647877162; x=1679413162;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-id;
  bh=3Aag5Lg2XqSw0CYTSeDsRBKRLZ1KqwvDj9lANj/XeAU=;
  b=ZLYyPzE5q8OZrxHj/h/aUowgY1aT9/40H2sFuh2hZBkVK6jMxAEoxY8N
   0OxbJknu3N/mIiXWkSv8g4CjBI/tAqlFblgecum7GQBH5q7D7On9o7Vly
   47CcvvUlHGOZLzflKFXbqQ70oBoN46eUi9ZQ3CkXR2g1FU7B4YyNfKXCm
   ze+SybgMCigtKTgpZSf6YMRFUXLgGoQiSA97NsDxJXZyOxU5By2i25uzF
   Gfn0H4HE7FqU1hhismRwvvZEqRL9XjBhuFqUvGJE3fVPVIJIKSwsNdw+m
   rkPa/srKz7e1ROwN0FGDkXoC4M9pMkM4/v+oAb0qv3KagNaN/3UfMdIvI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="237523924"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="237523924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:39:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="600520915"
Received: from svisaggi-mobl2.ger.corp.intel.com (HELO jfecht-mobl.ger.corp.intel.com) ([10.252.56.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:39:20 -0700
Date:   Mon, 21 Mar 2022 17:39:18 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Joe Perches <joe@perches.com>
cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/1] checkpatch: don't suggest else is not useful with
 chained if blocks
Message-ID: <e14d1c82-775d-58ec-11f9-4f2771111fc3@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-719652851-1647876962=:10813"
Content-ID: <c05cf049-67b8-2ab4-d5ad-2b3251743ff@linux.intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-719652851-1647876962=:10813
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <666b7077-8a34-5624-8249-97f553fc3a14@linux.intel.com>

When if blocks are chained with "else if" like this:

	if (a)
		c = 0;
	else if (b)
		break;
	else
		c = 1;

checkpatch recommends removing else:

WARNING: else is not generally useful after a break or return

Removing else will easily introduce logic errors in this situation
so it's better to check if the preceding line has "else if" before
issuing that warning.

Fixes: 032a4c0f9a77 ("checkpatch: warn on unnecessary else after return or break")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Don't match spuriously to removed lines
- Extend check backwards to the first line with the same or lower indent 
  as "else" line

v3:
- Add back the check to ensure line is defined

 scripts/checkpatch.pl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..3ea73155c42b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4037,14 +4037,24 @@ sub process {
 # check indentation of any line with a bare else
 # (but not if it is a multiple line "if (foo) return bar; else return baz;")
 # if the previous line is a break or return and is indented 1 tab more...
+# but don't warn when there is "else if" before that line to avoid logic errors
 		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
 			my $tabs = length($1) + 1;
 			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
 			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
 			     defined $lines[$linenr] &&
 			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
-				WARN("UNNECESSARY_ELSE",
-				     "else is not generally useful after a break or return\n" . $hereprev);
+				my $ifline = $linenr - 3;
+				$tabs--;
+				while ($ifline >= 1 &&
+				       $lines[$ifline] !~ /^[^-]\t{0,$tabs}[^\t]/) {
+					$ifline--;
+				}
+				if (!defined $lines[$ifline] ||
+				    $lines[$ifline] !~ /^[\+ ]\t{$tabs,$tabs}(\} *|)else if\s*\(/) {
+					WARN("UNNECESSARY_ELSE",
+					     "else is not generally useful after a break or return\n" . $hereprev);
+				}
 			}
 		}
 
-- 
2.30.2
--8323329-719652851-1647876962=:10813--
