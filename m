Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A388526D60
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiEMXNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiEMXNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:13:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F072E307DB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652483586; x=1684019586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RwN3h2frQEmuTLpALiwJVKiux9iit8+Y3qd7tVOSlJg=;
  b=fxmXik6QJGG2xgOwrO8vrWaONEC4D1f4qqzWNqk3NVF7ODugy+oGqFeW
   cgRGxbXUsqSGRWNXerAlwzB0c9SF9L+Ph07ZBCpy1e5XIOWYMA3qnrse5
   6qNC0bOsapAunq70VxYaUDbyn6N2+BibB0Hwr1TssmEyxwCVhhxb0gLQO
   pK5Bz9Dt3emKEUfHElK7cEPy0w0vdL7mFNgDWWc0iV3BpgGq27KOWXkDT
   SiHT0qMqZVuaUX/YweI2qXkpAfU0j87v3Lw007ak+f5r8mcrl0NP22VyO
   /UqMJizdvnyYDkMYKJL1mzjmiC65RSc6T363Q44OAq/BJY9zFqjLff9A8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="252479209"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="252479209"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 16:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="573202350"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 13 May 2022 16:13:04 -0700
Date:   Fri, 13 May 2022 16:16:40 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 20/29] init/main: Delay initialization of the lockup
 detector after smp_init()
Message-ID: <20220513231640.GA9074@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
 <1652178524.7j2o02lrl8.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652178524.7j2o02lrl8.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:38:22PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 9:59 am:
> > Certain implementations of the hardlockup detector require support for
> > Inter-Processor Interrupt shorthands. On x86, support for these can only
> > be determined after all the possible CPUs have booted once (in
> > smp_init()). Other architectures may not need such check.
> > 
> > lockup_detector_init() only performs the initializations of data
> > structures of the lockup detector. Hence, there are no dependencies on
> > smp_init().
> 

Thank you for your feedback Nicholas!

> I think this is the only real thing which affects other watchdog types?

Also patches 18 and 19 that decouple the NMI watchdog functionality from
perf.

> 
> Not sure if it's a big problem, the secondary CPUs coming up won't
> have their watchdog active until quite late, and the primary could
> implement its own timeout in __cpu_up for secondary coming up, and
> IPI it to get traces if necessary which is probably more robust.

Indeed that could work. Another alternative I have been pondering is to boot
the system with the perf-based NMI watchdog enabled. Once all CPUs are up
and running, switch to the HPET-based NMI watchdog and free the PMU counters.

> 
> Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thank you!

BR,
Ricardo
