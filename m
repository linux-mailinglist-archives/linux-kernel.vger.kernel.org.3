Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB29E525194
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356105AbiELPtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349369AbiELPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:49:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD40C9EF1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:49:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652370539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nfbJDkowExi1rljTaUNQHjUebBun1mVwBd9QMCWbWE=;
        b=4ZvXLhouzuM+pVL8jFPXColxqczB43n09r5tOaOpwZa2dRcoYsPAfTUoYPsrI7OMt7Wzpk
        aUJHn1HvyUNcMqPxKc8rYfbUlTtvmj3DIpeGQ2e44RfDvNZT76RJkTgRzzXhLJqIi/FZH0
        Fz+iknvcjQfDEMBBV9ypFeiojl2uNXFc9vz3g7WBNKHwW/9sxWQWg/NLS+Qn/PxZAhoahM
        IKVZ3NkaNC8UcpCdpygw6GX/o9g3bt/SgY3HyNFV6wSU4nd1sBF566tO9ODNN47Kf/DH/P
        IDxidfIGbIoUzAMNR6j8vhtQLh+s+0V3IBCbbDvXCdlFtWkv0uEl48/xOMjJKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652370539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nfbJDkowExi1rljTaUNQHjUebBun1mVwBd9QMCWbWE=;
        b=BFc9RhQ2NZRYUGyLIAkcUYukUqJLvQHaIAk+cavSJd4KNhfANQA5uyfET6FFYL2/Vdu5wx
        4VxQCTTlhOsaTKAw==
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/crash: Disable virt in core NMI crash handler
 to avoid double list_add
In-Reply-To: <Yn0WPBGGI4VcbM4S@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-2-seanjc@google.com> <87wnervxb7.ffs@tglx>
 <Yn0WPBGGI4VcbM4S@google.com>
Date:   Thu, 12 May 2022 17:48:58 +0200
Message-ID: <87k0aqvjit.ffs@tglx>
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

On Thu, May 12 2022 at 14:14, Sean Christopherson wrote:
> On Thu, May 12, 2022, Thomas Gleixner wrote:
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 4e3a839ae146..808d3e75fb2d 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -896,7 +896,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
>                 msecs--;
>         }
>  
> -       /* Leave the nmi callback set */
> +       /*
> +        * Leave the nmi callback set, shootdown is a one-time thing.  Clearing
> +        * the callback could result in a NULL pointer dereference if a CPU
> +        * (finally) responds after the timeout expires.
> +        */

Good point!
