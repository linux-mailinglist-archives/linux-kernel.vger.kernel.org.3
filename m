Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6A4DDD52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiCRPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiCRPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:54:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC38BC0F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647618816; x=1679154816;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=UNB9ejb1k95hmt7LHt6XrKcVABS6JdkF79URR5kfK2k=;
  b=NqGrzBUyXW25hFWPPwmPDcllXWDCfyg9uk9vWF7G6G0RpXWPPYkGBtQg
   WE79hNQTCZFc7EIuKPgL9PesJzXi+RYJG3NomVv2s/sm8WnLgEY9RkcUI
   B2xyjAHauu4xKmn6qS72Ipm45pxNJ8bqB/xSlDaTyw8i1bHjquTdOK+kK
   VMbK1Ya1cOQW9UuR+dtjoXzbURg8GWVm4/lBVSUUDC05zKZX40YoFJkGi
   grxX/GQtnsh+GCOnAkRfgw3nXy7cGdt3zS3PPpXTrHlwRDFBxuP7Otn4w
   y6sl81AgKPV5IcxQDIfp7BDtUTBYdyM02CLYqTEcEWkshpHMWMZvBK1wv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343594886"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343594886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:53:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558504422"
Received: from chittoor-mobl.amr.corp.intel.com (HELO [10.209.39.43]) ([10.209.39.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:53:35 -0700
Message-ID: <f9c71fde-714e-9e0a-48ec-05be1ce6d76b@intel.com>
Date:   Fri, 18 Mar 2022 08:53:27 -0700
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
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-28-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7 27/30] x86/mm: Make DMA memory shared for TD guest
In-Reply-To: <20220318153048.51177-28-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/22 08:30, Kirill A. Shutemov wrote:
> Intel TDX doesn't allow VMM to directly access guest private memory.
> Any memory that is required for communication with the VMM must be
> shared explicitly. The same rule applies for any DMA to and from the
> TDX guest. All DMA pages have to be marked as shared pages. A generic way
> to achieve this without any changes to device drivers is to use the
> SWIOTLB framework.
> 
> In TDX guest, CC_ATTR_GUEST_MEM_ENCRYPT is set. It makes all DMA to be
> rerouted via SWIOTLB (see pci_swiotlb_detect()). mem_encrypt_init()
> generalized to cover TDX. It makes SWIOTLB buffer shared.

It would be nice to have one transition paragraph to link the last one
to this:

The previous patch ("Add support for TDX shared memory") gave TDX guests
the _ability_ to make some pages shared, but did not actually make any
pages shared.  This actually marks SWIOTLB buffers *as* shared.

Start returning true for cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) in
TDX guests.  This has several implications:

 * Allows the existing mem_encrypt_init() to be used for TDX which
   sets SWIOTLB buffers shared (aka. "decrypted").
 * Ensures that all DMA is routed via the SWIOTLB mechanism (see
   pci_swiotlb_detect())


> Stop selecting DYNAMIC_PHYSICAL_MASK directly. It will get set
> indirectly by selcting X86_MEM_ENCRYPT.

		 ^ selecting

> mem_encrypt_init() is currently under an AMD-specific #ifdef. Move it to
> a generic area of the header.

That new paragraph was kinda funky.  With the changelog improvements above:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
