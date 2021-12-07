Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B077D46B89D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhLGKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:19:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhLGKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638872138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOdfiEUFnQ8oq2ledal/kWkSxPZYiIBUvxwXeK8aWUA=;
        b=HjaNXY5ud34bHw0TBt0HBqDiZ7Tc85sf0+eSVmzzRtJ9XIWisjxhJNqLwdkvtYSdrPxddM
        5JVnIP8FBzTLi23AeXR3elGsymd/J9Mp0qISv8spM98s+fpWOOv2/aE5HB9AUHUCvh/r1T
        IvF61qxX07gDv7S143wXyBan3YlR4V8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-P9Tjspe-P12OX_TvMISirQ-1; Tue, 07 Dec 2021 05:15:36 -0500
X-MC-Unique: P9Tjspe-P12OX_TvMISirQ-1
Received: by mail-wm1-f72.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so7494255wmg.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 02:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ZOdfiEUFnQ8oq2ledal/kWkSxPZYiIBUvxwXeK8aWUA=;
        b=yUHeMtS9vbDNwrQwppTk+t+0RBb44QV1XqK/oWA+vlAOS9sXZrJ7AwR1HG4z9THGDD
         bks/u1VanXY8qQfpeua/DJOXBm6+MCzEFs4RbIrphag0/3willBbUySSoSn8s9hj5/WQ
         wRXBRXeiHazUWcLAm2fox5Zjpgz6+q2LYjMcYq6tXZxOZ0rQ6hs9ZFSWUBOLkvY8ibgE
         ozI6M+hkk4RUIbbxjprlJ4anTUvDpfBoPX3hn0oI8lYDZaoOqUME4yyBrkwOBjCjHEpv
         dX7oot0qgZ1by2uSzpPBVfJjaKEZ68eEhYnYEmMowRKkW+vI+VUUCej2SzLhX23B3F4f
         qMPw==
X-Gm-Message-State: AOAM533np8aMhx09FZuEveGXJWrlH2Pz86VK8xPuf7eqCFQ91vsp7pxw
        NWCP4g1gDLJuk6x8RGIm17q/6G8Pvm0ERkvCz861VHU5lNgRledQBuhuzOJf34GJs2MGDvTCr1U
        XZvfxZuOot3boxmVg7a4vnVbU
X-Received: by 2002:adf:f444:: with SMTP id f4mr50062305wrp.538.1638872135194;
        Tue, 07 Dec 2021 02:15:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjRZw4P1L3VF7aNsoSNqPgbOYmZC4eaeb0kk2GB4Q6/89DHiu9q+me6oPZTwQdDuHUNivETg==
X-Received: by 2002:adf:f444:: with SMTP id f4mr50062285wrp.538.1638872135005;
        Tue, 07 Dec 2021 02:15:35 -0800 (PST)
Received: from [192.168.3.132] (p4ff23e57.dip0.t-ipconnect.de. [79.242.62.87])
        by smtp.gmail.com with ESMTPSA id j18sm2615766wmq.44.2021.12.07.02.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:15:34 -0800 (PST)
Message-ID: <0c5a157f-82cb-0ac8-9955-8f19469454bb@redhat.com>
Date:   Tue, 7 Dec 2021 11:15:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
 <CAHbLzko0UeNadswXEnwr6EtuKAZT4T-fnC5F7xnFcH4RbjhAiA@mail.gmail.com>
 <a48c16d6-07df-ff44-67e6-f0942672ec28@redhat.com>
 <CAHbLzkrfU3SQ8r4FyhumDHr02DSKd8oWbhwwVbBUHF7GCGY2Hg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
In-Reply-To: <CAHbLzkrfU3SQ8r4FyhumDHr02DSKd8oWbhwwVbBUHF7GCGY2Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Short term I tend to like [2], because it avoids having to mess with all
>> such instances to eventually get it right and the temporary overhead
>> until we have the code reworked should be really negligible ...
> 
> Thanks, David. Basically either option looks fine to me. But I'm a
> little bit concerned about [2]. It silently changes the node requested
> by the callers. It actually papers over potential bugs? And what if

Hi,

It's just a preferred node, so we do have a node fallback already via
the zonelist to other nodes for proper online nodes -- and would have
the proper node fallback when preallcoating all pgdat.

*Not* doing the fallback with a preferred node that is not online could
be considered a BUG instead.

Note that [2] was just a quick draft. We might have to do some minor
adjustments to handle __GFP_THISNODE properly.

But after all, we have:

VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));

in __alloc_pages_node() and __folio_alloc_node(). So it might not be
worth adjusting at all.

> the callers specify __GFP_THISNODE (I didn't search if such callers
> really exist in the current code)?
> 
> How's about a helper function, for example, called
> kvmalloc_best_node()? It does:
> 
> void * kvmalloc_best_node(unsigned long size, int flag, int nid)
> {
>     bool onlined = node_online(nid);
> 
>     WARN_ON_ONCE((flag & __GFP_THISNODE) && !onlined);
> 
>     if (!onlined)
>         nid = -1;
> 
>     return kvmalloc_node(size, GFP_xxx, nid);
> }

We still have to "fix" each and every affected for_each_node() ... code
until we have preallcoation of pgdat for all possible nodes.

-- 
Thanks,

David / dhildenb

