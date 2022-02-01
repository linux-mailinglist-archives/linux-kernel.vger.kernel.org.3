Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53944A6868
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbiBAXOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:14:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:29313 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbiBAXOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643757291; x=1675293291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JPI3uuMW8X1fbYmB/lxgAinKYS1OEHseGPfdAUaTibs=;
  b=iTPZRxXalG8hJyId/LBj+zzM0N+RMLTaVdLsQsEH50ianymNn9OS18ak
   tP1z0vFom74gKKXS6fklxvpYxvUcLacmpelDO9UWQ6aYBt2/74+hd24Gb
   TuyLyJ5UAL+9l7DiptD4ZSDnYbRaHasbW8cAMn85gcDskpoSoyOHWzfcb
   PgU3gaMkTWUUPWkukW14liED9uK2vddUr588Ai4XMdWbzMw/9gmTagc7M
   lX5fvJiYuIZvOx2jzt4UA7l2l4Ga+fD6meLgv/Llz1HmA1Ye8kekXTJOj
   /HGgDrrm2BtqqQhYyLwaVKix6mngWgPBn5sa3xY/gXb7+IAyZMkQU8YbF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334174221"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="334174221"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698591818"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2022 15:14:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5AF673B7; Wed,  2 Feb 2022 01:14:59 +0200 (EET)
Date:   Wed, 2 Feb 2022 02:14:59 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 01/29] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <20220201231459.2doc4iaibmuua4qk@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-2-kirill.shutemov@linux.intel.com>
 <87fsp2z8p8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsp2z8p8.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 08:29:55PM +0100, Thomas Gleixner wrote:
> Kirill,
> 
> On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> 
> Just a nitpick...
> 
> > +static bool tdx_guest_detected __ro_after_init;
> > +
> > +bool is_tdx_guest(void)
> > +{
> > +	return tdx_guest_detected;
> > +}
> > +
> > +void __init tdx_early_init(void)
> > +{
> > +	u32 eax, sig[3];
> > +
> > +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> > +
> > +	if (memcmp(TDX_IDENT, sig, 12))
> > +		return;
> > +
> > +	tdx_guest_detected = true;
> > +
> > +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> 
> So with that we have two ways to detect a TDX guest:
> 
>    - tdx_guest_detected
> 
>    - X86_FEATURE_TDX_GUEST
> 
> Shouldn't X86_FEATURE_TDX_GUEST be good enough?

Right. We have only 3 callers of is_tdx_guest() in cc_platform.c
I will replace them with cpu_feature_enabled(X86_FEATURE_TDX_GUEST).

Thanks.

-- 
 Kirill A. Shutemov
