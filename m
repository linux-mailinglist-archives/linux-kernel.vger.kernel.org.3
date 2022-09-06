Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA20B5AEF7C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiIFPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiIFPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B408B2E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662477138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GesI69YyBCVOELWdci2COwV5wfsC9CiwSBWxkans3kQ=;
        b=HlRT/qAUczR5l6rvM4K+ng6Oze0lBGwSjUHMLcXSNRCbMhiiVts0kCCPm+a4UsePeZcmOC
        tHDByUkgBLpvQQqXc5k7R4PqKPV/D4NECTmQirJ4vt3FRfNZVKDYaT12l+84TbEqp+Mn6T
        wcZLwQcYyoUYdDB5wfxadFqv55DpBpU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-ViJNUfFuPYm9BaikDtLg2w-1; Tue, 06 Sep 2022 09:57:32 -0400
X-MC-Unique: ViJNUfFuPYm9BaikDtLg2w-1
Received: by mail-wr1-f69.google.com with SMTP id u27-20020adfa19b000000b0022863c08ac4so1848437wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GesI69YyBCVOELWdci2COwV5wfsC9CiwSBWxkans3kQ=;
        b=6p+s/L/dfu3QhmnSK9ZMcYq3I6k9r/NyXDVDDXghshL86jNDw4woHTKbrMx6UNYr9P
         LJScrLFL6LIlf1dDCkVVB7lSVUyrHCAWCkziV+t/kjlEEJyNpBVNWdYmDTh8AbkwAREL
         MWm7/o1BeiaBMAHfjRMTt81r7bF48gSMvGZH8hA3FuWdYiR9eW7xasKVYVr9vx5Xo6qA
         ODqEWQWvFE3U8RE9sgXUJj3ObN5BsRsvwsJ36rAx9sETELS8gnOa+nmxMVwVLwz2MYiL
         Eur/QJuMPuMIEK3TcFN8CldrqyzC0kJs+nBDWpLTkVwvk2aclqYezOMTpbC/o+ybY9VV
         OQyg==
X-Gm-Message-State: ACgBeo38sEpYza/IkJn4CSvq4IGeDLhW4TLHU29EzdmRd1oq5K873Tti
        IA2eoaYWM6hDfe12N9u7S8LOPx4syTw9o/v3JoofWsuRuRgk6Q3PuhC+sVpMIwhHKCVSeoZTPmW
        AyoUa8k1aL5EMz2o6Mhzce2Qw
X-Received: by 2002:a5d:620f:0:b0:225:32fc:cea3 with SMTP id y15-20020a5d620f000000b0022532fccea3mr28879744wru.270.1662472651754;
        Tue, 06 Sep 2022 06:57:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7eSynrXPsi+KuH/gzENB5rhLBgeEcaH1gNRTh72DAT2eCUNGmvUgoO7mPK83bTeUzoRBEKiQ==
X-Received: by 2002:a5d:620f:0:b0:225:32fc:cea3 with SMTP id y15-20020a5d620f000000b0022532fccea3mr28879731wru.270.1662472651469;
        Tue, 06 Sep 2022 06:57:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003a2e92edeccsm22530563wmq.46.2022.09.06.06.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 06:57:30 -0700 (PDT)
Message-ID: <4516a349-49cb-fd7b-176a-f1a9479906d9@redhat.com>
Date:   Tue, 6 Sep 2022 15:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        peterx@redhat.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <YxdPi2E63aO0Dgyd@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YxdPi2E63aO0Dgyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.22 15:47, Jason Gunthorpe wrote:
> On Mon, Sep 05, 2022 at 09:59:47AM +0200, David Hildenbrand wrote:
> 
>>> That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
>>> whole lockless house of cards may fall apart if we try reading the
>>> page table values without READ_ONCE().
>>
>> I came to the conclusion that the implicit memory barrier when grabbing a
>> reference on the page is sufficient such that we don't need READ_ONCE here.
> 
> READ_ONCE is not about barriers or ordering, you still need the
> acquire inside the atomic to make the algorithm work.


While I don't disagree with what say is, I'll refer to 
Documentation/memory-barriers.txt "COMPILER BARRIER".

As discussed somewhere in this thread, if we already have an atomic RWM 
that implies a full ordering, it implies a compile barrier.


> 
> READ_ONCE primarily is a marker that the data being read is unstable
> and that the compiler must avoid all instability when reading it. eg
> in this case the compiler could insanely double read the value, even
> though the 'if' requires only a single read. This would result in
> corrupt calculation.

As we have a full memory barrier + compile barrier, the compiler might 
indeed do double reads and all that stuff. BUT, it has to re-read after 
we incremented the refcount, and IMHO that's the important part to 
detect the change.



-- 
Thanks,

David / dhildenb

