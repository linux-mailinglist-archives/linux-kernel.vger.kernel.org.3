Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA64C36F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiBXUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiBXUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:44:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E022EDDF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645735451; x=1677271451;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=4L2oqYuhBJxKZ35iByJHErNhWm8oR1DwoQ7OwJz0rYA=;
  b=G2DYQqdoTgz1MZrM1WmiRgrTW8+Ydm9ZG5BivAtiNvJ1CGAPX4+3ctOI
   J2Zr7uQOedWwKk0/l1dkX0KBniO1P5wWhZWNtf4f4BGxikw1kJmbl2Qlb
   fC+rmJhcKj5HUabiRvnarutEXnsMRxPSfFktmBV0n7GlRd1eUCFBAy54A
   x1fMI1oSG6O/ybcwiHNDp7kSo4QQL+UVP6VpNFwIZWJMBenqlLL1/EaUT
   o4lCdFFwXjY3fpEXEHttFoCAQ0KP0xTr39mJVUxJs4mcAgcsekYlGutek
   NZH1vxUa0yuYBCWi3DT0lrJ4GFrobYx/rsj/oE8IIBAbmYuLJhFUNavw0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239745059"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239745059"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 12:44:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639870948"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 12:44:05 -0800
Message-ID: <9cb7e51f-b485-a678-3d53-9eb56796712d@intel.com>
Date:   Thu, 24 Feb 2022 12:44:00 -0800
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
 <20220224155630.52734-13-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 12/30] x86/tdx: Detect TDX at early kernel decompression
 time
In-Reply-To: <20220224155630.52734-13-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> The early decompression code does port I/O for its console output. But,
> handling the decompression-time port I/O demands a different approach
> from normal runtime because the IDT required to support #VE based port
> I/O emulation is not yet set up. Paravirtualizing I/O calls during
> the decompression step is acceptable because the decompression code size is
> small enough and hence patching it will not bloat the image size a lot.

It's not the *decompression* code size that matters.  It's that there
aren't a lot of call sites to the I/O instructions.  Right?

> To support port I/O in decompression code, TDX must be detected before
> the decompression code might do port I/O. Detect whether the kernel runs
> in a TDX guest.
> 
> Add an early_is_tdx_guest() interface to query the cached TDX guest
> status in the decompression code.

Nit: I was a bit surprised by the minor cpuid() munging and the new
shared/tdx.h header.  They look sane, but you can reduce reviewer
surprise by adding a sentence or two of changelog material.

> The actual port I/O paravirtualization will come later in the series.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
