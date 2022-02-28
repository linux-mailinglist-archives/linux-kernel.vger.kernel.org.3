Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B64C71EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiB1Qro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiB1Qrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:47:42 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99C83038
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646066823; x=1677602823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d1WgYu4v5V8Z7rVxe9pdwk9MSrnrrOz1ni41OvnRn8Y=;
  b=hE+PxhcyovZKgurPoCFywPQ9IjwRKEQ3BJZMzVC9vz2gptm0cOtM0YQ5
   WJ/3d1pkD3bMrg0lhjnWBTBQj5RvS+Fg6kOn0xGLOBffgEztGyI9plE+v
   f0hGXEDKK88W7Kpg6j2Dkf/dH+iUWabMvGpNwydrkGe4wr8kVKQkDEwdc
   oOrkno28R1UpAn8FPQpDHy2rMOktpA+zQpvfmN54VTtfHy1vGOsL0K2ml
   PTjhhhkp/vn+0v4oMKpMkdl7wyLwQIuiaP/7B0j2fq255DEiDLy5KP/H2
   XVaKUw+xhgnwRTHJuaZsrhQbTlJwmBIDe0OQ0Y4cSjndtWta06VZbGJGt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313644055"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="313644055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:47:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="550312451"
Received: from eliasbro-mobl.amr.corp.intel.com (HELO [10.212.174.65]) ([10.212.174.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:47:02 -0800
Message-ID: <dd2d7c49-45bd-e8cd-a3c2-533e53f0bc4e@intel.com>
Date:   Mon, 28 Feb 2022 08:46:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 29/30] ACPICA: Avoid cache flush on TDX guest
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, sdeep@vmware.com,
        Sean Christopherson <seanjc@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-30-kirill.shutemov@linux.intel.com>
 <20220227220526.3rrmy3u7j2xpelcn@treble>
 <CAPcyv4jqHQDhpSE24-Y6amC9Y-z4vVnXy6Lvo1j2hdCvzPACvQ@mail.gmail.com>
 <20220228163713.5eewdwcqhmulsp4z@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220228163713.5eewdwcqhmulsp4z@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 08:37, Kirill A. Shutemov wrote:
>> Agree, why is this marked as "TODO"? The cache flushes associated with
>> ACPI sleep states are to flush cache before bare metal power loss to
>> CPU caches and bare metal transition of DDR in self-refresh mode. If a
>> cache flush is required it is the responsibility of the hypervisor.
>> Either it is safe for all guests or it is unsafe for all guests, not
>> TD specific.
> Do we have "any VM" check? I can't find it right away.

Yes:

> #define X86_FEATURE_HYPERVISOR          ( 4*32+31) /* Running on a hypervisor */

I'm pretty sure an earlier version of this patch used it.
