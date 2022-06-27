Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839CE55C5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiF0PN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbiF0PNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 328685FFF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656342782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARdvDRYqFQEpUSYWNh7p3WDzIDlCQtznR2856ZwQR38=;
        b=gW6/t2nJH8PAXDixQuQKnj/aHKA22vqsvEjs2CKz3/J+I8ul3HapcF9EMvCfJOzpnxtSvb
        uuz0iVQXIClDIDSuR+zbt4wqYNr9hy2OcZ08yY8ovSSMY+DeeeIT8ddSJ/rrTvIkZ51A8M
        rGkXTIt27RCmjiGsvEMsEpJVAC7+KoQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-M4idXYLWMliHXyCc_4gvYQ-1; Mon, 27 Jun 2022 11:13:00 -0400
X-MC-Unique: M4idXYLWMliHXyCc_4gvYQ-1
Received: by mail-ed1-f70.google.com with SMTP id f13-20020a0564021e8d00b00437a2acb543so1102239edf.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ARdvDRYqFQEpUSYWNh7p3WDzIDlCQtznR2856ZwQR38=;
        b=hQ1KDarbTT+1cCNOpRNJYXzBd4RwEYT62UrnQPkD2aoF44SHXbtoU36WRq2J769zMj
         trpEt7shSv0eZI4GtsTNToNJMxQB23mVGQTqwLIPk95ivWbLU4fCelYn/WsPvwIJTzJR
         Z3njnU6UHus4wQ8Kict7sX1nprb4ads4V8f7uRnKZT3cxNsa22dsdcif3w05k7/yB2Gd
         ogUizSeqLsKPukQxoRjvi81N//63UKRKIfTR5OMPpwZfz9lK1kgyFZDIcH7vmvLdp5z1
         enjODgQoJ1LfPjfo7QDHprL2V/Foy6axY350iuXSOJygvQ4TrbKuZEvL7zXQFmbKcZG6
         ZyZw==
X-Gm-Message-State: AJIora9t81fiqGePJ6cvViD0IsU0Nh0LMzAdOBWZqDvOn6txETGBdlny
        lHdl5Mt2c1hijN22ndkNPANDlYvI+/dzc8AL7JfOlMAuNPFh32dSpMCig33L/FivQ9F/hTUNvEd
        imgcN/d4G+N6iavO8vwy8bj/4vWMlTT+DUCR3nZapG2ccA4sW/ATjGQR+YkB66i8ojGzl/BQJXH
        gm
X-Received: by 2002:a17:906:5512:b0:726:be2c:a2e5 with SMTP id r18-20020a170906551200b00726be2ca2e5mr2270041ejp.88.1656342779681;
        Mon, 27 Jun 2022 08:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ujLOPA2JVmlJ+R4KMLfx0HjYsH41cRwgwuV7mZUbliS5V6Ns2xRIbDBxPpYaLhiDmvcPjGPQ==
X-Received: by 2002:a17:906:5512:b0:726:be2c:a2e5 with SMTP id r18-20020a170906551200b00726be2ca2e5mr2270015ejp.88.1656342779400;
        Mon, 27 Jun 2022 08:12:59 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906d20d00b00726298147b1sm5049433ejz.161.2022.06.27.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:12:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 02/10] KVM: VMX: Add missing CPU based VM
 execution controls to vmcs_config
In-Reply-To: <YrUBYTXRxBGYsd1a@google.com>
References: <20220622164432.194640-1-vkuznets@redhat.com>
 <20220622164432.194640-3-vkuznets@redhat.com>
 <YrUBYTXRxBGYsd1a@google.com>
Date:   Mon, 27 Jun 2022 17:12:58 +0200
Message-ID: <87wnd2uolh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Maybe say "dynamically enabled" or so instead of "missing"?
>

...

> On Wed, Jun 22, 2022, Vitaly Kuznetsov wrote:
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 24da9e93bdab..01294a2fc1c1 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2483,8 +2483,14 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  	      CPU_BASED_INVLPG_EXITING |
>>  	      CPU_BASED_RDPMC_EXITING;
>>  
>> -	opt = CPU_BASED_TPR_SHADOW |
>> +	opt = CPU_BASED_INTR_WINDOW_EXITING |
>> +	      CPU_BASED_RDTSC_EXITING |
>> +	      CPU_BASED_TPR_SHADOW |
>> +	      CPU_BASED_NMI_WINDOW_EXITING |
>> +	      CPU_BASED_USE_IO_BITMAPS |
>> +	      CPU_BASED_MONITOR_TRAP_FLAG |
>>  	      CPU_BASED_USE_MSR_BITMAPS |
>> +	      CPU_BASED_PAUSE_EXITING |
>>  	      CPU_BASED_ACTIVATE_SECONDARY_CONTROLS |
>>  	      CPU_BASED_ACTIVATE_TERTIARY_CONTROLS;

CPU_BASED_INTR_WINDOW_EXITING and CPU_BASED_NMI_WINDOW_EXITING are
actually "dynamically enabled" but CPU_BASED_RDTSC_EXITING/
CPU_BASED_USE_IO_BITMAPS/ CPU_BASED_MONITOR_TRAP_FLAG /
CPU_BASED_PAUSE_EXITING are not (and I found the first two immediately
after implementing 'macro shananigans' you suggested, of course :-), KVM
just doesn't use them for L1. So this is going to get splitted in two
patches.

-- 
Vitaly

