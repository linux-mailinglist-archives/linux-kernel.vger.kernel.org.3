Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41577489FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbiAJSzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242539AbiAJSzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641840944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYyRRXLaDdfZNoFNwWil/ubp0G98nyL4pk/ZhirIiec=;
        b=NgAP1BvUziL7KK5xyuEKccaSeENWCe/pEXP2kvznPtrGI1/M+WCgXC7T2pSVI1VGBTDB0b
        w6T/yBl+rbJmePV+1wmZMDGs7HUSELCvi/nXGXJnKxNNnPUTAJ1tDm2c7STajLUlqUtVCd
        tRKXG1KniFZWNSQut5hTwce78OTmIlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-zN2sO1w4MN2h1t1oAxhBQA-1; Mon, 10 Jan 2022 13:55:38 -0500
X-MC-Unique: zN2sO1w4MN2h1t1oAxhBQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E3A1023F4D;
        Mon, 10 Jan 2022 18:55:37 +0000 (UTC)
Received: from [10.22.8.96] (unknown [10.22.8.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 481018276C;
        Mon, 10 Jan 2022 18:55:36 +0000 (UTC)
Message-ID: <8ef383e2-b34c-6fae-7f60-ae507303b5bd@redhat.com>
Date:   Mon, 10 Jan 2022 13:55:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Tim Murray <timmurray@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <Ydx+u9YpzS8AZHrl@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Ydx+u9YpzS8AZHrl@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/22 13:45, Peter Zijlstra wrote:
> On Mon, Jan 10, 2022 at 11:18:27AM -0500, Waiman Long wrote:
>> On 1/10/22 03:05, Christoph Hellwig wrote:
>>> Adding the locking primitive maintainers to this patch adding open coded
>>> locking primitives..
>>>
>>> On Sat, Jan 08, 2022 at 08:46:17AM -0800, Jaegeuk Kim wrote:
>>>> From: Tim Murray <timmurray@google.com>
>>>>
>>>> f2fs rw_semaphores work better if writers can starve readers,
>>>> especially for the checkpoint thread, because writers are strictly
>>>> more important than reader threads. This prevents significant priority
>>>> inversion between low-priority readers that blocked while trying to
>>>> acquire the read lock and a second acquisition of the write lock that
>>>> might be blocking high priority work.
>>>>
>>>> Signed-off-by: Tim Murray <timmurray@google.com>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> We could certainly implement a down_read() variant (e.g.
>> down_read_lowprio()) with its own slowpath function to do this within the
>> rwsem code as long as there is a good use-case for this kind of
>> functionality.
> I think _unfair() or something along those lines is a *much* better
> naming that _lowprio(). Consider a RT task ending up calling _lowprio().
> That just doesn't make conceptual sense.
I am fine with the _unfair() name as I am not good at naming:-)
>
> And then there's the lockdep angle; the thing being unfair will lead to
> scenarios where lockdep will give a false positive because it expects
> the r-w-r order to block things, which won't happen. A position needs to
> be taken a-prioriy.

Right, we may need to twist lockdep to match the new behavior if we are 
going to provide such a functionality.

Cheers,
Longman

