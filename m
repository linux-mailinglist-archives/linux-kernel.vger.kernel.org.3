Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46049DBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiA0Hw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237540AbiA0Hw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643269978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YabZw893JW2loWWPIkIyf476d9uOVXRZS4qkmaaFWdY=;
        b=dEAztcVvqXvO5AoWHtf2fhT15hFniJPT5G9ZVgG10rLmncKq4oNrEUusxF4wOVbskyj18f
        BhmIjrTAwW6W7A3fo8p7pIKi2/3MQLlVRZ4pE4Dch6GuYyyOh1MfcWSFnF8KX4PzvbtvQv
        VzgTgB4u7i31QOZi6K+n2Gn5zrxkBQw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-vPNVuSZnOxu_w_C5OKjFpA-1; Thu, 27 Jan 2022 02:52:56 -0500
X-MC-Unique: vPNVuSZnOxu_w_C5OKjFpA-1
Received: by mail-wr1-f70.google.com with SMTP id i16-20020adfa510000000b001d7f57750a6so754146wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YabZw893JW2loWWPIkIyf476d9uOVXRZS4qkmaaFWdY=;
        b=TXsz29Y8ASn5GueFyCIENSqEqzcyval5tSjht6OtG1Dbebs8AjYXnMyLQQHgT+8oir
         wOYRfFOFGo1dIY9WXv7Ju0jzeealMlRXXQ8FGxdHBvoNWKE3t+lu3xc42VR5GCm1DE6J
         P8CGhgWRd4zp8G54Sw7LjOoItsjYyNaqs61p0Jt4mq6e4FLbfnhYAP1i9y5Dv50MBFVp
         oqOf7/rVs1A6MGQXqq+Ev2d9YpOfwHFCtgyzguJpzVwwqHe2TJCLYEbWdrdKF70+Aqzi
         /GnoIIfM1mb7pqOZTG0l8Qe2Xeqhdrq+ZOLNMMknWZxuwIk8GlwimhohhHp38juNYA63
         aVug==
X-Gm-Message-State: AOAM530YxxeZl4PvK7WtTcKNRalE3oRcOLWZfU1TED5tYRPgNIRBbgGn
        qYZdX6fvAaO4ws4K3OZtsC2UlLTuD2yZef5X6SqEmRIZ4mvAmGV0d5D8fwcr1Ih1yucNV3xsb2B
        wkhMcSlRnczK7IApuLhukBWpv
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr2104980wmg.4.1643269975575;
        Wed, 26 Jan 2022 23:52:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlfPajydhgnYfO0Y/v2sVH+H3onh4KBKxIDGD/yrfss4vYkRjbod1Tuq2X/m1REL0RMkV9qg==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr2104961wmg.4.1643269975358;
        Wed, 26 Jan 2022 23:52:55 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id a3sm1641890wri.89.2022.01.26.23.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 23:52:54 -0800 (PST)
Message-ID: <e82f74a6-437b-0db0-aba7-afd54bceac2e@redhat.com>
Date:   Thu, 27 Jan 2022 08:52:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [KVM] 2efd61a608:
 WARNING:at_arch/x86/kvm/../../../virt/kvm/kvm_main.c:#mark_page_dirty_in_slot
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20220127023015.GA34140@xsang-OptiPlex-9020>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220127023015.GA34140@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 03:30, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 2efd61a608b0039911924d2e5d7028eb37496e85 ("KVM: Warn if mark_page_dirty() is called without an active vCPU")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> [ 123.817787][ T9801] RIP: 0010:mark_page_dirty_in_slot (arch/x86/kvm/../../../virt/kvm/kvm_main.c:3160 (discriminator 1))
> [ 123.935134][ T9801] __kvm_write_guest_page (arch/x86/kvm/../../../virt/kvm/kvm_main.c:2947)
> [ 123.940399][ T9801] kvm_write_guest (arch/x86/kvm/../../../virt/kvm/kvm_main.c:2978)
> [ 123.944953][ T9801] kvm_hv_invalidate_tsc_page (arch/x86/kvm/hyperv.c:1220)

Hi, this is known and should be fixed soon.

Paolo

