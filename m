Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245C84B0A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbiBJJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:54:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbiBJJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:54:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66B17BA1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644486851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/c/W6OJxEmmuWZtANR8s8A0dNFJN61EVaFfDBYgRP0=;
        b=WSPgPe7RGec7Z2fTJQx/HyGWI1xLrrbrnU1+uKJ5G2oH8uLHckzwvflS3acOoPpRPz2n7U
        dV5YIQWtHFShT9/+CbgsKDOo1f/HjpFPoMDTcC2cNxJYpzEIyvSLbDbR5+TuAyPIiUBbnM
        7hocEtI+UHvjr8cdhsfwaeKC05v97y8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-Oc_tF_fHNW2M2s9u9TpDtw-1; Thu, 10 Feb 2022 04:54:10 -0500
X-MC-Unique: Oc_tF_fHNW2M2s9u9TpDtw-1
Received: by mail-ej1-f69.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so2461798ejc.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1/c/W6OJxEmmuWZtANR8s8A0dNFJN61EVaFfDBYgRP0=;
        b=kWCBVnpUhXLzbbfUfph+5vrbNkrdwx6b/YVLxnltoY2+ID+BSjRel6f5n1uRgT++7l
         9vmfxRV/qR4p/c408SY5sTvsG81oNsUN/tcOZl4mLnbDCI8fXA2iTNgXFOshyb2098EG
         Baq00AEDVCy4dnUOYLauCi7CSK7Li5ChGwoDw01v934GnSc9pKcI9E87fMOjY27zkIrZ
         X/uUDV1KaMfNtKCzP/HB3SJLA6s/AXnZbxgCvbt8HMHlAmNBhnWKb5SJ2JZ6jU0CWuhJ
         h2XIg4sW5zZwXpbQVb9TGSMM9VdrZijiAr3tToSY64ERKjfMJ7hG8uNoHSY/0un3j7I+
         ImUw==
X-Gm-Message-State: AOAM532pJDulRenRYG8sP2ceeCNgX2V4H/TGDmzBI8WyPtTlzPkqEO4l
        xCFWG54A3JhiNB5ZWVW0zvyZIuGDKY00jsZZvA5KxnyW8qvWOykpfOS8vIpzIafFGY7tF/2o5Mt
        TB9//6Fmv1+LUhpWcPRCC26i2
X-Received: by 2002:a17:906:77c3:: with SMTP id m3mr5574139ejn.698.1644486849267;
        Thu, 10 Feb 2022 01:54:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwV3BuvD8BD0jNJbRr7myPZuSZZFBdr4xgjx6HK56XZC5hg8XqoVjKaopXYnS591ZwLkwtzlg==
X-Received: by 2002:a17:906:77c3:: with SMTP id m3mr5574127ejn.698.1644486849094;
        Thu, 10 Feb 2022 01:54:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id bo9sm4961286edb.29.2022.02.10.01.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 01:54:08 -0800 (PST)
Message-ID: <e02f05cb-d4b7-1fe5-0d1e-d9aec06a1842@redhat.com>
Date:   Thu, 10 Feb 2022 10:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/23] KVM: MMU: MMU role refactoring
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com, vkuznets@redhat.com
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <YgRApq20ds4FDivX@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YgRApq20ds4FDivX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 23:31, Sean Christopherson wrote:
> Heresy!  Everyone knows the one true way is "KVM: x86/mmu:"
> 
>    $ glo | grep "KVM: MMU:" | wc -l
>    740
>    $ glo | grep "KVM: x86/mmu:" | wc -l
>    403
> 
> Dammit, I'm the heathen...
> 
> I do think we should use x86/mmu though.  VMX and SVM (and nVMX and nSVM) are ok
> because they're unlikely to collide with other architectures, but every arch has
> an MMU...
> 

Sure, I can adjust my habits.

Paolo

