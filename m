Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB1477A82
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhLPRZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:25:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:34536 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235830AbhLPRZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639675504; x=1671211504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2nNZew6Z9ZNfBloxy8d/28ymfM5DvMdcScX6xoLtWB8=;
  b=WL6MODUimiFDhFWO6VpPEjwsITgtq7p/fEDnHSMUwJcGFRWAe6juMHA8
   rdaHeUKlCsVJJkqT/zNzqdRTwNiZFmUxWvTpxQo2qfsrw8MJu56IJJqpd
   DL1qSb5ae3kx141UMhgdKAegomww9IDFGxSzCmy4mY3qe5x/JYUXMg6ck
   dVLGD3eVjJ21pY5zsVP9E5Q0wjC69gV1DZtN0NQL7JAFultMdhW9w0DLm
   LaBriacddGrUf4lx0N7inwzue7k62OEIKZWMdE5U3NhXfj/Az0mOhPAm/
   rq4XVO45NOwRl4db6tCWnVzhu0cIq0Q3GkOAWE1efR9UwPHELv8FVhhr1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226832914"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="226832914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 09:24:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="519336265"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 09:24:37 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpufeatures: Add fast-short-rep-movs check to copy_user_enhanced_fast_string()
Date:   Thu, 16 Dec 2021 09:24:31 -0800
Message-Id: <20211216172431.1396371-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f444a5ff95dc ("x86/cpufeatures: Add support for fast short REP; MOVSB")
fixed memmove() with an ALTERNATIVE that will use REP MOVSB for all
string lengths.

copy_user_enhanced_fast_string() has a similar run time check to avoid
using REP MOVSB for copies less that 64 bytes.

Add an ALTERNATIVE to patch out the short length check and always use
REP MOVSB on X86_FEATURE_FSRM CPUs.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/lib/copy_user_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e630b9b1..1c429f0489dd 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -200,8 +200,8 @@ EXPORT_SYMBOL(copy_user_generic_string)
  */
 SYM_FUNC_START(copy_user_enhanced_fast_string)
 	ASM_STAC
-	cmpl $64,%edx
-	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
+	/* CPUs without FSRM should avoid rep movsb for short copies */
+	ALTERNATIVE "cmpl $64, %edx; jb .L_copy_short_string", "", X86_FEATURE_FSRM
 	movl %edx,%ecx
 1:	rep
 	movsb
-- 
2.31.1

