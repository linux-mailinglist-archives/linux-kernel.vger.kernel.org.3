Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0139058D910
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbiHIM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbiHIM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 635A0183A9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660049979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQ+wwF48ReXy0cBWKcv7V3Cua0LWfPBd2sOCQuW8HDU=;
        b=ClcCJpOaB7c/s5g5sDe9QI121HR6HtNvRxt2p9sCmz+uQAyUKkkJ1L7YcIO32Q9Fm0nx3z
        lGg6djPNad6TyzGgVhPrejPH2dgn3qXQ783W4TIi6ZsWkteo5kKeStyWyxfOzDkultFbbp
        ehSyWbIgg7WrjUxaHzB1Y/BdlLR6gnQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-4jojwnFmMvymikxV2KbzPw-1; Tue, 09 Aug 2022 08:59:38 -0400
X-MC-Unique: 4jojwnFmMvymikxV2KbzPw-1
Received: by mail-ed1-f70.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso7238711ede.15
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 05:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FQ+wwF48ReXy0cBWKcv7V3Cua0LWfPBd2sOCQuW8HDU=;
        b=CPEKAUdlbb4yE/ZOJUxJ2y6dP7gcX14vGlp7Vu8U4y36tGlZrt/fodK1wEECovcoyS
         SGUXHY6DObh7bMBsEub7XhyRLt82BgC8YdNlDxpEcGudkJQmoyOQuo9k6iWacK7dvcTf
         zMPc2MvRY41HZo3hrRkGvgI4cxP/lVMGXO/VKy/C6YVOp4b3jj2igkZ0TCJmYaLo3KTN
         4dptAz+uVKkNGivdrIHwtnK2SqgxMrA5BRmdfeCtpv14+4bAF+Yj7DJhUHVPF0xNDfvx
         BwKymXLzxlVjpDKisWvMJHXvGk8wS8amkUlaBqZ9XTMr1vyS/G/XsyUKb25gZVXMBC1T
         GCfg==
X-Gm-Message-State: ACgBeo1T6gQ1peIGlXBeV5bhKQZINofERpwBIF9KLTZhu/CBY9mqY8p4
        J8p3DYvz0XD9Th/m/MpFwZu7oviDaZBHa7JE8KImwYdSwZI6nOqN7WHawk5XqXrKmXRN6peI6y1
        QvAflU9nyHkP/7ZwPOcqlGdn5
X-Received: by 2002:a17:907:7355:b0:730:65bc:e761 with SMTP id dq21-20020a170907735500b0073065bce761mr16603414ejc.145.1660049976556;
        Tue, 09 Aug 2022 05:59:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4aIlognX1ka5VIOyyASxtl2SULJCChbsWiporF7XeJ6dk0ZuPxY+VDmFZOshu2ItIRzk5+cg==
X-Received: by 2002:a17:907:7355:b0:730:65bc:e761 with SMTP id dq21-20020a170907735500b0073065bce761mr16603400ejc.145.1660049976349;
        Tue, 09 Aug 2022 05:59:36 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id h7-20020aa7c607000000b0043d7ff1e3bcsm6045081edq.72.2022.08.09.05.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 05:59:35 -0700 (PDT)
Message-ID: <397d670c-69c0-8686-e492-06063b7f6621@redhat.com>
Date:   Tue, 9 Aug 2022 14:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] KVM: x86/xen: Initialize Xen timer only once
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Coleman Dietsch <dietschc@csp.edu>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        stable@vger.kernel.org,
        syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
References: <20220808190607.323899-2-dietschc@csp.edu>
 <YvGrIRlJThFoLPsb@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YvGrIRlJThFoLPsb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 02:32, Sean Christopherson wrote:
> On Mon, Aug 08, 2022, Coleman Dietsch wrote:
>> Add a check for existing xen timers before initializing a new one.
>>
>> Currently kvm_xen_init_timer() is called on every
>> KVM_XEN_VCPU_ATTR_TYPE_TIMER, which is causing the following ODEBUG
>> crash when vcpu->arch.xen.timer is already set.
>>
>> ODEBUG: init active (active state 0)
>> object type: hrtimer hint: xen_timer_callbac0
>> RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
>> Call Trace:
>> __debug_object_init
>> debug_hrtimer_init
>> debug_init
>> hrtimer_init
>> kvm_xen_init_timer
>> kvm_xen_vcpu_set_attr
>> kvm_arch_vcpu_ioctl
>> kvm_vcpu_ioctl
>> vfs_ioctl
>>
>> Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
>> Cc: stable@vger.kernel.org
>> Link: https://syzkaller.appspot.com/bug?id=8234a9dfd3aafbf092cc5a7cd9842e3ebc45fc42
>> Reported-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
>> Signed-off-by: Coleman Dietsch <dietschc@csp.edu>
>> ---
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> 

Queued both (pending resolution of David's question), thanks.

Paolo

