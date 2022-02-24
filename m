Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DBD4C3944
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiBXW7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiBXW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:59:05 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF801728A7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645743513; x=1677279513;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hrB/iFKhgYwSPIyARBVZ1FoYQpBEDe7+WznvuerUMdg=;
  b=jdbb5MbEC5xtfoPh1q36bT+m33epmfvzbZVKe2TFIjNiiqCit4fF1vn1
   OhMwO8s+N64wQpICS7wNXHCZnn5+HNoYm7JVrCcBtDBgewZavZZqjzZcY
   ff6VpBKMs/pIYdFwSiUJs7WjA2YaxZvrL9zkyDW26Pbiv3ZqLk/qVpkUY
   VH0Ir5cYRr6DsoySPUQSKp5NX3jAyB5EbhlfklmbJjNMn5ndJTH4SkXB3
   BcM5/rqzsl4FwzIAkxPwSGQKh4J/1j5y1nkQJG3chNC7rbqRq3tVap1QS
   RBXpQngdv1pfrqnz0W1KM2OCCWBXxsSuDYyJpffhwpjbfoxSjG7tpzLdf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313087654"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="313087654"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 14:58:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639910344"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 14:58:32 -0800
Message-ID: <fe1dd1df-5979-04fe-269e-48bcd5edeaee@intel.com>
Date:   Thu, 24 Feb 2022 14:58:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-19-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 18/30] x86/tdx: Handle early boot port I/O
In-Reply-To: <20220224155630.52734-19-kirill.shutemov@linux.intel.com>
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

I wish this was telling more of a story.  There *is* a story to be told
and this series is really missing an opportunity to tell it.  The last
three patches do the same logical thing: add support for I/O
instructions when running as a TDX guest.  But, the three subjects call
it: "Support", "Add" and "Handle".  All three talk about "port I/O", but
in different ways.

Imagine you had the subjects be:

	x86/boot: Port I/O: add decompression-time support for TDX
	x86/tdx: Port I/O: add runtime hypercalls
	x86/tdx: Port I/O: add early boot support

That makes it be visually *obvious* what's going on.  All three are
covering the same ground: "Port I/O".  They're all adding something.  In
succession they add the same basic thing for
{decompression,runtime,early} code.

I mentioned this exact thing to *somebody* about this exact part of the
series, who knows when.  But, it still bugs me...

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> TDX guests cannot do port I/O directly. The TDX module triggers a #VE
> exception to let the guest kernel emulate port I/O by converting them
> into TDCALLs to call the host.

As part of telling the story, it would be best to refer to the code that
you introduced in the last few patches.  "At runtime..." could hearken
back to the subject from two patches ago.

Anyway, the code is fine.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
