Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08554FD3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356119AbiDLHe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbiDLHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DBA526E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649746374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/dPMWGmVa2VGitxhMaMArDoPD5HmxhcdwxUBvot0a4=;
        b=AG2FJ98LGgdmcuhQ1L4obAmn4ZxrhENYIKisiqGZs8pdd8pG2+ksiwZDFRE9bktF8mDOL7
        au5oVg7749k26VLxbT2n3Ru6z7WySodOClK1f539jRf2r122CxIi/XoPeMQMictABqFiE+
        XFTOlcUsKKD+ZK32R1XJLn53yXwyvDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-IKXqwtzfNL-98Sef6oiujg-1; Tue, 12 Apr 2022 02:52:52 -0400
X-MC-Unique: IKXqwtzfNL-98Sef6oiujg-1
Received: by mail-wm1-f72.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so832251wmi.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U/dPMWGmVa2VGitxhMaMArDoPD5HmxhcdwxUBvot0a4=;
        b=TR9+NzH0MSSE1HA/yD6uamWyLIH3z/genjRhaIGIY2HC/DYGN5L3dcTzn0Zwn/2gsf
         pNDxprSLVg4EYXHEQaXbgFXOa+9rHiMmkFpSQk4MXJ9qpqtLGmnZvUEOISSauE8jHJr4
         eWIpl1+FDiZKTFMVZmZpE/Kxl5rD3zM7AUJX/Heta0dLiu7yQShiwz3stglPqkmfkyMe
         cMbQ4MXiSZPdqtDM2hVklm0ZMNjhjdNaF15CbpozDRe7nTc8AgQjOy8YbSp43b0Ta+8B
         DI/6S9v8XifGSxA/r3KjxwCXx38HJghs4lporw9DaX7kLFlfWmfpEFc/LS1vFH3Sq/25
         CtRw==
X-Gm-Message-State: AOAM532TT6+KWOxEe3Zilxoa3N5rnDYhtSrldSKL54FirTmWR7z9PCt0
        zdXWXYZoEevyZ+K6q/AuVtXNRmlddGjOOXvinR4kDd8E+2K2OdMYZ8oDS4XH2Qvluvhchpc309v
        gaSW2hM/A5byqPMYOsXoH3loO
X-Received: by 2002:a05:6000:1a85:b0:205:a4f1:dba4 with SMTP id f5-20020a0560001a8500b00205a4f1dba4mr28667631wry.381.1649746371704;
        Mon, 11 Apr 2022 23:52:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRdqWq4OunBlCF9pVcZ+V2AKilo/61MElc17XigOtbeWrzHJ6eV9gHe9ilgUGp8E5TVegvoQ==
X-Received: by 2002:a05:6000:1a85:b0:205:a4f1:dba4 with SMTP id f5-20020a0560001a8500b00205a4f1dba4mr28667618wry.381.1649746371513;
        Mon, 11 Apr 2022 23:52:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r17-20020a0560001b9100b00207afaa8987sm786520wru.27.2022.04.11.23.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 23:52:50 -0700 (PDT)
Message-ID: <6e0fd8ac-5f17-44d9-97b7-285d4cbe6bcf@redhat.com>
Date:   Tue, 12 Apr 2022 08:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 102/104] KVM: TDX: Add methods to ignore accesses
 to CPU state
Content-Language: en-US
To:     Xiaoyao Li <xiaoyao.li@intel.com>, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <3a278829a8617b86b36c32b68a82bc727013ace8.1646422845.git.isaku.yamahata@intel.com>
 <ec60ba8e-3ed9-1d06-d8c2-4db9529daf93@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ec60ba8e-3ed9-1d06-d8c2-4db9529daf93@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 08:49, Xiaoyao Li wrote:
> 
>> +void tdx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
>> +{
>> +    kvm_register_mark_available(vcpu, reg);
>> +    switch (reg) {
>> +    case VCPU_REGS_RSP:
>> +    case VCPU_REGS_RIP:
>> +    case VCPU_EXREG_PDPTR:
>> +    case VCPU_EXREG_CR0:
>> +    case VCPU_EXREG_CR3:
>> +    case VCPU_EXREG_CR4:
>> +        break;
>> +    default:
>> +        KVM_BUG_ON(1, vcpu->kvm);
>> +        break;
>> +    }
>> +}
> 
> Isaku,
> 
> We missed one case that some GPRs are accessible by KVM/userspace for 
> TDVMCALL exit.

If a register is not in the VMX_REGS_LAZY_LOAD_SET it will never be 
passed to tdx_cache_reg.  As far as I understand those TDVMCALL 
registers do not include either RSP or RIP.

Paolo

