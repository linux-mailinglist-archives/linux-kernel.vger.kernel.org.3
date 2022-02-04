Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9714A9FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiBDTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:08:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:60628 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbiBDTIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644001733; x=1675537733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6SfLEIvZyltNvrg59VjyugMhouTIP12M6A8WGi67ek=;
  b=beztkDVODhACD80P5UR+C8z56e37t/ZKa9Z8b5mcnMxPLT3KJyfrXL0E
   I1KL0lHONRhDXNH52NjinfBdLNx9Vu0bDil1zUG0ZljUbAEMjG4uLIdYH
   FXLNAqb8op5I3yTDZHNZWl6RLMNbCL8h4h2H99uSEXmvsVwqRfhaH+Rae
   oyJu6EGrRewvAV1Dh9+EvYp9bWp9QoVmHTLjbSmBFp+x6g6x4kM+Pzs2F
   pgBnO20WuoK7w4LoWfpQwbt95AF2cHl2/nikzaStpoDvyJqurFaZIfQ6w
   KPh1sUbi9MIJgH9ZSv9jls3ZeGceefwkutvQ+1u8cToEyQkDJeEgowT22
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246015830"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246015830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:08:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="539270297"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:08:51 -0800
Date:   Fri, 4 Feb 2022 11:08:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
Message-ID: <20220204190851.GY785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
 <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
 <20220128231015.GK785175@iweiny-DESK2.sc.intel.com>
 <f72b0e17-11bf-b12e-fe7a-d38b0833acdc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72b0e17-11bf-b12e-fe7a-d38b0833acdc@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:51:56PM -0800, Dave Hansen wrote:
> On 1/28/22 15:10, Ira Weiny wrote:
> > This issue is that because PKS users are in kernel only and are not part of the
> > architecture specific code there needs to be 2 mechanisms within the Kconfig
> > structure.  One to communicate an architectures support PKS such that the user
> > who needs it can depend on that config as well as a second to allow that user
> > to communicate back to the architecture to enable PKS.
> 
> I *think* the point here is to ensure that PKS isn't compiled in unless
> it is supported *AND* needed.

Yes.

> You have to have architecture support
> (ARCH_HAS_SUPERVISOR_PKEYS) to permit features that depend on PKS to be
> enabled.  Then, once one ore more of *THOSE* is enabled,
> ARCH_ENABLE_SUPERVISOR_PKEYS comes into play and actually compiles the
> feature in.
> 
> In other words, there are two things that must happen before the code
> gets compiled in:
> 
> 1. Arch support
> 2. One or more features to use the arch support

Yes.  I really think we are both say the same thing with different words.

Ira
