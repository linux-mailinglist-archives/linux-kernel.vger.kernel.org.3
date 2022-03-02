Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D284CA424
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbiCBLuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiCBLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:50:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB50D457B7;
        Wed,  2 Mar 2022 03:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646221764; x=1677757764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v/8Z9henQ4GELSvmZeIpH0uJzq3nMVEvEH4YDo/BPMw=;
  b=MXdP8tTBhT+PXTOjsN53nzQUS4uBHl1QxGs+wwjdzbAgkqdefD0UVky8
   YA409pcbyNFHRZcmLH6p23+RZ2l3SB7dWz4EzLKtpAK33O1oV24NOa0x4
   AedXc4DCUsyiNmiSIWUYbjBROCaQN/bb6huk5egLSviZbhDAhW2GEhobj
   tGL/HQ4zXYLvr2kA21AbQlCpC8L3+2UnDYguOYGDnhxRzfYp1iwFvZmXr
   3jawUKa2dddWM+Kk0tf2ZCXEzIGmlOIHALchPM7jdBy2P6+RfZ4Qj3o/K
   g3IecPoUn3qRFfEaIiOSmvi3igRj8R3QeRP+k7YsT7tspGE4+eap8unxH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="236892113"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="236892113"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:49:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="535358916"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:49:22 -0800
Date:   Wed, 2 Mar 2022 11:49:16 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <Yh9ZvLHuztwQCu0d@silpixa00400314>
References: <20220219210354.GF59715@dread.disaster.area>
 <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
 <YhN76/ONC9qgIKQc@silpixa00400314>
 <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
 <Yh0y75aegqS4jIP7@silpixa00400314>
 <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
 <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh9G7FyCLtsm2mFA@kroah.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Mar 02, 2022 at 11:29:00AM +0100, Greg KH wrote:
> On Tue, Mar 01, 2022 at 04:11:13PM +1200, Herbert Xu wrote:
> > On Mon, Feb 28, 2022 at 05:12:20PM -0800, Linus Torvalds wrote:
> > > 
> > > It sounds like it was incidental and almost accidental that it fixed
> > > that thing, and nobody realized it should perhaps be also moved to
> > > stable.
> > 
> > Yes this was incidental.  The patch in question fixes an issue in
> > OOM situations where drivers that must allocate memory on each
> > request may lead to dead-lock so it's not really targeted at qat.
> 
> Ok, so what commits should I backport to kernels older than 5.10 to
> resolve this?
Is it possible to wait for a set that resolves the problem rather than
backporting the patches that disables the use-case?
I have a patchset that fixes the actual issue and we are doing an
internal review before submission to the mailing list.
I should be able to send a V1 out between today and tomorrow.

If not, then these are the patches that should be backported:
    7bcb2c99f8ed crypto: algapi - use common mechanism for inheriting flags
    2eb27c11937e crypto: algapi - add NEED_FALLBACK to INHERITED_FLAGS
    fbb6cda44190 crypto: algapi - introduce the flag CRYPTO_ALG_ALLOCATES_MEMORY
    b8aa7dc5c753 crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY
    cd74693870fb dm crypt: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY
Herbert, correct me if I'm wrong here.

Thanks,

-- 
Giovanni
