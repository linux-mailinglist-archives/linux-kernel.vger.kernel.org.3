Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BCA4C4A33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbiBYQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiBYQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:12:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AA012630
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645805545; x=1677341545;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0EV53wMM4MbvqAek/crIdddmgI/kzwQ1zNCaQJuAmyA=;
  b=B88SukdaqAtk+o+FPqnkgh5ebfHDMx6Pk5/ofdpn1uvojk7O3OdIil9U
   XDTvCQKb5FYYiHuq90jNh2I4Eg/w4NsaJpGBnCHJ7Ht9h/dLyYiRX2ic2
   KAqFVqgVCKtaVTZ4/UraaHYxfo6IEAeBy7U4V/yUOxjyUK579rf+D51CK
   s3StubIh/lk7qC5xyEx7S/vEvwxBfUy5ib9D/1/Wio5VPCh19WwKGhJr7
   7l67NmW8RP053v9yfG9tvXHcOwq77/Q4hn9CCv6s7EU6OzJEo1doifJ2+
   ViMucraYVvRkV3MicAFNwI4cUM1wqZlVaRYr63QBm1mQuhvEkMLlZ2Nvf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233147942"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="233147942"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:12:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="533619056"
Received: from wreed-mobl.amr.corp.intel.com (HELO [10.212.247.12]) ([10.212.247.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:12:23 -0800
Message-ID: <9daceae8-55f3-131b-6914-bfab16928d44@intel.com>
Date:   Fri, 25 Feb 2022 08:12:18 -0800
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
 <bd62c848-0fb8-7876-8a92-3d316318a568@intel.com>
 <20220225154650.2yfx3gtyrem3to7v@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 03/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
In-Reply-To: <20220225154650.2yfx3gtyrem3to7v@black.fi.intel.com>
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

> Bit 63 also has to be set as it represents error (0 is success with
> possible warning).
> 
> Bit 62 indicates if the error is recoverable. (0 is recoverable)
> 
> Bits 61:48 are reserved and must be 0. For this reason -1UL is not right.
> 
> Bits 47:40 are class.
> 
> Bits below that are up to grub.
> 
> See Table 17.6 of TDX module 1.0 spec.
> 
> So we can use 
> 
> #define TDX_SW_CLASS(code)		((code) | GENMASK_ULL(40, 47))
> #define TDX_ERROR(code)			((code) | (1UL << 63))
> #define TDX_SEAMCALL_VMFAILINVALID	TDX_ERROR(TDX_SW_CLASS(0xFFFF0000ULL))
> 
> But it looks silly to me. It brings more confusion than solves.

Passing 'code' is kinda silly now that I look at it.  But, this:

#define TDX_ERROR			(1UL << 63)
#define TDX_SW_ERROR 			(TDX_ERROR | GENMASK_ULL(40, 47))
#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | 0xFFFF0000ULL)

Actually gives you a chance in hell of connecting this code back to the
spec.
