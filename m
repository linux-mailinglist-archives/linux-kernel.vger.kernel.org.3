Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD0448C3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353121AbiALMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353117AbiALMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641990308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xWgksL6bFpGhiY8GnHIJjFsUKx5kfO64Lt2XcltxSMk=;
        b=VU3pzOsZlSghR5YqTMTJ/hHs6a4HCKa0aHpYAvB5rGLEQia0H2LlkS6Citruw2fgDCI7//
        MOwpexEErT+9yUTwB6n2qn/Tv1sdfj7q/FvOW+fLEyp1v9nDJGwO/gSNYVG7tkQxfj8uBf
        XY9CjbmRbpZLyd7RcxQz6CVAsqp2WlE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-mJW0YoquNTGGY5Jc3wOF0A-1; Wed, 12 Jan 2022 07:25:07 -0500
X-MC-Unique: mJW0YoquNTGGY5Jc3wOF0A-1
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso2170673edw.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=xWgksL6bFpGhiY8GnHIJjFsUKx5kfO64Lt2XcltxSMk=;
        b=YB7mSFzJX0DuEH6Nd044/FZCB8EM3JTJLXOFHNruhRLOeZEHRRCn2lPRkrjBsPALUD
         LyUMLiJRL1++HjfHrq/ZCbIMt9y0QHAeecqgrkE2yuEJGZ3mVR+RIqCFHsprRCy1LXyy
         hTAi6GRp5+EmAW3G6Fg8pvWhVoJUsbhhVuNBcfAwfvwxMLsMnexj8jEYrWzcPrHvfeHX
         tki3Ldc+zjozJOS2u5nbX7+4HwMZLltbGAFJM29lXPTO4OOZRLkij0gCPdAvYjmWauNR
         mZiffXe3lfeA4lh+yuv7kgzlukSshQnbVn0H13YbTJ2Pcpq5kB6yXig1pFyoOY1/LUvm
         J1/w==
X-Gm-Message-State: AOAM5303bw2rLFNLVk0WANI3q7UI7RHTZCneXynz+UUTqeUSDxzOZYAj
        dNckSl0t1g0WKc17BTOWhd9cKerPylDoB7LOcbmmz0JkSVB0KST5AJkyPRrZrb5vk0ZUakwzSjL
        M3buRd6K1N/su0ZdgtnE6BuE9
X-Received: by 2002:a17:907:720f:: with SMTP id dr15mr7339376ejc.729.1641990306553;
        Wed, 12 Jan 2022 04:25:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqxWZY7TfzuBRT62moR2hjCiDFrckpFbnSxgt2c5ujzQ6k4qnDmvre7ffxzfYevGV/CcTIwg==
X-Received: by 2002:a17:907:720f:: with SMTP id dr15mr7339357ejc.729.1641990306254;
        Wed, 12 Jan 2022 04:25:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id gn36sm2897744ejc.29.2022.01.12.04.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 04:25:05 -0800 (PST)
Message-ID: <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
Date:   Wed, 12 Jan 2022 13:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC v2] mm: introduce page pin owner
In-Reply-To: <20211228175904.3739751-1-minchan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.12.21 18:59, Minchan Kim wrote:
> A Contiguous Memory Allocator(CMA) allocation can fail if any page
> within the requested range has an elevated refcount(a pinned page).
> 
> Debugging such failures is difficult, because the struct pages only
> show a combined refcount, and do not show the callstacks or
> backtraces of the code that acquired each refcount. So the source
> of the page pins remains a mystery, at the time of CMA failure.
> 
> In order to solve this without adding too much overhead, just do
> nothing most of the time, which is pretty low overhead. However,
> once a CMA failure occurs, then mark the page (this requires a
> pointer's worth of space in struct page, but it uses page extensions
> to get that), and start tracing the subsequent put_page() calls.
> As the program finishes up, each page pin will be undone, and
> traced with a backtrace. The programmer reads the trace output and
> sees the list of all page pinning code paths.
> 

It's worth noting that this is a pure debug feature, right?


I like the general approach, however, IMHO the current naming is a bit
sub-optimal and misleading. All you're doing is flagging pages that
should result in a tracepoint when unref'ed.

"page pinners" makes it somewhat sound like you're targeting FOLL_PIN,
not simply any references.

"owner" is misleading IMHO as well.


What about something like:

"mm: selective tracing of page reference holders on unref"

PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF

$whatever feature/user can then set the bit, for example, when migration
fails.

I somewhat dislike that it's implicitly activated by failed page
migration. At least the current naming doesn't reflect that.


> This will consume an additional 8 bytes per 4KB page, or an
> additional 0.2% of RAM. In addition to the storage space, it will
> have some performance cost, due to increasing the size of struct
> page so that it is greater than the cacheline size (or multiples
> thereof) of popular (x86, ...) CPUs.

I think I might be missing something. Aren't you simply reusing
&page_ext->flags ? I mean, the "overhead" is just ordinary page_ext
overhead ... and whee exactly are you changing "struct page" layout? Is
this description outdated?

> 
> The idea can apply every user of migrate_pages as well as CMA to
> know the reason why the page migration failed. To support it,
> the implementation takes "enum migrate_reason" string as filter
> of the tracepoint(see below).
> 

I wonder if we could achieve the same thing for debugging by

a) Tracing the PFN when migration fails
b) Tracing any unref of any PFN

User space can then combine both information to achieve the same result.
I assume one would need a big trace buffer, but maybe for a debug
feature good enough?


-- 
Thanks,

David / dhildenb

