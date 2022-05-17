Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557A752AB05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352282AbiEQSiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiEQSiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:38:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4AC37BF8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652812693; x=1684348693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FTTY9ZFMfeTd8CI19p2u5YEYLQvqFSdIkPKeSEcRj4U=;
  b=YUuJ/uUKTbiDNFd4y++5VrAtg9TpHLmaQenw1VguwtX41VOsbhYcMRF/
   +WV0jZz/ovTh+WHJfS7eQRHhBgYjW+E8ObYQgDD0n7CfZOzOp8KeKP4Fe
   VYbasYy4TvlRO7GunlbYTbiEkFfGWN9jqVa275WZBao3zWJUM6JdUEeGS
   wwNSrmswYoqYhBDSfdikZlBQtDBiz6ZTjH6SyfPxWhCU/dvRPiBJeUOYZ
   QGskWD3gpuE6SjUsaml91/F7Ork3NINy/Q9NA4CSxLKovZaGw83ziWULl
   8bN9fKRiUZPr3iWIzLVMvNFZs4sWOAi/nUmcbAcNKejAp2N0+8d/tYKlM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251180154"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251180154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="555910452"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 11:38:12 -0700
Date:   Tue, 17 May 2022 11:41:54 -0700
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
Subject: Re: [PATCH v6 21/29] x86/nmi: Add an NMI_WATCHDOG NMI handler
 category
Message-ID: <20220517184154.GA6711@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
 <87a6bqrelv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6bqrelv.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:59:40PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 17:00, Ricardo Neri wrote:
> > Add a NMI_WATCHDOG as a new category of NMI handler. This new category
> > is to be used with the HPET-based hardlockup detector. This detector
> > does not have a direct way of checking if the HPET timer is the source of
> > the NMI. Instead, it indirectly estimates it using the time-stamp counter.
> >
> > Therefore, we may have false-positives in case another NMI occurs within
> > the estimated time window. For this reason, we want the handler of the
> > detector to be called after all the NMI_LOCAL handlers. A simple way
> > of achieving this with a new NMI handler category.
> >
> > @@ -379,6 +385,10 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
> >  	}
> >  	raw_spin_unlock(&nmi_reason_lock);
> >  
> > +	handled = nmi_handle(NMI_WATCHDOG, regs);
> > +	if (handled == NMI_HANDLED)
> > +		goto out;
> > +
> 
> How is this supposed to work reliably?
> 
> If perf is active and the HPET NMI and the perf NMI come in around the
> same time, then nmi_handle(LOCAL) can swallow the NMI and the watchdog
> won't be checked. Because MSI is strictly edge and the message is only
> sent once, this can result in a stale watchdog, no?

This is true. Instead, at the end of each NMI I should _also_ check if the TSC
is within the expected value of the HPET NMI watchdog. In this way, unrelated
NMIs (e.g., perf NMI) are handled and we don't miss the NMI from the HPET
channel.

Thanks and BR,
Ricardo
