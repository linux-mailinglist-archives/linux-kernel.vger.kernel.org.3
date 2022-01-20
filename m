Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292C5494FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiATOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229657AbiATOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642688143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XScZOTdHK9NR/qaohb7b7v22at67z4wlXzfCulfCEig=;
        b=GpJ4Lt/sJigYkbqK54W9eJJ2iEkWDYOTNgIInIqxD9NVPBq53OjU3Yt7xZzelXRPh2HwEs
        LLdWrfXTmIJCVdujU7olV16AkWFQoiaS3U7UuuPGQC4DVKHecQeR2QgJ0LqO3sxOhsvJuA
        DM3TTBPE1Cry4n0EebmGGPtZzh+yH0Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-2x83DMxcMCy4akKamitIIA-1; Thu, 20 Jan 2022 09:15:40 -0500
X-MC-Unique: 2x83DMxcMCy4akKamitIIA-1
Received: by mail-wm1-f69.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so6911783wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=XScZOTdHK9NR/qaohb7b7v22at67z4wlXzfCulfCEig=;
        b=REV7WmSf61/shUyDSUfeRr4KAvIxXFeJFiuxwaZ9/rCSv3r6eyKj2a9riZErtDo5PF
         rcy79p8vw5eSUlwu3SZ2fTYqFVAXb5gn4zyVCBOqAo9O8Tpj+N8trKHu5BO3UogDwmOy
         XwtYG55dF0PlWkGz+DitTOcW1LlNfmSi/pks3kt7TpJDmFebBQcULav+/nxGYXVuGXYv
         wIquGQi2aTSKEl76zn2BjgsKCAAutLEkWt7l6MHJMr9CrhjSK/o/Z9DIBAHwx/xOqA8H
         /epHgoK798VIoDzBNr02dpPrGPwJmHOwnt8rgqBgZrOux6/50aYG9zZ/J/SFmPktTYQC
         Y0+w==
X-Gm-Message-State: AOAM530WUNGvwYB69rkkOPqN5nvnW3p3VbCK+xcy4cvOAsxtBDhTQbjI
        vqr4ieybb/vYO/Y2waEfGf5R+DaVosfFtYTxxv95HsF2Y4vM96tBRiX3XoYhhlcsRfm1jksYXK3
        jk570OH8zND51meFGdW5rIkIQ
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr34803975wrc.632.1642688139131;
        Thu, 20 Jan 2022 06:15:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPwZ3koqXNPZsFK96gf9YtWGNPxY/0Ou3ZrfC1XR3G0x0Sq77s2w0+jl4nQXTyO6wEvSbYXg==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr34803954wrc.632.1642688138923;
        Thu, 20 Jan 2022 06:15:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id y8sm3699696wrd.8.2022.01.20.06.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:15:38 -0800 (PST)
Message-ID: <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
Date:   Thu, 20 Jan 2022 15:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "zhangliang (AG)" <zhangliang5@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.22 14:31, zhangliang (AG) wrote:
> Sure, I will do that :)

I'm polishing up / testing the patches and might send something out for discussion shortly.
Just a note that on my branch was a version with a wrong condition that should have been fixed now.

I am still thinking about PTE mapped THP. For these, we'll always
have page_count() > 1, essentially corresponding to the number of still-mapped sub-pages.

So if we end up with a R/O mapped part of a THP, we'll always have to COW and cannot reuse ever,
although it's really just a single process mapping the THP via PTEs.

One approach would be to scan the currently locked page table for entries mapping
this same page. If page_count() corresponds to that value, we know that only we are
mapping the THP and there are no additional references. That would be a special case
if we find an anon THP in do_wp_page(). Hm.

-- 
Thanks,

David / dhildenb

