Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D737A487ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348420AbiAGRBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348414AbiAGRBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641574879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6Wtt81F5NRyq+7anyHaeZ8gNweIa4SRLjJrTVDPmEE=;
        b=iR1VNgAh1yT0fF/cB/v3dIp6vnkmFioC06JtpioPBMuDWy0SH7QB+eiEAclQAU3Hy8tKg1
        vOASUVGhbdcBJqz0SD9zNuEHmE8P7pJsBnArrEcsTWqgD7xemp5yIYV8aHyK+tYZUQFSEz
        HRZlyoXBMgXwu7rAy+pY+MY6tntXYHU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-IMw5jx-qNn63BQXy2hsJog-1; Fri, 07 Jan 2022 12:01:18 -0500
X-MC-Unique: IMw5jx-qNn63BQXy2hsJog-1
Received: by mail-ed1-f69.google.com with SMTP id v18-20020a056402349200b003f8d3b7ee8dso5136294edc.23
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 09:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n6Wtt81F5NRyq+7anyHaeZ8gNweIa4SRLjJrTVDPmEE=;
        b=2o+VaVtY5If+/9Oh8kqjW4Y6dea8EigKGyIQxq+MFTmb2SWNUM/BWCEIpxdOx9Vmwk
         Lvw8BDxIS2BUMrnUS/8msBZrcO+RgAF6JC1hxW8u0hp59L5milzbJ1rivrIbVIIMdFNw
         LrN43or7g8lqJ521b42AT2DSFiciuy8/EFZfFiMUZHONFHW1l3buwivF8UwWfinItPLp
         /SGID1e0Tackg9W4tIQnJ/xVTOVsUSwGTUzOe/95YPPFcym7K9XjrBOKpdDnLIVzcNNW
         irCcLdzC5QLX64/QhsC4c5pd5FH7/5OFw1OLN20uet5RXDLZzgnJDpv282FsTh9NPGKW
         dBDQ==
X-Gm-Message-State: AOAM530M0ZKw/PgqAMJx+tMEnsWofxb1UlLcxa1W92s3RUC38P7mWrTT
        rPBPfS7/CsNcb5mB4aeojASIiKn/ko95vlHZ9x9Blhy7XLjtv53ftzyYkUSttHatcWroazEPOxd
        f1xQRInnC2Ys6eFu5pagHt2cw
X-Received: by 2002:a17:907:97d5:: with SMTP id js21mr50680665ejc.445.1641574877196;
        Fri, 07 Jan 2022 09:01:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBpOgErGO2OoUXRYl4edklXNaxrmp4F0X9/lL5aCJFBlLmbAuwypaepJ5eq/oE/BEAplUZTw==
X-Received: by 2002:a17:907:97d5:: with SMTP id js21mr50680647ejc.445.1641574876989;
        Fri, 07 Jan 2022 09:01:16 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id qw9sm1546027ejc.211.2022.01.07.09.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 09:01:16 -0800 (PST)
Message-ID: <189ed5d9-88b4-eed3-7388-f02dcadecb51@redhat.com>
Date:   Fri, 7 Jan 2022 18:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: SEV: Add lock subtyping in sev_lock_two_vms so
 lockdep doesn't report false dependencies
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1641364863-26331-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1641364863-26331-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 07:41, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Both source and dest vms' kvm->locks are held in sev_lock_two_vms,
> we should mark one with different subtype to avoid false positives
> from lockdep.
> 
> Fixes: c9d61dcb0bc26 (KVM: SEV: accept signals in sev_lock_two_vms)
> Reported-by: Yiru Xu <xyru1999@gmail.com>
> Tested-by: Jinrong Liang <cloudliang@tencent.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>   arch/x86/kvm/svm/sev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 7656a2c..be28831 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1565,7 +1565,7 @@ static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
>   	r = -EINTR;
>   	if (mutex_lock_killable(&dst_kvm->lock))
>   		goto release_src;
> -	if (mutex_lock_killable(&src_kvm->lock))
> +	if (mutex_lock_killable_nested(&src_kvm->lock, SINGLE_DEPTH_NESTING))
>   		goto unlock_dst;
>   	return 0;
>   

Queued, thanks.

Paolo

