Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E042A4DC4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiCQLdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiCQLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:33:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5D51E3E1D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:32:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647516727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SwDCMkx1hiBvcLMHz4kcJtrmslY3ziAgdCMSn2s1nXg=;
        b=Ww05F1XyDfQy4zQwMDwY/KSqz89O/snB/BmSaReiRxINY+fN1AO2IaBhVYKBVm9aBs3SOP
        D0/MgdA9P7Soed+qgk3+KkYsWrmeR36xAFJLtBXSd/unOjlcDr4nBPOokpkYOJBqVkiYzJ
        l/1Ft4SRpa0/NCvkJoyWcwe6vVIZ4IUY/sF2QM8V+twrwl7yoAHkSobO0D3sZOdSCAr6dU
        ilrz4czEN1BEVvcF25NLN6oqEi37nmsZX/zXm3wC8JEurSqGDbP7bNsMPd4yek2zGBYFsH
        1+H+mvW8xgKmto645SoMWde+zm0o1VSphLG/LRgIrhxgIvImTrpAX1yN0oCQAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647516727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SwDCMkx1hiBvcLMHz4kcJtrmslY3ziAgdCMSn2s1nXg=;
        b=QhcVktDaaatjN71JUY51iq206wW5fJ5zVwipzdtyVAAmFZenG9KsWxJ87nH6dk61tkvip4
        DPQ6M9T4iLQ2WsAw==
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
Subject: Re: [PATCHv6 10/30] x86/tdx: Handle CPUID via #VE
In-Reply-To: <20220316020856.24435-11-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-11-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 12:32:07 +0100
Message-ID: <87v8wc24so.ffs@tglx>
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
> In TDX guests, most CPUID leaf/sub-leaf combinations are virtualized
> by the TDX module while some trigger #VE.
>
> Implement the #VE handling for EXIT_REASON_CPUID by handing it through
> the hypercall, which in turn lets the TDX module handle it by invoking
> the host VMM.
>
> More details on CPUID Virtualization can be found in the TDX module
> specification, the section titled "CPUID Virtualization".
>
> Note that VMM that handles the hypercall is not trusted. It can return
> data that may steer the guest kernel in wrong direct. Only allow  VMM
> to control range reserved for hypervisor communication.
>
> Return all-zeros for any CPUID outside the hypervisor range. It matches
> CPU behaviour for non-supported leaf.
>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
