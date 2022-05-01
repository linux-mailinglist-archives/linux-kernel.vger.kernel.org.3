Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CA05166B4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiEARkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiEARke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 781FA12748
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651426627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKYyDzEa1Qm6/nRF+fARRdz7xpLxGmHcyaMuMYxwK7c=;
        b=Sp8wIKMv1OvxPZcVRm8Ak2pRC3L0MHfzGJGBCYE5oeXGndke4LDhNnOXebxo4wMsIA13Mn
        wNu+CM+O+Qk96PlKBwdMqTqET/ci8RQinP4BBnTjM7DEpY3KifuUffBVp3AgHndOO5pzwK
        N8fpjNBdNf4mn7HPo241dDOXPythtUw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-bS-7KcAxN5WYOC8qIAnquQ-1; Sun, 01 May 2022 13:37:06 -0400
X-MC-Unique: bS-7KcAxN5WYOC8qIAnquQ-1
Received: by mail-ej1-f69.google.com with SMTP id qf19-20020a1709077f1300b006f439243355so322965ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 10:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CKYyDzEa1Qm6/nRF+fARRdz7xpLxGmHcyaMuMYxwK7c=;
        b=sJwD57OGcCO7zhYdykM+iKJu4RxECETEGTHiwoqLharmTcHiZaYDaC+e5856lslCds
         bgL2GF2bBF8Y3EepV6BL0A7/YGW4sgLdqczft7mv+QF+wZ52ZSpqwYFKvobZ3KeTWw1d
         HYknxZnANRtwzsq9/YktEdDe/p00rJ+mjdLeevQkLbSB1c0dlJqseBj9kBoMLx1VYWDS
         3FddadiOAzLH3YcNVOD93z20j7B81zqPLopeDACWh2AzRw+dCCcGINaTQHd9dTR+qj2Q
         UnG+3tCO1YfNta9lMVhg/ZePfwHw8EipGUJBFuGmozcNreI8JVBeOeI/0XtQicPFqpyJ
         WNtw==
X-Gm-Message-State: AOAM5323D1gUDOwdUpHcbjJnTFhLVmtozUyZM+faZMFl6CbjfNJ3vTFJ
        0wrGcNFZCP7FoGPvb6S30WaVAQCt4cnZZ80C3JZlDVo4fsfX7bmwgfB0a47eFygdgjYeBDeupmL
        6IA83Ba2yMk3Ke7xy2tUStyJ7
X-Received: by 2002:a50:d707:0:b0:425:e37d:4ef3 with SMTP id t7-20020a50d707000000b00425e37d4ef3mr9847697edi.167.1651426624871;
        Sun, 01 May 2022 10:37:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2LQ9ZwdZjXacAt/NZtWsVCKIKSqXIdjiolSzR/GuJxk6zOwgAVK5QGcZPqDy4EWCga94JoQ==
X-Received: by 2002:a50:d707:0:b0:425:e37d:4ef3 with SMTP id t7-20020a50d707000000b00425e37d4ef3mr9847680edi.167.1651426624588;
        Sun, 01 May 2022 10:37:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id bf16-20020a0564021a5000b0042617ba63aesm5683779edb.56.2022.05.01.10.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 10:37:03 -0700 (PDT)
Message-ID: <54adc4a3-6b66-8ddf-db92-9630089da2dd@redhat.com>
Date:   Sun, 1 May 2022 19:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86: work around QEMU issue with synthetic CPUID
 leaves
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20220429192553.932611-1-pbonzini@redhat.com>
 <1dcfb3d243916a3957d5368c2298e3f8fd79a9f2.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1dcfb3d243916a3957d5368c2298e3f8fd79a9f2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/22 13:16, Maxim Levitsky wrote:
>> +		 * However, only do it if the host has CPUID leaf 0x8000001d.
>> +		 * QEMU thinks that it can query the host blindly for that
>> +		 * CPUID leaf if KVM reports that it supports 0x8000001d or
>> +		 * above.  The processor merrily returns values from the
>> +		 * highest Intel leaf which QEMU tries to use as the guest's
>> +		 * 0x8000001d.  Even worse, this can result in an infinite
>> +		 * loop if said highest leaf has no subleaves indexed by ECX.
>
> Very small nitpick: It might be useful to add a note that qemu does this only for the
> leaf 0x8000001d.

Yes, it's there: "QEMU thinks that it can query the host blindly for 
that CPUID leaf", "that" is 0x8000001d in the previous sentence.

Paolo

