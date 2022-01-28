Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C238A4A00F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiA1ThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230029AbiA1ThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643398641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJ78PqpfaYdoTQU7JcioKlmBoZlxq+jRcIlavIlWaQw=;
        b=Z8q5S7QA0uW+cvVGnuqhqNblWPHsSacXxEdsTpnI56NNhQtyEYMM4K/yAS6tSxh64NgSGv
        W/m8+j/1tl2bjTVrAs4PgsJjze87PnISILX9FnjE7fmCUHW2PTOvU2X843COLC2qAEDJec
        cnujYtuZeMNFw3JnqQjNLmsyNB3bwOc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-OHSSXqzqOLG8jvC5V6KSmA-1; Fri, 28 Jan 2022 14:37:20 -0500
X-MC-Unique: OHSSXqzqOLG8jvC5V6KSmA-1
Received: by mail-ot1-f72.google.com with SMTP id c22-20020a9d6856000000b005a0f193edf0so3707638oto.16
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sJ78PqpfaYdoTQU7JcioKlmBoZlxq+jRcIlavIlWaQw=;
        b=vzb1adO2hPJBJQYb2MbSqMhOrotYtB/jqD3CXOl7vWQI9WdJwokB0KcvGu6PYp1cwa
         pXLwYchpyEXHrUAy+IjwjYPQeBGmAyyAv6Hx6lW798xCBUyO3Hb/fQqJH9hxWcd/fD9S
         MEezRsjgu5nmzjvXrq7yMzJzENft0kX2j77qpAIqqPv5srayqZBGzcdXVtt+oUsV6mWj
         x+wXKKqtYRMsPakP1XxEpfw8M9tqxl5sZQdORnMuCKeUXpfoXqskwMaN2g3eerBaXh5R
         vjDR3cBclKwWMkAiWJL07l9sYjiUhAGs+RHn5KXTqQ1T9MiLqN5HYLQV5qekW7WzYWcz
         wIEA==
X-Gm-Message-State: AOAM531ms+Sk4sRlVQu5uABDHsi6pHfgkoCKj9w6JJxHLyhfe5uKbwz8
        naUT8JwvqkB8i3I9pqZDOge5XOuOt4pSGKF+uPgHI8YLO2qo/gjusrbPVLmQFEdw5PxJUPEKat5
        GYXMtqbWvsyYwW9JUhO17SPYn
X-Received: by 2002:a05:6808:302a:: with SMTP id ay42mr10605356oib.9.1643398639364;
        Fri, 28 Jan 2022 11:37:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJH5+YbwP3uDIx0eIMGxxU4M5Gxe9auKJAqcbbxh30RRitEA2FqyPq4CXplO1Q4MwMWUJJZQ==
X-Received: by 2002:a05:6808:302a:: with SMTP id ay42mr10605345oib.9.1643398639151;
        Fri, 28 Jan 2022 11:37:19 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g20sm12023713oiy.34.2022.01.28.11.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 11:37:18 -0800 (PST)
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
 <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
 <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
Date:   Fri, 28 Jan 2022 11:37:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/22 11:11 AM, Joe Perches wrote:
> On Fri, 2022-01-28 at 09:59 -0800, Tom Rix wrote:
>> On 1/28/22 9:42 AM, Bart Van Assche wrote:
>>> On 1/27/22 07:19, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> checkpatch reports several hundred formatting errors.
>>>> Run these files through clang-format and knock off
>>>> some of them.
>>> Isn't this the kind of patches that carries more risk than value?
> Risk for whitespace style reformatting patches is quite low.
>
> Nominally, clang-format changes should not produce a different
> compiled object file unless __LINE__/__DATE__/__TIME__ style
> changes occur.
>
> If it does, the clang-format tool is broken.
>
>>> Additionally, this patch conflicts with a patch series that I plan to
>>> post soon.
> []
>> Long term, it would be good have a reliable way to automatically fix
>> either new files or really broken old files.
> That's really a maintainer preference no?
>
> Especially so for any automation.

In practice everything is up to the maintainer.

If some maintainer wants fix their formatting then clang-format should 
just work

It isn't likely they will have time to hand fix every file.

Tom

>
>

