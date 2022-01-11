Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858AA48AABB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiAKJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiAKJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:43:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F43C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:43:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso4136797pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KnfNQM0P4Kk/f9HQK7av976cxzJdXVOcvjBDqvTAbaY=;
        b=IjCXqpKc+vMIKLi9hRQJSIg68R7/Cz32H2/4DJlhXVmA1PZ19v18p5UQAKRlNk1e8F
         dm/Y6k/pT62yLd/t0Bc94Kt8sBX16j8Tu/56AObBV/IQf7XFNpRXOgS3yLPylNTOBPwF
         gHOEj9abGeKdyo+BoWy4CjIFJH8GFmFg1KzGN2aUYNu15qNcZ6apuwlAKjfMXY6twOJq
         GP2POuPGGi1krxVpvwkfNiTOS5ibOBMj3RSx/AnqsEboglGJe1MN7HJqCCqlwNsh7Fk1
         Pn8haluL3FOdtV0fUmUCsKQfxmVeRd+JEZFlDtYJE2IChbtQc3p0BdbGexx5EKEphO9O
         S2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KnfNQM0P4Kk/f9HQK7av976cxzJdXVOcvjBDqvTAbaY=;
        b=er6YUrO3ZLoBjVEWof0hZAZyoT+22O8bHXHxQE/skDsI/WBVj4BWXgJ1MNOfuIcx1v
         XW7xtmVITeZlvEMs3wPAFDQRhQwKsWrLrJsthle0WQOzDZLUQHRxAtoALYKUzXHh4/ft
         1YasJkQYl2qYRqEOshY6CDDkqNLcgO/HhlivS9YIDIiiQZWfQ4DjgoXDKfwBRKv82cSf
         AiiQ4ytf1zYDOQLZ5VY+yFhE14mLb705xU2Zuvm4RCuTOO1xPvdykz8QzyufLGEk4M/u
         sSTcZdSCmpnXPGGx8+Kd4GmLxhCZ+4BJ/bCLRa2ujRjk/uRzilgAyZ4v/g+FqjCFxqe3
         IBpw==
X-Gm-Message-State: AOAM532d5JhU6ERWsfSQ8ymtG4BjRKH5hatZTfFuTx0jTQ4DB7FtPCck
        aIsFpmIFUbIvD7XLspm/PVo=
X-Google-Smtp-Source: ABdhPJwZfBwo/+msCTr23aIWD9mZnC/DNPCKsxnz15D3ucfytOuuINvDcO9OxS7QXee/78A4REhNjQ==
X-Received: by 2002:a17:90b:4f8d:: with SMTP id qe13mr2230606pjb.178.1641894223413;
        Tue, 11 Jan 2022 01:43:43 -0800 (PST)
Received: from [30.43.104.246] ([47.89.83.37])
        by smtp.gmail.com with ESMTPSA id lp6sm2214580pjb.55.2022.01.11.01.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 01:43:42 -0800 (PST)
Message-ID: <40d818a2-0c91-e06e-6ce8-ac8123b8d1d4@gmail.com>
Date:   Tue, 11 Jan 2022 17:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-7-gshan@redhat.com>
From:   Shannon Zhao <shannon.zhaosl@gmail.com>
In-Reply-To: <20210815001352.81927-7-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/15 8:13, Gavin Shan wrote:
> +static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_vcpu_regs *regs;
> +	unsigned long index = smccc_get_arg1(vcpu);
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei)) {
> +		ret = SDEI_NOT_SUPPORTED;
> +		goto out;
> +	}
Maybe we could move these common sanity check codes to 
kvm_sdei_hypercall to save some lines.

Thanks,
Shannon
