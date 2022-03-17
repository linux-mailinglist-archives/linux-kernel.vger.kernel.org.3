Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8B4DC5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiCQMQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiCQMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:16:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091091B9FE9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:15:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647519301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQcwj0LCiNAHVBDuF6Px80QfKbCwTCGxWCoZrupQZlo=;
        b=Cjnvxh1S31RQnn6USOycwCisBPoWwiBl84bXrF3YGtIin0snrNpZ5NKUAgxq7Tp9cbiS/R
        iT+wcGvZSEPy78X8oEm0xA4YWiQknikW5GSKiYcFxQPMfGgxhJ+vwrsC0EDj2kj87Iga4Q
        ToWIYXntUp//ShJdGMM7YHbUed4uS0x6ofR3oQCtOwEs9DbWIRpNE0MRtghK9tUBYfN1Ly
        9f4vaW1BocTQOfAjw42edVEcYr1QZHVVausXKWBi9MxOQopkjuISQ8HUwwKH69EcS584UZ
        ABVDMib+XjgKnxS/HmQLLPfxxDchI2I6luEgOxIq61ZlVxxbuXpfvh/aab2gIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647519301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQcwj0LCiNAHVBDuF6Px80QfKbCwTCGxWCoZrupQZlo=;
        b=GSDqsu2Co2UbhVlGw+G/o0fMIDXTI+hzQfocP9Hu3KVgdkFRmkNYddiwivo4zMwHD0sCLl
        enUQ+k7PxxaEz8AQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 16/30] x86/boot: Port I/O: add decompression-time
 support for TDX
In-Reply-To: <20220316020856.24435-17-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-17-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:15:01 +0100
Message-ID: <87a6do22t6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
>  void early_tdx_detect(void)
>  {
>  	u32 eax, sig[3];
> @@ -23,4 +94,12 @@ void early_tdx_detect(void)
>  
>  	/* Cache TDX guest feature status */
>  	tdx_guest_detected = true;
> +
> +	/* Use hypercalls instead of I/O instructions */
> +	inb = tdx_inb;

Eeew. What's wrong with writing this out?

        pio_ops.inb = tdx_inb;

So it becomes obvious what this is about?

Thanks,

        tglx
