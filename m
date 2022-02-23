Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0534C11CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiBWLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiBWLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:47:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF85FCB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645616834; x=1677152834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a4XrRLzJgCeKX3RMtmk/h3LXQfDWPVmPOqxxh3Pn1c0=;
  b=DbJALNwmEgLlvUmVmzesRR3H4UI7OINNLCl21QUIbT9IgJULXAv7pMo4
   Qo9kPDQaDNJfemayPxEaYz63/m401N4sZX/pvyyEYiYnpSbpO9ZRwRjZ7
   gxYOL7b9/6hAsYQ7Lw/a6/kuwZwxQUnYMObw6/RibYPDt4/EdV6zegUSS
   gsOwki6oTRh8C9oJuAWqey5tRRw2V2rqOzaxMJzrfar74WZkCwC0lzuQX
   LPZOoZ8MYPYBs9IIE7bJQte7e2NwB4lsa0r8ViyX7rT+5dH0b/Kzs7xPf
   6nTT4S4uKXNvR69xJRkya1smMYwiXiQETk2CfdV+tZ6GkgGi+ruqnAGzT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251681026"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251681026"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="505884390"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2022 03:47:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8903A142; Wed, 23 Feb 2022 13:47:24 +0200 (EET)
Date:   Wed, 23 Feb 2022 14:47:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Wei Liu <wei.liu@kernel.org>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM
 dependency
Message-ID: <20220223114724.4luaemfi3tyedlvh@black.fi.intel.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
 <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
 <YhVCoveTwsDZXE5G@zn.tnic>
 <4769a3c0-449b-184a-5c61-a0e155f9c5b4@gmail.com>
 <YhYPPHKZFsGzaI2U@zn.tnic>
 <bcdbd534-a077-3bb3-3d37-c9eb2a048854@gmail.com>
 <YhYS00FywnE8g4Um@zn.tnic>
 <b172898d-0464-054a-9182-1110297f3629@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b172898d-0464-054a-9182-1110297f3629@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:02:49PM +0800, Tianyu Lan wrote:
> On 2/23/2022 6:56 PM, Borislav Petkov wrote:
> > On Wed, Feb 23, 2022 at 06:43:40PM +0800, Tianyu Lan wrote:
> > > Hyper-V code check cpuid during runtime and there is no Hyper-V
> > > isolation VM option.
> > 
> > So how does "Current Hyper-V Isolation VM requires AMD_MEM_ENCRYPT" work
> > exactly?
> > 
> > Please explain in detail and not in piecemeal sentences.
> > 
> The kernel in the image needs to select AMD_MEM_ENCRYPT option
> otherwise the kernel can't boot up due to missing SEV support and
> sev_es_ghcb_hv_call() always return error.

If kernel boots under SEV, doesn't it mean we have 'sme_me_mask'
initialized? If it is non zero hv_is_isolation_supported() check in
cc_platform_has() has zero effect as it checked after 'sme_me_mask'.

I still have no idea what is going on.

How SEV related to HyperV isolation? How detection happens? Could you
give full picture?

-- 
 Kirill A. Shutemov
