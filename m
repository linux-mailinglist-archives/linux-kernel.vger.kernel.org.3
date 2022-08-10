Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7158F2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiHJTQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiHJTQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AD14286FA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660158975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yuk7N/xiq0HIW33fh8ipQmpkKHx9Ov4tG2OqBXiygDw=;
        b=G7p2L5HkJUK9+iaQXO7a4Rjzu9BWXdZhhA+MxG2801TnW8LV/RYVf8iD/iPZfr5uuQXEoF
        YZgltLIq4J27q9XYsTXpfPUD9F3w45gePYlvXqwBtDVzHySWmx0Ap7FQ6PJklYlSLVpdYE
        3pyhHgiQSteSQ9b4grWg2EnYlezI2WU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-rOYcSoUgN_OwsqE88w8g9w-1; Wed, 10 Aug 2022 15:16:14 -0400
X-MC-Unique: rOYcSoUgN_OwsqE88w8g9w-1
Received: by mail-ed1-f72.google.com with SMTP id i5-20020a05640242c500b0043e50334109so9782936edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Yuk7N/xiq0HIW33fh8ipQmpkKHx9Ov4tG2OqBXiygDw=;
        b=py7ce0TmQjK2p5CUvzume/hnEqk9jc2jPRCJhvKV4WGqVUZIIoOUqzXXFSNyKSwV3O
         k2cVYiuzQCt8xLRfYIglWptuyLQpew+bk96qfcP4BWFTHeztRG+GmQiaJy39twGEG4qx
         qfHoxikDABejeWM5Wc3FXL/oblv18eUdkAGF3ILet6igLuf39hRQXBZk1NtWAn7X917V
         RiD9KS/d/UpCLBjfRkvbjSXZyZYb1IQV/8P8DAoAAH5pAucNjgSS1fFZAqYnziNBzIYA
         WCp2hoM3x7SAZAn7MgF1CDgux3xkI8jl7OkrBgnCDU7h3RZyKMMQaVq+9aI7RN56Xj7x
         EJTQ==
X-Gm-Message-State: ACgBeo0ubTuDGDWgg+l9btullvtuQDFYKIdcTd72jp9qfXIeuViEqdcB
        smAAtrSCxDKMmao50MHAWdYZTtJ+F1Nj8IzULK/bno6FG9DjXt9MAb56vH4LyHi1U8JrDcnGGJg
        xI1jK/MjL1F9fMBa/3Isf7Lcj
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id gs18-20020a1709072d1200b007316a4eceb0mr10079037ejc.115.1660158972001;
        Wed, 10 Aug 2022 12:16:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+FYQetpU3q/Q5uOyO8nSkvyFk5TvPqTUmApwtAkGzu9ywUxx5N/JvC3UE+anDgXpNN9zzBg==
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id gs18-20020a1709072d1200b007316a4eceb0mr10079033ejc.115.1660158971826;
        Wed, 10 Aug 2022 12:16:11 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n6-20020aa7c786000000b0043a554818afsm8082123eds.42.2022.08.10.12.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 12:16:10 -0700 (PDT)
Message-ID: <eb0a073d-f045-a5d7-2d3d-54abe1ae478c@redhat.com>
Date:   Wed, 10 Aug 2022 21:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 2/3] KVM: x86: Generate set of VMX feature MSRs using
 first/last definitions
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
References: <20220805172945.35412-1-seanjc@google.com>
 <20220805172945.35412-3-seanjc@google.com>
 <29150d3f-36fb-516d-55d0-a9aebe23cdcf@redhat.com>
 <YvPDYVPgrLCRlYuH@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YvPDYVPgrLCRlYuH@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 16:40, Sean Christopherson wrote:
>> I'd rather move all the code to a new function kvm_init_feature_msr_list()
>> instead, and call it from kvm_arch_hardware_setup().
> 
> Would it make sense to also split out kvm_init_emulated_msr_list()?  Hmm, and
> rename this to kvm_init_virtualized_msr_list()?  I can't tell if that would be
> helpful or confusing.

I thought of feature MSRs because it's a different ioctl altogether, but 
this is not an objection; whatever seems less confusing to you.

Paolo

