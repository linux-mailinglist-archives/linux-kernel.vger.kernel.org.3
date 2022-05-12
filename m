Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63BF524191
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349691AbiELAfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbiELAfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:35:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B0A227835
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652315715; x=1683851715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dLBHzXs/7dIe56Ck53G1U2+PedWXR/Xhh4qftWNzQyo=;
  b=HpwEktkJh+JhmSx9dEdBPZSiOXyBYXUKYesmpH7CM64ZZK5/5bZsLxup
   JdmLB+/DJC/D4ZAPjjGWSeYaRJjX+DyAWo6nGSAJxLdauwY7Zg5NPcDwg
   jlJwUW3olL0JmxgaVPGhvnhu69/L2ISvbvfmb4IvlHVeBDtvh+GGpdOgg
   WGc8RnYaIrusBlLW5isigvXp3hLrd0GdaFtLsIr3BwMM3s9ly/8Y5o0UF
   png8tNu4yVG2oC6wmN5cA3BY5aaUZ1ubaQPIlQhsLETF4DIvG5eweRt5d
   N7wfpmDTy4Rz+Re0eDTWGSoeAFy136Ahb73/WOnA5URQL3oOuwVUucVvp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268684042"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="268684042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="711708630"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2022 17:35:14 -0700
Date:   Wed, 11 May 2022 17:38:45 -0700
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
Subject: Re: [PATCH v6 03/29] x86/apic/msi: Set the delivery mode
 individually for each IRQ
Message-ID: <20220512003845.GC16273@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
 <8735hmh1f5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735hmh1f5.ffs@tglx>
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

On Fri, May 06, 2022 at 10:05:34PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > There are no restrictions in hardware to set  MSI messages with its
> > own delivery mode.
> 
> "messages with its own" ? Plural/singular confusion.

Yes, this is not correct. It should have read "messages with their own..."

> 
> > Use the mode specified in the provided IRQ hardware
> > configuration data. Since most of the IRQs are configured to use the
> > delivery mode of the APIC driver in use (set in all of them to
> > APIC_DELIVERY_MODE_FIXED), the only functional changes are where
> > IRQs are configured to use a specific delivery mode.
> 
> This does not parse. There are no functional changes due to this patch
> and there is no point talking about functional changes in subsequent
> patches here.

I will remove this.

> 
> > Changing the utility function __irq_msi_compose_msg() takes care of
> > implementing the change in the in the local APIC, PCI-MSI, and DMAR-MSI
> 
> in the in the

Sorry! This is not correct.

> 
> > irq_chips.
> >
> > The IO-APIC irq_chip configures the entries in the interrupt redirection
> > table using the delivery mode specified in the corresponding MSI message.
> > Since the MSI message is composed by a higher irq_chip in the hierarchy,
> > it does not need to be updated.
> 
> The point is that updating __irq_msi_compose_msg() covers _all_ MSI
> consumers including IO-APIC.
> 
> I had to read that changelog 3 times to make sense of it. Something like
> this perhaps:
> 
>   "x86/apic/msi: Use the delivery mode from irq_cfg for message composition
> 
>    irq_cfg provides a delivery mode for each interrupt. Use it instead
>    of the hardcoded APIC_DELIVERY_MODE_FIXED. This allows to compose
>    messages for NMI delivery mode which is required to implement a HPET
>    based NMI watchdog.
> 
>    No functional change as the default delivery mode is set to
>    APIC_DELIVERY_MODE_FIXED."

Thank you for your help on the changelog! I will take your suggestion.

BR,
Ricardo
> 
> Thanks,
> 
>         tglx
