Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00748AAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiAKJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiAKJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:40:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE6C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:40:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso4808804pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=29eYrea5TDtnK5EIdmX1Jj/oj6JLKnkcWRIn4vZIh5c=;
        b=RD5XB8O2H5sDfMBSzLDqjPQ6w8nUiKM4fPElrmz1ywPkPhbTgt9w/fBGAZ6MWRAkBG
         AMv6BOonqA8uAyAac6tIA2pz8kslC2OiCWkhe7dHJXTl4Il5s3CW24pECot9fJH8TXG2
         U+JhWUsGAYpjCpjUlEABLiV/kbuZw9R9QyCaz0bPBFvRDZemd78bHj2zwqLnzeTMMkF4
         GfYnzt63Io59m6xdTWLMILLJK/Z6j68B7Z6ZrIJTO/rKrxT3s6qLbvzG8rnw9EgOBGOd
         MwnLOBtvD0wPnYiHLzbPiB4zpBoQ2y/GilmaF1BjxgjxaBIw8ck+73wqWZoGKCkf86ee
         7pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29eYrea5TDtnK5EIdmX1Jj/oj6JLKnkcWRIn4vZIh5c=;
        b=zRgmOOTp1Qlu9GiQWuXYmT3TdYdmXcL/sglBynCyKEkftm+DGgOvY76HkO278XBDWt
         GVPDGJvkpti0oktT4OJuyOjHhhPZOr4nTVtOojwV5iNwcpYCmIzzqqSLyELhihtLe4TU
         ErMVeB8oBZzNSevyc5b0Ygi31rs/bew0/+0y5rzC8ijlBwX8LKGdMRWRe3zLSbmvsph5
         0A71hYMtksGXoXkBiCZsBWAyWYki0ok5UWNJjWRo6CQ5A/dbIuSDlghP/rV18FbjyYOz
         nvWrRfEMh7iT8CqfRSdh2IdlEeViazGQkokD9nDInKfHvBflSqgCLGrj6wH9VGxC+jxH
         3DuA==
X-Gm-Message-State: AOAM5329l+kNRIv12WUisMuME7HAqvaL8EpgyI2Bzy5xn2Pu5pAkhjhe
        Y08syJmVYSM1vmT2dp97qJAxzDiGq9I=
X-Google-Smtp-Source: ABdhPJy4DNY+E2ONe6nBqviW4EdiG118126QljAAFfPBhjQJAPp+0nuqGn10nq9mOvyxudbM4wYNAg==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr3340098pgc.572.1641894055129;
        Tue, 11 Jan 2022 01:40:55 -0800 (PST)
Received: from [30.43.104.246] ([47.89.83.37])
        by smtp.gmail.com with ESMTPSA id x29sm919279pfh.175.2022.01.11.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 01:40:54 -0800 (PST)
Message-ID: <89165079-d2a6-fad8-3a9c-dcb46a8acdc7@gmail.com>
Date:   Tue, 11 Jan 2022 17:40:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 02/21] KVM: arm64: Add SDEI virtualization
 infrastructure
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-3-gshan@redhat.com>
From:   Shannon Zhao <shannon.zhaosl@gmail.com>
In-Reply-To: <20210815001352.81927-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/15 8:13, Gavin Shan wrote:
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e9a2b8f27792..2f021aa41632 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -150,6 +150,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   
>   	kvm_vgic_early_init(kvm);
>   
> +	kvm_sdei_init_vm(kvm);
> +
>   	/* The maximum number of VCPUs is limited by the host's GIC model */
>   	kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
Hi, Is it possible to let user space to choose whether enabling SEDI or 
not rather than enable it by default?
