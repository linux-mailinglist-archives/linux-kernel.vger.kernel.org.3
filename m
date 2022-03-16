Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED64DBAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiCPXLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiCPXLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:11:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2297A1403E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:10:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647472202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrNaIpuYf9ujQ8pyi8EuZjlmDJa2Kc176siD/Z1pJHQ=;
        b=aKhPhxcGnAr3zC+A1uz2zjeUDxDD48/mm/UXCJQvQIaCiChz/CcqAD6aJHOFqf2KATt+xb
        SLzQmayiu7PzmIr18eidcLVtnIPAmI+ltlOypEbzUm9gLpoLE6lcGjqhJRe1kd8pA+zoxP
        zlmn3LeVpSt4gbX//zxBBYStZGRilmWi5NcCcxpJJQ65jgnPLHh/2qyQ7DAlfByscbND5O
        gvW0Ux9fNbxApwqgAeUy6QUpG6ZTDY+nTRlAWkgtdnM6/0n/LLuprxfgp7jvJcMzrnK8F2
        HkNspK4WmO+A1j+AqUG8H78N/Yq5WbNmq6YnrekFfB7vBPy8ZNlnq+LMuK/f0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647472202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrNaIpuYf9ujQ8pyi8EuZjlmDJa2Kc176siD/Z1pJHQ=;
        b=A8hzEVrvBy8c3dDRtrZ1Sh7M9hgrdIDoH/puHlT/4FNrnrqSrIlcyPYqMwWdnbN4ysI16W
        hE0GgjS5BUzvLqDg==
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCHv6 01/30] x86/tdx: Detect running as a TDX guest in early
 boot
In-Reply-To: <20220316020856.24435-2-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-2-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 00:10:02 +0100
Message-ID: <87o825335h.ffs@tglx>
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
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> In preparation of extending cc_platform_has() API to support TDX guest,
> use CPUID instruction to detect support for TDX guests in the early
> boot code (via tdx_early_init()). Since copy_bootdata() is the first
> user of cc_platform_has() API, detect the TDX guest status before it.
>
> Define a synthetic feature flag (X86_FEATURE_TDX_GUEST) and set this
> bit in a valid TDX guest platform.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
