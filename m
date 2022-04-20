Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD150937C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383153AbiDTXVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbiDTXVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:21:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D8818B2D;
        Wed, 20 Apr 2022 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650496729; x=1682032729;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDzQY2+PCspZFvBhtBaNeIPM6Iwdxd0YJ8CLxltVuzA=;
  b=fFZNqZfk+NsUoRijVa5sl/EeTlplpiaH4AfnkT9+EM55oktdNEdYkeD4
   i9HHnpzMRhaHYhncJn5dP0YHw4EZr8n572S3X5EAecnYTnW+jXlujtu6o
   1645ZgoLzhtyOV/imoUVF0Lyo8bXOq7nOMawquVN/7OdQlrGrOrCeEOtV
   BmiZ/hcxhsSn52ok+wg/Orcja7+nqGHkBtAuZ5K2qXRC6ZPX7ey2nJgNA
   NPpBGF2HKh/S9+fhFu+3ha/0zYJVLdwwd0e1TdgNdElMTlMMt369ha0wm
   l/w1Zp3PpodxcZGgpjEjsFWLwKNiGHU59Da+8c5O6C/0QN/HHWwmqQcij
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327073935"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="327073935"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 16:18:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="669300098"
Received: from ssharm9-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.30.148])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 16:18:46 -0700
Message-ID: <b209ee09b74394ab7aed85e0244e2191ee3d4171.camel@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
From:   Kai Huang <kai.huang@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Thu, 21 Apr 2022 11:18:43 +1200
In-Reply-To: <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
> TDX guest supports encrypted disk as root or secondary drives.
> Decryption keys required to access such drives are usually maintained
> by 3rd party key servers. Attestation is required by 3rd party key
> servers to get the key for an encrypted disk volume, or possibly other
> encrypted services. Attestation is used to prove to the key server that
> the TD guest is running in a valid TD and the kernel and virtual BIOS
> and other environment are secure.
> 
> During the boot process various components before the kernel accumulate
> hashes in the TDX module, which can then combined into a report. This
> would typically include a hash of the bios, bios configuration, boot
> loader, command line, kernel, initrd.  After checking the hashes the
> key server will securely release the keys.
> 
> The actual details of the attestation protocol depend on the particular
> key server configuration, but some parts are common and need to
> communicate with the TDX module.

As we discussed "key provisioning from key server to support disk decryption" is
only one use case of attestation, so I don't think you need 3 paragraphs to talk
about details of this use case here.  The attestation flow is documented in GHCI
so it's clear.  The attestation flow (and what this patch does) does not have
any direct relation to the "disk decryption" details above.  I think you can
discard above entirely or using one or two simple sentences to explain.

Also, as you agreed you will remove the 8K shared memory assumption:

https://lore.kernel.org/lkml/20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com/T/

and if you agree with my approach (again, I recommend) to split the driver to
two parts (reorganize your patches essentially):

https://lore.kernel.org/lkml/20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com/T/#m9e3c5115df0be0b53d41f987e1eda1715255d1d8

I'll review again once you finish updating the driver.

Btw some minor comments below.


[...]

> --- /dev/null
> +++ b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c

Perhaps attest.c is enough, no matter where the file will reside.

> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * intel_tdx_attest.c - TDX guest attestation interface driver.
> + *
> + * Implements user interface to trigger attestation process and
> + * read the TD Quote result.
> + *
> + * Copyright (C) 2021-2022 Intel Corporation

For upstream I guess just need 2022.

[...]

> +struct attest_dev {
> +	/* Mutex to serialize attestation requests */
> +	struct mutex lock;

I think we need a comment to explain why the driver doesn't support multiple
GetQuote requests in parallel.  In fact the updated GHCI spec doesn't explicitly
say GetQuote cannot be done in parallel.  It has a new "GET_QUOTE_IN_FLIGHT"
flag introduced, which can be used to determine which Quote is finished I think.

I am fine with only supporting GetQuote in serialized way, but perhaps we need
to call out the reason somewhere.

[...]

> +
> +	/* Allocate DMA buffer to get TDQUOTE data from the VMM */
> +	adev->tdquote_buf = dma_alloc_coherent(dev, GET_QUOTE_MAX_SIZE,
> +						&adev->handle,
> +						GFP_KERNEL | __GFP_ZERO);
> +	if (!adev->tdquote_buf) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}

The buffer needs to be shared.  Guest must have called MapGPA to convert the
buffer to shared.  Is this guaranteed by calling dma_alloc_coherent(), since
seems I didn't see any MapGPA in the driver?  Anyway this deserves a comment I
think.


-- 
Thanks,
-Kai


