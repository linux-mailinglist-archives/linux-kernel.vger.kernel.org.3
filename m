Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05524BBE95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiBRRlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:41:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiBRRlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:41:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB69D5DEA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645206093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnuYPx4ALc7vupBYJPJ5qvV7EVEzwTLdGl9AEN4VlDg=;
        b=LJ2qPP1o/siJb14t6jrlse64ZkpWKZQNHfximiI9GtyxLthvWAbg9OPq9Ev5dY8/vwnipz
        otiNEi/5OIm3DtIoDx8rb8kD6WiuqCrzGNxoAJvXBCfk9Z8zVJnYcylMDeZrLZE9s11MPV
        Qvoeeu8QWTGIANWTtY4Z8B8RWfRPKXA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-MXcLaNaRMNquHRN5qQKqSg-1; Fri, 18 Feb 2022 12:41:31 -0500
X-MC-Unique: MXcLaNaRMNquHRN5qQKqSg-1
Received: by mail-ed1-f70.google.com with SMTP id o5-20020a50c905000000b00410effbf65dso5907855edh.17
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GnuYPx4ALc7vupBYJPJ5qvV7EVEzwTLdGl9AEN4VlDg=;
        b=XePR71nCzgBtEvsekeN4OcfNNgzz3sVtVC2zGLr16RY01v8Bi1m7U1VmxuyukosD+z
         rIxd1lvdjxKIognoa4OHO8OSURQ1+pHl7jr1+uemRTNNZ7jdVNm5qDE1UWR1tp8qQsQE
         9SI53VTtgu7wayv/KMfbAyvrREvnIpzsnsOW6ZaPFf3OFNM8QckOCVxJ3VgxL+5s9JNc
         dLQOv4ZL+WfGldASC9Ne0slugMg9HIsABgPilLKavqxG3i2KMnLqk+n5IOrd4DDpF5Vs
         P8kSg+qXBkTG6L67MkGHVN8fxWY+1UnIT98RUhyG2HuQAo7UcGrJWzn99/qFL8aXikfu
         idKQ==
X-Gm-Message-State: AOAM530g4dHvgR8+axujAlFelvm5ETDiUdKeISaTAAURfrxUyhJSMCie
        teGOtwbGRelcdL5TcoN3hJZGNF83A+g590kPjPxnnlTG+wqfwO2dpbJlR8dKHaOfnWzWnTV7sDN
        3L/VNdmiIPBByZTPzu5ey7YFv
X-Received: by 2002:a17:906:91c8:b0:6c5:76a6:688b with SMTP id b8-20020a17090691c800b006c576a6688bmr7601171ejx.174.1645206090167;
        Fri, 18 Feb 2022 09:41:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVaFGgjuTsFPf5JRE18FJ5HhxPm41qDpdkzlQQSvv+/hX9VXjS7tjz10ooZ8Pb4bglOjzg1Q==
X-Received: by 2002:a17:906:91c8:b0:6c5:76a6:688b with SMTP id b8-20020a17090691c800b006c576a6688bmr7601160ejx.174.1645206089931;
        Fri, 18 Feb 2022 09:41:29 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id h8sm4926063edk.14.2022.02.18.09.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 09:41:29 -0800 (PST)
Message-ID: <65871234-0c94-2455-c55f-6c1d5775e485@redhat.com>
Date:   Fri, 18 Feb 2022 18:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/6] KVM: x86: make several AVIC callbacks optional
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-6-pbonzini@redhat.com> <Yg/IGUFqqS2r98II@google.com>
 <eff2543a-10ab-611a-28e2-18999d21ddd8@redhat.com>
 <Yg/ZZMAz7XZ6wn/u@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yg/ZZMAz7XZ6wn/u@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 18:37, Sean Christopherson wrote:
>> True, on the other hand there's no reason why a hypothetical third vendor
>> would have to support it.  The call is conditional to apicv_active being
>> true.
> Ah, right, even if the the static_call_cond() is unnecessary because we want to
> make the hook mandatory if APICv is supported, APICv itself may not be supported.

I'm not even sure we want to make it mandatory, in fact.

Also new full log:

----
All their invocations are conditional on vcpu->arch.apicv_active,
meaning that they need not be implemented by vendor code: even
though at the moment both vendors implement APIC virtualization,
all of them should be optional.  In fact SVM does not need many of
them, and their implementation can be deleted now.
----

Paolo

