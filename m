Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B44694A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbhLFLEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242087AbhLFLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638788453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dwcq98RgVgHt3sPXfv+5EmMidd2mYMpzpPhJTxKj+Pg=;
        b=i/vmDjS5Io80DhudHKNuPrGvoHP7bKRIp0QRzJ5yi+kpznlwiBrZdPKQ3qUyOIfyIyLzgr
        8jWD0BqeS9D8VA9r4N7IuKYravXwoK+mNPyNN0+OZxyQQoHMds5jPqWQ7TSoSWY0Ed4nXe
        qyPhi8jpMz+5lJAa+RoFUBIfActgQw8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-431--Q4AcKG8MteFqt_El6FwpQ-1; Mon, 06 Dec 2021 06:00:52 -0500
X-MC-Unique: -Q4AcKG8MteFqt_El6FwpQ-1
Received: by mail-wr1-f72.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so1902488wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 03:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Dwcq98RgVgHt3sPXfv+5EmMidd2mYMpzpPhJTxKj+Pg=;
        b=gS0LA2ZFGRJHbaJ0JVsOeKVHbUMoOvDYmyCQ33Pyftu0mb3AHu7gihyvgmzNVWOvVY
         BKiSIvBZNqtj8Rc4MP+PCldHwh+nYOqDOvOsfhmXC9z8reug8Ahuc64AUaEW7r5k2Ws4
         Ztd9ucuLG7AMkY8cprBDwggfjQlmNdOA9f5LYdxxWVz8Bg9N1WRkeGXkly8M5va988AJ
         s4N+Xs2UZkG5xodHjIHg5lAf320MOCLeT4fEwnSPf21L2a/BYS+1FMcUxN8rXJsxFQHT
         HJrTmP7WHYu3hycHxYiRTOWalu9r/kLblHks89ArmCX+nhbZMv/GztAjkbsfDT6H/P93
         YadQ==
X-Gm-Message-State: AOAM533IqyG+tBeYVDi0Wc1zPHP/9IiCQnSVNhlKwYIv2Xh1HM4oH37E
        Uzyj7hK1OPIZLeuXazz1L4FfFGW36DO33S8qE4gk0M8Ji+89lB1Tm6h5neDjU7JUEc5u/1sDl6x
        r0gdhPdG6DA0HhS17fxrWisT6
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr42576574wrw.621.1638788451322;
        Mon, 06 Dec 2021 03:00:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsD+3h0MN8m0YP1di4DxA55EhaG9gGCvg9uplghrSeU3XnPWpeO4392iymq3y9VcgNqgQxrA==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr42576548wrw.621.1638788451146;
        Mon, 06 Dec 2021 03:00:51 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id 138sm13519081wma.17.2021.12.06.03.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 03:00:50 -0800 (PST)
Message-ID: <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
Date:   Mon, 6 Dec 2021 12:00:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
In-Reply-To: <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.21 11:54, Michal Hocko wrote:
> On Mon 06-12-21 11:45:54, David Hildenbrand wrote:
>>> This doesn't seen complete. Slab shrinkers are used in the reclaim
>>> context. Previously offline nodes could be onlined later and this would
>>> lead to NULL ptr because there is no hook to allocate new shrinker
>>> infos. This would be also really impractical because this would have to
>>> update all existing memcgs...
>>
>> Instead of going through the trouble of updating...
>>
>> ...  maybe just keep for_each_node() and check if the target node is
>> offline. If it's offline, just allocate from the first online node.
>> After all, we're not using __GFP_THISNODE, so there are no guarantees
>> either way ...
> 
> This looks like another way to paper over a deeper underlying problem
> IMHO. Fundamentally we have a problem that some pgdata are not allocated
> and that causes a lot of headache. Not to mention that node_online
> is just adding to a confusion because it doesn't really tell anything
> about the logical state of the node.
> 
> I think we really should get rid of this approach rather than play a
> whack-a-mole. We should really drop all notion of node_online and
> instead allocate pgdat for each possible node. Arch specific code should
> make sure that zone lists are properly initialized.
> 

I'm not sure if it's rally whack-a-mole really applies. It's just the
for_each_node_* calls that need love. In other cases, we shouldn't
really stumble over an offline node.

Someone deliberately decided to use "for_each_node()" instead of
for_each_online_node() without taking care of online vs. offline
semantics. That's just a BUG and needs fixing IMHO.

After all, we do need patches to backport, reworking pgdat init isn't
really something feasible for that I think. And I heard of PPC that can
hotplug thousands of nodes ...

-- 
Thanks,

David / dhildenb

