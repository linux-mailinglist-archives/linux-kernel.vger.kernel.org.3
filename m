Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14B4CCB91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiCDCLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiCDCLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:11:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FD91255B1;
        Thu,  3 Mar 2022 18:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646359863; x=1677895863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=stQFDxklUEDe2JE4ukqbDc1BpeH8q6qPMRCTSGj/cFU=;
  b=RGHmwTcQNugSFsX42PAPJIw1nvO35r79+Tp15FJdC31U43WdqiewHlNe
   KrV7vbGUN+cABhPH8YVx4GTeyqRcoLQSohgyF74ihLWZM50sPHAwt4UbA
   eD77lCLtnlPz8Z6zM6ilwLfqYypIf8xVbasZYD71dqXyks5eOFw/6Ocbd
   Xntx7R6leKd6GrUjCZXgto3T39MAU6ISA7rcuUfiQxCeUNTaUXw7++ANW
   tMIOqeLNFO1DC5WEJ7UFFh0/YU9J5LeNv/flrqbmOf1KXBM2hXP2cL5PV
   DZT6CMzHNuaNz+i9+bPENHsiCHpCA3CbNeGA0T1gMJOvqa0Dn5uBXR8xb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="317097241"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="317097241"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 18:11:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="511692613"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2022 18:11:01 -0800
Date:   Fri, 4 Mar 2022 10:11:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel test robot <lkp@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] lib/Kconfig.debug: add ARCH dependency for
 FUNCTION_ALIGN option
Message-ID: <20220304021100.GN4548@shbuild999.sh.intel.com>
References: <20220303082048.16558-1-feng.tang@intel.com>
 <20220303174550.4baa4d6d228320f09807c987@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303174550.4baa4d6d228320f09807c987@linux-foundation.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 05:45:50PM -0800, Andrew Morton wrote:
> On Thu,  3 Mar 2022 16:20:48 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > 0Day robots reported there is compiling issue for 'csky' ARCH
> > when CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED is enabled [1]:
> > 
> > ...
> >
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -401,8 +401,8 @@ config SECTION_MISMATCH_WARN_ONLY
> >  	  If unsure, say Y.
> >  
> >  config DEBUG_FORCE_FUNCTION_ALIGN_64B
> > -	bool "Force all function address 64B aligned" if EXPERT
> > -	depends on PPC || ARM || X86
> 
> I cannot find a kernel which contains the above line?

Sorry. I generated the patch while forgetting to revert the older version
https://lore.kernel.org/lkml/20220228022022.GG4548@shbuild999.sh.intel.com/

Here is the correct versin, thanks!

---

From 817dca1a74778979ba71ed362eac36feab5ac112 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Fri, 4 Mar 2022 10:03:40 +0800
Subject: [PATCH] lib/Kconfig.debug: add ARCH dependency for FUNCTION_ALIGN
 option

0Day robots reported there is compiling issue for 'csky' ARCH
when CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED is enabled [1]:

"
All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:2277: Error: pcrel offset for branch to .LS000B too far (0x3c)
"

Which has been discussed in [2]. And as there is no solution for csky
yet, add some dependency for this config to limit it to several ARCHs
which have no compiling issue so far.

[1]. https://lore.kernel.org/lkml/202202271612.W32UJAj2-lkp@intel.com/
[2]. https://www.spinics.net/lists/linux-kbuild/msg30298.html

Reported-by: kernel test robot <lkp@intel.com>
Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 lib/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..440fd666c16d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -416,7 +416,8 @@ config SECTION_MISMATCH_WARN_ONLY
 	  If unsure, say Y.
 
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
-	bool "Force all function address 64B aligned" if EXPERT
+	bool "Force all function address 64B aligned"
+	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC)
 	help
 	  There are cases that a commit from one domain changes the function
 	  address alignment of other domains, and cause magic performance
-- 
2.27.0


