Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27F847460B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhLNPHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:07:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231266AbhLNPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639494472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TsrbpN2qcfX3aFt5wXOi5c4TqBdGXNyhO7JY9oJZus=;
        b=N5bWILXcM5LpFt8RECYjIx62NVCaTyl6z5gCtMhRXWPtjm9dQkeDFa5waqPxxbRl780sWi
        69eNZg2PbM80KDSzVPRcPleRM1SEDa+movigbeKePeS1/wqvE3ao6iBivp2F4TKo3B6pye
        P11MFkRV0CHUGJ89r/M5W7YdezPBzhc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-WnmuezwuNQCEti9ggojHHg-1; Tue, 14 Dec 2021 10:07:51 -0500
X-MC-Unique: WnmuezwuNQCEti9ggojHHg-1
Received: by mail-ed1-f71.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so17252840edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5TsrbpN2qcfX3aFt5wXOi5c4TqBdGXNyhO7JY9oJZus=;
        b=f7Tig97EPQjELYvBG4cXMm7Z+ir3IxrVkyNOJmZ8U/zuBB84tG/DCcuzSz4DHuqSm1
         Ab4WbQqML6V299HbXk48tl6HFVGfbKZaO1RvMJqCu23zhfhhyYymr0J5wUTRu2NmqnvZ
         JqIddeL89hTKrX79D53ssImXTXa5OjZ2HFpw1JxDxNZB6VAglzgW4L+xTVITEBbLdXXa
         H58YgcYjSBoiiJBvDCjP1WGD8H9L4IXR//c4G3vFXf8dr9ovdR1HjQyEB7vsCNse1n6K
         tuAPyPf4BbnaAnkAo7nE4YPSa3K2A7ltjftamiHtnVhFeNY3DIWSdJm6rVKi2F33w1HP
         qUvg==
X-Gm-Message-State: AOAM530VfxOP9EXAvV/j8Qx37E5v8P6X3/lguG3vRce9ckHYFj20V56W
        jk2ZRBJaGaO0zT49unfC67FSDPUt0N7CEyaim1IUL21UfVoXIQHhE4HI3W19sRzBydz/+Z5Eut+
        9oisPQl5BPHes6E6iVGvyC/ju
X-Received: by 2002:a17:906:b084:: with SMTP id x4mr6166811ejy.214.1639494470133;
        Tue, 14 Dec 2021 07:07:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL1sFNHf7cavCioNMSZSnQSUNNrFzXwlJAk7yQXbGZOLU6nga68ZKQWPGfuPU160cU7w/tZA==
X-Received: by 2002:a17:906:b084:: with SMTP id x4mr6166795ejy.214.1639494469920;
        Tue, 14 Dec 2021 07:07:49 -0800 (PST)
Received: from gator.home (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id r3sm1233ejr.79.2021.12.14.07.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 07:07:49 -0800 (PST)
Date:   Tue, 14 Dec 2021 16:07:47 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com, mlevitsk@redhat.com,
        joao.m.martins@oracle.com, stable@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3] selftests: KVM: avoid failures due to reserved
 HyperTransport region
Message-ID: <20211214150747.c5xcdjghenunyw5e@gator.home>
References: <20211209223040.304355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209223040.304355-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 05:30:40PM -0500, Paolo Bonzini wrote:
> AMD proceessors define an address range that is reserved by HyperTransport
> and causes a failure if used for guest physical addresses.  Avoid
> selftests failures by reserving those guest physical addresses; the
> rules are:
> 
> - On parts with <40 bits, its fully hidden from software.
> 
> - Before Fam17h, it was always 12G just below 1T, even if there was more
> RAM above this location.  In this case we just not use any RAM above 1T.
> 
> - On Fam17h and later, it is variable based on SME, and is either just
> below 2^48 (no encryption) or 2^43 (encryption).
> 
> Fixes: ef4c9f4f6546 ("KVM: selftests: Fix 32-bit truncation of vm_get_max_gfn()")
> Cc: stable@vger.kernel.org
> Cc: David Matlack <dmatlack@google.com>
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20210805105423.412878-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  9 +++
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
>  .../selftests/kvm/lib/x86_64/processor.c      | 69 +++++++++++++++++++
>  3 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 6a1a37f30494..da2b702da71a 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -71,6 +71,15 @@ enum vm_guest_mode {
>  
>  #endif
>  
> +#if defined(__x86_64__)
> +unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
> +#else
> +static inline unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
> +{
> +	return ((1ULL << vm->pa_bits) >> vm->page_shift) - 1;
> +}

This breaks compiling on non-x86 architectures because of how we keep
the vm struct private. I'll send a patch that puts vm_compute_max_gfn
in lib/kvm_util.c but as a weak symbol.

(Maybe we should stop keeping the vm struct private...)

Thanks,
drew

