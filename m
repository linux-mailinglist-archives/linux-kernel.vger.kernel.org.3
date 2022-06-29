Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460F2560242
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiF2OPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiF2OPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:15:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209535869;
        Wed, 29 Jun 2022 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656512112; x=1688048112;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4nrdIMH7LeQTNEo2WI2WMtd03lmym7Tvgf9klz9R2g=;
  b=DhTgs/y/vDSEG19s8uyQFlPdp2EZBZ4P8CGNNWC8Kd3gpGRSxzq3nLYo
   ieJS3sNj9yFwbR73/3W7Y2mKqH5feZEn4d/MTJk1N2GcG3AQTfjBKLJYG
   EZx2kyXDf/+dPrdxcfUuK+AtQtjNCWAxpToOkDV3R+Xdvfe3qGu2FUTs7
   LgP9+JwbG+98mIQsmdPhg0T6WGd3e40UQCOMOGpsyjFId54Y0TSCno0iW
   6lKqCfqAc7DBhB9c2aYr21kXzQ5RgHNzdoYYMgqRQGi7kCUodu/BxnvpV
   LSyFEY/7w/UbhF4S+kPpcWrI9c8FGr05cYNrA31/5HXjTnlCDePA6XIQW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343728904"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="343728904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 07:14:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647409322"
Received: from egolubev-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.68.9])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 07:14:35 -0700
Message-ID: <4fa1d4befe5de6d402aeb72ec1ae9953789da3ec.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: PUNIT device mapping with Sub-NUMA
 clustering
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Jun 2022 07:14:34 -0700
In-Reply-To: <55a6470c-1ce5-b237-d3be-1b98e4dbe3ce@redhat.com>
References: <20220627215031.2158825-1-srinivas.pandruvada@linux.intel.com>
         <55a6470c-1ce5-b237-d3be-1b98e4dbe3ce@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the review.

On Wed, 2022-06-29 at 12:00 +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/27/22 23:50, Srinivas Pandruvada wrote:
> > 
[...]

> >  
> > +struct isst_if_pkg_info {
> > +       struct pci_dev *pci_dev[2];
> 
> This and (continued below) ...
> 
Didn't understand the comment.

> > +};
> > +
> >  static struct isst_if_cpu_info *isst_cpu_info;
> > +static struct isst_if_pkg_info *isst_pkg_info;
> > +
> >  #define ISST_MAX_PCI_DOMAINS   8
> >  
> >  static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no,
> > int dev, int fn)
> >  {
> > +       int pkg_id = topology_physical_package_id(cpu);
> >         struct pci_dev *matched_pci_dev = NULL;
> >         struct pci_dev *pci_dev = NULL;
> >         int no_matches = 0;
> > @@ -324,6 +331,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int
> > cpu, int bus_no, int dev, int fn
> >                 }
> >  
> >                 if (node == isst_cpu_info[cpu].numa_node) {
> > +                       isst_pkg_info[pkg_id].pci_dev[bus_no] =
> > _pci_dev;
> > +
> 
> This and ...
> 
Please explain the comment.

> >                         pci_dev = _pci_dev;
> >                         break;
> >                 }
> > @@ -342,6 +351,9 @@ static struct pci_dev *_isst_if_get_pci_dev(int
> > cpu, int bus_no, int dev, int fn
> >         if (!pci_dev && no_matches == 1)
> >                 pci_dev = matched_pci_dev;
> >  
> > +       if (!pci_dev)
> > +               pci_dev = isst_pkg_info[pkg_id].pci_dev[bus_no];
> > +
> 
> This assumes that bus_no is never > 1, is this assumption enforced
> somewhere?
> 
Yes. That is checked at the beginning of function
   if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
            cpu >= num_possible_cpus())
	 return NULL;


> Also maybe make the 2 in:
> 
> > +struct isst_if_pkg_info {
> > +       struct pci_dev *pci_dev[2];
> 
> a #define ?
I will.

Thanks,
Srinivas

> 
> Regards,
> 
> Hans
> 
> 
> >         return pci_dev;
> >  }
> >  
> > @@ -417,10 +429,19 @@ static int isst_if_cpu_info_init(void)
> >         if (!isst_cpu_info)
> >                 return -ENOMEM;
> >  
> > +       isst_pkg_info = kcalloc(topology_max_packages(),
> > +                               sizeof(*isst_pkg_info),
> > +                               GFP_KERNEL);
> > +       if (!isst_pkg_info) {
> > +               kfree(isst_cpu_info);
> > +               return -ENOMEM;
> > +       }
> > +
> >         ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> >                                 "platform/x86/isst-if:online",
> >                                 isst_if_cpu_online, NULL);
> >         if (ret < 0) {
> > +               kfree(isst_pkg_info);
> >                 kfree(isst_cpu_info);
> >                 return ret;
> >         }
> > @@ -433,6 +454,7 @@ static int isst_if_cpu_info_init(void)
> >  static void isst_if_cpu_info_exit(void)
> >  {
> >         cpuhp_remove_state(isst_if_online_id);
> > +       kfree(isst_pkg_info);
> >         kfree(isst_cpu_info);
> >  };
> >  
> 

