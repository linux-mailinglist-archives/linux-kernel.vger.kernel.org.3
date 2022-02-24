Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA454C39E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiBXXyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBXXye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:54:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA811D6395
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645746843; x=1677282843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lANl+8AEIhsmuwwaxKAns6Na25J2A7UFkUclSq5OcY4=;
  b=GT1Qjs2wwPr8jVStkMzyZkiiGhgm1WOoUmdmf5FEcnPEvmM/V+135pid
   +C6yppQTIIF/zfknceVoiGkA8sc5UD/2Dt+GmkNF0YSxIO1x+ub6T39pR
   bgpD60wAgn8QP5ygDWjVDD4w1knHh7gbgnudgtq7ZMikk6OHusV1t01IK
   OtCN32G+lUN9ea6WxFxGJrRV8T/oxg3bqeAPTUs2B87wLfEjWvjq4iKE1
   6ACTDAt7GT2fRpp0S3s5Usz5n7bU6IZzYifEwkMOv18KSuFfBA8Oa7mLZ
   SJ84ZEhnfKFA6rxcCTS0JINkz3bn2+WZm+YR0ySF2qrPZvFwLJMmd07NZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239778281"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239778281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639924363"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Feb 2022 15:53:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6B72994; Fri, 25 Feb 2022 01:54:13 +0200 (EET)
Date:   Fri, 25 Feb 2022 02:54:13 +0300
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
Subject: Re: [PATCHv4 05/30] x86/tdx: Extend the confidential computing API
 to support TDX guests
Message-ID: <20220224235413.lrzczn7re4mfdkup@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-6-kirill.shutemov@linux.intel.com>
 <d51dc9c2-61e5-c8dd-e358-e4ab3d5429ac@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51dc9c2-61e5-c8dd-e358-e4ab3d5429ac@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:54:16AM -0800, Dave Hansen wrote:
> 
> This left me wondering two things.  First, why this bothers storing
> 'gpa_width' when it's only used to generate a mask?  Why not just store
> the mask in the structure?

It was needed when tdx_shared_mask() was a thing. It takes a pair of
fresh eyes to break the inertia.

> Second, why have the global 'td_info' instead of just declaring it on
> the stack.  It is only used within a single function.  Having it on the
> stack is *REALLY* nice because the code ends up looking like:
> 
> 	struct foo foo;
> 	get_info(&foo);
> 	cc_set_bar(foo.bar);
> 
> The dependencies and scope are just stupidly obvious if you do that.

Okay, I will rework it with plain gpa_width on stack and get_info(&gpa_width);
Attributes will be needed after core enabling, so I will drop it from
here.

-- 
 Kirill A. Shutemov
