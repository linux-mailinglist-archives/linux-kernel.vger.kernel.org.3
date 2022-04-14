Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92EA50095D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiDNJLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiDNJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 159DE6D962
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649927330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXK01xwL5FfymBT2O/wpbjGm/1sDlFHcoIHw2SavFDU=;
        b=QysLLuvY3cd+YKWYSHCFG8D3GjXzVC1h68M7zupw2QdjESsWHjzdx0qQx9LiG1uPGVd7mc
        RZcuDq0S9t/EMJVrWyILaTLhsWVsz292wK5Vy5TEJF7NjAmS/+1LHk4EDpet/LOpYpmVO8
        WQbG9SStZiOHAjJYj39IscBoIbumjAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-VBUScGSiOHi0Z3iZISBSTw-1; Thu, 14 Apr 2022 05:08:48 -0400
X-MC-Unique: VBUScGSiOHi0Z3iZISBSTw-1
Received: by mail-wr1-f69.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so743211wrg.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EXK01xwL5FfymBT2O/wpbjGm/1sDlFHcoIHw2SavFDU=;
        b=JFLPe2jM/xoGB2gOb9t2tgHgWxKPVT6SzM6dl4HozEiWXZE4m9JJQylXsfc+CzKR4t
         KaqxQcV9m3xuiBqRD9YGEwGK2FU0hgp7aWXfUfi5Elnjj58tcKAhk5x2g2s/623FpI39
         aTP4ZZr2rH1Y2aVhfIjusBr9zscXOh4yPjaOqAPPE2GMflpEK6DI7ax+3hHg+Ewkdobh
         mS/uhZiR4u/uvux+Dr/1yrKC2lE0m+/YFvhpWTKU0QTcEvuPU+0QCNjxQwn779zFxc16
         obUdVUixiYZEHRU6VQXtvBspqu+YPdoezIALfZQbfDjP6KiUVElrGDA/VAYCE3AM0xae
         QjVw==
X-Gm-Message-State: AOAM533fU4bhfwE9Vi68Vea19XZxHOaBrIRkuP90FKPmm52K0mqQCwOh
        4oNllFg27zPIiSb+nCXl5adXnEgOKxoIriZ7x1vH/Cl3cXIMQvpJ3NNJcsOos0Kh2HfoP717Mde
        wLUDtGijZAJHV/KRdkvWr0ZTy
X-Received: by 2002:a5d:64a5:0:b0:205:8e66:e9b1 with SMTP id m5-20020a5d64a5000000b002058e66e9b1mr1312051wrp.464.1649927327735;
        Thu, 14 Apr 2022 02:08:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAXM3iNNx7LZYO7MKlv+Z8ZcSXxb0BvT2R6br6VU+ZZLHt08JHqpN2CnaubzNSWxNIqo5rdQ==
X-Received: by 2002:a5d:64a5:0:b0:205:8e66:e9b1 with SMTP id m5-20020a5d64a5000000b002058e66e9b1mr1312028wrp.464.1649927327531;
        Thu, 14 Apr 2022 02:08:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b0038cbd8c41e9sm4947976wmq.12.2022.04.14.02.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 02:08:46 -0700 (PDT)
Message-ID: <683974e7-5801-e289-8fa4-c8a8d21ec1b2@redhat.com>
Date:   Thu, 14 Apr 2022 11:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH V3 3/4] KVM: X86: Alloc role.pae_root shadow page
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org
References: <20220330132152.4568-1-jiangshanlai@gmail.com>
 <20220330132152.4568-4-jiangshanlai@gmail.com> <YlXrshJa2Sd1WQ0P@google.com>
 <CAJhGHyD-4YFDhkxk2SQFmKe3ooqw_0wE+9u3+sZ8zOdSUfbnxw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAJhGHyD-4YFDhkxk2SQFmKe3ooqw_0wE+9u3+sZ8zOdSUfbnxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 11:07, Lai Jiangshan wrote:
>> I don't think this will work for shadow paging.  CR3 only has to be 32-byte aligned
>> for PAE paging.  Unless I'm missing something subtle in the code, KVM will incorrectly
>> reuse a pae_root if the guest puts multiple PAE CR3s on a single page because KVM's
>> gfn calculation will drop bits 11:5.
> 
> I forgot about it.


Isn't the pae_root always rebuilt by

         if (!tdp_enabled && memcmp(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs)))
                 kvm_mmu_free_roots(vcpu->kvm, mmu, KVM_MMU_ROOT_CURRENT);

in load_pdptrs?  I think reuse cannot happen.

Paolo

