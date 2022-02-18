Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A734BB0CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiBREkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:40:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBREkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:40:02 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A82271E7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645159187; x=1676695187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kfOGR1ANBtU2GIap7Y1oxV3GGuoKoOq1IwoEsgH8zL4=;
  b=Omzwo/+t/mwZZcMnO5d/3QRw9R7bDTCzeoDnT+HRX5dUlECJ3CSCcDFv
   KWx3Ibb7x1FkTiIeAgRJCOlx7ezK9JrBwjqjqdhs/ohzUr+8E6GbiofCB
   GXISXN230Qi6TPrECc3oSgjH/342WbORUgtqSBYmBfhfoB3Jahsg8WbI+
   lJ80UirGUuWVQ2DXdaB4SD38AThyG2fuxleSSmmO9ThcWV768APWxdSnA
   GOW81So4JAwQ95tcqiZe2o3Q6Y1kunorfQTs1cj9XB5yO+27IQjtTUoSm
   xuYbGBKxG3t1uM6E7vcXyC/Qom7TAD4sT6HYHi9VNtlaxalhLpgnVjC8l
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311792062"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="311792062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:39:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="546100157"
Received: from rbfawkes-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.127.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:39:47 -0800
Date:   Thu, 17 Feb 2022 20:39:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 16/44] mm/pkeys: Introduce pks_mk_readwrite()
Message-ID: <Yg8jEltirmvzWOAs@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-17-ira.weiny@intel.com>
 <87f171f1-c44b-5103-f9e5-20a6b5c257dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f171f1-c44b-5103-f9e5-20a6b5c257dd@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:40:06AM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > +static inline void pks_mk_readwrite(int pkey)
> > +{
> > +	pks_update_protection(pkey, PKEY_READ_WRITE);
> > +}
> 
> I don't really like the "mk" terminology in here.  Maybe it's from
> dealing with the PTE helpers, but "mk" to me means that it won't do
> anything observable by itself.  We're also not starved for space here,
> and it's really odd to abbreviate "make->mk" but not do "readwrite->rw".
> 
> This really is going off and changing a register value.  I think:
> 
> 	pks_set_readwrite()

Ok  For completeness I'm changing the pgmap_mk_* calls to match; pgmap_set_*.

> 
> would be fine.  This starts to get a bit redundant, but looks fine too:
> 
> 	pks_set_key_readwrite()

Yes I think that is a bit to verbose.

I think pks_set_xxx() reads nicely.

Ira
