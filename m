Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC94C3A71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiBYAlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:41:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5A2C0308
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645749678; x=1677285678;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=dexBgzMhCODVfEiZ7QGi2mEYc91WKwibBq5WHDGuBPk=;
  b=FHcwIRwyO2qLdcVsHYI3PAccP2LsjZ3L6G4ZbxdttQYoeQkWrjdFTH0P
   sTjRidx89LvhM1AueX6HCjYDMHpslG37Zn7lQih4Zl+hztZE4ZQwhN/wX
   WEP5zrl+D5ktjWOFX1P7q5wsCIfslF2w02dZ44f4IZzyg5QQkL0Eisqsl
   Nx+ZTiODI+cnua3Z7IsQHp2sr/tmSo5oiKFlzpMH8DVzWQDsKutJxnx0T
   Q/nCwkdaEAh9VTerSc/ZVBwdld2M5o5QoFo214+aJdGnPDT+/98a8CO6b
   A6ooeeh7H/OhrIluN2lR39K1xJghRMEt1q0FZD4Ni5QaPZpxcQW4Q/uHs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251215315"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251215315"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:41:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639936654"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:41:17 -0800
Message-ID: <bd62c848-0fb8-7876-8a92-3d316318a568@intel.com>
Date:   Thu, 24 Feb 2022 16:41:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-4-kirill.shutemov@linux.intel.com>
 <faeb3c16-55a9-912d-1222-9dab364f56c7@intel.com>
 <20220224231011.c6mbmsj2ahtw4wmt@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 03/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
In-Reply-To: <20220224231011.c6mbmsj2ahtw4wmt@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 15:10, Kirill A. Shutemov wrote:
> +/*
> + * SW-defined error codes.
> + *
> + * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
> + * TDX module.
> + */
> +#define TDX_SEAMCALL_VMFAILINVALID     0x8000FF00FFFF0000ULL

That's OK-ish.  But, it would be nice to make this a bit less magic.
While I'm sure plenty of us can do the bits 47:40 => hex math in our
heads, it might be nice to do it with a macro.  Maybe:

/*
 * Bits 47:40 being set represent a reserved status class.
 * The TDX module will never set these so they are safe to
 * use for software error codes.
 */
#define TDX_SW_ERR(code) ((code) | GENMASK_ULL(40, 47))

#define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(0xFFFF0000ULL)

By the way, is the entire "0xFFFF0000ULL" thing up for grabs?  Or do the
the "0xFFFF...." bits _need_ to be set to represent an error somehow?

Would this work if it were:

#define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(0ULL)

or

#define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(1ULL)

or

#define TDX_SEAMCALL_VMFAILINVALID	TDX_SW_ERR(0x12345678ULL)

?
