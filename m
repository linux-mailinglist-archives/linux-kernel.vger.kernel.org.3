Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4800F4C916C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiCARYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCARYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CAAC344C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646155402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lFXunAdv5LdjJW8QDwspJT41+DJROvO8Ax1QEx6aw4A=;
        b=XxMTZWC2mYomoRb3SHerSgpEIWiv5HPUNIs7jCCBWr3JzheMbyySTVNZhr2tAbBVz6cTUZ
        yPXpiReIEpyS+AdRaYzNWm5dpKVwuNt2ci8DXptp4UGPcdOyHcKNHz+TBNSfisygK000Jn
        +FFsFc/xlbVvrXwXNK3Xd2/EJmzBrBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-lckL6NikMY6l6AiTQM1DgQ-1; Tue, 01 Mar 2022 12:23:21 -0500
X-MC-Unique: lckL6NikMY6l6AiTQM1DgQ-1
Received: by mail-wm1-f69.google.com with SMTP id l31-20020a05600c1d1f00b00380e3425ba7so1509654wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lFXunAdv5LdjJW8QDwspJT41+DJROvO8Ax1QEx6aw4A=;
        b=ZcwF7bZWFKOpeNit3b5mQ919Xi48cHscViIn24QcKMNyElnmCDLKxBgiq18JD33L4Q
         R7dmOy+RntZ0oEepq/zYuewiW4zkvOWCrYOgJdCHeI0qfVkqgghcRI2y8comZq6BOntc
         bUL52tu4CElhOyijXBYaL4gWei7JwTOc9sfs6eEQx42tdgAoUVh8+qXKdxo4+Zpfppvn
         WSMlOg0QsRGohVRedzmX/EyAxyci+E7ReHAXnSv7gJvUKdykiS9lQxq4rKRLkE0g+qrB
         bEvCS0fNcxjNlsNF8K0KO9f3Laqyj6jDEPpXuWU6w76vPHGkmWrAsRUDxgiWi1D7MZEv
         gAzw==
X-Gm-Message-State: AOAM531a/rfF+jXhpPy0bAPGsYYZgQjU61GKsTUtRlU2MiKwPn5eMC+G
        5I6X7BNFDb1D1xpS1bJ8bxjWnwGmwkuzkM8XeDgdzwhZiT8rnUFvvcXfH7kpOii39/E3cqO+R+m
        JJrxK9CHphR3Yvg3RR1346rCR
X-Received: by 2002:a5d:6acb:0:b0:1ef:9e02:5214 with SMTP id u11-20020a5d6acb000000b001ef9e025214mr9605803wrw.151.1646155400159;
        Tue, 01 Mar 2022 09:23:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybsHzJ1qP7vDADgXM1zyY8BnQaquWD5JrRb/ZZ0oV6+AsFWHNF9iahy81bgXX44HNLnhrUNA==
X-Received: by 2002:a5d:6acb:0:b0:1ef:9e02:5214 with SMTP id u11-20020a5d6acb000000b001ef9e025214mr9605788wrw.151.1646155399905;
        Tue, 01 Mar 2022 09:23:19 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id k25-20020a05600c1c9900b00381481059a3sm3382821wms.2.2022.03.01.09.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:23:19 -0800 (PST)
Message-ID: <c6f4d7e5-6138-084e-067f-6bb1ecda9e2c@redhat.com>
Date:   Tue, 1 Mar 2022 18:23:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] KVM: x86: SVM: disable preemption in
 avic_refresh_apicv_exec_ctrl
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
References: <20220301135526.136554-1-mlevitsk@redhat.com>
 <20220301135526.136554-3-mlevitsk@redhat.com> <Yh5UqJ0De0dk6uxD@google.com>
 <c9e99c37e9d6c666ac790ee2166418eb9e54e3fd.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <c9e99c37e9d6c666ac790ee2166418eb9e54e3fd.camel@redhat.com>
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

On 3/1/22 18:20, Maxim Levitsky wrote:
> I don't see that this patch is much different that what I proposed,
> especially since disable of preemption can be nested.

The difference is that it's done in avic_vcpu_{load,put} instead of the 
caller.  I like that your patch is smaller, but I like that Sean's patch 
solves it for good.

I queued his, but maybe I could apply yours to 5.17 and his to 5.18.  I 
might do this if I have to send more stuff to Linus before the release.

Paolo

