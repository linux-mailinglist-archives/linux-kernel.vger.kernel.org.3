Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF62475E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbhLOQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbhLOQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639587532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muCmOAWvr5CQnLclHX0MhSQxoOgFUPCsAa/pyphHI1Y=;
        b=eCAkVMlnocTXd01vBbDNdbhVE4+jZuX40KM+o+2QoBHFVQgqEuikdbX7d6PTcb7z6aCwUW
        cnbI2e6oZXCi/tunFzne9RXObHQSLDD71iWe9Lc4vv2Nx2JUkKmMMZOIoq0SXQKMZCaXbJ
        G16eDLFNo0T9kuNFnkZJ16hfDZj4j3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-XaZxwaWxO3qkA6d1KfTK0w-1; Wed, 15 Dec 2021 11:58:49 -0500
X-MC-Unique: XaZxwaWxO3qkA6d1KfTK0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C053D2F31;
        Wed, 15 Dec 2021 16:58:47 +0000 (UTC)
Received: from [10.22.10.54] (unknown [10.22.10.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6368C57CD2;
        Wed, 15 Dec 2021 16:58:46 +0000 (UTC)
Message-ID: <b50b7c01-c4fc-87bd-f5d9-80e6438cf670@redhat.com>
Date:   Wed, 15 Dec 2021 11:58:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH-next v3] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211214144412.447035-1-longman@redhat.com>
 <20211215043657.ngmxlk6rgc2ysbmz@offworld>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211215043657.ngmxlk6rgc2ysbmz@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/21 23:36, Davidlohr Bueso wrote:
> On Tue, 14 Dec 2021, Waiman Long wrote:
>
>> @@ -2189,7 +2194,7 @@ static void drain_local_stock(struct 
>> work_struct *dummy)
>>      * drain_stock races is that we always operate on local CPU stock
>>      * here with IRQ disabled
>>      */
>> -    local_irq_save(flags);
>> +    local_lock_irqsave(&memcg_stock.lock, flags);
>>
>>     stock = this_cpu_ptr(&memcg_stock);
>>     drain_obj_stock(&stock->irq_obj);
>
> So here there is still the problem that you can end up taking sleeping 
> locks
> with irqs disabled via obj_cgroup_put() >> obj_cgroup_release() - ie: the
> percpu_ref_switch_lock and css_set_lock. It had occurred to me to promote
> the former to a raw spinlock, but doubt we can get away with the latter.

Yes, it is tricky to avoid all these. One possibility to to delay 
obj_cgroup_release() through RCU. However, this is outside the scope of 
this patch.

Cheers,
Longman

