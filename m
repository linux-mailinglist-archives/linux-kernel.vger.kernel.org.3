Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6994D3744
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiCIRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiCIRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:01:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68802105AAE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646844467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+Ih3YtGyWyTixz3Aclx/Os2sciMyuCYkFjO6tpHUqw=;
        b=gy90+q9+Ov8tHWo4m6ChCKtDS90M0aeCGjM5CEXoaMxp5r0O8OT2xWcUELkdd89yR0bbpM
        YOJgjULZq32FZMHSBSn3LrOuXjytkiVm8UR9hRUv2hWK0FVFi+5GAw4OZTF/5U4NOs1jns
        PizRtZ5ElScFeoLW2fk5YaObgrNqs3I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463--4i141PwOc6F6HHbYsrXqA-1; Wed, 09 Mar 2022 11:47:46 -0500
X-MC-Unique: -4i141PwOc6F6HHbYsrXqA-1
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so1596331ejk.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R+Ih3YtGyWyTixz3Aclx/Os2sciMyuCYkFjO6tpHUqw=;
        b=ioLcVP6miB4OuqJ6CtU5jaM9j7NPABo2ICjEDWGgvM+SDTAW42mUcu2icFUTJCweXC
         V7NL8XUp3qasSjSt4WufBTTw+wWXH+0de2R8pVcPrnEnF4TXqxIYPzCCzZpYxQU5F67g
         0+LePr36Pp80CNT9hjWC6E7XrKxJh/M/fvrlm3824jVGFsi/FSQDPaG+IN9rOY5DO5ap
         GzRRSTiKmQiyp0Je/QEUOhZ0xSqBHyw6MGwLCRufCHRe3CFX2EfPzTVQjPWKrEhNYZC0
         dMSk6xTf5TdCj76pFLwfpRsL1Hckicptqy0opOWQ+8zh53bj8PV6GHAsoSDPcyCdEwPC
         htZg==
X-Gm-Message-State: AOAM533acHQrUHPYybomrLuKHolK2ey6COyJ7mtRSF7H1sLCKxLxSfp9
        gDY/0jdHIIZkTR7mN0HSGNHx1VquQGtXnTAF9E7Cys2o21Rl9aHarCz7YbyEkNdiKnjr3EbL7fp
        POG17mP3dGd6/lp0ykc6zvGkF
X-Received: by 2002:a05:6402:6da:b0:3fd:cacb:f4b2 with SMTP id n26-20020a05640206da00b003fdcacbf4b2mr347243edy.332.1646844465040;
        Wed, 09 Mar 2022 08:47:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv9CwpdD58CoUfTld7CeyhBYPnaNZPQgN9uEBEcu4bVuCDmHzx51HtCSC/TfYvP+E3+h9ELQ==
X-Received: by 2002:a05:6402:6da:b0:3fd:cacb:f4b2 with SMTP id n26-20020a05640206da00b003fdcacbf4b2mr347214edy.332.1646844464775;
        Wed, 09 Mar 2022 08:47:44 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id f5-20020a17090624c500b006cee6661b6esm950257ejb.10.2022.03.09.08.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:47:43 -0800 (PST)
Message-ID: <4ca2844c-c9df-8eff-5773-17340759d8ea@redhat.com>
Date:   Wed, 9 Mar 2022 17:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH MANUALSEL 5.4] KVM: x86: Yield to IPI target vCPU only if
 it is busy
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220309164655.138121-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220309164655.138121-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 17:46, Sasha Levin wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> [ Upstream commit 9ee83635d872812f3920209c606c6ea9e412ffcc ]
> 
> When sending a call-function IPI-many to vCPUs, yield to the
> IPI target vCPU which is marked as preempted.
> 
> but when emulating HLT, an idling vCPU will be voluntarily
> scheduled out and mark as preempted from the guest kernel
> perspective. yielding to idle vCPU is pointless and increase
> unnecessary vmexit, maybe miss the true preempted vCPU
> 
> so yield to IPI target vCPU only if vCPU is busy and preempted
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Message-Id: <1644380201-29423-1-git-send-email-lirongqing@baidu.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kernel/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 6ff2c7cac4c4..77e4d875a468 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -543,7 +543,7 @@ static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
>   
>   	/* Make sure other vCPUs get a chance to run if they need to. */
>   	for_each_cpu(cpu, mask) {
> -		if (vcpu_is_preempted(cpu)) {
> +		if (!idle_cpu(cpu) && vcpu_is_preempted(cpu)) {
>   			kvm_hypercall1(KVM_HC_SCHED_YIELD, per_cpu(x86_cpu_to_apicid, cpu));
>   			break;
>   		}

NACK

