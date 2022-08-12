Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC8C590CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiHLHka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiHLHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B43F928709
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660290023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzyQdT5cmtTht8IqFKMXiM9jaigfovrsBI7GWxuwi5g=;
        b=Ua4m4apeKIyBSosisrxkEknr0b4+8yjw1q/+z3HOlmnLjmvF+zhEZoU+xUa/bfOqjN9j2s
        zmN17MiosoAsTc2TvmudS977rQCmd/ZnDCLH4LoyWirwO9X4z1oIVqmKE4wj02EKzpsCxV
        WpLtebktcwg/pPzqQ/KehJg/3Bw1TGo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-3ayUF0oJNdCdbCPOIMzF8g-1; Fri, 12 Aug 2022 03:40:22 -0400
X-MC-Unique: 3ayUF0oJNdCdbCPOIMzF8g-1
Received: by mail-ed1-f71.google.com with SMTP id x20-20020a05640226d400b0043d50aadf3fso153955edd.23
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VzyQdT5cmtTht8IqFKMXiM9jaigfovrsBI7GWxuwi5g=;
        b=jAhODn6KBoAdBx3bqT0wEhpmARhznNjdIxtvtCglZOls9/0JG9d2DySsyVXtr4KKMe
         POd1w4HvwP8tSP1UBxsPBDPe7K37Q7Hpn2alAGD7lp7CLMZ1InR9Bka6sXqB52iqn5PO
         n+VctUEDyN2Xq/bsvajWxxenC3lTp5emf+t6J7q51iA/z/iRxM9AONOkEIeFhmdadeRU
         z+RXzaYuK7lVKR4Sf1DwpGQBx0WQXy8OAK/wRZIaFCTvPabitk4NZtc/MoJNrzTI5dyw
         3jxNigQ3cTO2HDWaG/yl58mHjs9h8V0soORvCjjIPYbfol3gHJp9l6JsGPktcKuH6enL
         kdaA==
X-Gm-Message-State: ACgBeo2mQhYP+Z04rem7HXr1AFTNbuYR7Enjt8u4BplggqTQRzjBr0Xt
        gESLlToDir/GsuAI4DsjkKOMSNNMvi/TZG1Qhv9oGFKhSH6jcukZ4Wv3KfnMyG2XQabsv4JKmc6
        Cseps8Y/mKcCV1ILpSGUd7s4g
X-Received: by 2002:a17:907:6d8c:b0:731:6c60:eced with SMTP id sb12-20020a1709076d8c00b007316c60ecedmr1908923ejc.266.1660290021446;
        Fri, 12 Aug 2022 00:40:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4+bs0ZA+sprvMn0/Ivf+3NRpmtrSL/ddfi5tjpVofxW6oWzVLkn3yetOTpHRI1HpZv21KQlQ==
X-Received: by 2002:a17:907:6d8c:b0:731:6c60:eced with SMTP id sb12-20020a1709076d8c00b007316c60ecedmr1908903ejc.266.1660290021233;
        Fri, 12 Aug 2022 00:40:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id a26-20020a17090682da00b006ff0b457cdasm507155ejy.53.2022.08.12.00.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:40:20 -0700 (PDT)
Message-ID: <d858ba66-422b-2bce-dafe-bc6586803e5f@redhat.com>
Date:   Fri, 12 Aug 2022 09:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH next 0/2] Documentation: KVM:
 KVM_CAP_VM_DISABLE_NX_HUGE_PAGES documentation fixes
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        kvm@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220811063601.195105-1-pbonzini@redhat.com>
 <1db2a0cd-bef1-213c-a411-3d39d378743a@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1db2a0cd-bef1-213c-a411-3d39d378743a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 15:30, Bagas Sanjaya wrote:
> On 8/11/22 13:36, Paolo Bonzini wrote:
>> Queued, thanks.
>>
>> Paolo
>>
>>
> 
> Thanks for picking this up. However, Stephen noted that the issue is
> already showed up on mainline [1]. Maybe this series should be queued
> for 6.0 release (as -rc fixes), right?

Yes, it's in Linus's tree already.  Thanks for replying to Stephen.

Paolo

