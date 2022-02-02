Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F94A76E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346274AbiBBRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbiBBRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643823118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35uO0GsWL2SrXQdWpTFnMx1XSOqtt2fi2MnGJpcHACk=;
        b=PL1JYn7bgcVxSzlQM4ayMX5ICXlWtQQeriHYY7a+c3XOeucT/E3dqE94N7sGlqIdLbhg0K
        hPxZIpirXkTHPLNQr5hnwrScoUM7P5g2hIcyDlhv/xpzjwgEhmirL034aSv1FxYVHymPXK
        Hq1tcU7IZ+ywlqFcBtc8SlUU4GMnPeU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-BAnt-99XP_Cl2_exzrt72Q-1; Wed, 02 Feb 2022 12:31:57 -0500
X-MC-Unique: BAnt-99XP_Cl2_exzrt72Q-1
Received: by mail-il1-f199.google.com with SMTP id k12-20020a92c24c000000b002bc9876bf27so1773012ilo.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 09:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=35uO0GsWL2SrXQdWpTFnMx1XSOqtt2fi2MnGJpcHACk=;
        b=BtJHMaHzJtSy6vkCAa+UAOe4MaZDJeM9iOv8WetRAwzZoum6eWdLaN2X2VHJL8Oc0b
         hoXu1K+UOLQ4d4kUGwcMI4y9ypvtBTa1uAl5XbzQ5yLgJFfkH1wSsqDZAhoGwyEIyfPK
         Q8OcL+Sqkovn55zhzGiLjlY/19rWqnJF3egkz0pfvEbG/F9NY9J1QigqIKsi/DMeGuu4
         yfwGeh1ahnCRcImk46xCQb6jV6fZuyj6a4Nn9Jn90EeOunQUZv/BjbuwhzkqW92yrpsL
         SpcUFKi8jBMOILmr0sFCTXYNtj0Sp2ZmQv/gSA6JiYvUFvfJPNvowXOfOtxeMq/I9t1e
         Prgw==
X-Gm-Message-State: AOAM533Tl5frTMHg4bYbwQ1uZmCqdL6D6JefJoh8pob2d+5mdff+/Iox
        AVzzxX4emNgP7YCEV/xglqqJlJxMes7GdPa5PmOILB1ha9+mWsymgI4uc6WNDS0SqRpmylS9pVL
        oGSo7ox8ZS3Z1rbYymsZ6qlQH
X-Received: by 2002:a5e:c20b:: with SMTP id v11mr16971493iop.197.1643823116537;
        Wed, 02 Feb 2022 09:31:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2yi185LCFnfKSJGv3qbM+JfuYG4eBGGUJQSqi0VdpRqTt9g1uDLptp1k3hBmFinbQ5DPjxQ==
X-Received: by 2002:a5e:c20b:: with SMTP id v11mr16971481iop.197.1643823116340;
        Wed, 02 Feb 2022 09:31:56 -0800 (PST)
Received: from [192.168.0.241] (135-23-175-80.cpe.pppoe.ca. [135.23.175.80])
        by smtp.gmail.com with ESMTPSA id q12sm5998731ilj.51.2022.02.02.09.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 09:31:55 -0800 (PST)
Message-ID: <ab2fabcf-b84d-6850-f25e-edc80a80662a@redhat.com>
Date:   Wed, 2 Feb 2022 12:31:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Aligning tcmalloc with glibc 2.35 rseq ABI
Content-Language: en-US
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
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
In-Reply-To: <87o83pxqh0.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 10:01, Florian Weimer via Libc-alpha wrote:
> * Mathieu Desnoyers:
> 
>> More to the point: is ptrdiff_t the correct type here ? I think so.
>> Do we want to revert the ABI and wait another 6 months before we
>> bring back rseq into glibc just for this ? I'm not sure this limitation
>> justifies it.
>>
>> So if there is a quick way to fix that before the official 2.35 release,
>> I'm all for it, otherwise I cannot say that __rseq_offset being an "int"
>> rather than a "ptrdiff_t" will make much real-life difference (unless
>> I'm proven wrong). But we will be stuck with this quirk forever.
> 
> I'm going to post a patch.  It's fairly small.

I'll review this as glibc release manager for glibc 2.35.

We'll get this right before I cut the release.

-- 
Cheers,
Carlos.

