Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2430D4EF902
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350176AbiDARfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350165AbiDARfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:35:31 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE125280
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648834421; x=1680370421;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Prr3OHQFQtCFSdwCOz3twIgyEvMuZhH+9u/SrFurkRA=;
  b=LYRKIq3+kEva+sU1MFFJmf1WgZAxyvwFJhAgvfwqLCyK6lMo949IrIHz
   hTJO33Cx2x2f1eMLQvOyHoT4hCND4fGvYxJraY+07+ExuARquTIQf33yX
   cTUDcya4cjJ5FzGpBoOYlfKnxg1R4pHhbHyeZxmOFY2L4JUsHqYeuRKVC
   /NvvGPNcVh4dNQTe/t4WW0CkTVNkr1crPyM68/kwWT2/O8hFg2pdTDF2h
   qzgeOnw4QwGhdxfTN9YupZI/6M81tFmja6P/8NJZdEbgVPv3xlJX5kkxG
   Vy+iuYvVoNJIzoAhKZrxdasfSiXTIWpkDgZ+rUNBBRBkpUVBnX3a5r3ud
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="320891334"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="320891334"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567663407"
Received: from dajones-mobl.amr.corp.intel.com (HELO [10.212.134.9]) ([10.212.134.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:33:39 -0700
Message-ID: <d97855fa-24e8-523a-fe9f-de504f02872a@intel.com>
Date:   Fri, 1 Apr 2022 10:33:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
 <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
 <20220324152415.grt6xvhblmd4uccu@black.fi.intel.com>
 <4c0c05a8-08f2-7d5d-6746-a92d0d3c5ef0@intel.com>
 <20220330231609.ymxekzgdp2pd7gfy@black.fi.intel.com>
 <9e84cdea-754c-1864-4c54-66beeba7f921@intel.com>
 <20220331015239.h7bihbfjq4xfrhyj@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
In-Reply-To: <20220331015239.h7bihbfjq4xfrhyj@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 18:52, Kirill A. Shutemov wrote:
> 
>>From ab320371f9ef8d24722394ec2505089e68737527 Mon Sep 17 00:00:00 2001
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Date: Thu, 15 Apr 2021 10:31:38 -0700
> Subject: [PATCH] x86/acpi, x86/boot: Add multiprocessor wake-up support
> 
> Secondary CPU startup is currently performed with something called
> the "INIT/SIPI protocol".  This protocol requires assistance from
> VMMs to boot guests.  As should be a familiar story by now, that
> support can not be provded to TDX guests because TDX VMMs are
> not trusted by guests.
> 
> To remedy this situation a new[1] "Multiprocessor Wakeup Structure"
> has been added to to an existing ACPI table (MADT).  This structure
> provides the physical address of a "mailbox".  A write to the mailbox
> then steers the secondary CPU to the boot code.
> 
> Add ACPI MADT wake structure parsing support and wake support.  Use
> this support to wake CPUs whenever it is present instead of INIT/SIPI.
> 
> While this structure can theoretically be used on 32-bit kernels,
> there are no 32-bit TDX guest kernels.  It has not been tested and
> can not practically *be* tested on 32-bit.  Make it 64-bit only.
> 
> 1. Details about the new structure can be found in ACPI v6.4, in the
>    "Multiprocessor Wakeup Structure" section.
> 
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Looks good.  I'm glad you were able to get rid of the extra-wakeup
checks too.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
