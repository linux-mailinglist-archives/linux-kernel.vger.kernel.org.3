Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6942E4C87E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiCAJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiCAJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C722885BC4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646127059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBY88ztZKva4Dfvhre7a4FFaoq99+j707lGLFNj1qsE=;
        b=hveHPxCLpWQTStfeBEOIz8ES9GayJXFkAMvoqHF6ZKcfls4HfcUfrCUHKL2ZYsuQUqPNp0
        FtkCmY2mLdgSJN83iz5F9PJE6T0oZeERBT4Ax6B1bMqGn9oxgw4wGHt4f1i5cgq3tcBKaW
        TSdBL/WnZ007umT5NUCBvDkMhtam3Nc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-n1-8YwsCMueSiDf5HPu4IQ-1; Tue, 01 Mar 2022 04:30:58 -0500
X-MC-Unique: n1-8YwsCMueSiDf5HPu4IQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5-20020a05600c25c500b00381822a6656so259442wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 01:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QBY88ztZKva4Dfvhre7a4FFaoq99+j707lGLFNj1qsE=;
        b=jNU7REoYedHK5CTFQPDlPtx0Uz+Ryq9P6gS5T3p8dqrsOFFxcFBzYVDIRDTfeByVer
         wuyL1Y1w89YmPZRMZRe2nFmAjfr/Fm9l3g9CZAR69SwFVlpuVygco9uolnqsg/kRQQvw
         OeZD9utUUPBRCFnyqTqpeBjMB7eCTiUKCAK0YK37Yv03rCsJQvffAtrvcx9H8mNJYtoC
         BaaPiAZE+UgeAUj39j7NHr0ieU2b2EEGyX4swtwIv3EgJ4FUvGx3F1tB3coZF8T26NSt
         emYWD9zkYUrtZStX1simpPu9/y+gxOx57KGF9m/ai6uUoQ+K9/beXr+hcy9Wh/NSxyRk
         CpSg==
X-Gm-Message-State: AOAM531zHP097k5Blca9c7ddqX64mEMIqHwIQw+4V8C1D9Xi3nJqSenp
        eskoALWy+83AzDWDgOqzrPGKFhlFtITsPVA/vbcOxYTgWrktTp2cUWTO5SXDKHScwCWX6IvDEe8
        /kjJ+13RbRCim2GycFs7uI6mK
X-Received: by 2002:a1c:a382:0:b0:381:cfd:5564 with SMTP id m124-20020a1ca382000000b003810cfd5564mr16055518wme.103.1646127057606;
        Tue, 01 Mar 2022 01:30:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxZ01JTKa85lEAtW7rkRzMrJlA0XsQxMME6SiPZ1SwraatSqHyEOf6kIqynfEITUDTCDJILg==
X-Received: by 2002:a1c:a382:0:b0:381:cfd:5564 with SMTP id m124-20020a1ca382000000b003810cfd5564mr16055505wme.103.1646127057353;
        Tue, 01 Mar 2022 01:30:57 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id j7-20020adfd207000000b001edc209e70asm12630321wrh.71.2022.03.01.01.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:30:56 -0800 (PST)
Message-ID: <e0ff6c64-7ab0-6300-7427-5a3e4364661e@redhat.com>
Date:   Tue, 1 Mar 2022 10:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/7] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225085025.3052894-2-jhubbard@nvidia.com>
 <6ba088ae-4f84-6cd9-cbcc-bbc6b9547f04@redhat.com>
 <36300717-48b2-79ec-a97b-386e36bbd2a6@nvidia.com>
 <d3973adb-9403-5b64-23ec-d6800d67e538@redhat.com>
 <f531a5be-9698-eb08-f10d-75adc2028483@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f531a5be-9698-eb08-f10d-75adc2028483@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> That might be problematic and possibly the wrong approach, depending on
>> *what* we're actually pinning and what we're intending to do with that.
>>
>> My assumption would have been that this interface is to duplicate a pin
> 
> I see that I need to put more documentation here, so people don't have
> to assume things... :)
> 

Yes, please :)

>> on a page, which would be perfectly fine, because the page actually saw
>> a FOLL_PIN previously.
>>
>> We're taking a pin on a page that we haven't obtained via FOLL_PIN if I
>> understand correctly. Which raises the questions, how do we end up with
>> the pages here, and what are we doing to do with them (use them like we
>> obtained them via FOLL_PIN?)?
>>
>>
>> If it's converting FOLL_GET -> FOLL_PIN manually, then we're bypassing
>> FOLL_PIN special handling in GUP code:
>>
>> page = get_user_pages(FOLL_GET)
>> pin_user_page(page)
>> put_page(page)
> 
> No, that's not where this is going at all. The idea, which  I now see
> needs better documentation, is to handle file-backed pages. Only.
> 
> We're not converting from one type to another, nor are we doubling up.
> We're just keeping the pin type consistent so that the vast block-
> processing machinery can take pages in and handle them, then release
> them at the end with bio_release_pages(), which will call
> unpin_user_pages().
> 

Ah, okay, that makes sense. Glad to hear that we're intending to use
this with !anon pages only.

>>
>>
>> For anonymous pages, we'll bail out for example once we have
>>
>> https://lkml.kernel.org/r/20220224122614.94921-14-david@redhat.com
>>
>> Because the conditions for pinned anonymous pages might no longer hold.
>>
>> If we won't call pin_user_page() on anonymous pages, it would be fine.
> 
> We won't, and in fact, I should add WARN_ON_ONCE(PageAnon(page)) to
> this function.

Exactly what I would have suggested,

> 
>> But then, I still wonder how we come up the "struct page" here.
>>
> 
>  From the file system. For example, the NFS-direct and fuse conversions
> in the last patches show how that works.
> 
> Thanks for this feedback, this is very helpful.

Thanks for clarifying, John!

-- 
Thanks,

David / dhildenb

