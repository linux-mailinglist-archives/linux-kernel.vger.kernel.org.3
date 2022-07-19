Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBB57A987
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbiGSVze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGSVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:55:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058642ACE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658267730; x=1689803730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uJNXesApcPuv7+f0CPvAyEmeKAEtnNkTdPgBgkJeCrE=;
  b=XwAL5vXBp6TnACaMB1ihmTJAaD1Lu408893gCGR3IQIxtI5I1CAKVzE4
   KGO+XxCiqpnStX8aFI0/3NGpdS3jj7xDVd0HURS8YRnRdEZsy28IBkIAl
   4jQzyy81za0UM6qcqEqDEqpMsgCoPTQB97ca/raL+KEOWcH2clKTxpBU7
   oSTXF21pnTV8lm4JJ/bh2DTXKsbvgmSbe154vCuDZdcV6OTFSYvl6u37J
   zKGBYCjBUu8zuXVorl0SY14F/lI64GjjkHXGe7HROov6yaFwsZ89E5BqO
   Qu8R35DVWuoiytJmwq0LEtQD1D0RiV4BogW3QHjVVvEHSEjLHQW4wOxa/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372919359"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="372919359"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 14:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="665614565"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2022 14:55:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 484CB10E; Wed, 20 Jul 2022 00:55:34 +0300 (EEST)
Date:   Wed, 20 Jul 2022 00:55:34 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Message-ID: <20220719215534.obolreae5dxdk223@black.fi.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
 <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
 <fe896ec7-cfce-e8ce-240d-88cca47f8996@intel.com>
 <6b84f9058ce5e60fdf3e4abd075a2b8f591ccffc.camel@intel.com>
 <20220705152910.rq2ga25gnw7kuvt5@box.shutemov.name>
 <5804d4a8-8c5f-5352-8eed-4962e0adca1c@linux.intel.com>
 <20220719161354.27cak6zy3uws3fvm@black.fi.intel.com>
 <1f320d34-c467-38fa-17b1-d0c7cde7b0d0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f320d34-c467-38fa-17b1-d0c7cde7b0d0@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:10:20AM -0700, Sathyanarayanan Kuppuswamy wrote:
> >> +static struct shmem_priv intel_shmem = {
> >> +       .init  = intel_shmem_init,
> >> +       .alloc = intel_shmem_alloc,
> >> +       .free  = intel_shmem_free,
> >> +};
> > 
> > Hm. What is Intel-specific here. Looks like a generic thing, no?
> > 
> > Maybe just drop all vendor stuff. CC_ATTR_MEM_ENCRYPT should be enough.
> 
> I thought that not all CC vendors would want to use DMA APIs for shared
> buffer allocation. So adding a vendor layer would give them a way to implement
> their own model.

set_memory_decrypted() is gated by CC_ATTR_MEM_ENCRYPT and it is the only
requirement for functionality AFAICS.

-- 
 Kirill A. Shutemov
