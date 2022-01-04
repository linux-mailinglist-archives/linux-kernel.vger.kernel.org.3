Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477E048475D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiADSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiADSBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:01:21 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63972C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:01:21 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c2so32876886pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y7kMj8vKAdjB/43mYSaPzkUgD294ljmZb/3bfGTlD70=;
        b=iIlO1ckG4XXaIOx3eP10sc+tykQAzNjOBByE8iXKtQMIbfSjS6FBXZEqcZnY4Xmsxe
         BWe+rbmB3ULPXZ+Nt+/ZPHgirnLQTEIjfMxIpK7Qh26p2XQ1nlJrbeRK0zLvouBvzSLK
         uZQrnVjnzDdHUkM/DrAAqexNpLhgd1MwxhmpyD8vJa75Kkij0HDU8cZxaj1cjUaXK6gk
         rw83cTLi6aaYJgQweUoRnrbkpozt3P/m6YMsPZeO4xRvmp60mvCuvHeFJAHG+yzah7pV
         XEwubOY39EHZd3wMtNikOgKCx+7rjZAOW0pu3cYC79EEeqIxdgQzOtKZD4+r7FowAmgK
         LxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y7kMj8vKAdjB/43mYSaPzkUgD294ljmZb/3bfGTlD70=;
        b=HHjz715jF48L0cNrHmkqpl2FQHbYPma16aQZJIEpDtrWUvtnFfsqrbuq9BBMwRT5gh
         LGEERU59Nqs6lCNfXBL30CqHbh+3qGOwOks5fpgSAiM5pIkZ/MAQtrfGdPdxVpO5+Xrc
         dQg5BrmrCqU87f9hFRNH1QRWgAvTq/34GhBx88fsraVizA2emh2ZLvDwJv2ibBsrnodS
         4wWQtWdWo5z+bWYGC+ex6//pFoV9NZvlabsSIH8NLpo+SiZrjoiFdQh3HsKbCqEUzb0G
         3vpLM8w5RJbcBg4GfjpdO4dCaP6IJ8kgvyk4sWqn3lNxkQ8zfCN99x++2X3mtf4+hPW/
         RZlQ==
X-Gm-Message-State: AOAM532d3f270LJo4hpjIyu54EVQUcGmRNDm87N0kwcrd5rYs9uWpe/o
        zGil6eBn7LrjftbAhQ2bPh32sg==
X-Google-Smtp-Source: ABdhPJx6GARrpfmd7RYe9EeZS+WjO2cdka7dAs3my8o/AgXGaGqcz1EmZ3HgIkTRGJBLcvh/QSF28A==
X-Received: by 2002:a62:7745:0:b0:4ba:7251:d559 with SMTP id s66-20020a627745000000b004ba7251d559mr51775452pfc.35.1641319280733;
        Tue, 04 Jan 2022 10:01:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t5sm34178556pgj.85.2022.01.04.10.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:01:20 -0800 (PST)
Date:   Tue, 4 Jan 2022 18:01:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hou Wenlong <houwenlong93@linux.alibaba.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: eventfd: Fix false positive RCU usage warning
Message-ID: <YdSLbGM8QQXJ7WWG@google.com>
References: <ab1358b84c60e6c942c270e3fe1a32bfa3177f3c.1641264282.git.houwenlong93@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1358b84c60e6c942c270e3fe1a32bfa3177f3c.1641264282.git.houwenlong93@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022, Hou Wenlong wrote:
> Fix the following false positive warning:
> [   20.995979] =============================
> [   20.996878] WARNING: suspicious RCU usage
> [   20.997792] 5.16.0-rc4+ #57 Not tainted
> [   20.998651] -----------------------------
> [   20.999544] arch/x86/kvm/../../../virt/kvm/eventfd.c:484 RCU-list traversed in non-reader section!!
> [   21.001490]
> [   21.001490] other info that might help us debug this:
> [   21.001490]
> [   21.003240]
> [   21.003240] rcu_scheduler_active = 2, debug_locks = 1
> [   21.004662] 3 locks held by fc_vcpu 0/330:
> [   21.005573]  #0: ffff8884835fc0b0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x88/0x6f0 [kvm]
> [   21.007617]  #1: ffffc90004c0bb68 (&kvm->srcu){....}-{0:0}, at: vcpu_enter_guest+0x600/0x1860 [kvm]
> [   21.009627]  #2: ffffc90004c0c1d0 (&kvm->irq_srcu){....}-{0:0}, at: kvm_notify_acked_irq+0x36/0x180 [kvm]
> [   21.011732]
> [   21.011732] stack backtrace:
> [   21.012733] CPU: 26 PID: 330 Comm: fc_vcpu 0 Not tainted 5.16.0-rc4+
> [   21.014189] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   21.016565] Call Trace:
> [   21.017105]  <TASK>
> [   21.017591]  dump_stack_lvl+0x44/0x57
> [   21.018467]  kvm_notify_acked_gsi+0x6b/0x70 [kvm]
> [   21.019533]  kvm_notify_acked_irq+0x8d/0x180 [kvm]
> [   21.020616]  kvm_ioapic_update_eoi+0x92/0x240 [kvm]
> [   21.021736]  kvm_apic_set_eoi_accelerated+0x2a/0xe0 [kvm]
> [   21.022968]  handle_apic_eoi_induced+0x3d/0x60 [kvm_intel]
> [   21.024168]  vmx_handle_exit+0x19c/0x6a0 [kvm_intel]
> [   21.025255]  vcpu_enter_guest+0x66e/0x1860 [kvm]
> [   21.026303]  ? lock_acquire+0x27f/0x300
> [   21.027166]  ? lock_is_held_type+0xdf/0x130
> [   21.028090]  ? kvm_arch_vcpu_ioctl_run+0x438/0x7f0 [kvm]
> [   21.029286]  ? kvm_arch_vcpu_ioctl_run+0x11a/0x7f0 [kvm]
> [   21.030485]  kvm_arch_vcpu_ioctl_run+0x438/0x7f0 [kvm]
> [   21.031647]  kvm_vcpu_ioctl+0x38a/0x6f0 [kvm]
> [   21.032647]  ? __fget_files+0x156/0x220
> [   21.033522]  __x64_sys_ioctl+0x89/0xc0
> [   21.034360]  ? syscall_trace_enter.isra.18+0xea/0x260
> [   21.035478]  do_syscall_64+0x3a/0x90
> [   21.036259]  entry_SYSCALL_64_after_hwframe+0x44/0xae

For future submissions, please strip the timestamps and the "? " entries, they're
unnecessary noise.

> Since srcu read lock is held, it's a false positive warning.

Stronger phrashing should be used, this makes it sound like SRCU is held by
coincidence, but kvm_unregister_irq_ack_notifier() does synchronize_srcu(&kvm->irq_srcu),
i.e. irq_srcu is indeed intended protection mechansim.

> Use hlist_for_each_entry_srcu() instead of hlist_for_each_entry_rcu()
> as it also checkes if the right lock is held.
> 
> Signed-off-by: Hou Wenlong <houwenlong93@linux.alibaba.com>

Changelog nits aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>
