Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAE54D6A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiCKWwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiCKWvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:51:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68229E5AC;
        Fri, 11 Mar 2022 14:25:37 -0800 (PST)
Date:   Fri, 11 Mar 2022 23:09:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647036548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1hpGVBDseCVeet7NoMPueWVt4kGDQQEBLbUVjRRwI8=;
        b=4QJaiVaptzeJS6+LzbVm3Xrw5F/1q7kF93x+4CRPNIm2qD7FOWhBK3NmuPoZTt+Zxq1WNA
        OeXe0GAmlsd3bBx46wIABfNjqOHMotZ2I4utofWmFyZmLjyshVaVfnb3Fs/C/kXL8orv7E
        r09AnCPs2rX1VKxeFou0StI2JjGuuJYFNuF0vnRTfm1pno8O4MmLkzwRsshTHzegyL8fT6
        Zg4kmrOF+V+t/k/4D5zmaYeG2txoBEGZ6h1yi40zjwSluAHC7cDDNU4iEb+CUrQT1P3WUm
        fCQMnCFdFX5mnMuVooF660bpOulTzE9khign51M7dtfiYurqK5XYvAnDGa3Lqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647036548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1hpGVBDseCVeet7NoMPueWVt4kGDQQEBLbUVjRRwI8=;
        b=tDCaJdY8cDI/Da494PQCrYc5rVXDpEaCC/LuqCmcF0zLSjp47EzZtocaK8hHKjG29NffSo
        QZ8U13ULgKPLAgBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [ANNOUNCE] 5.4.182-rt71
Message-ID: <YivIg2H6BY5KuMQ/@linutronix.de>
References: <0af02f70d3a0b3653bb3079266878f13e6682a69.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0af02f70d3a0b3653bb3079266878f13e6682a69.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-11 15:46:23 [-0600], Tom Zanussi wrote:
> index 79e34e98f812..e1dfb01f4623 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -802,6 +802,18 @@ struct task_struct {
>  	/* to be used once the psi infrastructure lands upstream. */
>  	unsigned			use_memdelay:1;
>  #endif
> +#ifdef CONFIG_PSI
> +	/* Stalled due to lack of memory */
> +	unsigned			in_memstall:1;
> +#endif
> +#ifdef CONFIG_PAGE_OWNER
> +	/* Used by page_owner=on to detect recursion in page tracking. */
> +	unsigned			in_page_owner:1;
> +#endif

the upper two don't look like they belong here.

> +#ifdef CONFIG_EVENTFD
> +	/* Recursion prevention for eventfd_signal() */
> +	unsigned			in_eventfd_signal:1;
> +#endif
>  
>  	unsigned long			atomic_flags; /* Flags requiring atomic access. */
>  
> diff --git a/localversion-rt b/localversion-rt

Sebastian
