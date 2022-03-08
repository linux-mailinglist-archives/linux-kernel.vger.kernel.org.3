Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D04D2359
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350492AbiCHVbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbiCHVbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:31:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5766E52B01
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646775052; x=1678311052;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=WA0vxU/p44S2iHbnrdjigobSa08q+hkzck9kHi/d9qk=;
  b=DkyXM/z2pgmrtmRgAcrBvq5evGgK/macFBWG5PS50ctpPNREqRrrK1+E
   ulp269xXLoW4w25DUfAq6JuJ/1+0WI6XF/riqPOWCf8KHR76ypITEOgv5
   SB5wHQlTGYxWFcvTfqYbnaKJgpDKY6t80w8v9629v3CRJPwuWcuG9YjuY
   D1lG1RYglbIIV789Z4W6wd3t3kGCz8uCc4UzoMPQ02oEeFI1baJGFXWaZ
   HcXW/1I3zBGZnO1umKWEkl13bnRNxhZ9nHXL7yAiGOOhaN+EmLoboPldG
   vml2QP6P8AqV/N99sJUAis9/RS5D/38JGC6N8WSY/RllnqdP+GT9z0S6v
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253649730"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="253649730"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:30:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547411671"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:30:50 -0800
Message-ID: <89804c89-b696-a14d-5a8f-67aee52cd141@intel.com>
Date:   Tue, 8 Mar 2022 13:30:46 -0800
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
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-18-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 17/30] x86/tdx: Port I/O: add runtime hypercalls
In-Reply-To: <20220302142806.51844-18-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:27, Kirill A. Shutemov wrote:
> This series has no special handling for ioperm(). Users will be able
> to successfully request I/O permissions but will induce a #VE on
> their> first I/O instruction.

How will this be visible to users or user applications?

> +static bool handle_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +	bool in;
> +	int size, port;
> +
> +	if (VE_IS_IO_STRING(exit_qual))
> +		return false;
> +
> +	in   = VE_IS_IO_IN(exit_qual);
> +	size = VE_GET_IO_SIZE(exit_qual);
> +	port = VE_GET_PORT_NUM(exit_qual);
> +
> +
> +	if (in)
> +		return handle_in(regs, size, port);
> +	else
> +		return handle_out(regs, size, port);
> +}

Some extra whitespace snuck in there.

With the question answered and whitespace fixed:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
