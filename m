Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21A34C33E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiBXRmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiBXRlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E93961CF0A4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645724485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZU9kCOEHshly2VLC25A2iAx+V2sxN9EfZxvkNN9yrms=;
        b=Sv+5du1HlrLSQ0MR8fjy7IowDwcktupQcX/6rkTAD0QLeg1moYN9uAzW2/0AAP1jktrq5g
        jie5hJBiHTmGcHMMYrSK2mNd468f4LKcrdKzmmuWsxLYuxCYebCDiH6s/f+Ny4WrQ3HBYg
        XFey3NsR7IKR8xZOPzryH46PivfcfC4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-3gZhkTUIM0K2UwpFuKuGXg-1; Thu, 24 Feb 2022 12:41:23 -0500
X-MC-Unique: 3gZhkTUIM0K2UwpFuKuGXg-1
Received: by mail-wr1-f70.google.com with SMTP id m3-20020adfa3c3000000b001ea95eb48abso203614wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZU9kCOEHshly2VLC25A2iAx+V2sxN9EfZxvkNN9yrms=;
        b=a51Wd8bAtbQCw0mDLM3pVCdLxycAuez30Ayp/FmfbO5i+OMgba/m8mXig91MOcI6K3
         TUPpSuFeiv9w64D1pqXYDfd1bVIKjPvWSE436AVdRke8idZoK96+/wSTHg2PpGLQqdTF
         +l0wVI2KhoJ93gThzhtbWk69cEHrxkrzfA+xGz2r6i2jhgEs3UUI0cpnlwB5rnjQaNdz
         hAzstRyyICf5fbTtRO2K3OQpXOtsNllOkzZ/jL07pd5Cg0z5rHTOKJIDUMHuzz6a6jJ+
         3EOV3Q0gVzK/v5gfTHe7fvkeBgcEnLpV0AxY9zqNZqKHxomL+nJ1+SngchZfkxwqfQb/
         dMpg==
X-Gm-Message-State: AOAM531uygBJZFmEEUNGT6tiFIn40vJlzvI+0ALEuGLnK1LQzl5g7ocL
        KFDAgLuitb5RDB701qr/JwGFfVWHLwqCDfuBpwqeAYMCrL3/M298DvYFwUxYhmIB3J/pdBVsK/E
        EelhRaCsOcW5+w0JGhPvKN6ix
X-Received: by 2002:adf:f303:0:b0:1e7:aeab:ac6a with SMTP id i3-20020adff303000000b001e7aeabac6amr3174575wro.40.1645724482695;
        Thu, 24 Feb 2022 09:41:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoXj2qud3pWml5ibfeTWdxFb8Sfw0Iq1KADIMiB6CiEFIvJWGtEasuaviJonK9ozqG8TX6cw==
X-Received: by 2002:adf:f303:0:b0:1e7:aeab:ac6a with SMTP id i3-20020adff303000000b001e7aeabac6amr3174544wro.40.1645724482379;
        Thu, 24 Feb 2022 09:41:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4900:ccb0:e874:2bce:973b? (p200300cbc7074900ccb0e8742bce973b.dip0.t-ipconnect.de. [2003:cb:c707:4900:ccb0:e874:2bce:973b])
        by smtp.gmail.com with ESMTPSA id q17-20020adfc511000000b001edc0a8a8b6sm62431wrf.0.2022.02.24.09.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:41:21 -0800 (PST)
Message-ID: <064ba776-e6c6-a430-7d74-0b691123e2a9@redhat.com>
Date:   Thu, 24 Feb 2022 18:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC 05/13] mm/rmap: remove do_page_add_anon_rmap()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-6-david@redhat.com>
 <CAHk-=wh+NxEVxeKc_o1xyVsJAQNqpN1zyCHN96gPEK+DzXaeLw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wh+NxEVxeKc_o1xyVsJAQNqpN1zyCHN96gPEK+DzXaeLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.22 18:29, Linus Torvalds wrote:
> On Thu, Feb 24, 2022 at 4:29 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> ... and instead convert page_add_anon_rmap() to accept flags.
> 
> Can you fix the comment above the RMAP_xyz definitions? That one still says
> 
>   /* bitflags for do_page_add_anon_rmap() */
> 
> that tnow no longer exists.

Oh, yes sure.

> 
> Also, while this kind of code isn't unusual, I think it's still confusing:
> 
>> +               page_add_anon_rmap(page, vma, addr, 0);
> 
> because when reading that, at least I go "what does 0 mean? Is it a
> page offset, or what?"

Yes, I agree.

> 
> It might be a good idea to simply add a
> 
>   #define RMAP_PAGE 0x00
> 
> or something like that, just to have the callers all make it obvious
> that we're talking about that RMAP_xyz bits - even if some of them may
> be default.
> 
> (Then using an enum of a special type is something we do if we want to
> add extra clarity or sparse testing, I don't think there are enough
> users for that to make sense)
> 

Actually, I thought about doing it similarly to what I did in
page_alloc.c with fpi_t:

typedef int __bitwise fpi_t;

#define FPI_NONE		((__force fpi_t)0)


I can do something similar here.

-- 
Thanks,

David / dhildenb

