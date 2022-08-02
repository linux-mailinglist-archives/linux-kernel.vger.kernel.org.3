Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD8588314
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiHBUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiHBUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB2381928E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659471833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHWhRmPR1pZp1I/u9ioQ+8YdKH4+dcWOy4DQBKc/PhU=;
        b=DBuGvOYDkorLyR4nMMFN0QoEZ1DIuLdV6djo3rCe57+KSQ2VQci4FkkYMoNFMHwwaTcRO5
        dPspiBS8e2tWzYYHkoCepIXuEFrj5IcPeKSnw6U1f3R4WKwZQrSDRdI1mqg8bVX/JyXtk/
        CqH45PUlw0zRWZEW36FYmnO7ZLYLdOQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-XsVMKtFAP0exStLDO2p8Ag-1; Tue, 02 Aug 2022 16:23:52 -0400
X-MC-Unique: XsVMKtFAP0exStLDO2p8Ag-1
Received: by mail-wm1-f69.google.com with SMTP id i81-20020a1c3b54000000b003a4a76942ddso3810635wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=hHWhRmPR1pZp1I/u9ioQ+8YdKH4+dcWOy4DQBKc/PhU=;
        b=Nxogll39yIn2BuzFd3OGfj+8nBB4f2SNcOPXtpsqzg2quzO3QEQh6AxNaDK0HVRpwo
         6W0S4ZjclWBrbpuXSpIk6nPP0mNGEsFGczhKnlyl9eGtpZmUIds6m+PG1uO7MkGBAJVR
         a/v8GFAeWmzLS+fAuyoQNafPOhVqscuyVB1zTOxvPut7AqpLf4xroIVIpEqX+VmIH5lJ
         qsWBsi3i/JHCNzNEjhR8qnCjGbduALf5QHE0Mv4xo+U1Z5ZBUf+zqWLyTAeOU5ivlpJV
         H8J0dBT7/OESMgXDsvDoafNto61rFn4YouRbI55JA1/gZzHcsI46SrVMNgsYj54kAkVW
         OgvA==
X-Gm-Message-State: ACgBeo1wfmQ7la5RydRr5wfZdwxAgQWzQkjTOLzTh9774KPy6MbS3r1u
        Ld+2TPt7juBzS8TeJNqfQh1+oYfRThJndqEtsdawetbKR/l6IckInsPjCHqLAIGgtSks56w2bNl
        kEf4Yq/YJ0Ek6xWarJlP5s/2S
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id e14-20020a056000178e00b00220635feb13mr6818163wrg.634.1659471831314;
        Tue, 02 Aug 2022 13:23:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5vksWm/3+8rmd/sp3eh73T8iiQEcMgMRwpn/DJHIZzLLqst23rQ7ipqTx8/HuWW2AUJpX4aA==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id e14-20020a056000178e00b00220635feb13mr6818151wrg.634.1659471830994;
        Tue, 02 Aug 2022 13:23:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3800:8435:659e:f80:9b3d? (p200300cbc70738008435659e0f809b3d.dip0.t-ipconnect.de. [2003:cb:c707:3800:8435:659e:f80:9b3d])
        by smtp.gmail.com with ESMTPSA id bg26-20020a05600c3c9a00b003a3279b9037sm25789082wmb.16.2022.08.02.13.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 13:23:50 -0700 (PDT)
Message-ID: <24ffea6e-ca66-2b94-c682-48a42a655fd1@redhat.com>
Date:   Tue, 2 Aug 2022 22:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220729014041.21292-1-peterx@redhat.com>
 <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
 <YuhVJmSsgs4Q1bYJ@xz-m1.local>
 <49434bea-3862-1052-2993-8ccad985708b@redhat.com>
 <YumFs0jpCc/Mwjzf@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
In-Reply-To: <YumFs0jpCc/Mwjzf@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think we only care about x86_64?  Should other archs have the same
> issue as long as there's the hardware young bit?
> 
> Even without it, it'll affect page reclaim logic too, and that's also not
> x86 only.

Okay, reading the cover letter and looking at the code my understanding
was that x86-64 is the real focus.

>>
>>>
>>> Besides I actually have a question on the anon exclusive bit in the swap
>>> pte: since we have that anyway, why we need a specific migration type for
>>> anon exclusive pages?  Can it be simply read migration entries with anon
>>> exclusive bit set?
>>
>> Not before all arch support pte_swp_mkexclusive/pte_swp_exclusive/.
>>
>> As pte_swp_mkexclusive/pte_swp_exclusive/ only applies to actual swap
>> PTEs, you could even reuse that bit for migration entries and get at
>> alteast the most relevant 64bit architectures supported easily.
> 
> Yes, but I think having two mechanisms for the single problem can confuse
> people.
> 

It would be one bit with two different meanings depending on the swp type.

> IIUC the swap bit is already defined in major archs anyway, and since anon
> exclusive bit is best-effort (or am I wrong?..), I won't worry too much on

It kind-of is best effort, but the goal is to have all archs support it.

... just like the young bit here?

> archs outside x86/arm/ppc/s390 on having anon exclusive bit lost during
> migrations, because afaict the whole swap type of ANON_EXCLUSIVE_READ is
> only servicing that very minority.. which seems to be a pity to waste the

I have a big item on my todo list to support all, but I have different
priorities right now.

If there is no free bit, simply steal one from the offset ... which is
the same thing your approach would do, just in a different way, no?

> swp type on all archs even if the archs defined swp pte bits just for anon
> exclusive.

Why do we care? We walk about one type not one bit.

-- 
Thanks,

David / dhildenb

