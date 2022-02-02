Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D64A7B15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbiBBW3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232942AbiBBW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643840940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtTZ0IQBRq2ZgYk8dzB8TRg20KSQIQ38+7ukt+l4rQA=;
        b=ebiKjL65El69/BLXq1u6SKKnGmNfMCdHKvTWOOIt4eX0IYw9geJkSkBBYPfK9zG+JftGCr
        f6jMA24DiqMTUzYAb/4w8X04jc/yMHWETgJHYs9UzaPVs3T3W/jcvoBMXNLlZZumHBLbKk
        gYgbCrsP6+oV90/dEHo32rqgqOycZo0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-GMS69tSHMAmf69kcngP6SQ-1; Wed, 02 Feb 2022 17:28:58 -0500
X-MC-Unique: GMS69tSHMAmf69kcngP6SQ-1
Received: by mail-qt1-f199.google.com with SMTP id c15-20020ac87dcf000000b002d0a849c0beso462320qte.16
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 14:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=GtTZ0IQBRq2ZgYk8dzB8TRg20KSQIQ38+7ukt+l4rQA=;
        b=yacUuiOXAufOt8821kxrdw86n897Yl4ha9Ttku0ndvtmow+Y6yUWfm8CAOexsJPp9w
         SB4a9yWi5H6fxsj8GDzYcRpbIxTfkO+aFWDFIoobWV4OEdQU3dFk/ieO80JIC+GJUqrW
         aTfhDhNaQpJbpPWbXVXS3e35lyMUxYMwVo2NsZfQSQWXMA3lUpr2d1QWEmeWu5zIQDRz
         8merMtkSHeQTDaFtD53/a0FgvYpU38WWodoM78xEDjZrA3vt9pC+2m0agYzbhC8SImg4
         gtZqbp048RdzrmQd5u1RXh2Wh8vp9lvIslENWis5v/gLPhz9Z/oT4a/zRz5He0r1W1Pp
         FbaQ==
X-Gm-Message-State: AOAM530DvgC1q1JscLJevAzsDknusWpeVoEHGRAMwLzVHWm1tIf13buJ
        6zQROArd2FL+JfRUEwBcACQeLXe0/dP+Xy49uUJ5gQgVz+JYYToOe4ECcW61HkFfJ4S0/puGnHU
        ePzSU2ANE7mGb35EHa9EZScgR
X-Received: by 2002:a37:c4d:: with SMTP id 74mr21902986qkm.619.1643840937945;
        Wed, 02 Feb 2022 14:28:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUnTy7VIm0cuNSXjTF3nE0BcP3j6/SLHPRwHmTzoDfTwRgM97sVQieHS90tuMZ4JXbXhedeQ==
X-Received: by 2002:a37:c4d:: with SMTP id 74mr21902979qkm.619.1643840937755;
        Wed, 02 Feb 2022 14:28:57 -0800 (PST)
Received: from [192.168.0.241] (135-23-175-80.cpe.pppoe.ca. [135.23.175.80])
        by smtp.gmail.com with ESMTPSA id s6sm13221670qko.93.2022.02.02.14.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 14:28:56 -0800 (PST)
Message-ID: <3081decb-11a5-11bf-4810-7c5ebe5dcc51@redhat.com>
Date:   Wed, 2 Feb 2022 17:28:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Aligning tcmalloc with glibc 2.35 rseq ABI
Content-Language: en-US
From:   Carlos O'Donell <carlos@redhat.com>
To:     Florian Weimer <fweimer@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Paul Turner <pjt@google.com>
References: <432231420.24682.1643727496135.JavaMail.zimbra@efficios.com>
 <CAEE+ybn_Cp1-T=2uB7xJqU2gEU-PxzsaV5jqCOupNp2cx_bK-Q@mail.gmail.com>
 <87mtja1fuz.fsf@oldenburg.str.redhat.com>
 <875ypx1x0d.fsf@oldenburg.str.redhat.com>
 <1375227765.27051.1643801804042.JavaMail.zimbra@efficios.com>
 <770517862.27112.1643807335312.JavaMail.zimbra@efficios.com>
 <87o83pxqh0.fsf@oldenburg.str.redhat.com>
 <ab2fabcf-b84d-6850-f25e-edc80a80662a@redhat.com>
Organization: Red Hat
In-Reply-To: <ab2fabcf-b84d-6850-f25e-edc80a80662a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 12:31, Carlos O'Donell wrote:
> On 2/2/22 10:01, Florian Weimer via Libc-alpha wrote:
>> * Mathieu Desnoyers:
>>
>>> More to the point: is ptrdiff_t the correct type here ? I think so.
>>> Do we want to revert the ABI and wait another 6 months before we
>>> bring back rseq into glibc just for this ? I'm not sure this limitation
>>> justifies it.
>>>
>>> So if there is a quick way to fix that before the official 2.35 release,
>>> I'm all for it, otherwise I cannot say that __rseq_offset being an "int"
>>> rather than a "ptrdiff_t" will make much real-life difference (unless
>>> I'm proven wrong). But we will be stuck with this quirk forever.
>>
>> I'm going to post a patch.  It's fairly small.
> 
> I'll review this as glibc release manager for glibc 2.35.
> 
> We'll get this right before I cut the release.
 
I've reviewed the static linker relocation designs, and aside from the odd-duck
for ia64, we've used ptrdiff_t sized relocations, nominally 64-bits for the
64-bit targets (though on AArch64 -mtls-size admits at most 48-bits).

The ptrdiff_t change will be a part of the glibc 2.35 release:

commit 6c33b018438ee799c29486f21d43d8100bdbd597
Author: Florian Weimer <fweimer@redhat.com>
Date:   Wed Feb 2 22:37:20 2022 +0100

    Linux: Use ptrdiff_t for __rseq_offset
    
    This matches the data size initial-exec relocations use on most
    targets.
    
    Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Reviewed-by: Carlos O'Donell <carlos@redhat.com>

-- 
Cheers,
Carlos.

