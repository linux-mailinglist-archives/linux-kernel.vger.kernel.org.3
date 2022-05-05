Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54C451C105
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380019AbiEENoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379925AbiEENoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:44:01 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76435DF75
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651758019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqdrYW62uTnZvKa7HUn2Nv6tPwsemJAGd//mOeVF61A=;
        b=ZPcLsevF29doU2+AxGy2OXrDZtUQ2A5YITJPwvYEqIPS79RK4kSozPiHZm3UnXo1ZMICBQ
        Koe7ypr+zF4Fhj+qkP5mtY3ZjF7aZrKpIAKttuuwTnG66fhkpo0CojACWU/AUQEIPRKrQP
        A1PhnX3nieaHf+DGa0LtaveC/BZzhy4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-9oBbxT6vPfmdsgpZkJfF7A-1; Thu, 05 May 2022 09:40:18 -0400
X-MC-Unique: 9oBbxT6vPfmdsgpZkJfF7A-1
Received: by mail-ej1-f71.google.com with SMTP id nd34-20020a17090762a200b006e0ef16745cso2629436ejc.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cqdrYW62uTnZvKa7HUn2Nv6tPwsemJAGd//mOeVF61A=;
        b=2OPTAfDmG1fbnpKFVb7zgCfCPKFK6ilHly8ExnCC9SOJacwz2Ya5y0Jp47Yn/fTAJ0
         LimRdtTmvsa2O3i4jFCMi0xIWw/k3rA2U/lBocL1hxYEM/vn2PKVZL3hukbT40A7pB36
         GuDULlfS+E4rKUIWZAthiGFM0wOA9PHCRq0higwaQIIxGLT+quvmVOONU79F3SLv21+z
         o7E7hvQxLDXXojqaRovlc2L3PMB9HNNEU6TiFAJY+G8C8sqLRNqYhWI3jhyqO3KHxqyH
         tAeztQZ9aIR3aWBEBAIFF8PApB+NC/YHs/JNFxI+IzThSzfCsP0Iayi4fkapYzkE4sug
         rPyA==
X-Gm-Message-State: AOAM5308fDWf2L9kTM5BjPZ0bkCKDgTtAWubYslp/Ze70So6GNkRJa53
        5hYyoAAUuhZ/+mEvDmdsC99ObRmWfgPPLB4f+2zTPFgxMaUJOnoP2Cp7IudTm0HL8OPQFXzZ9us
        DjyOkNWTTBvd/lr7akoPJRlHv
X-Received: by 2002:a05:6402:1399:b0:410:9fa2:60d6 with SMTP id b25-20020a056402139900b004109fa260d6mr7209286edv.35.1651758017318;
        Thu, 05 May 2022 06:40:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPe6WJb7OIa3ESzr+aNmV7030frJYOWHSOZsepP3IUesecusunQPL4mGY5h9sKeBQVJyQf3Q==
X-Received: by 2002:a05:6402:1399:b0:410:9fa2:60d6 with SMTP id b25-20020a056402139900b004109fa260d6mr7209258edv.35.1651758017072;
        Thu, 05 May 2022 06:40:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id c24-20020aa7c758000000b0042617ba63b4sm824307eds.62.2022.05.05.06.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:40:16 -0700 (PDT)
Message-ID: <84920fc8-a966-25d2-9b3b-c7918c0b9cd4@redhat.com>
Date:   Thu, 5 May 2022 15:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86: Function missing integer return value
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Juergen Gross <jgross@suse.com>, Li kunyu <kunyu@nfschina.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        seanjc@google.com
References: <20220505113218.93520-1-kunyu@nfschina.com>
 <ba469ccc-f5c4-248a-4c26-1cbf487fd62e@suse.com>
 <fdd2d7e2-cf7c-4bfd-39d2-af5a3cf60b26@maciej.szmigiero.name>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <fdd2d7e2-cf7c-4bfd-39d2-af5a3cf60b26@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 15:37, Maciej S. Szmigiero wrote:
>> This statement is not reachable, so the patch is adding unneeded dead
>> code only.
> 
> Maybe some static checker isn't smart enough to figure this out.

The static checker really should be improved.  This is a while(true), 
not the halting problem. :)

Paolo

