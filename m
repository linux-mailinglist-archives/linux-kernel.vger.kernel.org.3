Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F514F76CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiDGHJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiDGHJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A09111C0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649315263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voufsMIqrDdMDWGVcd+MayfyZfSm1283TLUaIoZ6ZqE=;
        b=LrFuvdBZl+uO5HCKLDP356yNGAgkWYBqP2f+JliaGjc3es+uLmFWSFdUQXsh5ZrQ7BZBZ0
        X3Glo8p/1QkKKYXXlFJ7X2jxsSDm0FCRUMUqRwgln/3CGKNWIjU5WAqWnIAGUVd2ty7neg
        vPVsEy9iTWc7jEBDAofqiGNvdsxGfIU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-XHf0sTwEOse4L5o0loJA-w-1; Thu, 07 Apr 2022 03:07:41 -0400
X-MC-Unique: XHf0sTwEOse4L5o0loJA-w-1
Received: by mail-ej1-f71.google.com with SMTP id dt18-20020a170907729200b006e83eb70d77so235658ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=voufsMIqrDdMDWGVcd+MayfyZfSm1283TLUaIoZ6ZqE=;
        b=qiqJk9ZvYgLYXrdTF7E02P4KB9oIXvZTJOkCXcwwgyYlCVsJQaUWUwOyPIQLgToPwn
         SHnknV9eImeZDXhoCmmtf5vyLtDaPfAdBirfUI+5up9GXGdybZGcuyi0i2KH5l3c/2qn
         MPmFxt5LYXu4nckbuI4nlDWS7XXW9GAcbIDEzFMJR1juSD4uz3TThLJ7Bw1Q8jpKnXLZ
         qc2cQYPNJwb6EBw9TMydGsiIiG5SjDpazOiuzNCcMLVF2ZmnFIgir4LA/qFjMyAlizkN
         KVN/IvHG4beY/z8ocFviAaO+yddbV8NAb68aCRgJSfLM09xUGXJ7kvPuFingGdC4XDYJ
         tKIQ==
X-Gm-Message-State: AOAM5323cCliaRVuSrcjNXDMF/m5f6OUVPiXoZzMRKDGORtHqCQxMhBm
        5rde+KH1UFvZjrp2sSUCsvCyULJK1Xhw9pkU5p4WDV11FXbn8YZTPmHyG6lrsNxESFVAswzDsWL
        pm45o5XVNDN5xIUCaUGLtU4EU
X-Received: by 2002:a05:6402:289f:b0:41c:d9af:ce39 with SMTP id eg31-20020a056402289f00b0041cd9afce39mr13021044edb.415.1649315260692;
        Thu, 07 Apr 2022 00:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxP9QGmu2kaiH6qWo/P6yz6O6e9dfYGJFWv3nF0OceRbfFHwL9zQDTpaEvdZh23+2eh/Mn9A==
X-Received: by 2002:a05:6402:289f:b0:41c:d9af:ce39 with SMTP id eg31-20020a056402289f00b0041cd9afce39mr13021023edb.415.1649315260465;
        Thu, 07 Apr 2022 00:07:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id a18-20020a1709063e9200b006e0527baa77sm7341760ejj.92.2022.04.07.00.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:07:39 -0700 (PDT)
Message-ID: <02fd5a73-1120-6e43-cc5f-ecef331fcd8a@redhat.com>
Date:   Thu, 7 Apr 2022 09:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] KVM: x86: Deplete Paolo's brown paper bag supply by one
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220406225106.55471-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220406225106.55471-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 00:51, Sean Christopherson wrote:
> Fix an inverted check on CR0.PG when computing the cpu_role, the MMU is
> direct and all CR4 bits ignored if paging is disabled, not enabled.
> 
> Fixes: d73678dc11ec ("KVM: x86/mmu: split cpu_role from mmu_role")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> I haven't done much testing on the rest of the MMU role patches, this just
> popped up in very, very basic testing ;-)  I assume this will be squashed,
> hence the snarky shortlog.

It certainly got my attention... squashed, thanks. :)

Paolo

>   arch/x86/kvm/mmu/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e41d7bba7a65..ab24fc161bac 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4699,7 +4699,7 @@ kvm_calc_cpu_role(struct kvm_vcpu *vcpu, const struct kvm_mmu_role_regs *regs)
>   	role.base.smm = is_smm(vcpu);
>   	role.base.guest_mode = is_guest_mode(vcpu);
>   
> -	if (____is_cr0_pg(regs)) {
> +	if (!____is_cr0_pg(regs)) {
>   		role.base.direct = 1;
>   		return role;
>   	}
> 
> base-commit: 56ba4b488353a8925b30367d72e41d1996c23554

