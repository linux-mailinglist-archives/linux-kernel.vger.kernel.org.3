Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54659507CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358241AbiDSWlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353827AbiDSWk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:40:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB834673;
        Tue, 19 Apr 2022 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650407895; x=1681943895;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZ5x6lVQZ6TKJPa9jLNf41JFMLWlV3hpwDqGfPvblVU=;
  b=EkfEh+B/ql3iF3tdJ7LXp58adkQCHNr6mAxczmlpxzX/NfphEpqCcG0H
   z+mVN2iS4R11S/W0XlZJLwKlLbqXaG/+NINoE2u6xDS1zFP3ks/go9fSz
   l6yjoRtvKknnIza5zUJOIqEexflsyFJJXeN1mQvcknxb0BO+64mzsqOVF
   8L35YfjecZZddNSOVCSvoB2yWomowsrRt0N8ZP/sr6M/RPAc6bP22NI9m
   TztxtHmdBvUqd3FGfaAmmtitvJzGFf7OsvZhRS0vK4Je8yOYIqefmxsv8
   JgMRctzO7zz8pCcH7WYS5oQZD7pcSnfAnJuDOiMMkabkSWH9XbDIvJUpc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262746452"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262746452"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:38:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="727244733"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.58.15])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:38:12 -0700
Message-ID: <5371d2df8940226674f27a7ce950e9ae1468a951.camel@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
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
Date:   Wed, 20 Apr 2022 10:38:09 +1200
In-Reply-To: <07ef65c4-708e-1bcf-9a7e-f804acefcc7c@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
         <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
         <0d532b0ce1155bf7778366b14c5d1311c45fef01.camel@intel.com>
         <07ef65c4-708e-1bcf-9a7e-f804acefcc7c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 07:00 -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 4/19/22 1:16 AM, Kai Huang wrote:
> > In fact after slightly thinking more, I think you can split TDREPORT TDCALL
> > support with GetQuote/SetupEventNotifyInterrupt support.  The reason is as I
> > said, GetQuote isn't mandatory to support attestation.  TD attestation agent can
> > use i.e. vsock, tcp/ip, to communicate to QE directly.  Whether kernel needs to
> > support GetQuote is actually arguable.
> 
> IMO, we should not use a usage model to categorize "GetQuote" support
> as a mandatory or non-mandatory requirement.
> 
> For customers who use VSOCK, they can get away without GetQuote
> TDVMCALL support. But for customers who do not want to use
> VSOCK model, this is a required support. AFAIK, our current customer
> requirement is to use TDVMCALL approach for attestation support.
> 
> If your suggestion is to split GetQuote support as separate
> patch to make it easier for review, I am fine with such
> suggestion.
> 

I am not saying we should get rid of GetQuote support.  If there's customer
wants this with a good reason, we can certainly support it.  I understand that
some customer wants to deploy QE in host and don't want additional communication
channel (i.e. vsock) between guest and host, which may add additional attack
window and/or customer's validation resource.

My point is regardless whether we need to support GetQuote, logically this
driver can be split to two parts as I said: 1) basic TDREPORT support to
userspace; 2) additional GetQuote support.  And I think there are many benefits
if you do in this way as I commented below.


> > 
> > So IMHO you can split this attestation driver into two parts:
> > 
> > 1) A "basic" driver which supports reporting TDREPORT to userspace
> > 2) Additional support of GetQuote/SetupEventNotifyInterrupt.
> > 
> > The 1) can even be in a single patch (I guess it won't be complicated).  It is
> > easy to review (and i.e. can be merged separately), and with it, you will
> > immediately have one way to support attestation.
> > 
> > 2) can be reviewed separately, perhaps with one additional Kconfig option (i.e.
> > CONFIG_INTEL_TDX_ATTESTATION_GET_QUOTE).  I think this part has most of the
> 
> 
> GetQuote IOCTL support is a very simple feature support, so, IMO, we
> don't need to complicate it with additional config.
> 
> > 

Additional Kconfig can reduce attack window by turning it off for people don't
need it.  Anyway no strong opinion here.

-- 
Thanks,
-Kai


