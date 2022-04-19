Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD058506638
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349559AbiDSHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349553AbiDSHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:50:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F12E0A6;
        Tue, 19 Apr 2022 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650354461; x=1681890461;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCuWwp4T8c+i/pzUc3TOqamLAZWFR89Br+QbZJimevc=;
  b=NY5fRDZUyb0IcqmtsIl9vT4aGP2rj6KmF2P+YvMYW+/c122c4Pbn0gEi
   6SDZuAvgHAuihRmBxxa/4oHkv6hqwgWBC4rHDLa38QfDyd1b0j5u/Ss3y
   JBd+kPk98AB3a20+J/d8W67j0J5ggSZ9pfcVwscVo18flLz+0NhEdFPI6
   iAA1H7dLiOSYsS7rklDgfJQTCz7a4QYXyvv9vPfbBb8DSU8nDHH3m9aQY
   y7zrbc3YrnGHoHCpjqn13JE1UXO8txDeMmTw/hpOuEHnRTtvkeRMwiqz7
   wk3jgp0ulqA4EnzKtG6tq5vzL+5Wl+8zU3daSpwtGE8GLN3rxvZ1CbssB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262563170"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="262563170"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 00:47:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="554614019"
Received: from csambran-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.20])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 00:47:36 -0700
Message-ID: <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
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
Date:   Tue, 19 Apr 2022 19:47:33 +1200
In-Reply-To: <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
> --- /dev/null
> +++ b/drivers/platform/x86/intel/tdx/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# X86 TDX Platform Specific Drivers
> +#
> +
> +config INTEL_TDX_ATTESTATION
> +	tristate "Intel TDX attestation driver"
> +	depends on INTEL_TDX_GUEST
> +	help
> +	  The TDX attestation driver provides IOCTL interfaces to the user to
> +	  request TDREPORT from the TDX module or request quote from the VMM
> +	  or to get quote buffer size. It is mainly used to get secure disk
> +	  decryption keys from the key server.
> diff --git a/drivers/platform/x86/intel/tdx/Makefile b/drivers/platform/x86/intel/tdx/Makefile
> new file mode 100644
> index 000000000000..94eea6108fbd
> --- /dev/null
> +++ b/drivers/platform/x86/intel/tdx/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_INTEL_TDX_ATTESTATION)	+= intel_tdx_attest.o
> diff --git a/drivers/platform/x86/intel/tdx/intel_tdx_attest.c b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
> new file mode 100644
> index 000000000000..9124db800d4f
> --- /dev/null
> +++ b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c


From security's perspective, attestation is an essential part of TDX.  That
being said, w/o attestation support in TD guest, I guess nobody will seriously
use TD guest.

From this perspective, I am not sure what's the value of having a dedicated
INTEL_TDX_ATTESTATION Kconfig.  The attestation support code should be turned on
unconditionally when CONFIG_INTEL_TDX_GUEST is on.  The code can also be just
under arch/x86/coco/tdx/ I guess?

But I'll leave this to maintainers.
