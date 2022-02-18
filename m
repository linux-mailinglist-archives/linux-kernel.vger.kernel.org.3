Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542DC4BC076
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbiBRTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:48:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiBRTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:48:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09C268373
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645213715; x=1676749715;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=XDQZJxIx28rQCTMb2jQbyuTZQHexkK21y4qx7zsjtWQ=;
  b=aXTbUpGwOCy2FOU8PuVjXVWRVh7C3dmR9UoHoeAziUCDJh195N3ItBNz
   1bACXodpMWZiJgrlSdF01b0LVO+T5KcYdVxUe5MVkoONJehSjuBvrpqDG
   FblfPH4MNvTu8Vlu3VGT/GkYjegoppP4SHoAIb++BPg0dkGWXz0pcvulb
   X2eJQr/Kuc3jSt1euTksGf5x+74ys0UKo/4ZWnKaRR7Ea2i3dwkt0TRTK
   ZB0i2t9Q83obaT2xvBhR2JWaXKJRFQ5DkNs1e5WWLopyy87AvX/XhpyON
   cBhOndRmnqTLw8TSBln4xhdYfZqSNmMZgvkRKfl6bK83gBcYn4/LfDarp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="250957483"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="250957483"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 11:48:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="546426638"
Received: from jabonill-mobl1.amr.corp.intel.com (HELO [10.251.27.55]) ([10.251.27.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 11:48:29 -0800
Message-ID: <523e473f-3a9f-7d82-1d51-2f5db673c84a@intel.com>
Date:   Fri, 18 Feb 2022 11:39:42 -0800
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
        x86@kernel.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv3 01/32] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
In-Reply-To: <20220218161718.67148-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 08:16, Kirill A. Shutemov wrote:
> So far, AMD_MEM_ENCRYPT is the only user of X86_MEM_ENCRYPT. TDX will be
> the second. It will make mem_encrypt.c build without AMD_MEM_ENCRYPT,
> which triggers a warning:
> 
> arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for
> 	function 'mem_encrypt_init' [-Wmissing-prototypes]
> 
> Fix it by moving mem_encrypt_init() declaration outside of #ifdef
> CONFIG_AMD_MEM_ENCRYPT.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

