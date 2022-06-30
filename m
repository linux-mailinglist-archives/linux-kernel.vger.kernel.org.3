Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C38560F41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiF3Cjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiF3Ci5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D491EC74
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656556728; x=1688092728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zwlsCioRpw1uFafDOCGVO1n7Aos4RJziHab6JNVMCos=;
  b=l1Tkkv4CTuMuhFDKsogHtQxmhlOQ1ufpACk4XaiMCLIM0mkzXKiip1WX
   bljKdYLdQrcgKlM09HxesI6cIc2Gb+80DJ0tuGwkq20ydS39cjDSXCO1B
   uuAWy7cTwB/2yvmMNpFo8vDd4oIRbGvHcnNBJuYEsGsOLXwzpmYKrE+bJ
   FqHQJI/QeCpnatU6vBVemFvDaU7a4XKgGgnWyIxL2tLkOfTBDUJXlHKpX
   EqKXYlvQcKkBIwGlGscqVtSYuD5NBicUjxJjBcWeM7kP1NFrrSA55JHCr
   OAYnCdIqkKUlRMKS2OHCu896lfCFQipIIucc54EXkAQ8T3X35BTdUBorr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262625562"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="262625562"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 19:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="917854750"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 19:38:44 -0700
Date:   Thu, 30 Jun 2022 10:38:44 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220630023844.GA4668@shbuild999.sh.intel.com>
References: <20220630014715.73330-1-feng.tang@intel.com>
 <20220629193006.77e9f071a5940e882c459cdd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629193006.77e9f071a5940e882c459cdd@linux-foundation.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for the review!

On Wed, Jun 29, 2022 at 07:30:06PM -0700, Andrew Morton wrote:
> On Thu, 30 Jun 2022 09:47:15 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > kmalloc's API family is critical for mm, with one shortcoming that
> > its object size is fixed to be power of 2. When user requests memory
> > for '2^n + 1' bytes, actually 2^(n+1) bytes will be allocated, so
> > in worst case, there is around 50% memory space waste.
> > 
> > We've met a kernel boot OOM panic, and from the dumped slab info:
> > 
> >     [   26.062145] kmalloc-2k            814056KB     814056KB
> > 
> > >From debug we found there are huge number of 'struct iova_magazine',
> > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> > 1016 bytes. Though the issue is solved by giving the right(bigger)
> > size of RAM, it is still better to optimize the size (either use
> > a kmalloc friendly size or create a dedicated slab for it).
> 
> Well that's nice, and additional visibility is presumably a good thing.
> 
> But what the heck is going on with iova_magazine?  Is anyone looking at
> moderating its impact?

Yes, I have a very simple patch at hand

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145..5422e67bb4b5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -614,7 +614,7 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  * dynamic size tuning described in the paper.
  */
 
-#define IOVA_MAG_SIZE 128
+#define IOVA_MAG_SIZE 127
 #define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_magazine {

I guess changing it from 128 to 127 will not hurt much, and plan to
send it out soon.

Thanks,
Feng


