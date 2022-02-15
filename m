Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719994B7542
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiBOSHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:07:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiBOSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C31AD761F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644948447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=datg8lNLKiIl1WXCHn9HnuSPwv/jJjkjBNmJYipaVUg=;
        b=TSiXY/IiBY5t6FTo5zlTUFR5GdsUA1oiKQ1oI20tSkwo+ueiVDiqUyUSTtadzJOyowX2EI
        +83mO/TkhDbuQVCrYP9/GXYI3iqBPIo9QyCYlueaDbr1mE+NSCS+XT8gja4qtnmR1nP9uW
        Mt0B83VQSNsoVUK/WSxiKfP48FNpp+E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-LwqLaUqXMR-tm6eR0wN9CQ-1; Tue, 15 Feb 2022 13:07:26 -0500
X-MC-Unique: LwqLaUqXMR-tm6eR0wN9CQ-1
Received: by mail-ej1-f71.google.com with SMTP id hc39-20020a17090716a700b006ce88cf89dfso2779077ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=datg8lNLKiIl1WXCHn9HnuSPwv/jJjkjBNmJYipaVUg=;
        b=pgbLdw8T9+vOHWquebrBMBnBFoRHydj2rD/2ykAJp6b8IZonYPScDIE0K5QauHhWpg
         cmIqWpU5odt48s7z+V/nu7O+QRKCWBMc9nrSAAHHVTwRkUTp19hFR4qoRoed6HC4dAFs
         +s7vcMGZJR2+FAVXS1RiIKasHmuwI6C5kuweHrKker1wBZUk2prHoSqC00K88QW13mq1
         9+skLv15Cjd0uXCJYUMBXlr9pF7fueXgCneQRrCDsA4A2ANK0Ny8P5w8k1Yv4gb7DY03
         oML4ZEEnHj2ZsHOmmYOge1wMKnGx/5eRqW/Byi5UviekKX9f2k14ruKvIGCMhjnRjOB3
         vwAQ==
X-Gm-Message-State: AOAM531GVHIvU0dJkkRtg6glXq5EMZadylEZ1RHoy1qolRJ7xy6EBsbk
        K03f6UyTjbBodrp18dq5xrPV7+/F3qzlYnBGohLfslG0KVlVewZ2H+kE4COtGWYu2XZtqsTsoQ7
        QesbhFk0z4h06t1xDei3zB3d/
X-Received: by 2002:a17:906:6498:: with SMTP id e24mr269427ejm.12.1644948445025;
        Tue, 15 Feb 2022 10:07:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuHQdH6fWFMzgIH7BEvZiDbuwOK8q1e43c06q1Yb4ASG5HGXjrHD1XO2oGrj8kzqM+AOBPRQ==
X-Received: by 2002:a17:906:6498:: with SMTP id e24mr269410ejm.12.1644948444793;
        Tue, 15 Feb 2022 10:07:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id ed9sm222149edb.59.2022.02.15.10.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 10:07:23 -0800 (PST)
Message-ID: <b34d235f-e22a-71dc-0c20-7be46d2182ff@redhat.com>
Date:   Tue, 15 Feb 2022 19:07:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] KVM: x86: allow defining return-0 static calls
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220214131614.3050333-1-pbonzini@redhat.com>
 <20220214131614.3050333-6-pbonzini@redhat.com> <Ygvi5jr4V8S/bKSe@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ygvi5jr4V8S/bKSe@google.com>
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

On 2/15/22 18:29, Sean Christopherson wrote:
> s/KVM_X86_OP_RET0/KVM_X86_OP_OPTIONAL_RET0
> 
> And maybe "NULL func" instead of "NULL value", since some members of kvm_x86_ops
> hold a value, not a func.
> 
>> struct kvm_x86_ops will be changed to __static_call_return0.
> This implies kvm_x86_ops itself is changed, which is incorrect.  "will be patched
> to __static_call_return0() when updating static calls" or so.
> 

Very good point, thanks.

Paolo

