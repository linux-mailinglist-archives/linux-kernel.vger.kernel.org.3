Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA55326B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiEXJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiEXJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB2886005E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653385358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFo5wCOAm0pgrR3mlKlJ9zjKOLJ6nCkOz288AuApEU8=;
        b=gsnYp9hdJw//ZQK+DOyGhHvX8Rhnl4m0o4lZdYV+EAORX7jzDMbbvJnnvqKigRdPEmHEAV
        N6IIAsAFoZVaBOffVyJZw1X++CqMk2rXYQJGPtqJ6Rs/j/uCu9ahKywLnXyhRkddT/iw2A
        Z+XAzrU4aNcZyEzCJRFIXosaumqbY8o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-wsCygmOTO72vm_ObHCupeA-1; Tue, 24 May 2022 05:42:35 -0400
X-MC-Unique: wsCygmOTO72vm_ObHCupeA-1
Received: by mail-ej1-f69.google.com with SMTP id sh14-20020a1709076e8e00b006f4a5de6888so7517742ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zFo5wCOAm0pgrR3mlKlJ9zjKOLJ6nCkOz288AuApEU8=;
        b=6FazuyT2WhBm0Mq7G3IaMK79/4QXn3pc/TFLrsmI0jEA10cznXkL49DzyhfJ8Ay2AE
         R4Ty1f6y434pMJtYKi932/2QxIpVrwRy4eGSR1d7qYXcTkpBmfo/kxOUSRHon6SS30a6
         0vmxs1WTAINazVfmkqdfkbeKcTHNsLsL3OGffms20T0w+zADAcrSeHz3A4MkBuCCPC7k
         vj/kberUZoqjtI0fD75ThPJH+HGFKAIeqvmw7SMRA3HodgVWXanqMYK8nHRj8DnItPDO
         Lueb+5T7yE2Dv+FbPctUx3/9+IOL2PCsKy5dBd7pnX32USci/dmFwns8vsXrxtuE8um1
         reGA==
X-Gm-Message-State: AOAM533HfcaEkRdUzD9iG9az0JslHck/UDYo/sMzz31KcRwOikdDa/WM
        uFRrtxhMOiK14PLdklzY78GrTYFtjFyCPYVW130BTOemlRgS7m5PNIeKDSeP7SjGgg7URgilKaF
        98kWb2OFybsuO2tptFEtvH4Fw
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr23817498ejc.653.1653385354823;
        Tue, 24 May 2022 02:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz1c8JZ5OgT7BSYJ7GMI1ZrbV0ucv3Jm2MDi5bXDEPX/pxgf5WI1Tr1nVK1/8YFWI1DdgwYw==
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr23817486ejc.653.1653385354641;
        Tue, 24 May 2022 02:42:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id 16-20020a17090601d000b006f3ef214db3sm7086985ejj.25.2022.05.24.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:42:33 -0700 (PDT)
Message-ID: <43bba413-030e-578b-a7d0-e81aed4e67b4@redhat.com>
Date:   Tue, 24 May 2022 11:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] s390/uv_uapi: depend on CONFIG_S390
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org
References: <20220523192420.151184-1-pbonzini@redhat.com>
 <78b9cc09-caef-94c7-8bff-30544098603f@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <78b9cc09-caef-94c7-8bff-30544098603f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 09:01, Christian Borntraeger wrote:
> Am 23.05.22 um 21:24 schrieb Paolo Bonzini:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   drivers/s390/char/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
>> index ef8f41833c1a..108e8eb06249 100644
>> --- a/drivers/s390/char/Kconfig
>> +++ b/drivers/s390/char/Kconfig
>> @@ -103,6 +103,7 @@ config SCLP_OFB
>>   config S390_UV_UAPI
>>       def_tristate m
>>       prompt "Ultravisor userspace API"
>> +        depends on S390
>>       help
>>         Selecting exposes parts of the UV interface to userspace
>>         by providing a misc character device at /dev/uv.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> with the whitespace as outlined.

Yes, that needs to be a tab.

> Can you pick it yourself?

Sure, thanks.

Paolo

