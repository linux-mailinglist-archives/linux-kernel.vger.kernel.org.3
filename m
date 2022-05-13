Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7145269C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383504AbiEMS6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383484AbiEMS6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:58:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A76BFD3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652468283; x=1684004283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCKiBLo5JPRevaGfzEi2/7NKS4ODTjaZmZIfll5payA=;
  b=bzXOv8Ur/Dyf8IXM97WGcM9FqyG5GYI/5yKQLxTPRg1MyXvYEDYjJNle
   GoN3oq+HczowEHatVndBVNgBOntiLZSvquPTV8/3Mut8GSfrnHpjsI70u
   aRe9WuWThsbVxdBv/ACmhIH+PoE3IxRFuL2tT79rSbnLnK7mzVwB5ytz7
   eAArfZMO3EpXxVUq+q0rJLtjL987Y6N1nB0hcxsGVqE0o4mqlqY22ffuf
   LOdN8l8cIeZK3G4npHuVaqZRsK7VdtuLom1wSMrDVU5YJmsx8gXs46pym
   lSvfLsrB8C6qDHBCg4naPPljwWsN5x+SEZmIBxnaVTfTxw4wnWBcvUT8H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="295647410"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="295647410"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 11:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="521535494"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2022 11:58:02 -0700
Date:   Fri, 13 May 2022 12:01:37 -0700
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
Subject: Re: [PATCH v6 12/29] iommu/amd: Enable NMIPass when allocating an
 NMI irq
Message-ID: <20220513190137.GC22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-13-ricardo.neri-calderon@linux.intel.com>
 <87tua2fj41.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tua2fj41.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:26:22PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> >  
> > +	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
> > +		/* Only one IRQ per NMI */
> > +		if (nr_irqs != 1)
> > +			return -EINVAL;
> 
> See previous reply.

I remove this check.

Thanks and BR,
Ricardo
> 
