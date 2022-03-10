Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4E4D3DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbiCJAJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiCJAI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:08:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3493EB83
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646870879; x=1678406879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=91Jgg/UVu4M4x2rWKkuRZAV2z3I4cdtEgRk8s7As9gY=;
  b=Jnk0LH4TtmJzqhMUAQsWgeN5kFrhbaObytNtAgfCl6NYMgF2S0gZfOoF
   W7ZURjSQJ6+zhLuf2VvhHbBGr1hVrgKqYfcLh3GBC93MqaSRT5CCqtTsU
   cmEv9zvh1gI0gI5KAPw1UKdLtrEPYixUyA/T+rzZVgwxbmUKVw6xIuPYs
   B7m8lnyfyvhD10H+5oqiHhthHKzpY3vOz4Wo2zcU8lJ0j6dMHY5ha9Vq7
   40RR6crNM9vVURt2HgoQjXAZv3Pq5fOMfCSQLaXjVSGDvmFkdWAEejFt/
   br3guCfO7FtvGoX8QQAZBnpsnkNY2EBJichg+fYEmOu1eS/nA5qjRvV2C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318343976"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="318343976"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:07:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642346247"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:07:57 -0800
Message-ID: <528422e7-c247-5700-a935-f7525bbbbb96@intel.com>
Date:   Wed, 9 Mar 2022 16:07:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv5.2 04/30] x86/tdx: Extend the confidential computing API
 to support TDX guests
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     aarcange@redhat.com, ak@linux.intel.com, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <79432a51-4d26-1fcb-81f2-6a9e7a44706f@intel.com>
 <20220309235121.33236-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220309235121.33236-1-kirill.shutemov@linux.intel.com>
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

On 3/9/22 15:51, Kirill A. Shutemov wrote:
> Confidential Computing (CC) features (like string I/O unroll support,
> memory encryption/decryption support, etc) are conditionally enabled
> in the kernel using cc_platform_has() API. Since TDX guests also need
> to use these CC features, extend cc_platform_has() API and add TDX
> guest-specific CC attributes support.
> 
> CC API also provides an interface to deal with encryption mask. Extend
> it to cover TDX.
> 
> Details about which bit in the page table entry to be used to indicate
> shared/private state is determined by using the TDINFO TDCALL.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  v5.2:
>   - Update comment for tdx_module_call() definition and for the
>     TDX_GET_INFO call site.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
