Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B90511070
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357769AbiD0FTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355829AbiD0FS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:18:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52717369DA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651036547; x=1682572547;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4k2lqCBsdLB6FDMhkJVMQ/3jFI1YfOs57EnX9zrWiMM=;
  b=cPrE845ZvSAq70i6lL8SMPLjEYzjnwCGNJD30USdE8sR1MhdzCPvQerr
   fCles/vLuP4KjU+1xfw+RbZJEg4XYKwP0fJKasmyfMtNzPZkW83C6qail
   hVUb9zEfyB6IAxF7AVpEwU5Jxdum/VzaRq1pg2QK8cfHtFt/Cou7QN2un
   olVDFDOOhOqZGIKh+SoYUmM0WFZLjB6NZ0G0b1Q3fb3Kz/eOaCSSu4I/u
   H/VuzzgdYgO5WtdeLDIDJaS2CBIqBvTFpt51KKaJE3Z0tssDNJcQG3Ez0
   5o5UjPtlmJTa67u+I2v2ANDWd10OXzzk3DRdm26JSPsannytVH+4aMmkl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265341618"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265341618"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 22:15:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730614700"
Received: from aliang-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.1.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 22:15:43 -0700
Message-ID: <a597c1fffab01e1048421887d5ef7aa2ac01c46e.camel@intel.com>
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Date:   Wed, 27 Apr 2022 17:15:41 +1200
In-Reply-To: <1168a7cc-9e41-ee2d-8b3d-8dbd1ab85609@linux.intel.com>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <0457ce8e78ddd1d6c7832176368e095adae1bc18.camel@intel.com>
         <1168a7cc-9e41-ee2d-8b3d-8dbd1ab85609@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 12:07 -0700, Sathyanarayanan Kuppuswamy wrote:
> > Is there any particular reason to use platform driver and support it as a
> > module?
> > 
> > SGX driver uses misc_register() to register /dev/sgx_enclave during boot. 
> > Looks
> > it would be simpler.
> 
> Main reason is to use a proper device in dma_alloc* APIs.
> 
> My initial version only used misc device as you have mentioned. But
> Hans raised a concern about using proper struct device in dma_alloc*
> APIs and suggested modifying the driver to use platform device
> model. You can find relevant discussion here.
> 
> https://lore.kernel.org/all/47d06f45-c1b5-2c8f-d937-3abacbf10321@redhat.com/

Thanks for the info.  Sorry I didn't dig review comments for previous version.

However, after digging more, I am wondering why do you need to use DMA API at
the first place.

Firstly, for this basic driver to report TDREPORT to userspace, there's no need
to use any DMA API, nor we need to use shared memory, as we just get the report
into some buffer (doesn't need to be shared) and copy the report back to
userspace.  So it doesn't make a lot sense to use platform device here.

Secondly, in terms of GetQuote support, it seems Dave/Andi suggested you can use
vmalloc()/vmap() and just use set_memory_decrypted() to convert it to shared:

https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/

I don't see why it cannot work?  Then wouldn't this approach be simpler than
using DMA API?  Any reason to choose platform device?

Btw, a side topic:

Andy suggested we don't do memory allocation and private-shared conversion at
IOCTL time as the conversion is expensive:

https://lore.kernel.org/all/06c85c19-e16c-3121-ed47-075cfa779b67@kernel.org/

This is reasonable (and sorry I didn't see this when I commented in v3).

To avoid IOCTL time private-shared conversion, and yet support dynamic Quote
length, can we do following:

- Allocate a *default* size buffer at driver loading time (i.e. 4 pages), and
convert to shared.  This default size should cover 99% cases as Intel QGS
currently generates Quote smaller than 8K, and Intel attestation agent hard-code
a 4 pages buffer for Quote.

- In GetQuote IOCTL, when the len is larger than default size, we discard the
original one and allocate a larger buffer.

How does this sound?


-- 
Thanks,
-Kai


