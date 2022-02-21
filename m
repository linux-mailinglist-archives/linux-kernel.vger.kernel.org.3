Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C61E4BE229
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376742AbiBUNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:53:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376788AbiBUNxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:53:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9FDE9E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645451605; x=1676987605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ErfHXPfkw5Ja9S/Lcj6RYf+Mflg/caQz6cN0PzobeDU=;
  b=epajSyECE+nmk4J9PUVUlwidiHWg6YfypkWY1+Dfjfjs//nPJsgODVG2
   EpwFR3C9NDjtDnnRfkfZJsdStpNAzOkXw4DoniItUYXozROBSZRbxhOAg
   3HeCTHV8GPlatjzII8rhZSCQqiA2EltmG+ZYJzBvTPbc2uiefb5WFisgw
   iI1NdatzjzrD/Pr5Z8dg9JVH6tUpE35bppKHGa/zp0doTycHNqSesla0s
   QdIZ02GzEg9ycUfjsUq4WX9wd3aj3VCodiaObzEDd0l0JYRrIf3hY9ipG
   1SL80EDX5qUM8EGzTh5wS6/Ds9uEyluFQyYRgXc1WU5rtKTedBw/j1q9T
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337942288"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="337942288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 05:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="505082386"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2022 05:53:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 13737161; Mon, 21 Feb 2022 15:53:34 +0200 (EET)
Date:   Mon, 21 Feb 2022 16:53:34 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 13/32] x86/tdx: Detect TDX at early kernel
 decompression time
Message-ID: <20220221135334.zzcozxu6vyskxjzo@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-14-kirill.shutemov@linux.intel.com>
 <YhN5edJQ+LkVc0us@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhN5edJQ+LkVc0us@grain>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 02:37:29PM +0300, Cyrill Gorcunov wrote:
> On Fri, Feb 18, 2022 at 07:16:59PM +0300, Kirill A. Shutemov wrote:
> ...
> > 
> > +
> > +void early_tdx_detect(void)
> > +{
> > +	u32 eax, sig[3];
> > +
> > +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> > +
> > +	if (memcmp(TDX_IDENT, sig, 12))
> > +		return;
> 
> Maybe worth to guard ourself, like
> 
> 	BUILD_BUG_ON(sizeof(sig) != (sizeof(TDX_IDENT)-1));
> 	if (memcmp(TDX_IDENT, sig, sizeof(sig))
> 		return;

Sure. Will do.

-- 
 Kirill A. Shutemov
