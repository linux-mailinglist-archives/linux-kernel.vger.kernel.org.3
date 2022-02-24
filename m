Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B294F4C3328
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiBXRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBXRFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:05:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108041B6093
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645722165; x=1677258165;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=U/NF9uBKurx4EkBXVTIb/WvcTafwmKZyDfXs8IvBSGI=;
  b=IXWDCKbEGV8bCLZvp/ki2G2fSt37n4Zj+LglCqKvtnc83zaOx1nOlile
   gUQJjSpUjJ9OIxsSQLMzywR0RiyYlJQ7CTEdeMAirBsLbIzTz5kLYEzbH
   uUrehSbeDrY15LOUoPgxPLH71JMdwfEYpefKZQnDR04t4+Nq88vEDxi34
   JzLjlE+oahnjGS968LdxogPelAOWUn28qEjxznNbgw4wttHJEQfCI2XxF
   GvwmrviQFtJ652WITdXCQegco10VnY87OFKIUH5XmPj4kdJ3l2ctNVx3U
   EoMP2D/vBLoyllUQTjs7e+QCD1MxwyMRVWmOaeMi7oyworUIqYk7nuQNI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252207471"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252207471"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 09:01:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548834043"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 09:01:47 -0800
Message-ID: <052d7b15-1b3f-490e-fb30-538334b67a0a@intel.com>
Date:   Thu, 24 Feb 2022 09:01:42 -0800
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
 <20220224155630.52734-5-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 04/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
In-Reply-To: <20220224155630.52734-5-kirill.shutemov@linux.intel.com>
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

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> +	tdcall
> +
> +	/*
> +	 * TDVMCALL leaf does not suppose to fail. If it fails something
> +	 * is horribly wrong with TDX module. Stop the world.
> +	 */
> +	testq %rax, %rax
> +	jne .Lpanic

This should be:

	"A TDVMCALL is not supposed to fail."

I also wish this was mentioning something about the difference between a
failure and return code.

	/*
	 * %rax==0 indicates a failure of the TDVMCALL mechanism itself
	 * and that something has gone horribly wrong with the TDX
	 * module.
	 *
	 * The return status of the hypercall operation is separate
	 * (in %r10).  Hypercall errors are a part of normal operation
	 * and are handled by callers.
	 */

I've been confused by this exact thing multiple times over the months
that I've been looking at this code.  I think it deserves a good comment.
