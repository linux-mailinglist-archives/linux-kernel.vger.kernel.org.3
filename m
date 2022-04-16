Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78EE5032E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiDPDqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiDPDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:46:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED7B1AA5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650080649; x=1681616649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k584vKKiP9rD6Rub7r/+a7TUTKHJARYTn4kDakiB38M=;
  b=Vcic4Q4R+WoIwN9NGBpT8Ut14P4kzmNnwMxNmA6SLa3XQUilVvXA7koG
   3ezQlpvUqcudIvs2b+w5ZmU3ylnq+cBRNPpfFFpLyUveJygXhhO0n70g/
   XGPt4kNIjpAPmdZijO+m1AT3k8qdOBIATsIyd1jCpbNHkO4b+GmPpaixK
   hxEuZhFDcsP5qCAY9pWcVe1NaQld/eNRNA4eDE09ekyysvomUp4naJjDF
   RyqoerOG7+OIWpLMTqnyC+Gu1QjF5HtIX+QA8u/b2ybufWtylLglsuEN5
   kcuYlRH8Nc+T5Vwvewhm54IE6780MIYSLKxjgsZ8B6zSJt+IC7h6QDWmc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="326167372"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="326167372"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 20:44:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="528160721"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 20:44:09 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1] checkpatch: Skip "From" tag from 75 character limit enforcement
Date:   Sat, 16 Apr 2022 03:43:50 +0000
Message-Id: <db07b0f2a4ff86723b9631d4a2c5a10829a716d5.1650080239.git.sathyanarayanan.kuppuswamy@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>

Currently, checkpatch script skips tags like "Fixes", "Link" and
"$signature_tags" when enforcing the 75 character limit in the commit
log. But it is missing the "From" tag in the skip list. So if a commit
log includes a "From:" tag with a long name or email, it reports a
false warning message.

To avoid this issue, include the "From" tag in the 75 character limit
enforcement skip list.

Reported-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e02998701..c8cbc216f098 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3174,7 +3174,7 @@ sub process {
 					# file delta changes
 		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
-		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
+		      $line =~ /^\s*(?:From:|Fixes:|Link:|$signature_tags)/i ||
 					# A Fixes: or Link: line or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
-- 
2.25.1

