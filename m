Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675DF4B768A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbiBORJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:09:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbiBORJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEA0E11ACD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644944983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3G5j4kEwfW/KskenRRmTNu3NeddBDSDhRd8IfvVzTbA=;
        b=UYb2G8dMX6l6kNw6JQkTWpIxvIB/4bMZhmvRJLGi90jdQq2eATdsBXocKZ9qg6b+IQjP0z
        mgI1ijT/w8Z8/lWDCdTJ1azz+DZie3TSQm7xmS8xJxanRgkBTKvnjFuTgM6TRNJ07Xyq6R
        J0/QjsRSbVJbo0Lwua5/HGAIqQKl1qk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-zC0QkTMtO1ufCZd719InGg-1; Tue, 15 Feb 2022 12:09:41 -0500
X-MC-Unique: zC0QkTMtO1ufCZd719InGg-1
Received: by mail-ej1-f69.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso7607493eje.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3G5j4kEwfW/KskenRRmTNu3NeddBDSDhRd8IfvVzTbA=;
        b=nFeENzqDdqzObiiLCqO9jhQqOKtOJKuG9YP59/YiYpVzfFLaxb8xuRuSZtal2oaf05
         EJg/O4ECZcxt7fvqKz1FxTuCLwzuSm1u8HHQ7JMKLrTuAyFMtpOuWY6cZHAKzRe+WMO8
         cAF9xPWPSkRuEuNAod+N+8FGAC0kc5u/jdVcDcYhM1CR8ITRE+jkbvEOl2HDMS1L8gxQ
         0rY43EuH67V5C8ejb5o2/8YoVvxYfggfiuHhYYO/2me41siwrVE/nJ3bSytcCPaibACS
         HnPURexvZXiI9Abo5axKCE/zuYUGJ7qScA3gqiW9/lAslWJmPuZ668bby2EJDNDk1Pct
         YzEQ==
X-Gm-Message-State: AOAM531wzqDR1edc3THChVQp40V97/JaBPGo4ki1rCWNmyePdjGkAW1N
        D5qGmTi/ZSLuzusZkAlxo4bz7GXDbg6niHIHWmP3/+7HVff9Iv9fmI/pEf6qFAMUlrm/A1CN3gf
        2yaushbuySQczuhoKUiBPpuBC
X-Received: by 2002:a17:907:94d4:: with SMTP id dn20mr58487ejc.208.1644944980595;
        Tue, 15 Feb 2022 09:09:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjgzIx+YSERRX1DGrlJmAIzLBv1Ph6gFQmdmnSXDpycNs0lQ/i0lPcNqwqQKBOjSzUFJ+4FQ==
X-Received: by 2002:a17:907:94d4:: with SMTP id dn20mr58475ejc.208.1644944980392;
        Tue, 15 Feb 2022 09:09:40 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id h21sm169428edt.26.2022.02.15.09.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:09:39 -0800 (PST)
Message-ID: <50c5692d-a6a6-6e38-cb8a-5def631841de@redhat.com>
Date:   Tue, 15 Feb 2022 18:09:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/5] KVM: x86: remove KVM_X86_OP_NULL and mark optional
 kvm_x86_ops
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220214131614.3050333-1-pbonzini@redhat.com>
 <20220214131614.3050333-3-pbonzini@redhat.com> <Ygvd9Q+R+tt6WfC2@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ygvd9Q+R+tt6WfC2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 18:08, Sean Christopherson wrote:
>> - * KVM_X86_OP() and KVM_X86_OP_NULL() are used to help generate
>> + * KVM_X86_OP() and KVM_X86_OP_OPTIONAL() are used to help generate
>>    * "static_call()"s. They are also intended for use when defining
>> - * the vmx/svm kvm_x86_ops. KVM_X86_OP() can be used for those
>> - * functions that follow the [svm|vmx]_func_name convention.
>> - * KVM_X86_OP_NULL() can leave a NULL definition for the
>> - * case where there is no definition or a function name that
>> - * doesn't match the typical naming convention is supplied.
>> + * the vmx/svm kvm_x86_ops.
> But assuming your veto of actually using kvm-x86-ops to fill vendor ops isn't
> overriden, they're_not_  "intended for use when defining the vmx/svm kvm_x86_ops."

True, and the original veto was actually how KVM_X86_OP_NULL() became 
unused.

Paolo

