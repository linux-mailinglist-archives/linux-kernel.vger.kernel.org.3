Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAA4E453B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiCVRi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiCVRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C860506FD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647970646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XRQWPJTa2nAm0XTHwZnMEHTKHif4VV7vwzt+VcrTSk=;
        b=WJ2zbHwP64smN5daibrjbs1YF9MdCUKYZXuXI1lyox5N0zfdHLoFQ3+O6GvKqeC3hA4hqe
        OQ4cU9oFpjYkJJQeOhl/IOdE9WEMtaDinnYMeWYD1aiPdBzGGVfj8lhvAqywiJmRpXnglp
        i4z8oDQShkA1KxhY+TOliTGYkvVLc38=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-A0e0tYQ7NpOv-u0M9dblTQ-1; Tue, 22 Mar 2022 13:37:24 -0400
X-MC-Unique: A0e0tYQ7NpOv-u0M9dblTQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BA521029A87;
        Tue, 22 Mar 2022 17:37:24 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EE5D4029C6;
        Tue, 22 Mar 2022 17:37:24 +0000 (UTC)
Message-ID: <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
Date:   Tue, 22 Mar 2022 13:37:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] f2fs for 5.18
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 13:22, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 1:39 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>> In this cycle, f2fs has some performance improvements for Android workloads such
>> as using read-unfair rwsems [...]
> I've pulled this, but that read-unfair rwsem code looks incredibly
> dodgy. Doing your own locking is always a bad sign, and it ahs
> traditionally come back to bite us pretty much every time. At least it
> uses real lock primitives, just in a really odd way.
>
> The whole notion of making an rwsem unfair to readers sounds really
> really odd.  I mean, the whole and only _point_ of an rwsem is to
> allow concurrent readers, and traditionally if it's unfair it's unfair
> to _writers_ because that tends to be better for throughput (but
> unfairness can cause horrible latency).
>
> So it smells like there's something bad going on in f2fs.
>
> That said, I'm adding Waiman to the cc here in case he would have
> ideas at least for a cleaner interface. Our rw_semaphores are
> explicitly trying to be fair, because unfairness (the other way) was
> such a big problem.
>
> I'm wondering it the optimistic read lock stealing is bothering f2fs?

I don't believe it is the optimistic read lock stealing code that is 
bothering f2fs.

AFAICS, the read-unfair rwsem code is created to resolve a potential 
lock starvation problem that they found on linux-5.10.y stable tree. I 
believe I have fixed that in the v5.11 kernel, see commit 2f06f702925 
("locking/rwsem: Prevent potential lock starvation"). However that 
commit is not in the stable tree. In fact, I have moved forward and 
taken out reader optimistic spinning but added just optimistic lock 
stealing instead. I believe the problem would have solved by including 
that patch series in their build. I haven't gotten any response as to 
whether they had tested this or not.

Apparently they prefer to upstream this stop-gap solution.

Cheers,
Longman

