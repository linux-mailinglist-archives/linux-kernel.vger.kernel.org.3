Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA0466500
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358457AbhLBOUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358455AbhLBOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:19:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8309C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:16:36 -0800 (PST)
Date:   Thu, 2 Dec 2021 15:16:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638454595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZU1su0RUbHEWZ9xTW5xA1VcYBVXaMWu9hENzMq9yUOI=;
        b=Q2z1qDHjtv0p26rTvdKhsrUbRXN069iOBRZ56H3uWUPAcZL3rEAJ2P635jWmewlL2p4JVT
        JiRrjgGCZ5DY+lfu73DBfBJBOjtkmn9uIM/E9K02LBeu2LlwEWkEw9/TN7ZccqnN1V55Bm
        0oBA+QFM6+TBiAbXGVYRDh2xhNMlWpQi5pEGS5jIEjEA/gYdjq7QRLzp9eRefgdtnMckBa
        JJobyPw9uRFQDlJna0L6Zd9EdYlJOPEINkxrZphrDJSeLAfFWSzLqlAsdjCHBC07QP3znZ
        GVSdNE+NhebPskaXJs0OTEw9xs3ylDs9gpUg0l++nygwI3X9ZjX3uc+6X8j6Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638454595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZU1su0RUbHEWZ9xTW5xA1VcYBVXaMWu9hENzMq9yUOI=;
        b=tGCqv0LUnjfaqpadA1WjKoRhshy2+x5X3aGaI7gO2Zn+55zWRRRfYl5b75dI9wJgcomeLz
        8a+bayfNY3pQPcDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notifier: Return an error when a callback has already
 been registered
Message-ID: <20211202141630.rdkrtrltxhzdqtyb@linutronix.de>
References: <20211202133601.23527-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202133601.23527-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-02 14:36:01 [+0100], Borislav Petkov wrote:
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -19,14 +19,12 @@ BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
>   *	are layered on top of these, with appropriate locking added.
>   */
>  
> -static int notifier_chain_register(struct notifier_block **nl,
> -		struct notifier_block *n)
> +static int __notifier_chain_register(struct notifier_block **nl,
> +				     struct notifier_block *n)
>  {
>  	while ((*nl) != NULL) {
> -		if (unlikely((*nl) == n)) {
> -			WARN(1, "double register detected");
> -			return 0;

This could be s/0/-EEXIST/ or do I miss something?
I appreciate the updated warning with %ps!

> -		}
> +		if (unlikely((*nl) == n))
> +			return -EEXIST;
>  		if (n->priority > (*nl)->priority)
>  			break;
>  		nl = &((*nl)->next);

Sebastian
