Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C964DC627
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiCQMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiCQMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:49:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1504124C20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:48:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647521282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AkFqp/wks0AeBUh3MjSCJiSE3sFCCm9/cIgptBe41go=;
        b=geLLgiORCEymvP35+lraR0XBsDosznASTNKNCh9KjtEDO0TU3x4yAo2dRE/1vo/1X3X8Ro
        05XRaDsFtA6uwf8uQuP5sKG8/mHyAFwHP1FauNiCwnT7BqqNbkaiQUOtaCu/ijJ26fRfRI
        E6EL4Jrsyz5m0zRhRFBIrMrGTgVqd8S/FRETi8chAE/gSvAMwIFmZR7jnKqQwm6s65FWo/
        z1Qyjk9c3FkzzPnmO4CXyAK2obvKNC59EMJx73McsHEvswRJc6B5/gB/x6DgcGvpiPIJ45
        HudXPg3s2iME5VPxgcfsS/2UeSxCdQh5m/+hg+KNP2iALk4WLJj9s/tiNjTf+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647521282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AkFqp/wks0AeBUh3MjSCJiSE3sFCCm9/cIgptBe41go=;
        b=1Duf42lbc4Qgplr3OzSXayu1+fDc1SkHYHYhsyiFTiHku6dlsDSNTgj66usMQ+grdVu4oq
        LCUfrgAQDY4mYGDw==
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 23/30] x86/boot: Avoid #VE during boot for TDX platforms
In-Reply-To: <20220316020856.24435-24-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-24-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:48:01 +0100
Message-ID: <87tubwzqwu.ffs@tglx>
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
> This theoretically makes the guest boot more fragile. If, for instance,
> EFER was set up incorrectly and a WRMSR was performed, it will trigger
> early exception panic or a triple fault, if it's before early
> exceptions are set up. However, this is likely to trip up the guest
> BIOS long before control reaches the kernel. In any case, these kinds
> of problems are unlikely to occur in production environments, and
> developers have good debug tools to fix them quickly.
>
> Change the common boot code to work on TDX and non-TDX systems.
> This should have no functional effect on non-TDX systems.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
