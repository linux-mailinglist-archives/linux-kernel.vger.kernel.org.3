Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97BF481F46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhL3Skf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233595AbhL3Ske (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640889633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbQ6UTaZ+JchUIz8NAwbybt8i/nP+nB2Nzcb91Lig9Y=;
        b=h0JACVYQS2xiOzphT5DupU03WWtt5qYwNVxDyj0vT3cFlI6oeXNRDHPa3ICYxBZfpicY8m
        5ZqNUOOn7kkzhtCE3iEK0Okv5hDlz9E0lRdu8YNKg70FYLWe4a5y7e2SfBzeK5CKKd4Gy6
        /XumNuY9zKs9RLQo03wV3IX7COhw6MU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-iQP98mV0Mu6ccx3V__Zlqw-1; Thu, 30 Dec 2021 13:40:32 -0500
X-MC-Unique: iQP98mV0Mu6ccx3V__Zlqw-1
Received: by mail-ed1-f69.google.com with SMTP id d7-20020aa7ce07000000b003f84e9b9c2fso17454121edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MbQ6UTaZ+JchUIz8NAwbybt8i/nP+nB2Nzcb91Lig9Y=;
        b=j7I8ItCI+GuGKJiVX5ZlLyphAe6nP7gvhjYrspBZorAana1s0KYf9ClIeNA0rV4YNZ
         i4Kor6toSvmlPSD6Z4NoJm40N4gb871sdYOzEne0Lcg887zN/YSf27EA/dfkhYlVnMzt
         xbcl0D0gAReoGJGmpCsLIf3EnAmxo5hyv2EtCNGa3p+mPJMtOahdTyNaWY/08AFC4m70
         rE2EE6VXfnMpyIcqSX014TpnY3hSYj3/cTtH3oBHSiW605iB3GZ7z8kIIIItphSB7ws9
         GnIM5Y2IM/2ARR4Rr3vdRxz5VC8+IdlxqYGBfyYFyhYXlno+Bu4JSkx7qDvCesDESlIv
         3KaA==
X-Gm-Message-State: AOAM533x/iWQI1teEcE+jC7v/E4ekmSvcfzineLi6sQVDatOL9GREbP6
        jJinH9z4fFlQCYTfb/+FPJt5bAI9K5OhPEgkkgVMyIXXgggS+jeQf7YigEdES7+Gtk6WMNFORI+
        TcPST2TS2iwzeoi1v/o7y11PF
X-Received: by 2002:a50:fc93:: with SMTP id f19mr12870673edq.180.1640889631043;
        Thu, 30 Dec 2021 10:40:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/sv+BexySX7FvaFv581MzQ3yHBjt1kF9Bju+nrFgYmhFaGX7ob1HlciOK3TfSeDh3YWWYvQ==
X-Received: by 2002:a50:fc93:: with SMTP id f19mr12870655edq.180.1640889630836;
        Thu, 30 Dec 2021 10:40:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id nb20sm7761809ejc.25.2021.12.30.10.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 10:40:30 -0800 (PST)
Message-ID: <980d3895-b9c1-6f3c-3b7e-b5fc208769ad@redhat.com>
Date:   Thu, 30 Dec 2021 19:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 4/4] platform/x86: Add crystal_cove_charger driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211225115509.94891-1-hdegoede@redhat.com>
 <20211225115509.94891-5-hdegoede@redhat.com>
 <CAHp75VcnPJvprayX+B_nHEahbrSyvAORyD9dAuMJ9zEP+Jq3hw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcnPJvprayX+B_nHEahbrSyvAORyD9dAuMJ9zEP+Jq3hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/25/21 15:37, Andy Shevchenko wrote:
> On Sat, Dec 25, 2021 at 1:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Driver for the external-charger IRQ pass-through function of the
>> Bay Trail Crystal Cove PMIC.
> 
> Intel Bay Trail (same in the code)

Ack will fix before merging.

>> Note this is NOT a power_supply class driver, it just deals with IRQ
>> pass-through, this requires this separate driver because the PMIC's
>> level 2 interrupt for this must be explicitly acked.
>>
>> This new driver gets enabled by the existing X86_ANDROID_TABLETS Kconfig
>> option because the x86-android-tablets module is the only user of the
>> exported external-charger IRQ.
> 
> ...
> 
>>  drivers/platform/x86/crystal_cove_charger.c | 153 ++++++++++++++++++++
> 
> I'm wondering why it's not under the intel/ subfolder. Do we expect to
> have the same PMIC used on other x86 vendors?

I was wondering about doing this myself before submitting this upstream,
since you have the same idea, lets go for it. I'll move this before
merging it.

> 
> ...
> 
>> +static int crystal_cove_charger_probe(struct platform_device *pdev)
>> +{
> 
> Adding
> 
>   struct device *dev = &pdev->dev;
> 
> may increase readability a bit and perhaps reduce the amount of LOCs.

Normally I'm a fan of doing that myself, but it doesn't really help
here since there are only a few references and those fit in 1 line.

Regards,

Hans

