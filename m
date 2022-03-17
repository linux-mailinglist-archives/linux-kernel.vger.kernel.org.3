Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A1B4DBBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349081AbiCQAXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCQAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:23:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712DB1C926
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:21:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647476513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdWZs0ah8LGBJVtZdqv2qP7Ddky78LdHhCInSqp+XmU=;
        b=yrIgrsFa2qFXcxXCoRkmAJUd33v5qM8wZxhPvFQ4oIS63ntmGND4iXf7sMxKksauy56cKW
        xIfjk7uqpGT/kKTmQRWT+PnOZy9HvlC2iHwghJR0MXdDH+eK3dkArteqDNS9gXovDmYNRH
        tHiUg0oYMMteN6f8MzoiNu+eQuP9X0pzlFFtjjyEtt5LPRvZRFZLkHUunq4V/4V+nVhA0H
        HugvBXIPSl0QomKdEgEVs26eT0BVST65Hmy5LuRtWk+QkvujM4SrpLPtV09Swi/ltY1ulC
        U6eOpWsVNP/DlhoAASP7mpI4Gzsnjy6K0spqY8MsaciSjuasBJD5PoRPcrsOzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647476513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdWZs0ah8LGBJVtZdqv2qP7Ddky78LdHhCInSqp+XmU=;
        b=lcGhwQT+4xslZyugH23RAJTCZV24DZ+R/8Hty8wHmzkvsjNpjxpYkcDBzNwp6TWzXieRUS
        AX1SqQP5iqUs1ICQ==
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
Subject: Re: [PATCHv6 06/30] x86/traps: Refactor exc_general_protection()
In-Reply-To: <20220316020856.24435-7-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-7-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 01:21:53 +0100
Message-ID: <87a6dp2ztq.ffs@tglx>
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
> TDX brings a new exception -- Virtualization Exception (#VE). Handling
> of #VE structurally very similar to handling #GP.
>
> Extract two helpers from exc_general_protection() that can be reused for
> handling #VE.
>
> No functional changes.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Not that I care much, but this is the second instance of something I
suggested. We have tags for that...

> +static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
> +				    unsigned long error_code, const char *str)
> +{
> +	int ret;

Adding this to make my suggestion compile is the easy way out, but...

> +
> +	if (fixup_exception(regs, trapnr, error_code, 0))
> +		return true;
> +
> +	current->thread.error_code = error_code;
> +	current->thread.trap_nr = trapnr;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to trust the result
> +	 * from kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (!preemptible() && kprobe_running() &&
> +	    kprobe_fault_handler(regs, trapnr))
> +		return true;
> +
> +	ret = notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV);
> +	return ret == NOTIFY_STOP;

Why not doing the obvious:

	return notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV) == NOTIFY_STOP;

Hmm?

Thanks,

        tglx
