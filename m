Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC40462810
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhK2XTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhK2XTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:19:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB4BC06FD79
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:08:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o4so18508388pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGXlqysNMLf5dA9ShtMuuUcB61yXXSlnUdTXbJgqyho=;
        b=aQ/MHWcXkD40A0P6F/6pM4uytFQ1pWDwdyAmR4hDPIKAUjO1vpeLU+g2hrC/FxndqK
         loB4MxuF23gDHET1FyZyFunD5Du7IPGSUpsxbh7Us1OFyB4/JhEK3lM+Ntxco0j/q7c6
         QjZvaJP5Le+cmyeC/BiIoJbf4PkdiDyTTkNhIL9j8ygo81zWKZrLKTWgvABuo4P/PbSX
         dmlq0JFxUo7H/RqhL3jXUJtxX+CnCl9WussVvI3u8/SItZceeQnSdjRGzC5MSduA7Ky9
         vjgqowrmtB3btV4elbRxg407ENgf5kCrB8pI72qo0qexp01IGdJaQWfCKYQ+vUiD+Qrc
         tVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGXlqysNMLf5dA9ShtMuuUcB61yXXSlnUdTXbJgqyho=;
        b=DB1olT7J77QVlp2RNIs/r0kyTJ2T90a4neDzDCkaItDUfPLvSN7hKbzf0UOc0HE0PP
         JcIF5t+np1K/iStf4QzuI+zANmBY4uQOF9aWBwCJCU4PUQ2RaPO9nNcnLdT3yBUlwnsE
         GRZ7Y6lfGWoX2Riqfym7A25Qo5aASOvrIoWcXauykThSiVJx9vS578bQcbr6XktOoBLd
         ZF8W9kMrzBgWBFI4UgqpSdksx2uNPhWEnF4o2AoUUkGncwBpUIb5TIHxb9x56kUxMuAp
         bniS22x3nK4vt2XHo/hFNEAU1dxJrZ0/bCjYggPsd4ZeOBNMfgKX89zFKaMiATvaxb0K
         Db8A==
X-Gm-Message-State: AOAM533YJXXzxEsaUezZcwsDtOoCmUhdDPHbDRIU0QzurAng2R3SQf56
        pclOZw3otjSaJzqjy0j7rurTtg==
X-Google-Smtp-Source: ABdhPJxK2jL73IyU2JgUo1UmNPcjuYlETOcdXVWiZubhTKgRJr0mbwX0U3dEq0NUGzE3QbDNfd6SHg==
X-Received: by 2002:a63:f91f:: with SMTP id h31mr24053499pgi.538.1638227330585;
        Mon, 29 Nov 2021 15:08:50 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y190sm18403540pfg.153.2021.11.29.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:08:50 -0800 (PST)
Date:   Mon, 29 Nov 2021 23:08:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pgonda@google.com
Subject: Re: [PATCH 09/12] KVM: SEV: Do COPY_ENC_CONTEXT_FROM with both VMs
 locked
Message-ID: <YaVdfpxHFjEnT+yK@google.com>
References: <20211123005036.2954379-1-pbonzini@redhat.com>
 <20211123005036.2954379-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123005036.2954379-10-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021, Paolo Bonzini wrote:
> Now that we have a facility to lock two VMs with deadlock
> protection, use it for the creation of mirror VMs as well.  One of
> COPY_ENC_CONTEXT_FROM(dst, src) and COPY_ENC_CONTEXT_FROM(src, dst)
> would always fail, so the combination is nonsensical and it is okay to
> return -EBUSY if it is attempted.
> 
> This sidesteps the question of what happens if a VM is
> MOVE_ENC_CONTEXT_FROM'd at the same time as it is
> COPY_ENC_CONTEXT_FROM'd: the locking prevents that from
> happening.
> 
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/sev.c | 69 +++++++++++++++++-------------------------
>  1 file changed, 27 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c1eb1c83401d..025d9731b66c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1548,6 +1548,9 @@ static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
>  	struct kvm_sev_info *dst_sev = &to_kvm_svm(dst_kvm)->sev_info;
>  	struct kvm_sev_info *src_sev = &to_kvm_svm(src_kvm)->sev_info;
>  
> +	if (dst_kvm == src_kvm)
> +		return -EINVAL;

This should go into 

  KVM: SEV: cleanup locking for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
 
because before that, KVM would never attempt mutex_lock() on the second VM, one
of the SEV || !SEV was guaranteed to fail.

With that change,

Reviewed-by: Sean Christopherson <seanjc@google.com> 
