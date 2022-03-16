Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6EB4DBA81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352579AbiCPWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358239AbiCPWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:07:57 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F691D9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647468403; x=1679004403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8lrRTt2yRaYR3UojtiJvH84kXfEA2OmAGoWInUQQmKQ=;
  b=QKyIvRr4sP0IF8OBbv856afr6Cr9cK60JwZXY+VxT35lB3srIRwJ1Mqc
   4HFS47o7Xxl71kFuc8Js1Fk1XpSTXxPR3E7SfXDSVUJgJtvV6diGJuTSx
   wHzbvCHblyMr1JM/xGawD4STro+SOiRXn0lP/bTV/R4UvVyTOCwKMgmA+
   kn5n9V01RxNd6F8YJ89y7XquZ7VQWzdL2USR3bBUZYMAuVuZGNd9NvcYQ
   tuchoJxYITNR/oGFov4A+BZudaz1X0itPc+seSEdIV7DdRE8ek6eG/Tu1
   Qc4fa8+JN4w4NIL5skSw+UqMS9r14lE5Ghi6qo51VTXkPMLdS97nq9ROo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317442782"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317442782"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:06:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="783631077"
Received: from pwblakex-mobl1.amr.corp.intel.com (HELO [10.212.129.47]) ([10.212.129.47])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:06:31 -0700
Message-ID: <48427079-52cf-d6c7-718b-7f0b33a724bb@intel.com>
Date:   Wed, 16 Mar 2022 15:06:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv6 25/30] x86/tdx: Make pages shared in ioremap()
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
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-26-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220316020856.24435-26-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 19:08, Kirill A. Shutemov wrote:
> In TDX guests, guest memory is protected from host access. If a guest
> performs I/O, it needs to explicitly share the I/O memory with the host.
> 
> Make all ioremap()ed pages that are not backed by normal memory
> (IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.
> 
> The permissions in PAGE_KERNEL_IO already work for "decrypted" memory
> on AMD SEV/SME systems.  That means that they have no need to make a
> pgprot_decrypted() call.
> 
> TDX guests, on the other hand, _need_ change to PAGE_KERNEL_IO for
> "decrypted" mappings.  Add a pgprot_decrypted() for TDX.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
