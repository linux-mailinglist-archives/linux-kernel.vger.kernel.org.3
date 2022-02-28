Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51324C6234
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 05:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiB1Edc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 23:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiB1Ed2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 23:33:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9963B8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 20:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646022767; x=1677558767;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=sZM5IhQY9m1kb2U1YvX059YdAXPx+QlG4LkIA/0q2/U=;
  b=ky8Ct/VncUq+XKn75zz3gUNZpp4amW7KdTwv/QOZ28A3cpALN9U0yCav
   /VOoeiwztDw5r0KX39sIS2NtqM7T1f82oKFT7oD5rTpUEOAHdwRdxAKHr
   ZHYxY49pdd1A8DTv9jSNR6b1sqcT/7lAfMSglolC6WuMRp81eP75dGQTu
   bo5Gwn5RR/x17Kfq2VNUwKwU03ffeD8aDIBnW3v3DgWS2DjQBlWL2M3WZ
   BrlhtZEhqKO5Axfcn16KA/j9+Jd/V8PaJC/PaG7PKpV2dUXe4+U891Jt6
   UAzv9YINFpLyHeU5q7yrJwZk4XiBj7FLvAQpi4bhxtvU9hEar619CmF5+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="232776943"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="232776943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 20:32:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="550075011"
Received: from eliasbro-mobl.amr.corp.intel.com (HELO [10.212.174.65]) ([10.212.174.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 20:32:43 -0800
Message-ID: <b1ddd8eb-0165-7d31-e253-d69c3a8e7db9@intel.com>
Date:   Sun, 27 Feb 2022 20:32:38 -0800
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
 <20220224155630.52734-18-kirill.shutemov@linux.intel.com>
 <dd370f1e-e9f9-0843-da24-83ad6f99ec76@intel.com>
 <20220228011627.63355pcbpn7tosiy@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 17/30] x86/tdx: Add port I/O emulation
In-Reply-To: <20220228011627.63355pcbpn7tosiy@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/22 17:16, Kirill A. Shutemov wrote:
> Anyway, it is in our plans to sort it out, but it is not in scope of core
> enabling. Let's make it functional first.

Yeah, but we need to know what these plans are.  There's still a _bit_
too much hand-waving and "trust us" going on in this set.

If this can induce extra SIGSEV's in userspace that aren't possible in
non-TDX systems, please call that out.

For instance, something like this in the changelog of this patch would
be really nice:

	== Userspace Implications ==

	The ioperm() facility allows userspace access to I/O
	instructions like inb/outb.  Among other things, this allows
	writing userspace device drivers.

	This series has no special handling for ioperm().  Users
	will be able to successfully request I/O permissions but will
	induce a #VE on their first I/O instruction.  If this is
	undesirable users can <add advice here about LOCKDOWN_IOPORT>

	More robust handling of this situation (denying ioperm() in
	all TDX guests) will be addressed in follow-on work.

That says: This causes a problem.  The problem looks like this.  It can
be addressed now by doing $FOO or later by doing $BAR.

But, the *problem* needs to be called out.  That way, folks can actually
think about the problem rather than just reading a happy changelog that
neglects to mention any of the problems that the patch leaves in its wake.

The same goes for the CPUID mess.  I'm not demanding a full solution in
the patch or the series even.  But, what I am demanding is a full
_problem_ disclosure.
