Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250EE4CB787
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiCCHPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:15:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1CE0125C83
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646291688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEqRPqaD5FWGRJv5e1sQSjcE5/2LakOMZH9spOXim5M=;
        b=emvX3IbdPjhwp99IZs7YQgh0pqQn9hZgdqJ7mMLgo/SitcZbKv6Ijkziq3zBu0082Q2/h+
        f2yqj1X39SegebACTlPE1OvE5NmIaKP6s2gxy0Q3wW9irmqULXNfJYOV6laOX4Ud8nZaGV
        UHT+WLtLoDU38MRAq+1PMQRu7I2V/oQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-54qaAjvxM-uap_6f_xKt5Q-1; Thu, 03 Mar 2022 02:14:45 -0500
X-MC-Unique: 54qaAjvxM-uap_6f_xKt5Q-1
Received: by mail-wm1-f70.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso921578wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 23:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WEqRPqaD5FWGRJv5e1sQSjcE5/2LakOMZH9spOXim5M=;
        b=AM5DRcDrjj0UOUYczjHH0Hr3ihf0L4r9Bt4LC11puSIbtF8SH6iI9YFZTeflWJPgT/
         CAevrw/mvVpb6ljPUuoKwQ05/g8XgfUxMUWpnGdmoTzIqHwijPvfCdDrrLnQLdJzuJi8
         otbAvnLfdOSlHUT+BfLAj/q9ObEYLCDk4IoNlTNo8KEubwXFDTGBvxa7w9DxGu6vNQwv
         MwdWYJGnq+25+U7aACl0sh8OuF6tGGG15ArAuMvTaNw+9LUocPRNNYJ0CMVCXYVqbbpO
         uU0bvxDPpTJqm0OvTc8W+cgkjTphfmywktMlkYR5xcphbMEFceDwox1xVeOA4VL6XkZt
         0Mhw==
X-Gm-Message-State: AOAM531APSFl5DqPXcSrOGW886YwtjWHhmnWFyQVm+gvsXFLTgWBDiKR
        Az2rJktenJxaporlIjR+NyjOrI/7Ul5hHYfjQGg0JxroFbwy8/1g3TqSq6QanIYDuI6JQfUXujw
        PlduXs/y7BgVDfC4TAt0Bak/r
X-Received: by 2002:a05:6000:143:b0:1f0:25a1:874c with SMTP id r3-20020a056000014300b001f025a1874cmr5296247wrx.191.1646291684429;
        Wed, 02 Mar 2022 23:14:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmjuyMNNC6DR/Bl4cLZuPvdIEPk0k/BS2RIKyITE+TQM+Zj5AHfzvYai86xVZe0dQU+DiiAA==
X-Received: by 2002:a05:6000:143:b0:1f0:25a1:874c with SMTP id r3-20020a056000014300b001f025a1874cmr5296233wrx.191.1646291684224;
        Wed, 02 Mar 2022 23:14:44 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm6127182wmg.7.2022.03.02.23.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 23:14:43 -0800 (PST)
Message-ID: <0c22b156-10c5-1988-7256-a9db7871989d@redhat.com>
Date:   Thu, 3 Mar 2022 08:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/7] KVM: x86/mmu: Zap only obsolete roots if a root
 shadow page is zapped
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220225182248.3812651-1-seanjc@google.com>
 <20220225182248.3812651-5-seanjc@google.com>
 <40a22c39-9da4-6c37-8ad0-b33970e35a2b@redhat.com>
 <ee757515-4a0f-c5cb-cd57-04983f62f499@redhat.com>
 <Yh/JdHphCLOm4evG@google.com>
 <217cc048-8ca7-2b7b-141f-f44f0d95eec5@redhat.com>
 <Yh/1hPMhqeFKO0ih@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yh/1hPMhqeFKO0ih@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 23:53, Sean Christopherson wrote:
>>
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index c5e3f219803e..7899ca4748c7 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -3857,6 +3857,9 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu,
>> hpa_t root_hpa,
>>          unsigned long cr3;
>>
>>          if (npt_enabled) {
>> +               if (is_tdp_mmu_root(root_hpa))
>> +                       svm->current_vmcb->asid_generation = 0;
>> +
>>                  svm->vmcb->control.nested_cr3 = __sme_set(root_hpa);
>>                  vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
>>
>> Why not just new_asid
> My mental coin flip came up tails?  new_asid() is definitely more intuitive.
> 

Can you submit a patch (seems like 5.17+stable material)?

Paolo

