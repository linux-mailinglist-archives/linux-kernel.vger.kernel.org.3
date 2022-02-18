Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF44BB1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiBRGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:01:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBRGBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:01:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE626512B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645164080; x=1676700080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WIaZmEHzMxcJvoDjxKbAEPF9S2X6WO7L8fWfrnJriR8=;
  b=L0090UBv+xR/lkb5JTOeY344iLTd2n08Hx9BgQKvajpH/ejzSPp25+9r
   KN7a2n68ImZYl4MH2O14ZWek7uL01LzKCfkMerZH+WUcLLJlaiAJaz68B
   fIAieSzQNKPAfR1jUvqcDKK672V6/augx4m+enDkbIJlKB6wHnbYUprAB
   vCpov+NZP0qSvhn3X5AQsiNYBvEoYU1HKcHBU7lb4ctuD3xVpgYiPvOT7
   yLNM9PoA8CEkgCCDajN2NRcNR/uQumM8ZWJFhqOS0aXp8ng4JQ349nU34
   qD1JxhPb2BuMTIgLnjeke87wbKzrl9YTsqiirhcS4C8GVdtIE4DaXsK6U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238463423"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="238463423"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:01:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="605453730"
Received: from rbfawkes-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.127.120])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:01:19 -0800
Date:   Thu, 17 Feb 2022 22:01:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
Message-ID: <Yg82L5ibjbn15AHO@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-27-ira.weiny@intel.com>
 <2a919d9ed8ed874f8b89014c0b42cbadb44d837b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a919d9ed8ed874f8b89014c0b42cbadb44d837b.camel@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:13:40AM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > +       if (error_code & X86_PF_PK)
> > +               pks_dump_fault_info(regs);
> > +
> 
> If the kernel makes an errant accesses to a userspace address with PKU
> enabled and the usersapce page marked AD, it should oops and get here,
> but will the X86_PF_PK bit be set even if smap is the real cause? Per
> the SDM, it sounds like it would:
> "
> For accesses to user-mode addresses, the flag is set if
> (1) CR4.PKE = 1;
> (2) the linear address has protection key i; and
> (3) the PKRU register (see Section 4.6.2) is such that either
>         (a) ADi = 1; or
>         (b) the following all hold:
>                 (i) WDi = 1;
>                 (ii) the access is a write access; and
>                 (iii) either CR0.WP = 1 or the access causing the
>                       page-fault exception was a user-mode access.
> "
> 
> ...and then this somewhat confusingly dumps the pks register. Is that
> the real behavior?

Are you suggesting the PKRU should be printed instead or in addition to the
PKS?

AFAICS this really should not present a problem even if the fault is due to a
user pkey violation.  It is simply extra information.

Ira
