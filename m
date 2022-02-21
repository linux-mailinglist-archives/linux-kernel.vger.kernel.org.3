Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7B4BECDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiBUWCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:02:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiBUWCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:02:50 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4311175
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645480946; x=1677016946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pays2ZYekgShXL0c4yiXfyL5YScU3tBfMcoGi8S85HU=;
  b=VXvtC3GzyrLCJxX2WXFXhel2E1mhuLeAHIGbuXmkZsH0Lf+440JbHPEZ
   OvBvumWCXxwyseAzFPvTtKCMBmb2ddikIVivnIXgPZ+Ne1VYuZ+heGINr
   EpJxwI+1n9qMuTgcs+Z+5Mspi0PXinFrZlnkcxjuAdrcZEdOJNz39JJa7
   kSe6uHRfNutSc0vcSl4edHNrPokudSd3h/jEMmzKa1MQOo18272hq7/Os
   WZSqF+Hxg2Ub3xR/58nCx0RNTyJn27ht6s6aHkNVF2srxpQqJfTjaBeHO
   bhFSbPLDQzUxwrTONHjK1anQXioCO1lqTCDnkywDdE6Gq26om5lNHQHo1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="312318607"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="312318607"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 14:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="627483108"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 14:02:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DF1C812C; Tue, 22 Feb 2022 00:02:33 +0200 (EET)
Date:   Tue, 22 Feb 2022 01:02:33 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 16/32] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220221220233.mbntv342fg2wp7dp@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-17-kirill.shutemov@linux.intel.com>
 <8bb2e660-f92d-a501-57ea-61138dafed28@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb2e660-f92d-a501-57ea-61138dafed28@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 02:04:33PM -0600, Tom Lendacky wrote:
> On 2/18/22 10:17, Kirill A. Shutemov wrote:
> > Port I/O instructions trigger #VE in the TDX environment. In response to
> > the exception, kernel emulates these instructions using hypercalls.
> > 
> > But during early boot, on the decompression stage, it is cumbersome to
> > deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> > handling.
> > 
> > Add a way to hook up alternative port I/O helpers in the boot stub.
> 
> This seems like a lot of churn in order to get this all working without
> taking a #VE.

Well, it evolved from more concise (but also more hacky) implementation:

https://lore.kernel.org/all/20211214150304.62613-11-kirill.shutemov@linux.intel.com

> How cumbersome is it to get #VE handling working in the decompression
> stage? Can you build on any of the support that was added to handle #VC?

We definitely can.

But I still think exception-based implementation is inherently more
fragile. I would rather stick with this.

-- 
 Kirill A. Shutemov
