Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38E4B9120
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiBPTYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiBPTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0271291FAE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645039457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AsqS7+VmvWZcYN9LZSwD5nLjJsRjkPDbXjgKl7v7Go4=;
        b=Tlf6bFCZwLs84t71e4Mu9/PBoWedmbwRma3Ehk2CFjop34m+GOF5hwneE2ICwEmiLoeUpl
        b9zV9C8kSrfhg6nXjGqj3aj/BKBZVNAbzrZi3GnLso2H8vveV5hnxrb+nU/u1FDQs3T8f8
        dBkKVbL9riUe/2IrJfGx+AKUXz+UcxE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-dlfH-_8zM3W2rE4sg1ZmDg-1; Wed, 16 Feb 2022 14:24:15 -0500
X-MC-Unique: dlfH-_8zM3W2rE4sg1ZmDg-1
Received: by mail-ed1-f72.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso2150164edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=AsqS7+VmvWZcYN9LZSwD5nLjJsRjkPDbXjgKl7v7Go4=;
        b=fOYnhc3H0IOX8aL8oqp2x9gMhc2i6YVRS2ckTdNmPR8NB7008X1IDIXrET6dFfJE+a
         io99EhcBl6pEK8NG5js9rjr0MNb26Jhd1B9V78cCxDNADJeG8QB5BZrxcRT274YqebaD
         d0nZ7ourA3oKI8EeXZ75PpkbQKVsrPPfa+5ajpnegfzsYenWKeXOz/a13RLuDoSkkgCz
         is2b/wQEGegdG2WjYvDrN8W/MHq0K7Alfe4we4x4xda0GIFN/ecMpDBc1I4cKdOWd32O
         mZ6DRn5+2o6pR/2oBUZUvY37UKWbVxiqO0cqOGS/fEOLWUp9eFxp6JkLGILSirQb60t/
         XVBQ==
X-Gm-Message-State: AOAM532rau6Ea2PE4NC/RScCnHYG2BH3uLF8ovo6TfNuEtCfDjHg/txN
        bGSkp7CqPCDG4JeoTOS3r49CaKKnBrBH7sAzoI05LZnN2nW/O4DtsPKGV5PnT0ZXQ8xxHnuQVmn
        LeeWOtcFfCblzgIfPSoFzUcZ9
X-Received: by 2002:a05:6402:2753:b0:410:b9a4:399e with SMTP id z19-20020a056402275300b00410b9a4399emr4670784edd.187.1645039454664;
        Wed, 16 Feb 2022 11:24:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybomThG6iWBChnuKd2KiR+xifx00F8DOt/ReKiiZEgpvB3l6rMkzRx8hXMQJcqbQp/w4IK4Q==
X-Received: by 2002:a05:6402:2753:b0:410:b9a4:399e with SMTP id z19-20020a056402275300b00410b9a4399emr4670769edd.187.1645039454462;
        Wed, 16 Feb 2022 11:24:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:600:4ff7:25c:5aad:2711? (p200300cbc70b06004ff7025c5aad2711.dip0.t-ipconnect.de. [2003:cb:c70b:600:4ff7:25c:5aad:2711])
        by smtp.gmail.com with ESMTPSA id r6sm240566ejd.100.2022.02.16.11.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:24:14 -0800 (PST)
Message-ID: <39d17db6-0f8a-0e54-289b-85b9baf1e936@redhat.com>
Date:   Wed, 16 Feb 2022 20:24:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Xu <peterx@redhat.com>
References: <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1> <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1>
 <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
 <20200919000153.GZ8409@ziepe.ca> <20200921083505.GA5862@quack2.suse.cz>
 <20200921120301.GD8409@ziepe.ca>
 <CAFCwf10eNmwq2wD71xjUhqkvv5+_pJMR1nPug2RqNDcFT4H86Q@mail.gmail.com>
 <CAHk-=wgLk5xWj8v6mQXaWL0zWAf2cis8EpPkQUuEZ7K3LxVQHQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
In-Reply-To: <CAHk-=wgLk5xWj8v6mQXaWL0zWAf2cis8EpPkQUuEZ7K3LxVQHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.22 20:04, Linus Torvalds wrote:
> [ Added David Hildenbrand to the participants. David, see
> 
>     https://bugzilla.kernel.org/show_bug.cgi?id=215616
> 
>   for details ]
> 

Thanks for sharing.

> On Wed, Feb 16, 2022 at 8:59 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>>
>> All the details are in the bug, but the bottom line is that somehow,
>> this patch causes corruption when the numa balancing feature is
>> enabled AND we don't use process affinity AND we use GUP to pin pages
>> so our accelerator can DMA to/from system memory.
> 
> Hmm. I thought all the remaining issues were related to THP - and
> David Hildenbrand had a series to fix those up.


What I shared so far recently [1] was part 1 of my COW fixes to fix the
COW security issues -- missed COW. This fixes 1) of [2].

Part 2 is around fixing "wrong COW" for FOLL_PIN a.k.a. memory
corruption. That's essentially what PageAnonExclusive() will be all
about, making sure that we don't lose synchronicity between GUP and mm
due to a wrong COW. This will fix 3) of [2]

Part 3 is converting O_DIRECT to use FOLL_PIN instead of FOLL_GET to
similarly fix "wrong COW" for O_DIRECT. John is working on that. This
will fix 2) of [2].


> 
> The fact that it also shows up with numa balancing is a bit
> unfortunate, because I think that means that that patch series may not
> have caught that case.
> 
> That said - what does "we use GUP to pin pages" mean? Does it actually
> use the pinning logic, or just regular old GUP?

If it uses FOLL_PIN it might be handled by part 2, if it uses O_DIRECT
magic it might be covered by part 3. If neither of both, more work might
be needed to convert it to FOLL_PIN, as with the new COW logic we won't
be able to have the same guarantees for FOLL_GET as we'll have for
FOLL_PIN (which is a difference to our original plans to fix it all [3]).


[1] https://lkml.kernel.org/r/20220126095557.32392-1-david@redhat.com
[2]
https://lore.kernel.org/all/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com/
[3] https://lore.kernel.org/all/20211217113049.23850-1-david@redhat.com/T/#u

-- 
Thanks,

David / dhildenb

