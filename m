Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB76E4CB007
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbiCBUkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbiCBUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:39:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD59A48394
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646253551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlSN1ce+rKktPC0zZEd6egBCU+uP7yvWtLT1wgIfjGo=;
        b=XDmeXE6Ar22FFdHxogTbZVJS1VLN6+X5KGkZyoYLcz1swhynUVoBtWbKHFymcuVTw/RD6/
        P23hPWtl7y3whQKiWnRIYzCgdDMX2a7Yp50onTefxp5ig0hzLH9RxDbMWKmFZKzHablW6P
        AZT3Ke30P7LtzPBmnF6fVvQSHpDdkZU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-yBv3wbkUPPSblAXy95s1Bw-1; Wed, 02 Mar 2022 15:39:10 -0500
X-MC-Unique: yBv3wbkUPPSblAXy95s1Bw-1
Received: by mail-wr1-f69.google.com with SMTP id h11-20020a5d430b000000b001f01a35a86fso1057126wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vlSN1ce+rKktPC0zZEd6egBCU+uP7yvWtLT1wgIfjGo=;
        b=huuAL9j/OA+hdqqxkOu8TwQKCdiOWTWT8fmVmma7Nm3p4Dq2E99bmjyq5cWQODAU3R
         wuwj/eir3pIm2SZKzVXJgQK2B1x9uXLHjugZ/EFezlNVCUgiN6fbWaplfEDqxgI5EtWV
         aV/HWPNsNFxskOp7rgparuoQlEvr2drnd1uxqu+1PiF1KnTsBa7i5JkYddTDHM2yygjF
         ZmivJWkOpInt0xDeLSyRxUW/dWCv2gTdLkUkRMO5LJuSs3K1Dmqsg3As9Tqardbwuruv
         +uja8GTGJTWyeOdEtAMhWQmZMPzdVLXs2BXdepOQeaN7qNZ59rrnYHxDKiZA/kAswfrc
         1R6w==
X-Gm-Message-State: AOAM532+9syOJNYKwsy0hj7NdENUqdvJ66Ea4K6g1t09BNMoN7qrus/u
        Nt9AidwWFEZNXMUWFQBppvEUgNavmcpH/YbVprRpiRa4jLb1PoeNyD0+yA90GGIPvTwZc1ORixZ
        akULvyVyH0RCiNj0Ffedqk92Z
X-Received: by 2002:a05:600c:a51:b0:381:3dc6:c724 with SMTP id c17-20020a05600c0a5100b003813dc6c724mr1261774wmq.106.1646253548853;
        Wed, 02 Mar 2022 12:39:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBJXf9B+5/Uv338YP5HJJ8ya0kM2lSFZCLI0P+MsJBqatWbo6lHUHD1NmOL1Wu80SBlqAx4Q==
X-Received: by 2002:a05:600c:a51:b0:381:3dc6:c724 with SMTP id c17-20020a05600c0a5100b003813dc6c724mr1261753wmq.106.1646253548650;
        Wed, 02 Mar 2022 12:39:08 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id b13-20020a05600c4e0d00b003816cb4892csm12523764wmq.0.2022.03.02.12.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:39:07 -0800 (PST)
Message-ID: <217cc048-8ca7-2b7b-141f-f44f0d95eec5@redhat.com>
Date:   Wed, 2 Mar 2022 21:39:04 +0100
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yh/JdHphCLOm4evG@google.com>
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

On 3/2/22 20:45, Sean Christopherson wrote:
> AMD NPT is hosed because KVM's awful ASID scheme doesn't assign an ASID per root
> and doesn't force a new ASID.  IMO, this is an SVM mess and not a TDP MMU bug.

I agree.

> In the short term, I think something like the following would suffice.  Long term,
> we really need to redo SVM ASID management so that ASIDs are tied to a KVM root.


diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c5e3f219803e..7899ca4748c7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3857,6 +3857,9 @@ static void svm_load_mmu_pgd(struct kvm_vcpu 
*vcpu, hpa_t root_hpa,
         unsigned long cr3;

         if (npt_enabled) {
+               if (is_tdp_mmu_root(root_hpa))
+                       svm->current_vmcb->asid_generation = 0;
+
                 svm->vmcb->control.nested_cr3 = __sme_set(root_hpa);
                 vmcb_mark_dirty(svm->vmcb, VMCB_NPT);

Why not just new_asid (even unconditionally, who cares)?

BTW yeah, the smoke test worked but the actual one failed horribly.

Paolo

