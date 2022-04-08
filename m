Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBE4F9374
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiDHLEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiDHLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:04:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD9AA03A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649415757; x=1680951757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFxNXrQEPQt/s5mWa74/q1vXf4oIJJXO5fak1yrXHUc=;
  b=irgEN+FSmVLmLR2zDO7F8KYbx/l0mUbgirMry3mCEJwhdHQKVohB3OjY
   QWm63vhKOu8pIk/liBE1QwBbtvBZsn/tepgQ9I0Sv00+LHperf3bVQ6fw
   X4H/1hMlseyuZtqAZ1igwr16mcBix07yDERaVylTrNBhG0cNU7peFKGBH
   tXn5lWrqjx7jErANJitTpkHG+TdzSXXbXrBsKYBXdR9BOy1J+T11Rws4v
   yJjI2xpAObM/zAwL6AgpFEVpza1QRRhGHao0aj5lekDK2Q5OwxDLompeq
   6PaxIuqJkmOGJ/j5UEcshVlUxJ+fy6pY2XclwsFVv6tkmNGEhpCCbVwkB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241500691"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="241500691"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="589184437"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2022 04:02:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 57B5C132; Fri,  8 Apr 2022 14:01:16 +0300 (EEST)
Date:   Fri, 8 Apr 2022 14:01:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/30] TDX Guest: TDX core support
Message-ID: <20220408110116.bog3cdtig6entvjh@black.fi.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
 <b43720c6-0763-f4bb-64a0-7745c6ad920a@intel.com>
 <Yk8WZn+etpj/o0OM@google.com>
 <20220407174744.cskt3rg63io4lkug@black.fi.intel.com>
 <Yk8zEN9bZKiQltcL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk8zEN9bZKiQltcL@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 06:53:04PM +0000, Sean Christopherson wrote:
> On Thu, Apr 07, 2022, Kirill A. Shutemov wrote:
> > On Thu, Apr 07, 2022 at 04:50:46PM +0000, Sean Christopherson wrote:
> > > On Thu, Apr 07, 2022, Dave Hansen wrote:
> > > > It would also be really nice to get some SEV folks on the list as
> > > > well.  I suspect the coco/ directory will grow more common SEV/TDX
> > > > code over time.
> > > > 
> > > > X86 CONFIDENTIAL COMPUTING
> > > > M:      x86@kernel.org
> > > > R:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ...
> > > > S:      Supported
> > > > F:      arch/x86/coco/
> > > > ...
> > > 
> > > And/or a dedicated vger list?
> > 
> > We already have linux-coco@lists.linux.dev. Although, it is not
> > x86-specific.
> 
> Is it ok to spam that list with TDX/SNP stuff, or would it be better to create
> something x86-specific?

In this case the existing coco mailing list will have little to none use
as most of coco traffic is x86-specific at the moment. We can split off
x86-specific later if needed.

-- 
 Kirill A. Shutemov
