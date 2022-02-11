Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE04B2C06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352329AbiBKRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:48:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352316AbiBKRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:48:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B663AE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644601678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bGomXKmD4Labg1JIcePjP5kik7k3u2urR4t7NcrCQU=;
        b=L9AYwlTF9HoLOmw2PsmXWKi44IvZAz9pxKVYf49yQHcIKtvraksYUki9OTPKo2yqQ3k15e
        AfJ1MJGoKKeKTadoPLyXZSmB/kGtFcbtf1O0gbpjQFRYQucd2QdzdAxXORaD5ViSLrhI44
        4KQZKPN/DaTo/Hdq+rmQp1BqpRPHaJU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-kcPVuhWQNnm5Q6NEpDGgHA-1; Fri, 11 Feb 2022 12:47:56 -0500
X-MC-Unique: kcPVuhWQNnm5Q6NEpDGgHA-1
Received: by mail-ej1-f69.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso4402987ejk.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+bGomXKmD4Labg1JIcePjP5kik7k3u2urR4t7NcrCQU=;
        b=ZUF6xGvDe51bqvi7qMarhTa/eHdeb32NPA7ZwnZIRuKQqd48t3UAE1tq74b8ti69uh
         b80dMQYyTZ/EVP2PNXzvcHncNGERSJ9+bh82njOAaYEEA3+5ep7ESbmNlBoQUFdWaOuZ
         WOmEhL4oGVoFXmBbl5O9oor/GdlK5gWcvZb7NhiPsTLis9vJOAAg0denYlch5dOVKglX
         ++EHfiFz1E+CzgTVMVUNu+RQX8JApy1cobJL/gNAyWDjANWSR3FdRJvbkkuJge5gEj7D
         Q9lAVsvzVz46VN7xtf4XIpTbMcAVYjXlcvxno1p/WrYLzgEHMxnWQ0w4wa7F7z6gYXQd
         jleg==
X-Gm-Message-State: AOAM5331dvBQgcW9mzGlHi4eSDyA/vY2soCSgt+c9tosT0VO4FDfByKw
        /wMwKuiv86nAaGWCI4YvrmM8FYVbj0uPcV+e0QuGTO4Dnvu2IyqK6fhTx008B2IPOZ767s47h3u
        lyACIGp8wNv1XPnRVn+KtBCnc
X-Received: by 2002:a17:907:94d5:: with SMTP id dn21mr2371718ejc.77.1644601675460;
        Fri, 11 Feb 2022 09:47:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzStRg+xJ5e8CXnMfqaSrVBdK9BYOEdRdN7EdmM6bxli07TfRsiQv49YJrRTcTfXd+3MqlsKw==
X-Received: by 2002:a17:907:94d5:: with SMTP id dn21mr2371707ejc.77.1644601675282;
        Fri, 11 Feb 2022 09:47:55 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id gx17sm4290834ejb.28.2022.02.11.09.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:47:54 -0800 (PST)
Message-ID: <56ee0380-3717-b150-c674-08f76b6e295b@redhat.com>
Date:   Fri, 11 Feb 2022 18:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/12] KVM: MMU: load new PGD after the shadow MMU is
 initialized
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-11-pbonzini@redhat.com> <Ygagy355RARlppQ4@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ygagy355RARlppQ4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 18:45, Sean Christopherson wrote:
> On Wed, Feb 09, 2022, Paolo Bonzini wrote:
>> Now that __kvm_mmu_new_pgd does not look at the MMU's root_level and
>> shadow_root_level anymore, pull the PGD load after the initialization of
>> the shadow MMUs.
>>
>> Besides being more intuitive, this enables future simplifications
>> and optimizations because it's not necessary anymore to compute the
>> role outside kvm_init_mmu.  In particular, kvm_mmu_reset_context was not
>> attempting to use a cached PGD to avoid having to figure out the new role.
>> It will soon be able to follow what nested_{vmx,svm}_load_cr3 are doing,
>> and avoid unloading all the cached roots.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> 
> If you add a sanity check as described in the other thread[*],
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>

It's not as easy as I thought, but it becomes almost trivial with the 
CPU/MMU role refactoring.  I'll get that posted as soon as I can push a 
final-ish version of this one to kvm/queue.

Paolo

