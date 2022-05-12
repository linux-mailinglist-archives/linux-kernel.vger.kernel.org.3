Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1481B524201
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiELBZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiELBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:25:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B50149171
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652318720; x=1683854720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KAdCvO2a+1p4JnZfxOvuZ/9ABl5DPkTt0ZZjzHocw5A=;
  b=gdWPTVd81/YPn38CGxMYt2Bp5C0K++5cNN5d7u7nQoO2NnMaOJc7VQ05
   94bOG8SI7Kseaa+8q8651M8D4N5HCELgkWda7aENIcWIBZHvES1x5X9E+
   frK3KifWEiygcWaK1jH26xD2D8PCxBN80fyxsoLA3thj0yBug2RCxONZg
   SOQSDhv6WRl/Q+oa7KmUeLyanMSxGXsExHzpwfM6neFD97q0hdCG4c59f
   AoTVlYccGL+5+DRQyNtoFiJd8pcuTHjiNNZ4fEgKFZd4cCRhYsuxu2OSQ
   ueFOZx+sHhZUG96UgpZScMdlUz1cderMq27LK1QhOAlhmKKi1h9rvmi/G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249752016"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="249752016"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 18:25:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="739467249"
Received: from mkmishra-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.36.168])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 18:25:19 -0700
Date:   Wed, 11 May 2022 18:25:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 33/44] kmap: Make kmap work for devmap protected pages
Message-ID: <Ynxh/5jewIuGwb5d@iweiny-desk3>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-34-ira.weiny@intel.com>
 <Ymq3yrQ3rmgnbX1o@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymq3yrQ3rmgnbX1o@infradead.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:50:34AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 19, 2022 at 10:06:38AM -0700, ira.weiny@intel.com wrote:
> > index a77be5630209..32ed07c2994b 100644
> > --- a/include/linux/highmem-internal.h
> > +++ b/include/linux/highmem-internal.h
> > @@ -151,6 +151,8 @@ static inline void totalhigh_pages_add(long count)
> >  
> >  #else /* CONFIG_HIGHMEM */
> >  
> > +#include <linux/memremap.h>
> 
> Uuuh, I'd really prefer to avoid having to pull in memremap.h into
> basically the whole kernel build.
> 

Fair enough.  What should I call a header to store the new pgmap_set_*() calls?

devmap_prot.h

?

Or I could just add the calls into highmem-internal.h.  That might be more
appropriate given the new direction of that interface.

I think I'm leaning toward that vs adding another header.

Ira
