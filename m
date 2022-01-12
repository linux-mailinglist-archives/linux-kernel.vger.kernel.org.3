Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D190748C6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348043AbiALPIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243634AbiALPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642000108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIsaeiGuSCkVHBbiFSlgQvB16Jlw+ZXtL+xJeRxkUSY=;
        b=dAx8CnXlBqVkWRt+WJ4VnFqnmB9zrc3RwsNQT4U58RDxtP4qUabyxpqxhzLagphmV5+sv3
        v5KhqXIDGHerE9A5/M6MiV7u6kHVMR4dAjTxEVg2+C86/bEjBM3/TYeUMWgEaEXyuVLDK6
        SvNgLlH4skwrOCI1mqTdFcFpRCO2DUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-bpTCFuRDMDGM_PFejjfqQw-1; Wed, 12 Jan 2022 10:08:26 -0500
X-MC-Unique: bpTCFuRDMDGM_PFejjfqQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 640B4801B0C;
        Wed, 12 Jan 2022 15:08:25 +0000 (UTC)
Received: from [10.22.10.195] (unknown [10.22.10.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03B4279A29;
        Wed, 12 Jan 2022 15:08:18 +0000 (UTC)
Message-ID: <fd02584d-03d7-f27b-c11c-6ed1f212f03c@redhat.com>
Date:   Wed, 12 Jan 2022 10:08:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Tim Murray <timmurray@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
 <9efbbcb7-29cd-a8ab-0632-01986edc862f@redhat.com>
 <CAEe=Sx=C8e7=A6ziy8dYC+FvkWvVYZ+o=XMCP_4vX0efsUPT4Q@mail.gmail.com>
 <86891228-9c91-09f1-0e2d-0a3392649d52@redhat.com>
 <Yd25SWaqEDSpR1vO@google.com>
 <4a2352a9-42b4-56cd-423a-825faffcd801@redhat.com>
 <Yd4f49lhnC7+vvAm@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yd4f49lhnC7+vvAm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 19:25, Jaegeuk Kim wrote:
> On 01/11, Waiman Long wrote:
>>
>> v5.10 kernel still have reader optimistic spinning enabled in rwsem which
>> may have worsen the writer wait time. Could you try with a more up-to-date
>> kernel or backport the relevant rwsem patches into your test kernel to see
>> how much it can help?
> We're using https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10.
> By any chance, may I ask which upstream patches we need to backport?
>
I am referring to the following commits:

617f3ef95177 locking/rwsem: Remove reader optimistic spinning
1a728dff855a locking/rwsem: Enable reader optimistic lock stealing
2f06f702925b locking/rwsem: Prevent potential lock starvation
c8fe8b056438 locking/rwsem: Pass the current atomic count to 
rwsem_down_read_slowpath()

To apply cleanly on top of 5.10.y, you will also need the followings:

c995e638ccbb locking/rwsem: Fold __down_{read,write}*()
285c61aedf6b locking/rwsem: Introduce rwsem_write_trylock()
3379116a0ca9 locking/rwsem: Better collate rwsem_read_trylock()

Reading the commit log of 2f06f702925b ("locking/rwsem: Prevent 
potential lock starvation"), I realize that writer lock starvation is 
possible in the f2fs case. That can explain why there was a worst case 
lock wait time of 9.7s.

I believe that you will see a big improvement by applying those upstream 
commits. In hindsight, I think I should have put a "Fixes" tag in that 
commit.

>>
>>>> Anyway, AFAICS, this patch keeps readers out of the rwsem wait queue and so
>>>> only writers can go into it. We can make an unfair rwsem to give preference
>>>> to writers in the wait queue and wake up readers only if there is no more
>>>> writers in the wait queue or even in the optimistic spinning queue. That
>>>> should achieve the same effect as this patch.
>>> Can we get a patch for the variant to test a bit? Meanwhile, I think we can
>>> merge this patch to add a wraper first and switches to it later?
>> Give me a week or so and I can make a RFC patch to support unfair rwsem for
>> you to try out. You do need to try it on the latest kernel, though.
> Thank you so much. My thought flow is applying this in f2fs for all the old
> kernels shipped in Android devices. Then, we can try to backport upstream
> rwsem patches and yours to switch finally. Let me know if you have any concern.

Assuming that Tr is the worst case reader lock hold time with a single 
writer, I believe the worst case writer lock wait time should be about 
2*Tr with the above commits applied. Introducing a unfair rwsem option 
will reduce that to just Tr. So try this out by applying the above 
upstream commits to see if they can meet your requirement as you may not 
really need an unfair rwsem option.

Cheers,
Longman

