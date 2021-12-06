Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28044691F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbhLFJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:10:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239928AbhLFJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638781591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVIHKBsFBEu5zZ965qZJ2FXtzIGfRwaA3qUe2cZhBzw=;
        b=HHBpAwqhWyQPdJgjh/mcDJchVpTxgr2unBAiYGIvc3ZsfxsjD2S8qjsDNrLMm0CqqAw9w2
        2mvva90a63Q6NPDh730kMp/6O+6z4GYq0VLWT/wcd/S4+PdW3xEG4ahglJ/0MSQudaqROQ
        AANdPq2c2Agn3ZRgBICmn2SwtIVyWNA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-2JkR2_zxNDGUmH2Usr9akQ-1; Mon, 06 Dec 2021 04:06:30 -0500
X-MC-Unique: 2JkR2_zxNDGUmH2Usr9akQ-1
Received: by mail-ed1-f71.google.com with SMTP id k7-20020aa7c387000000b003e7ed87fb31so7853743edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vVIHKBsFBEu5zZ965qZJ2FXtzIGfRwaA3qUe2cZhBzw=;
        b=Pi37hnEmlJ0EYEYOIr33+NHUCFbMjfugU3sK36855HXgFBRxf3R/NhADIcwRBbZJD2
         tBaUC8aJdli/FZ82V8v6yXosBpYjxaRDPslso9bF0MtbtUXfTKJ3KWn7TyDPRcElha9Z
         k7DztS6We+0nrlpst9cCKE77Lo+GRK82E8toLawZPKJyGzF9geqA82n8SmcTAwRB8/PG
         S/UEwKolVu7orIl2ZwsYIK6+eEwR9Tk3NXuE2U5m3rkMbCgFBOiqZ2MkYrfrxkJLT0jT
         3zq6iv5suL1YvBtFFIMJCuRl5OljH7YQ8Km43OXI8nMYNnQXiiRIoUHNw64sKsN+lRve
         w2gg==
X-Gm-Message-State: AOAM530E3h3fQGK9LJqEPSKCiZAr37BJGS2Ac8ZgQQCdQBlQY+/MCTI2
        v758R2DGFtJo+QcuegG2CkNlibvRNsT8IsybFrK2BIcMTew6QC6wEu3wf8IG0T34O1sqwdNx9J+
        nAbxy5Uz+f8nqjLc9G6AxWfyX
X-Received: by 2002:a50:9514:: with SMTP id u20mr52142570eda.117.1638781587838;
        Mon, 06 Dec 2021 01:06:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNCU153xrFqJiuFOZtm9RCUodEdli+fDVWDvQKBTNgkxa9VBQ5k3uG8wPNQRYAsOJmsj2Jeg==
X-Received: by 2002:a50:9514:: with SMTP id u20mr52142542eda.117.1638781587686;
        Mon, 06 Dec 2021 01:06:27 -0800 (PST)
Received: from fedora (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h2sm7467053edl.85.2021.12.06.01.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:06:27 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amhamza.mgc@gmail.com, pbonzini@redhat.com, seanjc@google.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH] KVM: x86: fix for missing initialization of return
 status variable
In-Reply-To: <20211205194719.16987-1-amhamza.mgc@gmail.com>
References: <20211205194719.16987-1-amhamza.mgc@gmail.com>
Date:   Mon, 06 Dec 2021 10:06:26 +0100
Message-ID: <87ee6q6r1p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ameer Hamza <amhamza.mgc@gmail.com> writes:

> If undefined ioctl number is passed to the kvm_vcpu_ioctl_device_attr
> function, it should return with error status.
>
> Addresses-Coverity: 1494124 ("Uninitialized scalar variable")
>
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e0aa4dd53c7f..55b90c185717 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5001,7 +5001,7 @@ static int kvm_vcpu_ioctl_device_attr(struct kvm_vcpu *vcpu,
>  				      void __user *argp)
>  {
>  	struct kvm_device_attr attr;
> -	int r;
> +	int r = -EINVAL;
>  
>  	if (copy_from_user(&attr, argp, sizeof(attr)))
>  		return -EFAULT;

The reported issue is not real, kvm_vcpu_ioctl_device_attr() is never
called with anything but [KVM_HAS_DEVICE_ATTR, KVM_GET_DEVICE_ATTR,
KVM_SET_DEVICE_ATTR] as 'ioctl' and the switch below covers all
three. Instead of initializing 'r' we could've added a 'default' case to
the switch, either returning something like EINVAL or just BUG(). Hope
it'll silence coverity.

-- 
Vitaly

