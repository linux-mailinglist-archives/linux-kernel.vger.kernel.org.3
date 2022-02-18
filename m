Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A993D4BAFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiBRCWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:22:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiBRCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:22:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A01207FE1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645150955; x=1676686955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QU8J+dWQ/tdSGzMJktnA28S9uF/ngVGBExUxOBiC6E=;
  b=WZRdFohrs9hoOYmlbCMTWI7NmDDPK+5Cq5Fr34BHbB2iu+XAzzRFKsmL
   q4FZ1gS1XvsnrwMvYz90xj0970PEWPtIo2DpRYqj53Z7gYoTLXhRO9u6g
   DG4I4EpKvl1Y5Pa9zdH7owX/KXqSqgY4BRxzZeFbKpNOeChJa7myZ3+Mi
   RyugdF85m4grHgt3p6Mwj5pisci765jN6n5auXOD2340xVe2JPXkqVhva
   Bz2V7nkBK6E+P/YdzFnIMPIevxF8WoPt9M93TcAlBydMBCmRkYQ3jqAtZ
   jWvDPlIMOu+H0xk5ALGXejxVs+93xVlLs4IR1N/3ehKVe2V3OiggObypq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="249866414"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="249866414"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 18:22:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="504259881"
Received: from rbfawkes-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.127.120])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 18:22:34 -0800
Date:   Thu, 17 Feb 2022 18:22:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 16/44] mm/pkeys: Introduce pks_mk_readwrite()
Message-ID: <Yg8C6UkgfBmQlPSq@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-17-ira.weiny@intel.com>
 <a1f74401512ee19176397633aa823f9b6e375973.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f74401512ee19176397633aa823f9b6e375973.camel@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:10:39PM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > +void pks_update_protection(int pkey, u32 protection)
> > +{
> 
> I don't know if this matters too much, but the type of a pkey is either
> int or u16 across this series and PKU. But it's only possibly a 4 bit
> value.

I was settling on 'int' because the PKRU code uses int a lot.

That said, PKRU is a bit more complicated; x86 is 4 bits, powerpc is 5 bits,
and I see 4 different types for pkey [int, u16, u32, s16].

The signed values are used to mean 'key or error' in a couple of places.  Which
leaves 'int' as a convenient choice over 's16' IMO.  The use of u32 and u16
seems arbitrary.  Both should be plenty big for generic core code.

> Seems the smallest that would fit is char. Why use one over the
> other?
> 
> Also, why u32 for protection here? The whole pkrs value containing the
> bits for all keys is 32 bits, but per key there is only room ever for 2
> bits, right?

Correct but I'm not sure anything would be saved by declaring u8.  Regardless
I've changed it.

> 
> It would be nice to be consistent and have a reason, but again, I don't
> know if makes any real difference.

I was consistent in the core code with 'int'.  I'll look at cleaning up some of
the PKRU code but I think that is a separate series from this one.

For this series I'll standardize on u8 because u16 is also too big.  I have
seen one place where it would be nice to have a type of unsigned to check the
bounds of the pkey.  So you have a valid point that following the PKRU code was
less than ideal.

Ira
