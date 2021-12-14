Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA34474994
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhLNRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhLNRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:36:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:36:25 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w24so1405075ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qfoCk9NYj36wSO78chHeHprCwWDcDj2DQwomY20Cuc=;
        b=OUZQ8DCHjP9TRW8CJm+8LSgPbnAxZlVxs4OzE40QKhFaYd2m7JZEn+vySxLM0pB3pX
         Gr8+TxFGWRg4W9UQMIh2Jbe7wm7b+SSyDou3BBhjhTI4AEy8hWAd83ri8jlQ7SBhyfZD
         xlFNBekQNhOZtE62lEBj6v3PWDZ/jfAnYzaW72F9JuI/51oT1G/N2Yt/vGLJLjf8qCzE
         lf6nyfzhhSqy7H3VAGjwDma+i9bTJ+ZSpEtgqGt+u2cWi8hvc/3Piy4pG+p8RsbzvdaT
         7VpNg20B0AwbsvgVnqRfkk6/WBLpkQK/LU8ft30oYEyHUaj5U+3n+mIagSlvuturhVf/
         DyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qfoCk9NYj36wSO78chHeHprCwWDcDj2DQwomY20Cuc=;
        b=KyE+n8v3pKz088785L++qHXt9t8+YxMJXkfXS8urp22jlh21+ij7kpZjQqJxSRSpAT
         PhROYoGuIVycU5Wg7ARhftHuzkpAz6lTmuiQDR+VOsqVAy9wa6TDDVJM1GM7PIz/HxnT
         rsBwH3npNcKbRoh51vYlsYgK46cpvZT9zj/oBI3yEvfsoZLcxqTWq+R+TbAc5I+B1hyU
         3YL0ofy+W34Q74HDxfodpodyUUyum+Md5ssXWLRHWNMSfEuIq1sAYobkB20ZtOu9h4Uz
         gGAiF5JmRf4nKQ6R4j1OeXuTKKwYAs2gw1KYW9vt2cBkxWGmqMrZ64MdaHlv+wDXVLjA
         V7MA==
X-Gm-Message-State: AOAM532IZ2oT0rNXXNJ/TrtCrQm3dsQ1Rk6tV9RVbk9GD8mdS4h1D6hp
        U55ZZxecwenuMYP5jpAMquqnBA==
X-Google-Smtp-Source: ABdhPJybrbbAKyROLXuOjybmV0nvQSHW/baM2Y1cBztL8vk2eAGw9GH1zzra5MJK4rFe86GdrgSg+w==
X-Received: by 2002:a17:903:283:b0:142:1243:d879 with SMTP id j3-20020a170903028300b001421243d879mr6960928plr.61.1639503385324;
        Tue, 14 Dec 2021 09:36:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z8sm325250pgc.53.2021.12.14.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:36:24 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:36:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Huangzhichao <huangzhichao@huawei.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The vcpu won't be wakened for a long time
Message-ID: <YbjWFTtNo9Ap7kDp@google.com>
References: <73d46f3cc46a499c8e39fdf704b2deaf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d46f3cc46a499c8e39fdf704b2deaf@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> Hi guys,
> 
> We find a problem in kvm_vcpu_block().
> 
> The testcase is:
>  - VM configured with 1 vcpu and 1 VF (using vfio-pci passthrough)
>  - the vfio interrupt and the vcpu are bound to the same pcpu
>  - using remapped mode IRTE, NOT posted mode

What exactly is configured to force remapped mode?

> The bug was triggered when the vcpu executed HLT instruction:
> 
> kvm_vcpu_block:
>     prepare_to_rcuwait(&vcpu->wait);
>     for (;;) {
>         set_current_state(TASK_INTERRUPTIBLE);
> 
>         if (kvm_vcpu_check_block(vcpu) < 0)
>             break;
> 					<------------ (*)
>         waited = true;
>         schedule();
>     }
>     finish_rcuwait(&vcpu->wait);
> 
> The vcpu will go to sleep even if an interrupt from the VF is fired at (*) and
> the PIR and ON bit will be set ( in vmx_deliver_posted_interrupt ), so the vcpu
> won't be wakened by subsequent interrupts.
> 
> Any suggestions ? Thanks.

What kernel version?  There have been a variety of fixes/changes in the area in
recent kernels.
