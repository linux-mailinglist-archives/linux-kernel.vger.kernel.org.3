Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82C481F42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhL3Sip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240204AbhL3Sin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640889523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMtfcubxS1jCFV3zQJL+J175Tn1FOB4sXNwCW0+vK8c=;
        b=EEqazvALqH8q+838Ks7bwuFM2VrrCdm8TsidTfSSsukofiGnwPvgE08ZxqXO8M3u/O3vNX
        uc1so6Mpmn1c/oQPdMdEtVp3GycrHSMzeRBmr0KMQEtV0OaChDRa2zP78jrMfdaM82VuG5
        5Eh0nM8UpAWJZrSgikxaCaHlTnuRkNQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-rCO6bkAUMBqJl0HYCOoI6w-1; Thu, 30 Dec 2021 13:38:41 -0500
X-MC-Unique: rCO6bkAUMBqJl0HYCOoI6w-1
Received: by mail-ed1-f72.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so17579904edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rMtfcubxS1jCFV3zQJL+J175Tn1FOB4sXNwCW0+vK8c=;
        b=3qv5mVFdOWaE6L//wDZh5OfuF6vIBptjRQ3SLBvDK5OwVAXf0SNqj6EovJ1j6Djt9w
         jf/aXXsNvl4pfd8M99vuHyBoAOMoKVsOI+/ECPPhQ5Q9/30pT8S2syoKdXHhobpt0Ljc
         x4GT5Hbks8TPiMIrfZLT8xgaCU0ogPyuxzdIzG9TX2AlgoWf5o6tBeGJP/LjbTNQHtds
         +56MNZ0zwcH0lmEGCSowKC+g8gRMZClj+PG16DL9dCrQQBtoXGdefW2RYcOz9AAmJLAP
         PQe3bYRvJDMOlcEgb01gBXGFBMn7kGnU8EU64rNO2ja5Hi1L+lBRHZsgXHAHxtQT/5/7
         qYvQ==
X-Gm-Message-State: AOAM530kpLjTMlaQWbpyzo8NzZqNdSaQUc6HdsW3Qsh5PGEhJ1nUZpjg
        NWG1qrBe5mxCQtdfVx75+8ez52nDAgZisiYp+6lonESIoISdjt9W8R7fJ284eH1UO4WLpzXJHgH
        TzG0mDzOZl86fqgEenwZOx4Iq
X-Received: by 2002:a17:906:458:: with SMTP id e24mr26790861eja.108.1640889520549;
        Thu, 30 Dec 2021 10:38:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyw+XZf7hjbrHnfghGHm6EyGHNfdPtr42MkKTcxycQp1abbnqZrxktapKHA+pk8e3XiaUbzUw==
X-Received: by 2002:a17:906:458:: with SMTP id e24mr26790852eja.108.1640889520410;
        Thu, 30 Dec 2021 10:38:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id i8sm7672182edc.91.2021.12.30.10.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 10:38:40 -0800 (PST)
Message-ID: <2b0ccceb-4a6f-387f-42ae-b1043ee751c9@redhat.com>
Date:   Thu, 30 Dec 2021 19:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/4] mfd: intel_soc_pmic_crc: Sort cells by IRQ order
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211225115509.94891-1-hdegoede@redhat.com>
 <20211225115509.94891-2-hdegoede@redhat.com>
 <CAHp75VfLcCKPa1J5qG=iLhZRT1JKQFbBiaf7D23zmctS2ojFhQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfLcCKPa1J5qG=iLhZRT1JKQFbBiaf7D23zmctS2ojFhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 12/25/21 15:20, Andy Shevchenko wrote:
> On Sat, Dec 25, 2021 at 1:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The cells for the Crystal Cove PMIC are already mostly sorted by
>> function / IRQ order. Move the ADC cell so that they are fully sorted.
>>
>> Also move some of the resource definitions so that their order matches
>> the (new) order of the cells.
> 
> 
> ...
> 
>>  #define CRYSTAL_COVE_IRQ_GPIO          5
> 
> 
>>         {
> 
> As Lee commented once in p2sb patch series I think it makes sense here
> as well, i.e.
> 
> [CRYSTAL_COVE_IRQ_GPIO] = {
> 
>>                 .name = "crystal_cove_gpio",
>>                 .num_resources = ARRAY_SIZE(gpio_resources),
> 
> What do you think?

There are also cells without IRQs, e.g. for the ACPI PMIC OpRegion
driver to bind to. So we cannot (consistently) do this.

Regards,

Hans

