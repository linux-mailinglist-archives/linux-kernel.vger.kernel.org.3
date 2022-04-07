Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92374F8697
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiDGRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346625AbiDGRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:52:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF122EBEA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649353823; x=1680889823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JUgoIzkbObqNcLqCN60nFlf3X8vseVwgWs8e1aCpjC8=;
  b=Sl5M0A9acxrYaaSxBvivkfyF1w7sSIx12rXvhcBxiI8PPk1859P0l7Sg
   2uRVCh7++cKAM0eqVccZE8u37rm6Vh23mEEGu/UQDLTcTwFKA3XMlz8E6
   SexUC3u1s+S1bafrEU+R/w/uF7edxDKWJ7IOJMQ+9Etk7x895OYfTir11
   5PwmgUh8wKqNCUaZ0p2tTNQE0KZXxdEVuMGxVUSMfilT0Fr406FPKHf3l
   gTa+tSAB8Dj+i6OEx7FPa6Kqjq029wGzJDnbQ2LQ/E8RB+sAf6hLT4uTz
   m+lL/ry7ap2c4j2s/pom9C5NwCTQsINI20gdWBwH/KuoWDvxLvkzzr26i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="324557191"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="324557191"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 10:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="793042580"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2022 10:50:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 156B3132; Thu,  7 Apr 2022 20:47:44 +0300 (EEST)
Date:   Thu, 7 Apr 2022 20:47:44 +0300
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
Message-ID: <20220407174744.cskt3rg63io4lkug@black.fi.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
 <b43720c6-0763-f4bb-64a0-7745c6ad920a@intel.com>
 <Yk8WZn+etpj/o0OM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk8WZn+etpj/o0OM@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:50:46PM +0000, Sean Christopherson wrote:
> On Thu, Apr 07, 2022, Dave Hansen wrote:
> > On 4/5/22 16:29, Kirill A. Shutemov wrote:
> > ...
> > >  arch/x86/coco/Makefile                   |   2 +
> > >  arch/x86/coco/core.c                     |  22 +-
> > >  arch/x86/coco/tdx/Makefile               |   3 +
> > >  arch/x86/coco/tdx/tdcall.S               | 204 +++++++
> > >  arch/x86/coco/tdx/tdx.c                  | 692 +++++++++++++++++++++++
> > 
> > This coco/ code currently doesn't have a specific MAINTAINERS entry.
> > That makes me a bit worried that folks like Kirill won't get cc'd on
> > patches.
> > 
> > Should we just do a MAINTAINERS entry like this?

No objections on my side.

> > It would also be really nice to get some SEV folks on the list as
> > well.  I suspect the coco/ directory will grow more common SEV/TDX
> > code over time.
> > 
> > X86 CONFIDENTIAL COMPUTING
> > M:      x86@kernel.org
> > R:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ...
> > S:      Supported
> > F:      arch/x86/coco/
> > ...
> 
> And/or a dedicated vger list?

We already have linux-coco@lists.linux.dev. Although, it is not
x86-specific.

-- 
 Kirill A. Shutemov
