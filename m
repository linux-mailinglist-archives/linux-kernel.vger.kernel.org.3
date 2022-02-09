Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139204AE970
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiBIFoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:44:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiBIFfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:35:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2C9C004589
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644384924; x=1675920924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KE6xfqngCfvzZJKMLOkMX94zaj2SFyiEC9rCfOFqENM=;
  b=lkAd10fmMC0/H6g0Nk5x/yiSTWjh28NZpZeqH8TixmBotEFfEtWDLFhB
   C+RmHLnVJOgoOQIAF40JMokj2xO5gdztW42OiTu8EwPbybkky9eAJ6mXY
   5UZCuvDUB5DS0LJE6iw5/2816wGXv8zwlD7d0PwtxNrHdiIpTgskB0oSV
   PuMYnviMyd48gFSMyeYH2ujMVcLfL9jTGFOQVtgrjSoePGxPEN2+mU6ca
   TSU0DRPF+ufpnEwYPDpXwWB8TUM1OUmH+mINUDf3v6T96yteTdsxlTl5A
   dcJbFcXGZr5FYaF9esG+YYa/Pei4qUwDpvhf1G1tgMM3gOs2yNxwE0+we
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249331348"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="249331348"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 21:34:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="525844931"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 21:34:30 -0800
Date:   Tue, 8 Feb 2022 21:34:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
Message-ID: <20220209053430.GL785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
 <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
 <20220128231015.GK785175@iweiny-DESK2.sc.intel.com>
 <f72b0e17-11bf-b12e-fe7a-d38b0833acdc@intel.com>
 <20220204190851.GY785175@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204190851.GY785175@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 11:08:51AM -0800, 'Ira Weiny' wrote:
> On Fri, Jan 28, 2022 at 03:51:56PM -0800, Dave Hansen wrote:
> > On 1/28/22 15:10, Ira Weiny wrote:
> > > This issue is that because PKS users are in kernel only and are not part of the
> > > architecture specific code there needs to be 2 mechanisms within the Kconfig
> > > structure.  One to communicate an architectures support PKS such that the user
> > > who needs it can depend on that config as well as a second to allow that user
> > > to communicate back to the architecture to enable PKS.
> > 
> > I *think* the point here is to ensure that PKS isn't compiled in unless
> > it is supported *AND* needed.
> 
> Yes.
> 
> > You have to have architecture support
> > (ARCH_HAS_SUPERVISOR_PKEYS) to permit features that depend on PKS to be
> > enabled.  Then, once one ore more of *THOSE* is enabled,
> > ARCH_ENABLE_SUPERVISOR_PKEYS comes into play and actually compiles the
> > feature in.
> > 
> > In other words, there are two things that must happen before the code
> > gets compiled in:
> > 
> > 1. Arch support
> > 2. One or more features to use the arch support
> 
> Yes.  I really think we are both say the same thing with different words.

Is the following more clear?

<commit>

PKS is only useful to kernel consumers and is only available on some
architectures.  If no kernel consumers are configured or PKS support is
not available the PKS code can be eliminated from the compile.

Define a Kconfig structure which allows kernel consumers to detect
architecture support (ARCH_HAS_SUPERVISOR_PKEYS) and, if available,
indicate that PKS should be compiled in (ARCH_ENABLE_SUPERVISOR_PKEYS).

In this patch ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first
kernel consumer sets it.

</commit>

Thanks,
Ira
