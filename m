Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A174C4978
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiBYPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiBYPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:47:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3501FCD3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645803999; x=1677339999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+VNIJrBliATBPQIEq9t/zjjHb5pQKkyjHD4i7W8pi8=;
  b=MpQht58DTwcD44OvNEL3gNYzXAXAYLJo5xgP08lghhF5GFWJvPSM7ct3
   SDX2YIAl/aAYMDoG3kPVu/yTUfIEPE4jDgePKDrJCDMDC52/jnfHfhNWM
   dFHUnfEup7iMLSkAHErwGLoidjx3A1vROMB8bA8bGg1MVPZePt9DYn4M3
   5RbNfKm8VmU6bSWVgMiplEra/alDWhtMTPsNxz+ebZKUyzjHYIfmpH0/+
   U1/OdeAwg6ucIilqiZBMgJjn9yK4k/ZozOLIsCSL58Gx4YAMyb8YPoM3p
   j+32qkoSYyXCDeS4HqED4mpAApxc3zmhO6fu9NpoRhnYiGj2cUb5NID4L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="277154591"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="277154591"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 07:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="638273041"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2022 07:46:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 676B694; Fri, 25 Feb 2022 17:46:50 +0200 (EET)
Date:   Fri, 25 Feb 2022 18:46:50 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 03/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
Message-ID: <20220225154650.2yfx3gtyrem3to7v@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-4-kirill.shutemov@linux.intel.com>
 <faeb3c16-55a9-912d-1222-9dab364f56c7@intel.com>
 <20220224231011.c6mbmsj2ahtw4wmt@black.fi.intel.com>
 <bd62c848-0fb8-7876-8a92-3d316318a568@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd62c848-0fb8-7876-8a92-3d316318a568@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:41:12PM -0800, Dave Hansen wrote:
> On 2/24/22 15:10, Kirill A. Shutemov wrote:
> > +/*
> > + * SW-defined error codes.
> > + *
> > + * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
> > + * TDX module.
> > + */
> > +#define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL
> 
> That's OK-ish.  But, it would be nice to make this a bit less magic.
> While I'm sure plenty of us can do the bits 47:40 => hex math in our
> heads, it might be nice to do it with a macro.  Maybe:
> 
> /*
>  * Bits 47:40 being set represent a reserved status class.
>  * The TDX module will never set these so they are safe to
>  * use for software error codes.
>  */
> #define TDX_SW_ERR(code) ((code) | GENMASK_ULL(40, 47))

Bit 63 also has to be set as it represents error (0 is success with
possible warning).

Bit 62 indicates if the error is recoverable. (0 is recoverable)

Bits 61:48 are reserved and must be 0. For this reason -1UL is not right.

Bits 47:40 are class.

Bits below that are up to grub.

See Table 17.6 of TDX module 1.0 spec.

So we can use 

#define TDX_SW_CLASS(code)		((code) | GENMASK_ULL(40, 47))
#define TDX_ERROR(code)			((code) | (1UL << 63))
#define TDX_SEAMCALL_VMFAILINVALID	TDX_ERROR(TDX_SW_CLASS(0xFFFF0000ULL))

But it looks silly to me. It brings more confusion than solves.

Hm?

> #define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(0xFFFF0000ULL)
> 
> By the way, is the entire "0xFFFF0000ULL" thing up for grabs?  Or do the
> the "0xFFFF...." bits _need_ to be set to represent an error somehow?
> 
> Would this work if it were:
> 
> #define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(0ULL)
> 
> or
> 
> #define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(1ULL)
> 
> or
> 
> #define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(0x12345678ULL)
> 
> ?

Yes, it should work with any code.

-- 
 Kirill A. Shutemov
