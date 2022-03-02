Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A591D4CB26C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiCBWnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCBWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:43:22 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF010DA55;
        Wed,  2 Mar 2022 14:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646260958; x=1677796958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbbW6zgJhdL9jTUIjV0Xlnv2OOGVQA6qbG62TLxohm0=;
  b=FsO4is93K045DnGK93t7T/oX5D6QUNugPwidN75HJ74ld5rRPF5sZPxN
   pjRPwjfcgbNou1ZLQKVIZ+62hDEp7itStJGeAmbvpG0tzsMncWp+svOLO
   AFn2OvB9it9e59gV7Ocs/k3bSxrHLO6vcOg7syiZ5+/lpjrAAxlcGW+xK
   ebVKkM3BoRjwF9EuVoQTDZaZ1O/RMCZ6y02dfY1BDvp/4PHAQeT7LMkPp
   kTspu1vlIyki4Y3sxLBdOJ38Ay3+sYx0DlEz98TajHfKrMqOgMqz+ZroH
   jTyPW7ADLV2TRuZqi2EaHzq386NVCcqkW1oxmqbRj/GiMqbgBjZTlv5eC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="314240759"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="314240759"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 14:42:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="508365588"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 14:42:35 -0800
Date:   Wed, 2 Mar 2022 22:42:20 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <Yh/yr6oB5yeOUErL@silpixa00400314>
References: <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
 <Yh0y75aegqS4jIP7@silpixa00400314>
 <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
 <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com>
 <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:27:47AM +1200, Herbert Xu wrote:
> On Wed, Mar 02, 2022 at 03:56:36PM +0100, Greg KH wrote:
> >
> > > If not, then these are the patches that should be backported:
> > >     7bcb2c99f8ed crypto: algapi - use common mechanism for inheriting flags
> > >     2eb27c11937e crypto: algapi - add NEED_FALLBACK to INHERITED_FLAGS
> > >     fbb6cda44190 crypto: algapi - introduce the flag CRYPTO_ALG_ALLOCATES_MEMORY
> > >     b8aa7dc5c753 crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY
> > >     cd74693870fb dm crypt: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY
> > > Herbert, correct me if I'm wrong here.
> > 
> > These need to be manually backported as they do not apply cleanly.  Can
> > you provide such a set?  Or should I just disable a specific driver here
> > instead which would be easier overall?
> 
> I think the safest thing is to disable qat in stable (possibly only
> when DM_CRYPT is enabled/modular).  The patches in question while
> good may have too wide an effect for the stable kernel series.
> 
> Giovanni, could you send Greg a Kconfig patch to do that?
I was thinking, as an alternative, to lower the cra_priority in the QAT
driver for the algorithms used by dm-crypt so they are not used by
default.
Is that a viable option?

Sure, I can provide a patch for either the cra_priority or the Kconfig
option for the stable kernels that don't have the patches above.

-- 
Giovanni
