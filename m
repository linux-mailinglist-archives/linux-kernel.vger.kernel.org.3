Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1449692D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiAVB1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:27:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:64619 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbiAVB1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642814822; x=1674350822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UD7s7Zcefoz9ISDKfMgvrzcYY3klPxvRu6niB2q8PFE=;
  b=PLv4uIOZxav2Ac0ou0AtCLq/5vbaNOph40YAq/TAJqqH1ObpfuLKo/zu
   XHDD0yjGIMoLyUUHqTakWCVn6X6rCdXlDU4yokufQHP/LUj9rg6GukVPU
   EwM86oawSOCpXmUCNhCDvXLfr+y/iWM5N+NGNIoLw1KypBLS8rhGEoGaM
   6978gZJ7sBHlzK5g+FoZY456HnmmKeDvDPaLRvvMaU5AmhhbbLUf5+9K5
   Wk+ggPdtKXX+waHJ57offewDkpW5M+I9e2uBAGckuRO5pZ8wPb+xVEdqt
   Bp5qzMHmG1U9VYL30XZr0zlZ3jotYl7gaiRKW/9nX5YkdHexXn4Ol1wyl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="233133928"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="233133928"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:27:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="694827753"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:27:01 -0800
Date:   Fri, 21 Jan 2022 17:27:00 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "bp@alien8.de >> Borislav Petkov" <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Phantom PMEM poison issue
Message-ID: <YetdZBbt0P/QBHDr@agluck-desk2.amr.corp.intel.com>
References: <1737f707-7743-4898-37d4-03098d7aaa57@oracle.com>
 <0aab10e0-6f1d-d67b-8aef-7e3d18e26544@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aab10e0-6f1d-d67b-8aef-7e3d18e26544@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 12:40:18AM +0000, Jane Chu wrote:
> On 1/21/2022 4:31 PM, Jane Chu wrote:
> > On baremetal Intel platform with DCPMEM installed and configured to
> > provision daxfs, say a poison was consumed by a load from a user thread,
> > and then daxfs takes action and clears the poison, confirmed by "ndctl
> > -NM".
> > 
> > Now, depends on the luck, after sometime(from a few seconds to 5+ hours)
> > the ghost of the previous poison will surface, and it takes
> > unload/reload the libnvdimm drivers in order to drive the phantom poison
> > away, confirmed by ARS.
> > 
> > Turns out, the issue is quite reproducible with the latest stable Linux.
> > 
> > Here is the relevant console message after injected 8 poisons in one
> > page via
> >     # ndctl inject-error namespace0.0 -n 2 -B 8210
> 
> There is a cut-n-paste error, the above line should be
>    "# ndctl inject-error namespace0.0 -n 8 -B 8210"

You say "in one page" here. What is the page size? 
> 
> -jane
> 
> > then, cleared them all, and wait for 5+ hours, notice the time stamp.
> > BTW, the system is idle otherwise.
> > 
> > [ 2439.742296] mce: Uncorrected hardware memory error in user-access at
> > 1850602400
> > [ 2439.742420] Memory failure: 0x1850602: Sending SIGBUS to
> > fsdax_poison_v1:8457 due to hardware memory corruption
> > [ 2439.761866] Memory failure: 0x1850602: recovery action for dax page:
> > Recovered
> > [ 2439.769949] mce: [Hardware Error]: Machine check events logged
> > -1850603000 uncached-minus<->write-back
> > [ 2439.769984] x86/PAT: memtype_reserve failed [mem
> > 0x1850602000-0x1850602fff], track uncached-minus, req uncached-minus
> > [ 2439.769985] Could not invalidate pfn=0x1850602 from 1:1 map
> > [ 2440.856351] x86/PAT: fsdax_poison_v1:8457 freeing invalid memtype
> > [mem 0x1850602000-0x1850602fff]

This error is reported in PFN=1850602 (at offset 0x400 = 1K)

> > 
> > At this point,
> > # ndctl list -NMu -r 0
> > {
> >     "dev":"namespace0.0",
> >     "mode":"fsdax",
> >     "map":"dev",
> >     "size":"15.75 GiB (16.91 GB)",
> >     "uuid":"2ccc540a-3c7b-4b91-b87b-9e897ad0b9bb",
> >     "sector_size":4096,
> >     "align":2097152,
> >     "blockdev":"pmem0"
> > }
> > 
> > [21351.992296] {2}[Hardware Error]: Hardware error from APEI Generic
> > Hardware Error Source: 1
> > [21352.001528] {2}[Hardware Error]: event severity: recoverable
> > [21352.007838] {2}[Hardware Error]:  Error 0, type: recoverable
> > [21352.014156] {2}[Hardware Error]:   section_type: memory error
> > [21352.020572] {2}[Hardware Error]:   physical_address: 0x0000001850603200

This error is in the following page: PFN=1850603 (at offset 0x200 = 512b)

Is that what you mean by "phantom error" ... from a different
address from those that were injected?

-Tony
