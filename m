Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2C4D23CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbiCHWEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiCHWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:04:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE62B1B1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646776984; x=1678312984;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ZT26ErrkMnLS+1+vNfP977cSvkK8za/maZjsPLhMLgc=;
  b=PglgO//LYcJ65FW0EVU5OzB1OhCEsukZhM/grFOdNPF2aySv3HrNqGjN
   /28TN5fAmZgpBDZ+ZA/EtB71idK3HVk7r5qrEBqmo/EDUQ24ZkXW8SWO/
   uWVK/xXct5gAfT9LbOmXgsfVX/M7SwfajRXIGF/PDjGTX9ywz7jfFbP2/
   VVKPadAJ/Y1G+twg62cmVzKqgUXCV72rtgZRuh4lz5IF0Th0yAnhtcYxa
   0v+tOpE9UGQEIHlwDEq0EAbV+zydyOaq1ztzpO06GrFukUTowYi1sItkD
   H3IX6dw19LoxHJ0WvYaACLY4kQxHhjs8iBdUjKSNqi1zrF+ig9VFdjm0Y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="234778287"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="234778287"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 14:03:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547421221"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 14:03:01 -0800
Message-ID: <3cef05aa-cc8c-f0a1-e48c-9cc8cdd327eb@intel.com>
Date:   Tue, 8 Mar 2022 14:02:54 -0800
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
 <20220302142806.51844-26-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 25/30] x86/tdx: Make pages shared in ioremap()
In-Reply-To: <20220302142806.51844-26-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:28, Kirill A. Shutemov wrote:
> In TDX guests, guest memory is protected from host access. If a guest
> performs I/O, it needs to explicitly share the I/O memory with the host.
> 
> Make all ioremap()ed pages that are not backed by normal memory
> (IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.
> 
> Since TDX memory encryption support is similar to AMD SEV architecture,
> reuse the infrastructure from AMD SEV code.
> 
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/mm/ioremap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 026031b3b782..a5d4ec1afca2 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -242,10 +242,15 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>  	 * If the page being mapped is in memory and SEV is active then
>  	 * make sure the memory encryption attribute is enabled in the
>  	 * resulting mapping.
> +	 * In TDX guests, memory is marked private by default. If encryption
> +	 * is not requested (using encrypted), explicitly set decrypt
> +	 * attribute in all IOREMAPPED memory.
>  	 */

Nit: in this context, nobody knows what "private" means.

I'd probably just say this in the changelog:

	The permissions in PAGE_KERNEL_IO already work for "decrypted"
	memory on AMD SEV/SME systems.  That means that they have no
	need to make a pgprot_decrypted() call.

	TDX guests, on the other hand, _need_ change to PAGE_KERNEL_IO
	for "decrypted" mappings.  Add a pgprot_decrypted() for TDX.

I'm not sure you need a code comment.  There's really nothing that
mentions TDX in the code being commented.  If it needs clarification,
I'd do it behind the pgprot*() helpers.
