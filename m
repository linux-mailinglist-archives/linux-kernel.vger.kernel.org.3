Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF0467A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381886AbhLCPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381883AbhLCPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638546562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wn/B+NRo5r0JBN9o4MkIX7l2zDFt6F/saJZ6BQL4N2U=;
        b=iz545Ge+39Y311hGLbP0VYhWkbZ82f0+pES8iYLXFB+l3b+FAlyAFK1BHATebzM5J3AmZX
        Y0D2EWr634W93GG0WTDnNrXAxfwBhfkc27ErwdWlcfc/qr/x6Z6+pQNA9wg7+boS3zk5th
        4zMUmcAq6KP80BB/+CtCRpYMXOhkt+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-HOKEf28RNnitHRFnrAW8XA-1; Fri, 03 Dec 2021 10:49:20 -0500
X-MC-Unique: HOKEf28RNnitHRFnrAW8XA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2898881CCBA;
        Fri,  3 Dec 2021 15:49:19 +0000 (UTC)
Received: from [10.22.32.36] (unknown [10.22.32.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10ABE5DAA5;
        Fri,  3 Dec 2021 15:49:17 +0000 (UTC)
Message-ID: <7961d0f7-d1e4-d631-5806-58607e50279d@redhat.com>
Date:   Fri, 3 Dec 2021 10:49:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/2] locking: Fix racy reads of owner->on_cpu
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20211203075935.136808-1-wangkefeng.wang@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211203075935.136808-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 02:59, Kefeng Wang wrote:
> v2:
> - adding owner_on_cpu() refactor, shared by mutex/rtmutex/rwsem
>
> v1: https://lore.kernel.org/all/20211202101238.33546-1-elver@google.com/
>
> Kefeng Wang (1):
>    locking: Make owner_on_cpu() into <linux/sched.h>
>
> Marco Elver (1):
>    locking: Mark racy reads of owner->on_cpu
>
>   include/linux/sched.h    |  9 +++++++++
>   kernel/locking/mutex.c   | 11 ++---------
>   kernel/locking/rtmutex.c |  5 ++---
>   kernel/locking/rwsem.c   |  9 ---------
>   4 files changed, 13 insertions(+), 21 deletions(-)
>
LGTM

Acked-by: Waiman Long <longman@redhat.com>

