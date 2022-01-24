Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C288A498498
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbiAXQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbiAXQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:23:14 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C7C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:23:14 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 187so15610686pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l7aZJnt8QJHGg+NhfzeZeueXVQnuGTn1GJNwLw97API=;
        b=aMgOFBudEvo/1+mRGOn+iLXumNUshu9rs2Jl4IUpDDpx4RwzMzW4x8HTOy1fGwmdiM
         55Dw8smutxb6UOvriTHkEd5g7L3tWNtxbP0d5S0ywsFR0Gk4yY/ON+XcwJNLBtO7pQR9
         +QXL+eYiYtZ2IDlrIl9YlJCWJ5xEOQUbk9vKcW9POGqHRvmC1FIOaNps3gZnPnetlIDu
         +ghHC6fCb6nqd5h6RINSXYVRfDYALCAN8wJn/+NyBpuz0yg4TC3NVOrl3VKUj2TlUE85
         oBHKi3R6q4kWUNYx2XRJPFgN9rBd+PSgQRKr6TgNOc2LcdcZ1IFIaN0wwmjom0fA3sB3
         Fu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7aZJnt8QJHGg+NhfzeZeueXVQnuGTn1GJNwLw97API=;
        b=C+yu1g7UUCQaFhem17y2pjFuoTZdluN+6Jx4vKvZPUipkYebr0pdatzWm+5ZpYDfwW
         5OowLpHQ++mk6egXGQJkilraSqpiyUzdNJBbOCUechohbyDTfsE9OIKBWr1pflifDniU
         hy1cLvJxQrPUfXVV7Osx4T+hIxCQ4GXySx6fkmAJhFw3I+Ph7KIOMnjV6OjQVW/edpnZ
         00YOYoH/NWJio51JSUrqF/UOJ4i+pR6aiDtzITTeatYBgf0MYCrvBhU07iw342oqSYSn
         Wc75sLC6rhGtjt2HkPJLkyRLASCiO7V0En0/6dkPO2O6Yh4v0WZTv9c+wqUqbDQtleHn
         FHNg==
X-Gm-Message-State: AOAM532onHzPF0H9y3HV6/dMjpxVvClOj5+2dO6m7dREirSAUSCI1DaS
        iN/AethauzQ6fnfbAhwoz/5JIg==
X-Google-Smtp-Source: ABdhPJxVMo1edQcNkn0O784je5xXtByJ/sPu5BxFgdgA331J9x1X3lWhbYdWQ6XphC5dfFHpuu3EhA==
X-Received: by 2002:a63:81c6:: with SMTP id t189mr12364478pgd.417.1643041393455;
        Mon, 24 Jan 2022 08:23:13 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id nu15sm5412136pjb.5.2022.01.24.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:23:12 -0800 (PST)
Date:   Mon, 24 Jan 2022 16:23:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/cpuid: Exclude unpermitted xfeatures for
 vcpu->arch.guest_supported_xcr0
Message-ID: <Ye7SbfPL/QAjOI6s@google.com>
References: <20220123055025.81342-1-likexu@tencent.com>
 <BN9PR11MB52762E2DEF810DF9AFAE1DDC8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <38c1fbc3-d770-48f3-5432-8fa1fde033f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c1fbc3-d770-48f3-5432-8fa1fde033f5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022, Like Xu wrote:
> On 24/1/2022 3:06 pm, Tian, Kevin wrote:
> > > From: Like Xu <like.xu.linux@gmail.com>
> > > Sent: Sunday, January 23, 2022 1:50 PM
> > > 
> > > From: Like Xu <likexu@tencent.com>
> > > 
> > > A malicious user space can bypass xstate_get_guest_group_perm() in the
> > > KVM_GET_SUPPORTED_CPUID mechanism and obtain unpermitted xfeatures,
> > > since the validity check of xcr0 depends only on guest_supported_xcr0.
> > 
> > Unpermitted xfeatures cannot pass kvm_check_cpuid()...
> 
> Indeed, 5ab2f45bba4894a0db4af8567da3efd6228dd010.
> 
> This part of logic is pretty fragile and fragmented due to semantic
> inconsistencies between supported_xcr0 and guest_supported_xcr0
> in other three places:

There are no inconsistencies, at least not in the examples below, as the examples
are intended to work in host context.  guest_supported_xcr0 is about what the guest
is/isn't allowed to access, it has no bearing on what host userspace can/can't do.
Or are you talking about a different type of inconsistency?

> - __do_cpuid_func

Reporting what KVM supports to host userspace.

> - kvm_mpx_supported

This is a check on host support.

> - kvm_vcpu_ioctl_x86_set_xsave

"write" from host userspace.

> Have you identified all their areas of use ?
