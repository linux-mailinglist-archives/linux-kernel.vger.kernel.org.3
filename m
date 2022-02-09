Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EA4AEBD8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiBIIJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBIIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:09:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A48C0613CA;
        Wed,  9 Feb 2022 00:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644394154; x=1675930154;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=LKFwMYErOyQ7FD8kDgGe+wDCBONw9xSlkzc7M6XnIP0=;
  b=BKE71LYUJnNHfqI8MeZTrVZ20JkcJeZYoz/6NIJDgmquMLTFN9hJfLjp
   ZQymuTLFEv/AJiKmGOKM7GGf1YOsBQJbQuhHeSi8wtgCPW2YFXG/Nyvkx
   u+fP7PyqhntXc2m4UJbdaVYh548Q9OwzOQoBz/A2MxL/mlOcLGFlwrFwb
   wCuKMX5oDNEqValElx3prIJFhGv28KmTRKOJNtlU9psOl5avPXtxPfxuu
   pfeC17VL3903V04PRkZII0f0UuYSKSzEMRRFIz5il9H94ULIF26dXpi5D
   i8S93Rd0lq4XBbR+QzVesOfjImES7ZJwM9bwS/VTYa/gPEzNH5URIjoQK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335553362"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="335553362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 00:09:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="499884350"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 00:09:11 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
References: <20220209165837.19f27e9e@canb.auug.org.au>
Date:   Wed, 09 Feb 2022 16:09:09 +0800
In-Reply-To: <20220209165837.19f27e9e@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 9 Feb 2022 16:58:37 +1100")
Message-ID: <87r18cjwbe.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/admin-guide/sysctl/kernel.rst:603: WARNING: Inconsistent literal block quoting.
>
> Maybe introduced or exposed by commit
>
>   68d17e593eb9 ("numa-balancing-optimize-page-placement-for-memory-tiering-system-fix-fix")
>
> I am not clear what the warning means.

Hi, Stephen,

Found this is a restructuredtext format issue, the following patch fixes
it for me.

Best Regards,
Huang, Ying

-------------------------------------8<-------------------------------------------
From fb8b9aa5cbf49d37950d04fc808f464589c7e344 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 9 Feb 2022 16:04:11 +0800
Subject: [PATCH] numa-balancing-optimize-page-placement-for-memory-tiering-system-fix-fix-fix

Fix the following warnings of `make htmldocs`,

Documentation/admin-guide/sysctl/kernel.rst:603: WARNING: Inconsistent literal block quoting.
---
 Documentation/admin-guide/sysctl/kernel.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 078e1aff4adc..59c3b4ce37cd 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -597,7 +597,7 @@ numa_balancing
 
 Enables/disables and configures automatic page fault based NUMA memory
 balancing.  Memory is moved automatically to nodes that access it often. 
-The value to set can be the result of ORing the following::
+The value to set can be the result of ORing the following:
 
 = =================================
 0 NUMA_BALANCING_DISABLED
-- 
2.30.2

