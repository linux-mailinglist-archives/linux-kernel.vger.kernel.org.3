Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D64EDF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiCaQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiCaQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:57:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337C232126
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648745728; x=1680281728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IP3Qpce+WyUMM7QQju7XQB09RXxl0bxyb7Ub1Mu6XFw=;
  b=h8KQH+NoeIedIId8FAtpRbnODA1ENehdpJyjzsX5l8PBYUrc8wg3Y6J8
   xUiJWqf1EJOq1NZtFEcMj0MyRXYfxXa21AyVEFxYk65K4B1czWauwJdNT
   Uh/BFFR6LXoc749hPi8il/W261YmKpQdBzHoN5H+YhT/tvSHgU+gcUR/m
   NClr5zWBYBVS5N3V5tITCIgPmKFDOLz5zxQIemGSy2pJFKxmXstSuHiEn
   NN5wX6Sf1jbAsOlEJJ2aXNejGDMYWSOZ/x9i3tPj8mJO6Xrtxgr2G/CCl
   W6gPY5rCmn2C8OfeJxSzS3zF/CxNot0R+Oa9SQF5FGl/COk7Gax7++ckh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247393493"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="247393493"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="522420778"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2022 09:54:57 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZy4W-0000SS-Hu;
        Thu, 31 Mar 2022 16:54:56 +0000
Date:   Fri, 1 Apr 2022 00:54:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] mm/secretmem: secretmem_iops can be static
Message-ID: <YkXc0RjJYQoGZZ8A@57de4820519d>
References: <202204010033.oeIla4qb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204010033.oeIla4qb-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/secretmem.c:173:31: warning: symbol 'secretmem_iops' was not declared. Should it be static?

Fixes: 24209f2f4d62 ("mm/secretmem: fix panic when growing a memfd_secret")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 mm/secretmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index a83e98aa3a7b3..ddf45c0435be7 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -170,7 +170,7 @@ static int secretmem_setattr(struct user_namespace *mnt_userns,
 	return simple_setattr(mnt_userns, dentry, iattr);
 }
 
-const struct inode_operations secretmem_iops = {
+static const struct inode_operations secretmem_iops = {
 	.setattr = secretmem_setattr,
 };
 
