Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D794E2C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350265AbiCUPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbiCUPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:32:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264A26ADE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647876651; x=1679412651;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-id;
  bh=6R4a25yf57fnkmnxguh1KEXG3Yi7RK574IAzZuSCxo0=;
  b=iHLVzCQzJO8mJF11+7FlSj1QBO1nNIYq8zzkDIFpURUW/H2TAaJnu9UA
   iCYbEdAAJ6hwGSjqH4oA30ASDa2cKa6tWrJqSO3WKq8RlQO+dlwHDBsBm
   HFCJBH8W3ZhI0eyip5rAqeo3fF9ipbYcu69ycUx9lUEWpztE4vXm0XfJV
   0RcDNsxzV4txEPSPE7ekDB5R9HZKlNKvreNuI51/x6p/+rv9Hf4PwUz6A
   apHcGsYQfI4uvnpjM0EsSjFx7P7tlmTT+KRyZ0c3witwHV9BqEuAUcMBO
   ADd+qMPpMM10nfBVeazJIujKHPE1MwwXYMrgwy05SYVHIToqS/6wAOsXs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="320782235"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="320782235"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:30:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="518479086"
Received: from jfecht-mobl.ger.corp.intel.com ([10.252.56.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:30:49 -0700
Date:   Mon, 21 Mar 2022 17:30:44 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Joe Perches <joe@perches.com>
cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] checkpatch: don't suggest else is not useful with
 chained
Message-ID: <139ce92d-32f-4187-2f38-48e6ec354b74@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-481241047-1647876567=:10813"
Content-ID: <39465e99-31a-ad9f-4da-d2131c594354@linux.intel.com>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-481241047-1647876567=:10813
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a12940d6-75b4-a163-1678-c2f852ce7a8b@linux.intel.com>

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

 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..ec0d9ac7e555 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4037,14 +4037,23 @@ sub process {
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
+				if ($lines[$ifline] !~ /^[\+ ]\t{$tabs,$tabs}(\} *|)else if\s*\(/) {
+					WARN("UNNECESSARY_ELSE",
+					     "else is not generally useful after a break or return\n" . $hereprev);
+				}
 			}
 		}
 
-- 
2.30.2
--8323329-481241047-1647876567=:10813--
