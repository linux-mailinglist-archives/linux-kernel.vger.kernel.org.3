Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453F50A7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391168AbiDUSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiDUSJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE94F24088
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650564376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4HhsPKolmLzyXIAPmiV7kISwst2cNULrzQjVoJrkBM=;
        b=NdQRaxSJKFLXEc71cyN0Ax5yd0GWFC7NLJr6ppyCXfehRf6P9pPnFNwplxqazN1eRV3EwO
        FK3iOQ1lP2c2aV2EieJ9WYc9kKBZsITLzZLr+w+XyKJ6Fuj9owpCXX+NVMXPNgt62HzeOk
        MRRsLhNlZOzcYo2XJkWmpLAAV3TaAx4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-96-SZo51MqC7ulnue_0MfQ-1; Thu, 21 Apr 2022 14:06:15 -0400
X-MC-Unique: 96-SZo51MqC7ulnue_0MfQ-1
Received: by mail-wm1-f71.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so2720125wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P4HhsPKolmLzyXIAPmiV7kISwst2cNULrzQjVoJrkBM=;
        b=cLdV7xmMNkcC2ZYLeqyIb7k6NaOCglP3mLRzjRlvEZnZDchWYSByl4LoQxrdCn8mHL
         URL4vOxp4qpcohwlKwSIcm1KUZ3OtPNrl05HvjJfNxeg7LKruw3iwBqhPFm0lV7GcSxK
         L7VMbusbZJJCFUq1EQzWqpf3KP3AtJAlD0LaG/Lyvui38t1TAJA08VJGPqB8guaADmjO
         ESg9eUA1lOS89JGLmQ6DojhuTWWBeDaccbms8PeVb3rnL8ji2DQBK/QfZHXbfiSzFJnB
         ViZ5TOxqjLQmlPQp8Q9CVqCKIJ/3IHefV0lirvKTEdlv4icwlSgaP8SqCFPq9v9v3vPb
         OW0g==
X-Gm-Message-State: AOAM530UCEgZf83Bu2oUoagCLGHJYwZAd+no6CcdfkQ4EWRf6o+ta1/h
        Y4BqgutY6PUAxAA0aPuonVbl3Zkr56yvn7ACTPP30r8ryZ2Bany13B9dlwce8q1Ps5MOTdjcCSp
        H8v+ZpgtIissgl07MynSG1GU2
X-Received: by 2002:adf:c547:0:b0:207:9abc:cfa1 with SMTP id s7-20020adfc547000000b002079abccfa1mr685901wrf.390.1650564374204;
        Thu, 21 Apr 2022 11:06:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpj0yPuDnWazYb01yXoAAQ/3svcqqwyjpGpys9U+6aoIt5zXweO/RmwFo4BxAOOvuaPQ/iSg==
X-Received: by 2002:adf:c547:0:b0:207:9abc:cfa1 with SMTP id s7-20020adfc547000000b002079abccfa1mr685888wrf.390.1650564374014;
        Thu, 21 Apr 2022 11:06:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056000168b00b0020a919422ccsm3463856wrd.109.2022.04.21.11.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 11:06:13 -0700 (PDT)
Message-ID: <b87bc46c-36ba-f428-1e91-6315f3534fa4@redhat.com>
Date:   Thu, 21 Apr 2022 20:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: linux-next: build failure after merge of the kvm tree
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     KVM <kvm@vger.kernel.org>, Peter Gonda <pgonda@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220419153423.644c0fa1@canb.auug.org.au>
 <Yl7c06VX5Pf4ZKsa@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yl7c06VX5Pf4ZKsa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 18:01, Sean Christopherson wrote:
> Yeah, it's a bit of mess.  I believe we have a way out, waiting on Paolo to weigh in.
> 
> https://lore.kernel.org/all/YlisiF4BU6Uxe+iU@google.com

Sent out my proposal.  For ARM, it is also binary backwards-compatible 
for 64-bit userspace.

Paolo

