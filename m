Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2034949B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359286AbiATImb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359228AbiATIma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642668149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKfas3q2Y/HkFD5WHzkZNGqSak03+yPlc1Wl3ABZ/MA=;
        b=CDewnc5iYAPsxsJFyi0B2y+obfa42x3ukZi8X3oFwlZVIw7WHpDGLz5NaAc3LYKmt7kHCv
        U0oCJv5zyI5NsGYuzfLsaHbo/uaLHUS9tvAssGF4W2jVkW4PTDJhd6vCfGVe7TS8XM2WcR
        pVcv66GsOgkOX/QXdOezSsElg45XZxg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-8_T12OoxNeWnmb74iwQMBA-1; Thu, 20 Jan 2022 03:42:26 -0500
X-MC-Unique: 8_T12OoxNeWnmb74iwQMBA-1
Received: by mail-ed1-f72.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso5299779edw.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=XKfas3q2Y/HkFD5WHzkZNGqSak03+yPlc1Wl3ABZ/MA=;
        b=6eNBAff8popWAr7gRO5+LMblO0wbevvQOax6T80PD6oQZ4nXapTnL2GLIAijp/WuB8
         +20DusWXOoap/I7wYj9P+CLqRVen2GwJKs1PrCzlxjMbd/BHdDSiWx9dku9piX7u5g/9
         6sGoVXJ3ouzcpVPl2fWI7GVJIF0VXQypN/UTFwkKccQPUkpgg5q8gWW1ycMFoWSuDKtH
         SWSzVQxbf9+/VH953kOMvAnRChPButG0LQ0gtur4LLyTI7IFu4nPJ1YiGHVqVKiMJ3jA
         QcL+gqPCqr+Nzo4ggqYnCTDS84sTbRxgJ9q0sk003QXfGlhQXClWnDp3V8KYZQfHjric
         OIuw==
X-Gm-Message-State: AOAM532FEJ3C0B78ETV3sed1lL921nOELNyGmmYgyw6ClnWx37naa43C
        Wa/khNnRTr/9FzYW7dwUvj44hft3j9GnYYEw4URh4S7h/xVp62HMJEeu3MxAUmNFZb+vebDJ72P
        TgSWvRnf6luTQPgJtOTQF96bM
X-Received: by 2002:aa7:db41:: with SMTP id n1mr34824562edt.307.1642668145197;
        Thu, 20 Jan 2022 00:42:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/ka5nYE9RQxAfTQqOQRXjh4/GUPE9pMARacpmyi60VpyoWD50I04ufeRwvZBALw0xRZjWhQ==
X-Received: by 2002:aa7:db41:: with SMTP id n1mr34824547edt.307.1642668144966;
        Thu, 20 Jan 2022 00:42:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id e15sm984952edy.46.2022.01.20.00.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 00:42:24 -0800 (PST)
Message-ID: <644356e5-2a85-fcea-2280-ff779ae8d38d@redhat.com>
Date:   Thu, 20 Jan 2022 09:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz> <YedXhpwURNTkW1Z3@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
In-Reply-To: <YedXhpwURNTkW1Z3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.22 01:12, Minchan Kim wrote:
> On Mon, Jan 17, 2022 at 02:47:06PM +0100, Michal Hocko wrote:
>> On Thu 30-12-21 11:36:27, Minchan Kim wrote:
>>> lru_cache_disable involves IPIs to drain pagevec of each core,
>>> which sometimes takes quite long time to complete depending
>>> on cpu's business, which makes allocation too slow up to
>>> sveral hundredth milliseconds. Furthermore, the repeated draining
>>> in the alloc_contig_range makes thing worse considering caller
>>> of alloc_contig_range usually tries multiple times in the loop.
>>>
>>> This patch makes the lru_cache_disable aware of the fact the
>>> pagevec was already disabled. With that, user of alloc_contig_range
>>> can disable the lru cache in advance in their context during the
>>> repeated trial so they can avoid the multiple costly draining
>>> in cma allocation.
>>
>> Do you have any numbers on any improvements?
> 
> The LRU draining consumed above 50% overhead for the 20M CMA alloc.
> 
>>
>> Now to the change. I do not like this much to be honest. LRU cache
>> disabling is a complex synchronization scheme implemented in
>> __lru_add_drain_all now you are stacking another level on top of that.
>>
>> More fundamentally though. I am not sure I understand the problem TBH.
> 
> The problem is that kinds of IPI using normal prority workqueue to drain
> takes much time depending on the system CPU business.
> 
>> What prevents you from calling lru_cache_disable at the cma level in the
>> first place?
> 
> You meant moving the call from alloc_contig_range to caller layer?
> So, virtio_mem_fake_online, too? It could and make sense from
> performance perspective since upper layer usually calls the
> alloc_contig_range multiple times on retrial loop.
> 

^ I actually do have something like that on my TODO list.

The issue is that we have demanding requirements for
alloc_contig_range(), discussed in the past for CMA bulk allocations:

(1) Fast, unreliable allocations

Fail fast and let caller continue with next allocation instead of
retrying. Try to not degrade system performance.

(2) Slow, reliable allocations

Retry as good as possible. Degrading system performance (e.g., disabling
lru) is acceptable.


virtio-mem is usually (2), although there could be some use cases where
we first want to try (1) -- unplug as much memory as we can fast -- to
then fallback to (2) -- unplug what remains.

CMA bulk allocations are (1). "Ordinary" CMA is mostly (2) I'd assume.

-- 
Thanks,

David / dhildenb

