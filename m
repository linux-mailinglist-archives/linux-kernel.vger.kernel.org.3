Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860DB4F9A42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiDHQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDHQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A86EE2C642
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649434414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RABOyYo670sPAWQ+PEuN77+r1YMjgpRyhVZuUCYWh68=;
        b=PNyu3Jtp9Os/ahfXBaAZ6gV/TnEfy27U50z2YbBdwcJ8xOBenGU5JS2kXufrL4vfEkhQ23
        I1xvBFdVxOU2wjfvKcw6jmOd1R7MTfjm02CiZvb8Q5bLEQyd8IRLaA3HX5VG00gVNOG9Qs
        6M++qv85lTlMTkPZZdwHVdwcTnlRqAs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-Vkn7yk-1MXKE3z6tCmA0PA-1; Fri, 08 Apr 2022 12:13:33 -0400
X-MC-Unique: Vkn7yk-1MXKE3z6tCmA0PA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-2ebebe9f982so12334497b3.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RABOyYo670sPAWQ+PEuN77+r1YMjgpRyhVZuUCYWh68=;
        b=qJhG0XhSunNFCbu4A4W/qRZ9XgC/Ml2tBKhnCLbNHBKtFJJHsh3BHzxP+uKemKSHL1
         2vYGqNFsybPltT+zHBYVqrWhxtWBZNC733HA9n1yxB337kaawPZluN12Z84c/zFY7i4W
         6sR1V1OXuafD/Z5LJj3aeM3nMjTIDLvheyZcgwUsDkpmswweWg7q1YIACrnfMSUYQ/6F
         3u5xfko53f+GdMdQlNl1neUa5JOzrrdqNWn3wvHqwuL/ZEEaPFVTO0d/cs+e4dAeA7PJ
         0cnkYFiVmHstzw9os7vYXH6YXy+MGZbNtM20EZ713TGH3mT26WHKEldTHsfd8Y7POBWj
         BSLg==
X-Gm-Message-State: AOAM530OWup7SujbvGNOh69z5BY8ecNmhrvpUk54WSSMOy4WbmxK5IDK
        GkxdWBL5t+eBn/OVquBkP7zoxCrwcT0CATNsnnaCV9zwwlsHEXfP5tyU/aebMHFX0AbKB0eZb5N
        Z0dnNYlKq5c/0EilLROjWOodFG6qC2DJId/f2t3wa
X-Received: by 2002:a25:adc8:0:b0:633:b79d:92ee with SMTP id d8-20020a25adc8000000b00633b79d92eemr14066212ybe.457.1649434412957;
        Fri, 08 Apr 2022 09:13:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRgvqC+MnDBFtFpOj0kzf4fzJqLCJ33Or5sPWhBYgE8Lr6rPUPkktLh7gmkeG3+q2BSQNdr/IZiHbdDYQjY1w=
X-Received: by 2002:a25:adc8:0:b0:633:b79d:92ee with SMTP id
 d8-20020a25adc8000000b00633b79d92eemr14066179ybe.457.1649434412748; Fri, 08
 Apr 2022 09:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220408032809.3696798-1-npache@redhat.com> <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
In-Reply-To: <87k0bzk7e5.ffs@tglx>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Fri, 8 Apr 2022 12:13:16 -0400
Message-ID: <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ---
> #include <errno.h>
> #include <fcntl.h>
> #include <pthread.h>
> #include <time.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
>
> #include <sys/types.h>
> #include <sys/mman.h>
>
> static char n[4096];
>
> int main(void)
> {
>         pthread_mutexattr_t mat_s, mat_p;
>         pthread_mutex_t *mut_s, *mut_p;
>         pthread_barrierattr_t ba;
>         pthread_barrier_t *b;
>         struct timespec to;
>         void *pri, *shr;
>         int r;
>
>         shr = mmap(NULL, sizeof(n), PROT_READ | PROT_WRITE,
>                    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>
>         pthread_mutexattr_init(&mat_s);
>         pthread_mutexattr_setrobust(&mat_s, PTHREAD_MUTEX_ROBUST);
>         mut_s = shr;
>         pthread_mutex_init(mut_s, &mat_s);
>
>         pthread_barrierattr_init(&ba);
>         pthread_barrierattr_setpshared(&ba, PTHREAD_PROCESS_SHARED);
>         b = shr + 1024;
>         pthread_barrier_init(b, &ba, 2);
>
>         if (!fork()) {
>                 pri = mmap(NULL, 1<<20, PROT_READ | PROT_WRITE,
>                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>                 pthread_mutexattr_init(&mat_p);
>                 pthread_mutexattr_setpshared(&mat_p, PTHREAD_PROCESS_PRIVATE);
>                 pthread_mutexattr_setrobust(&mat_p, PTHREAD_MUTEX_ROBUST);
One thing I don't understand is what kind of sane use case relies on
robust futex for a process-private lock?
Is there a purpose to a lock being on the robust list if there are no
other processes that must be woken in case the holder process is
killed?
If this usage serves no purpose besides causing races during oom, we
should discourage this use, perhaps by adding a note on the manpage.

>                 mut_p = pri;
>                 pthread_mutex_init(mut_p, &mat_p);
>
>                 // With lock order s, p parent gets timeout
>                 // With lock order p, s parent gets owner died
>                 pthread_mutex_lock(mut_s);
>                 pthread_mutex_lock(mut_p);
>                 // Remove unmap and lock order does not matter
>                 munmap(pri, sizeof(n));
>                 pthread_barrier_wait(b);
>                 printf("child gone\n");
>         } else {
>                 pthread_barrier_wait(b);
>                 printf("parent lock\n");
>                 clock_gettime(CLOCK_REALTIME, &to);
>                 to.tv_sec += 1;
>                 r = pthread_mutex_timedlock(mut_s, &to);
>                 printf("parent lock returned: %s\n", strerror(r));
>         }
>         return 0;
> }
>

