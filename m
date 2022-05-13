Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279BB526CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiEMWNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiEMWNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:13:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E2B719DB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652479996; x=1684015996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cxef9S28Y+ZsR9yxpw47GL3tVgcHUSJqzLfqt+5PNSo=;
  b=Q04s0Y9VtUDQRM4mG92f3MMBXfQDBkqGdEsZ5j/+TPA+YetCe2HoTezj
   dpwcplWrID1tY897TIoEynRXM9J1r3FoLjtucFULc7YdfcXlwpqIYZI9O
   TUnta5b22dKHX/BYW2M8+u+l+bcr85RvGTtFSaJC60iXsSFrzbybWY9L9
   dWuqvpPN5PeRb+UfK3WwWYLgS1XxEmzxVji8oNtyCU4JWtSBS3lzBO6UM
   47ukV5tF9WKnxqga4DyNC4gT8zXhjnhutRev+KtpIPh1X6DmpCMWpXNnG
   PVk2eDh/Rl9ke6LPIOY/vSeEXYvdiLXuh5SRaUV4ra6S3tQ3Jnj4CUlhJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270357920"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270357920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="543454884"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2022 15:13:15 -0700
Date:   Fri, 13 May 2022 15:16:50 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 22/29] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20220513221650.GA8691@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
 <877d6uref8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d6uref8.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:03:39PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 17:00, Ricardo Neri wrote:
> > +	if (is_hpet_hld_interrupt(hdata)) {
> > +		/*
> > +		 * Kick the timer first. If the HPET channel is periodic, it
> > +		 * helps to reduce the delta between the expected TSC value and
> > +		 * its actual value the next time the HPET channel fires.
> > +		 */
> > +		kick_timer(hdata, !(hdata->has_periodic));
> > +
> > +		if (cpumask_weight(hld_data->monitored_cpumask) > 1) {
> > +			/*
> > +			 * Since we cannot know the source of an NMI, the best
> > +			 * we can do is to use a flag to indicate to all online
> > +			 * CPUs that they will get an NMI and that the source of
> > +			 * that NMI is the hardlockup detector. Offline CPUs
> > +			 * also receive the NMI but they ignore it.
> > +			 *
> > +			 * Even though we are in NMI context, we have concluded
> > +			 * that the NMI came from the HPET channel assigned to
> > +			 * the detector, an event that is infrequent and only
> > +			 * occurs in the handling CPU. There should not be races
> > +			 * with other NMIs.
> > +			 */
> > +			cpumask_copy(hld_data->inspect_cpumask,
> > +				     cpu_online_mask);
> > +
> > +			/* If we are here, IPI shorthands are enabled. */
> > +			apic->send_IPI_allbutself(NMI_VECTOR);
> 
> So if the monitored cpumask is a subset of online CPUs, which is the
> case when isolation features are enabled, then you still send NMIs to
> those isolated CPUs. I'm sure the isolation folks will be enthused.

Yes, I acknowledged this limitation in the cover letter. I should also update
Documentation/admin-guide/lockup-watchdogs.rst.

This patchset proposes the HPET NMI watchdog as an opt-in feature.

Perhaps the limitation might be mitigated by adding a check for non-housekeeping
and non-monitored CPUs in exc_nmi(). However, that will not eliminate the
problem of isolated CPUs also getting the NMI.

Thanks and BR,
Ricardo
