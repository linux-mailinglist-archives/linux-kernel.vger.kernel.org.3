Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AAC4C4295
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiBYKkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiBYKkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:40:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C7168F86
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645785583; x=1677321583;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DG3T4BbCTX7YBHk3EL4ymTUGC1G0GZFiorvp+JOiGqE=;
  b=S+mjqqfxnvYuaGccSONN+AGMu97tuViUdB4NOO3Km57Jw7uH4Jvp73/c
   18gdndAU7PofBLoBYuc7CiOlMlzOjj0LzgiojmVKk72z7r+p+cUqqRLeQ
   c2x9ZAR+8d3gdX/cAHH3aZ5UWVqMjsiihN/neJyJKMeXq4Xpl5UL5DbaR
   l29Q7gvW9oAI7EjwWO2me+S0MBZOAROY9laGlumMp8DlNN5/3U/gnT6mS
   BhoTqyndGadMA7sjQxGR/kkslOjBezGKk5Ulpm9B7JT9SreDJc5qlxRpX
   CzLVAH3kqHmjbe34/4m6yKIZAsslZYtsc3UxbCOqpgse7nm80AViv6lRl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233097562"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="233097562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:39:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="638198528"
Received: from rcsacra-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.49.144])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:39:37 -0800
Message-ID: <55a93cbf3bcbf3ec224885ead96b2adbc0ac445c.camel@intel.com>
Subject: Re: [PATCHv4 03/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Date:   Fri, 25 Feb 2022 23:39:35 +1300
In-Reply-To: <bd62c848-0fb8-7876-8a92-3d316318a568@intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
         <20220224155630.52734-4-kirill.shutemov@linux.intel.com>
         <faeb3c16-55a9-912d-1222-9dab364f56c7@intel.com>
         <20220224231011.c6mbmsj2ahtw4wmt@black.fi.intel.com>
         <bd62c848-0fb8-7876-8a92-3d316318a568@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-24 at 16:41 -0800, Dave Hansen wrote:
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
> 
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

Perhaps we can just use -1 (0xFFFFFFFFFFFFFFFFULL) instead of above value for
TDX_SEAMCALL_VMFAILINVALID.

Actually this value will mainly be used when calling P-SEAMLDR's SEAMLDR.INFO
SEAMCALL to detect whether P-SEAMLDR is loaded.  A success of this SEAMCALL
returns the P-SEAMLDR information which further tells whether the TDX module
is loaded or not (please refer to SEAMLDR sepc[1], chapter 4.1 SEAMLDR.INFO).

And P-SEAMLDR actually uses a different error code definition from TDX module
(SEAMLDR spec, chapter 4.4 ERROR HANDLING"):

"The Intel P-SEAMLDR module returns error codes in the format
0x80000000_cccceeee, where the value cccc specifies the error class, and the
value eeee specifies the error code within that class"

It doesn't make a lot sense to use TDX module's error code definition to
define a value that is also supposed to cover P-SEAMLDR, although the chosen
value happens to work.

Instead, -1 works for both, as both error code definitions of P-SEAMLDR and
TDX module have couple of bits reserved and will never be set to 1.

[1]
https://www.intel.com/content/dam/develop/external/us/en/documents-tps/intel-tdx-seamldr-interface-specification.pdf





