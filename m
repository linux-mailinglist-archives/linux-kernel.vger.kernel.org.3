Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FE4836C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiACSXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:23:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:40648 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235464AbiACSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641234199; x=1672770199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n5k2UhdN+j7gY/E4tkTwvjhub+C6mmhH7yewhVj0DJA=;
  b=EXanNZ5cAXIoNLRgXv8K9S16keFuO+sDO5ML62SJ04LtF83U2wnAwb+Q
   isyjb6A+Lp5ZT5Wroh+3Z/+oBqeCPa0+fa0ZScuJZMtMTzVG7TSjLCV6v
   vJK5fqGMA42KCunDK6Nq99Vkkx9XvqKMLGq4phtVhtj9WlYnfcCWod3if
   cUnhB8q0kzVtV26OMQopBh0x2HjLZpexAqUGdSrYECNi3AJrbPqNxoTiq
   ysTzJS38zQudKvGhYpuH2TEMNUj8xnp+48tKCewSBZ/if827GTKkl55E3
   NrEOdPPqSRCUK6iRJPseAXWvC7AfwzV6iMHljd3H+sdJC1hdD3T93NCrn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="229414668"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="229414668"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 10:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="573775933"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2022 10:23:18 -0800
Date:   Mon, 3 Jan 2022 10:24:59 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
Message-ID: <20220103182459.GA5706@ranerica-svr.sc.intel.com>
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
 <20211220151438.1196-4-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hQUMBw-0t0QzvCfOvzp0WEhE64xiU1JX2jkzdG5BJrMg@mail.gmail.com>
 <20220102214647.GC14930@ranerica-svr.sc.intel.com>
 <2f284d197a5cc160d973a81c898ff42fb4a75db1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f284d197a5cc160d973a81c898ff42fb4a75db1.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 06:22:33PM -0800, srinivas pandruvada wrote:
> On Sun, 2022-01-02 at 13:46 -0800, Ricardo Neri wrote:
> > On Thu, Dec 30, 2021 at 07:43:22PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 20, 2021 at 4:23 PM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > 
> > > 
> [...]
> 
> > > This looks like it may be too general, because HFI is not a
> > > thermal-only thing.
> > 
> > > 
> > > Maybe cal it INTEL_HFI_THERMAL?
> > 
> > True. The *Enhanced* HFI introduces the concept of thread classes
> > [1]. I was
> > planning to wrap this patchset, which parses the HFI table and deals
> > with updates, as INTEL_HFI. The code that deals with classes would be
> > wrapped as INTEL_EHFI.
> > 
> > After this comment, so you still think that INTEL_HFI_THERMAL makes
> > more
> > sense?
> In general most of the configs for Intel thermal is has THERMAL suffix,
> so to be consistent may be add THERMAL also at the end.
> 
> You can still add INTEL_EHFI as a silent config, which user will not
> select. It will be selected by default with INTEL_HFI_THERMAL.

That makes sense to me. I will add the _THERMAL suffix to the config
option.

Thanks and BR,
Ricardo
