Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2EF4DC51A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiCQL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiCQL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:57:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714361E5A72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:55:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647518158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rn9QBzBUI1s/IZTPL9yAROMhYtJoorPVEuYavK1bZUA=;
        b=hnYIHYQoovUFM7NF30lawWj/vpu/4d10NYx1hnu1UUxuJbDWq50Mae1cljClrGOdHUQH53
        g3QhYi4TyUT8nv/ERBO41t1COdUhGUqADXlwt+R+W3hYit/lEI3bikqKAfXnEx+QzRhs7o
        9KATxKubpytvdhJ6cBLH28HuwNYNJTFX4rRNZNoQz5rUSOWshVrGykzsevo1lKJJgE/R0N
        Rj+11+rT7vw/YFrrwRaQkdQ1qBgt7pIcMFufTetLO+HbPAhv7FHE9Ml6zi3NmCdkU0IgH1
        rwDKSN3+P9V9B9zQ0Duz4OQriHFBH2nk6FpuwbUkddNdhA8JtoqB3XohLL/JgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647518158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rn9QBzBUI1s/IZTPL9yAROMhYtJoorPVEuYavK1bZUA=;
        b=7y3AZEsAu9nDDLqJOERpQRJMrhask1f3lLpmK4e3joe0MjosjsQOpmpXzrlnFfAp38msK4
        KHkllpJ9ZcKl+BCg==
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
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 12/30] x86/tdx: Detect TDX at early kernel
 decompression time
In-Reply-To: <20220316020856.24435-13-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-13-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 12:55:57 +0100
Message-ID: <87k0cs23oy.ffs@tglx>
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
> +
> +#include <asm/shared/tdx.h>
> +
> +static bool tdx_guest_detected;
> +
> +bool early_is_tdx_guest(void)
> +{
> +	return tdx_guest_detected;
> +}

Neither tdx_guest_detected nor early_is_tdx_guest() is used anywhere.

Thanks,

        tglx
