Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14AF4D2D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiCILDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiCILDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DFE3289AE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646823772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3XbrCovqtdO2alSM1NhHDwkb673n4bp3acsIFhcLTE=;
        b=amPnXfr0W2fB/DUoSMxLJV6NiCBnaetAGbysbYx+u5sZiygqlPVdG7SScpLEsAtKminzrM
        sBxbxaleEHF/CS8kNkDWn9FSomSNKXd1dDsb/v8p+0JOriw1nPpH5spuB63BnaFKUe/RYj
        M7oQy9GKrCIB8kR3ied/3ig6fbtANuw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-tS4mtK5rPD6nGEfxjA7Q7g-1; Wed, 09 Mar 2022 06:02:51 -0500
X-MC-Unique: tS4mtK5rPD6nGEfxjA7Q7g-1
Received: by mail-ej1-f72.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so1110010ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l3XbrCovqtdO2alSM1NhHDwkb673n4bp3acsIFhcLTE=;
        b=8J8OyPsOVNfVQhv5KjWDjYqgkx61uYxdy7SfBe3uBShq5uVNIKpg1TFv1fwe34yAT7
         2us8bWi9BYLxTJ4ii+lW5IaCsakQpIQav5oRQXSHNZ6dJahYRlAs2/dUy1ctA0gzmLXG
         Ow9TUXGtZbBImTTeSLIN/6YxtdmRYxvxLC2IoVGqK7DeA4WuCfgw02wkMiSTFr6SAlDl
         IEnFfW9P4lUUiZc4L3xA1Lu/VqvC/Gsez3M6g3iklcp3BHgQdixWaeMkuohG5uWIV3A/
         77P/dUUQNXnDSHuG7KqJJFVjBstblibtMFd42gmIfyrN6tC68mfKA48gUaG5YpyqGRHQ
         dUow==
X-Gm-Message-State: AOAM531Rhy4bmwwcZLXrHJSvV7+LF9XprW2a3BrWP9ZVgTZKzLTXKXZB
        fBQIujerWadBQDxoqsxE5sq19NhaleYMlrVLA+mcuONAJDDJR1lxoomJwidAFmd33UsoXcxq5Hd
        WafoJMcFOjHGDQeT2ycXIw6cx
X-Received: by 2002:a17:907:e9e:b0:6da:68cd:fe43 with SMTP id ho30-20020a1709070e9e00b006da68cdfe43mr17296610ejc.161.1646823769859;
        Wed, 09 Mar 2022 03:02:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLFK+hu10hbW+53duxLixYqGk1vI3LHURrtIszmQjP1c+mERaelOMU8OSY5UwM9Bkh+CExAg==
X-Received: by 2002:a17:907:e9e:b0:6da:68cd:fe43 with SMTP id ho30-20020a1709070e9e00b006da68cdfe43mr17296592ejc.161.1646823769645;
        Wed, 09 Mar 2022 03:02:49 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id y18-20020a170906471200b006da8a883b5fsm587812ejq.54.2022.03.09.03.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 03:02:49 -0800 (PST)
Message-ID: <3b1de531-a2b8-2638-0c8f-fc23fdf5473c@redhat.com>
Date:   Wed, 9 Mar 2022 12:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] KVM: SVM: fix panic on out-of-bounds guest IRQ
Content-Language: en-US
To:     wang.yi59@zte.com.cn
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn, liu.yi24@zte.com.cn
References: <202203091827565144689@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <202203091827565144689@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 11:27, wang.yi59@zte.com.cn wrote:
>> Hi, the Signed-off-by chain is wrong.  Did Yi Liu write the patch (and
>> you are just sending it)?
> The Signed-off-by chain is not wrong, I (Yi Wang) wrote this patch and Yi Liu
> co-developed it.
> 

Ok, so it should be

Co-developed-by: Yi Liu <liu.yi24@zte.com.cn>
Signed-off-by: Yi Liu <liu.yi24@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

I'll fix it myself - thanks for the quick reply!

Paolo

