Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B146253EA30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiFFOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiFFOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:14:02 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C42C653
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:14:00 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f2bb84f9edso19255555fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3cP+WhjIMFd4Hbfsr5/ENvdSuimZ1mS+1KHrF7Liuqc=;
        b=XGYmsxg14M+lK4OHA1hxciUhwAJ4vbhy5fXTMvSsLxpIJjqmBx7/hRJYO1yMWYugvc
         dAFXKnRxXPCYSHFLunMNMaAUun8iauYkL8M7BQyzkaaP13kHA0dr500XDDeSwe9Eax1s
         efplhlinjoA7rk4ZAYsJ1mN8Sg+T/HXX0ej60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3cP+WhjIMFd4Hbfsr5/ENvdSuimZ1mS+1KHrF7Liuqc=;
        b=VtDV4fMeoZ5SXFlLyeJyCTskwcuiXS8AZHuh/gd+fvmfHgo2W/KGqAQHt7DxFMRlro
         FyRPExgQ3w3L50JzDQld8zzTNOSr6SUwY88RlD7CpPbymodxC/slm58XC7X0elDT4DeT
         mcQwKlkmef5qADzUVnDdqZmD+LuUgA6/q+mBGdSDNZMUisj1gETMYzptY5waBLyrl8xM
         axhFAz6jhdUNZBkOJmrCIyT+Ho6SK7IEu5UAJNUwvNyVmHcLlUuG8qehRLvpzmSZPu5x
         VPmROIf9/+8IyCPk00XA87MaY2+pDupBWOwXwZ146uVVxhIBzMa9O5S2l2wuvlnIalpU
         g5nQ==
X-Gm-Message-State: AOAM533ecmx8Ighc06o0dLGEj3lCmtMYk2EVaGLwUBj7iC/+raWWJ0sg
        0dYAvEYCQSaa69Ge9t1euRhI+g==
X-Google-Smtp-Source: ABdhPJwLDiM99Fj8vzlM1sfE4CsjrhkLwScaAI2kR8dCZ0qI9jd/XAFsLz6CevfLJnhSXzNCmlp1PA==
X-Received: by 2002:a05:6870:d192:b0:de:691:81ad with SMTP id a18-20020a056870d19200b000de069181admr30881237oac.165.1654524839943;
        Mon, 06 Jun 2022 07:13:59 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:cc11:d018:c11b:3321])
        by smtp.gmail.com with ESMTPSA id c11-20020a056830000b00b0060bec21ffcdsm3348053otp.22.2022.06.06.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:13:59 -0700 (PDT)
Date:   Mon, 6 Jun 2022 09:13:58 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kvm@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] entry/kvm: Exit to user mode when TIF_NOTIFY_SIGNAL is
 set
Message-ID: <Yp4LpgBHjvBEbyeS@do-x1extreme>
References: <20220504180840.2907296-1-sforshee@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504180840.2907296-1-sforshee@digitalocean.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:08:40PM -0500, Seth Forshee wrote:
> A livepatch transition may stall indefinitely when a kvm vCPU is heavily
> loaded. To the host, the vCPU task is a user thread which is spending a
> very long time in the ioctl(KVM_RUN) syscall. During livepatch
> transition, set_notify_signal() will be called on such tasks to
> interrupt the syscall so that the task can be transitioned. This
> interrupts guest execution, but when xfer_to_guest_mode_work() sees that
> TIF_NOTIFY_SIGNAL is set but not TIF_SIGPENDING it concludes that an
> exit to user mode is unnecessary, and guest execution is resumed without
> transitioning the task for the livepatch.
> 
> This handling of TIF_NOTIFY_SIGNAL is incorrect, as set_notify_signal()
> is expected to break tasks out of interruptible kernel loops and cause
> them to return to userspace. Change xfer_to_guest_mode_work() to handle
> TIF_NOTIFY_SIGNAL the same as TIF_SIGPENDING, signaling to the vCPU run
> loop that an exit to userpsace is needed. Any pending task_work will be
> run when get_signal() is called from exit_to_user_mode_loop(), so there
> is no longer any need to run task work from xfer_to_guest_mode_work().
> 
> Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Seth Forshee <sforshee@digitalocean.com>

Friendly reminder as it seems like this patch may have been forgotten.

Thanks,
Seth

> ---
>  kernel/entry/kvm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
> index 9d09f489b60e..2e0f75bcb7fd 100644
> --- a/kernel/entry/kvm.c
> +++ b/kernel/entry/kvm.c
> @@ -9,12 +9,6 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>  		int ret;
>  
>  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
> -			clear_notify_signal();
> -			if (task_work_pending(current))
> -				task_work_run();
> -		}
> -
> -		if (ti_work & _TIF_SIGPENDING) {
>  			kvm_handle_signal_exit(vcpu);
>  			return -EINTR;
>  		}
> -- 
> 2.32.0
> 
