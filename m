Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC148ED09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiANPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:19:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:7202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239376AbiANPTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642173571; x=1673709571;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qowLRleV7CksEzwRd59cyb0/LxsFQr8gPBqQKIbcK5c=;
  b=EXt8v70+q6m2THRpnpSwViRnC4s13fZBpv4er5u9aQCwkVYr6y4G1pCI
   QtLduMnfql/WIp8fddhnihPtE++pX6kcd0sboOPtkQnZcZL+60ZhyZKpe
   GQsoTzoYCfoOq9+RvrmyomtaK/i2CGgpDhdEI+lluzRx+xiTiQSbr0e4j
   nZg7MH9PErPrR/cn6AD+lO2HgDp/hhtUjeoNMrPgGoiRXZOVOz9MljPQN
   MhkHFaQSYW/vBYb6HRs1K69G1i+jwPzUCC/XKHbajcW8FEiFanRC+nUrS
   yKBOr4jMEjp7TLgDf7aTm63pMZrm8kL/vlflVhXq9B1pfWgD1S0b4RsaC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244218732"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="244218732"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 07:19:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="530279733"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 07:19:30 -0800
Date:   Fri, 14 Jan 2022 07:24:07 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <20220114072407.290691fa@jacob-builder>
In-Reply-To: <1b8d3145-c404-e952-e61e-5cdc2f6a92a6@linux.intel.com>
References: <1642080198-10971-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <b2139255-2463-c62f-4746-8df7f3f49221@linux.intel.com>
        <20220113191122.53bc6ac0@jacob-builder>
        <1b8d3145-c404-e952-e61e-5cdc2f6a92a6@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Fri, 14 Jan 2022 11:12:45 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> On 1/14/22 11:11 AM, Jacob Pan wrote:
> > On Fri, 14 Jan 2022 08:58:53 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> > wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 1/13/22 9:23 PM, Jacob Pan wrote:  
> >>> During PCI bus rescan, adding new devices involve two notifiers.
> >>> 1. dmar_pci_bus_notifier()
> >>> 2. iommu_bus_notifier()
> >>> The current code sets #1 as low priority (INT_MIN) which resulted in
> >>> #2 being invoked first. The result is that struct device pointer
> >>> cannot be found in DRHD search for the new device's DMAR/IOMMU.
> >>> Subsequently, the device is put under the "catch-all" IOMMU instead
> >>> of the correct one.
> >>>
> >>> This could cause system hang when device TLB invalidation is sent to
> >>> the wrong IOMMU. Invalidation timeout error or hard lockup can be
> >>> observed.
> >>>
> >>> This patch fixes the issue by setting a higher priority for
> >>> dmar_pci_bus_notifier. DRHD search for a new device will find the
> >>> correct IOMMU.
> >>>
> >>> Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
> >>> Reported-by: Zhang, Bernice<bernice.zhang@intel.com>
> >>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>    drivers/iommu/intel/dmar.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> >>> index 915bff76fe96..5d07e5b89c2e 100644
> >>> --- a/drivers/iommu/intel/dmar.c
> >>> +++ b/drivers/iommu/intel/dmar.c
> >>> @@ -385,7 +385,7 @@ static int dmar_pci_bus_notifier(struct
> >>> notifier_block *nb,
> >>>    static struct notifier_block dmar_pci_bus_nb = {
> >>>    	.notifier_call = dmar_pci_bus_notifier,
> >>> -	.priority = INT_MIN,
> >>> +	.priority = INT_MAX,
> >>>    };
> >>>    
> >>>    static struct dmar_drhd_unit *
> >>>      
> >> Nice catch! dmar_pci_bus_add_dev() should take place*before*
> >> iommu_probe_device(). This change enforces this with a higher notifier
> >> priority for dmar callback.
> >>
> >> Comparably, dmar_pci_bus_del_dev() should take place*after*
> >> iommu_release_device(). Perhaps we can use two notifiers, one for
> >> ADD_DEVICE (with .priority=INT_MAX) and the other for REMOVE_DEVICE
> >> (with .priority=INT_MIN)?
> >>  
> > Since device_to_iommu() lookup in intel_iommu_release_device() only
> > checks if device is under "an" IOMMU, not "the" IOMMU. Then the remove
> > path order is not needed, right?
> > 
> > I know this is not robust, but having so many notifiers with implicit
> > priority is not clean either.
> > 
> > Perhaps, we should have explicit priority defined around iommu_bus
> > notifier? i.e.
> > 
> > @@ -1841,6 +1841,7 @@ static int iommu_bus_init(struct bus_type *bus,
> > const struct iommu_ops *ops) return -ENOMEM;
> >          nb->notifier_call = iommu_bus_notifier;
> >                         
> > +       nb->priority = IOMMU_BUS_NOTIFY_PRIORITY;
> >                         
> > 
> >   static struct notifier_block dmar_pci_bus_add_nb = {
> >          .notifier_call = dmar_pci_bus_notifier,
> > -       .priority = INT_MIN,
> > +       .priority = IOMMU_BUS_NOTIFY_PRIORITY + 1,
> >   };
> > 
> >   static struct notifier_block dmar_pci_bus_remove_nb = {
> >          .notifier_call = dmar_pci_bus_notifier,
> > -       .priority = INT_MIN,
> > +       .priority = IOMMU_BUS_NOTIFY_PRIORITY - 1,
> >   };  
> 
> IOMMU_BUS_NOTIFY_PRIORITY by default is 0. So you can simply use 1 and
> -1? Adding a comment around it will be helpful.
> 
Yeah, I will add comment.


Thanks,

Jacob
