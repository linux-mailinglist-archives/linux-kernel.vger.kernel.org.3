Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2994B515E8A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382914AbiD3PHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiD3PHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:07:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2641D3D1DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:03:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r17so5647759iln.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bN+KlP95Qh+8AzcCi+O6jrxnnkr4fpqjrAoo7JZUIrQ=;
        b=C6qrrrvEsqgjFf0tfTBiY7jTg89Sp2IS2uml7YJ6VowC8dsRhzZ/tCkleGdXdpmIe3
         bnwPgwQNjENrtPZ+7b77dZqd6+tThC3P4fVZc7B+gG9dSkZIv0rBGRfJgO39Xmrcyy0X
         U7D3aHufAIRj9Xe1NhyE+wd9bufDs7KsHRWXlEx8riPpWoXgPpwu3ICs/mpaZQCYcf4q
         F4jGI0lEmsprK9a2i2AaFf6V+6v8iVaXZISI5JOHrNAC2MV1L2K/v9Ej1j4l2ltdPOIu
         H4UPlfwV7dXiQJUyYdmOcjn0xXBpoUZmFnsUoVT35QINXgGsUDpe8P9LRIQquIhICFq2
         iwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bN+KlP95Qh+8AzcCi+O6jrxnnkr4fpqjrAoo7JZUIrQ=;
        b=gdhTYtBsA2pG2qhdleCGUa2qT+OzUWp5hWqRIWCN0xVbuUdlXSjkuq5mZZr4vXQi6+
         eQjdxEmtQjM1qYqYK7FZdUuNV5+h5pg0eeXMhiahqxArDBTvUmVTwdJ57m4sCyH12uYv
         SUieu6a2T3uFOFYi9qkX85jd55qcNrtB+OE6wKV8xs6LIThE90rMOonBDc5qeYWvfVxv
         WYIr7gckz4cfa0WHH9OFuJmhZvk5ezYCzo4U5td1FI0jmefnhXtOXAy3HXsvtQ5Bd9Pm
         r1ZiJHpZT3mFjiXYeKuRuiBQObcOLC1TRZFe4hNuUmGF81FEKxzdV3uh80zCx6mS6mYA
         qqmw==
X-Gm-Message-State: AOAM532Q5S4C5bOkA4g7oz9hMgdSLGQyWFkAOI2akKehTp1v0FV+r9Hr
        EtjiBRvcT3mVbXVb0Ehl2ohk4w==
X-Google-Smtp-Source: ABdhPJyM5TByhnNMF+jWGfM3cRLjNBIHWo0ESp/jYAqpetPFRpUFDymt8/tMOtck9wvrr7VrV9KjLQ==
X-Received: by 2002:a05:6e02:1748:b0:2cd:a0ea:8ff4 with SMTP id y8-20020a056e02174800b002cda0ea8ff4mr1694967ill.269.1651331020330;
        Sat, 30 Apr 2022 08:03:40 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id x18-20020a056602211200b0065a47e16f36sm679878iox.8.2022.04.30.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 08:03:39 -0700 (PDT)
Date:   Sat, 30 Apr 2022 15:03:36 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 06/18] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
Message-ID: <Ym1PyIQY4m4/9IVi@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-7-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-7-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 11:38:59PM +0800, Gavin Shan wrote:
> This supports SDEI_EVENT_CONTEXT hypercall. It's used by the guest
> to retrieve the registers (x0 - x17) from the interrupted or preempted
> context in the event handler. The interrupted or preempted context
> is saved prior to handling the event by executing its handler and
> restored after that.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 941263578b30..af5d11b8eb2f 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -140,6 +140,37 @@ static unsigned long hypercall_enable(struct kvm_vcpu *vcpu, bool enable)
>  	return ret;
>  }
>  
> +static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_vcpu_context *context;
> +	unsigned long param_id = smccc_get_arg(vcpu, 1);
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	spin_lock(&vsdei->lock);
> +
> +	/* Check if we have events are being handled */
> +	context = &vsdei->context[SDEI_EVENT_PRIORITY_CRITICAL];
> +	context = context->event ? context : NULL;
> +	context = context ? : &vsdei->context[SDEI_EVENT_PRIORITY_NORMAL];
> +	context = context->event ? context : NULL;
> +	if (!context) {
> +		ret = SDEI_DENIED;
> +		goto unlock;
> +	}

Eek! You'll probably be able to drop all of this and just check the SDEI
active flag.

--
Thanks,
Oliver
