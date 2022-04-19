Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9C5066C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbiDSITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiDSITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:19:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF8C2BB2B;
        Tue, 19 Apr 2022 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650356215; x=1681892215;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oa/WjC9/I4BJ7aIcmzeNF6YbXNnZp+KVh7mD9aqG/8g=;
  b=Ciu1tns02JG/ocOwm99p4+jShuhFeiasM/iPoDdYe3pPsCyC48G32CFx
   hPoNFRzu+FczBgn05AREualOMXVgThANKazRmmzqCtCNYaY7AebG8aKmM
   ZfU44jYSm8T89qeVLDBtSCp5cGSHkTtDAIxqhtnK3LmDORuuXKXyJanhD
   u90wdnFAWDqXOv5f9JHWeHJI9QSpT+Nwj4pJwU0wZh3Gl0X2Cdaz5XEf8
   3sYgs69sk4IWCBdNCyArr4rVYvcz6ShBFckddZ/CBYYx27Tyx6is92P0e
   w1WKkZYfn/K0xgsZRxLqgmy6v40sYQB6oL7j0abHEriOlyjFpOyo19xMb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288805432"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="288805432"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:16:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="647178439"
Received: from csambran-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.20])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:16:50 -0700
Message-ID: <0d532b0ce1155bf7778366b14c5d1311c45fef01.camel@intel.com>
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
Date:   Tue, 19 Apr 2022 20:16:48 +1200
In-Reply-To: <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
         <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 19:47 +1200, Kai Huang wrote:
> On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel/tdx/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# X86 TDX Platform Specific Drivers
> > +#
> > +
> > +config INTEL_TDX_ATTESTATION
> > +	tristate "Intel TDX attestation driver"
> > +	depends on INTEL_TDX_GUEST
> > +	help
> > +	  The TDX attestation driver provides IOCTL interfaces to the user to
> > +	  request TDREPORT from the TDX module or request quote from the VMM
> > +	  or to get quote buffer size. It is mainly used to get secure disk
> > +	  decryption keys from the key server.
> > diff --git a/drivers/platform/x86/intel/tdx/Makefile b/drivers/platform/x86/intel/tdx/Makefile
> > new file mode 100644
> > index 000000000000..94eea6108fbd
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel/tdx/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_INTEL_TDX_ATTESTATION)	+= intel_tdx_attest.o
> > diff --git a/drivers/platform/x86/intel/tdx/intel_tdx_attest.c b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
> > new file mode 100644
> > index 000000000000..9124db800d4f
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
> 
> 
> From security's perspective, attestation is an essential part of TDX.  That
> being said, w/o attestation support in TD guest, I guess nobody will seriously
> use TD guest.
> 
> From this perspective, I am not sure what's the value of having a dedicated
> INTEL_TDX_ATTESTATION Kconfig.  The attestation support code should be turned on
> unconditionally when CONFIG_INTEL_TDX_GUEST is on.  The code can also be just
> under arch/x86/coco/tdx/ I guess?
> 
> But I'll leave this to maintainers.

In fact after slightly thinking more, I think you can split TDREPORT TDCALL
support with GetQuote/SetupEventNotifyInterrupt support.  The reason is as I
said, GetQuote isn't mandatory to support attestation.  TD attestation agent can
use i.e. vsock, tcp/ip, to communicate to QE directly.  Whether kernel needs to
support GetQuote is actually arguable.

So IMHO you can split this attestation driver into two parts:

1) A "basic" driver which supports reporting TDREPORT to userspace
2) Additional support of GetQuote/SetupEventNotifyInterrupt.

The 1) can even be in a single patch (I guess it won't be complicated).  It is
easy to review (and i.e. can be merged separately), and with it, you will
immediately have one way to support attestation.

2) can be reviewed separately, perhaps with one additional Kconfig option (i.e.
CONFIG_INTEL_TDX_ATTESTATION_GET_QUOTE).  I think this part has most of the
complexity things in terms of review.

-- 
Thanks,
-Kai


