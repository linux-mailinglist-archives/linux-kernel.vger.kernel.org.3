Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A94FFAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiDMQEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:04:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9826556
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649865749; x=1681401749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vEfGCLciTRVozTL9o246yJ/aR9lha4XWlq8MjHNUi0k=;
  b=FXSo1CSECTa+y3wdYY3hDbHWbOuBp6IS9Lmye+1NfdDp/ImAhoXJu5Tn
   HeOdkXT3m1zqcZpVA1Ro3HvABIW4f6ezJ+IWPcF/3Q68sWVUfiKBA4Wus
   RQwWcEA98KkYCjHnYAMt4dhwEyS9IbNQ44g9kFuDGiE4ixB+ju8ctZgax
   2LbpbH0t8/H+btBV90daUcOp3WJJUpf5a6LUSgMSTOMlhSxlG9d//51LX
   9fWcmwk6mJFMkqlGVoBwJ3sqk0N2Cc1zL566RCpDfEM6tio3B0y625RV7
   P+Y6zZBBFk7awmbe27osftBWtghlNr0gI2OCH6YzVOovkHSWUljvQQrtj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323148801"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323148801"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="573331211"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Apr 2022 09:02:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nefRp-0000Qr-BA;
        Wed, 13 Apr 2022 16:02:25 +0000
Date:   Thu, 14 Apr 2022 00:02:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] mm/shmem: vma_needs_copy can be static
Message-ID: <Ylb0CGeFJlc4EzLk@7ec4ff11d4ae>
References: <202204140043.Tx7BIBvI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204140043.Tx7BIBvI-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/memory.c:1238:1: warning: symbol 'vma_needs_copy' was not declared. Should it be static?

Fixes: 729c63ce2bbd ("mm/shmem: handle uffd-wp during fork()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index a426c46dd6f68..92cca76bcd3ee 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1234,7 +1234,7 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
  * false when we can speed up fork() by allowing lazy page faults later until
  * when the child accesses the memory range.
  */
-bool
+static bool
 vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
 	/*
