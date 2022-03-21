Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0204E2328
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiCUJTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiCUJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:19:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B612D1C9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647854295; x=1679390295;
  h=date:from:to:subject:message-id:mime-version:content-id;
  bh=jonP4+6iYubBq/5erYu2VPXvdJ2xO+xya6wMVjF8LCs=;
  b=hVzoemsdgkSdZ5b6vZDSs4pBZaSRuQxDzyN3WNU4Q+ifOEpqcJXTno3u
   v6+lzzhWdIOFzBsoeGHIqCnpyDJ+sdLwovmaQj8GDSYcqIFCdtBDu1m9t
   fQXBfxq+ay6r0MxlitFYr0c+O5LBwrts2PP0LvlalhBGllr8ygeql3esM
   VB/IMMLwUhR/4jUSg/JEHzp9waEI+D/vTOXWwg8RjjC8A8oBliFF+FEdG
   wMCg08+WkJ36cu01rGZpG+yfMinellxfu1NW63pdLSMV+rqoo/fDgjsQn
   mjUElx+fPJDrUXDijhfmNd3RRUYInStKQ/kAcUDcLn0ztAmxAJG8q7sIJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="282332713"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="282332713"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:18:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559786130"
Received: from gvancuts-desk1.ger.corp.intel.com ([10.251.223.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:18:12 -0700
Date:   Mon, 21 Mar 2022 11:18:06 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/1] checkpatch: don't suggest else is not useful with
 chained
Message-ID: <5a7bace5-eb8e-6e91-ae89-e4e47ab53a90@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2061366498-1647612670=:1694"
Content-ID: <7dba770-c392-406a-bf65-e11efbef962@linux.intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2061366498-1647612670=:1694
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a2f22171-c7cc-8c71-fa1d-fdbea45af68@linux.intel.com>

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

I was only able to solve this case for single line if blocks but
it would be useful to address also multi-line if blocks but it is
beyond my understanding about checkpatch internals.

 scripts/checkpatch.pl | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..8e095b77bfb6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4037,14 +4037,17 @@ sub process {
 # check indentation of any line with a bare else
 # (but not if it is a multiple line "if (foo) return bar; else return baz;")
 # if the previous line is a break or return and is indented 1 tab more...
+# but don't warn when there is "else if" on before that line to avoid logic errors
 		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
 			my $tabs = length($1) + 1;
-			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
-			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
-			     defined $lines[$linenr] &&
-			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
+			if ($linenr >= 3 &&
+			    $lines[$linenr - 3] !~ /[} \t]else\s+if\s*\(/ &&
+			    ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
+			     ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
+			      defined $lines[$linenr] &&
+			      $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/))) {
 				WARN("UNNECESSARY_ELSE",
-				     "else is not generally useful after a break or return\n" . $hereprev);
+				     "else is not generally useful after a break or return\n" . $hereprev . "\n");
 			}
 		}
 
-- 
2.30.2
--8323329-2061366498-1647612670=:1694--
