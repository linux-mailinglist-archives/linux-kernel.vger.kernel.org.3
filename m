Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1515700FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiGKLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiGKLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 561971D7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657539675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHZTeBa+zo6V5aGVigu7pGUwqHAZBzzfDHWLTO9INzI=;
        b=VnME6Q7nQgsS30ursDvkPyRslJgOQr0nbpJ0wrgV7GYn0ryV7GTKcRewRXhwLpiQdxoUmV
        7zKQfHzB/yj9wy1rDgsNWLiF4sARvsZJpK4e6QJ9Krzk6V0+j3IPQq3VlnrUxueHmO2Yha
        NUImyKaBKh8gmd1o+YoVn2DtHKTcurE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-FKQKtNkQPUSZgoLKc59SHw-1; Mon, 11 Jul 2022 07:41:14 -0400
X-MC-Unique: FKQKtNkQPUSZgoLKc59SHw-1
Received: by mail-wm1-f69.google.com with SMTP id r186-20020a1c44c3000000b003a2daf644f9so4813196wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gHZTeBa+zo6V5aGVigu7pGUwqHAZBzzfDHWLTO9INzI=;
        b=j5hRt06afRNgLEmvwAFQdE5/XFfvaRWQojmETtTFRO4F6lQd0HY7wq3tdrH6H8GfLC
         YrfruILEUf+q8BEoMTDbXHfWjteXjIqqJ3V1PThk5w2+eRLZWtfy1leXxumG9E3CPNFI
         wpLT/RJbLHi6VYKIYkf1DTTDHRGWNMavZVhgJeTdBh6ZujmTjTKQ5ZYfO6kQnEOfRHbq
         MuPyzPBBdkVnK2ke9/IWYosZRD6/p4KlvaEcXVvCwp8fEQsS7goRk+VXuK6+FZsYkeW0
         2A1YsLSCsXbxxOdXfBihESY2S6tdwCXoOvpANZCxtego+6JeN9FPVw7q7mVQtflQ3kVl
         oT3A==
X-Gm-Message-State: AJIora/esBF5vm9CFIj6GHeefrMhk9voB96C2gIjm6Jj+tYmoQWySQaG
        aquwPXojDc+gcYI5jbvyeq6ZYCdi7R2OJU0fVrZB4T/Sv1xG7isnIDwa9yA8a+zFZZHISz3fmT0
        FleUNlvj/Q3U8qef/q5/szI22
X-Received: by 2002:adf:fbc6:0:b0:21d:3fc3:99e with SMTP id d6-20020adffbc6000000b0021d3fc3099emr16603227wrs.550.1657539673360;
        Mon, 11 Jul 2022 04:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqCQTI5mdoLJYyLC9KKsKSmRT9hOYxAFOVKHCeTy+01po4lrgNtzb/0y31cJeV8TLUEzjpoQ==
X-Received: by 2002:adf:fbc6:0:b0:21d:3fc3:99e with SMTP id d6-20020adffbc6000000b0021d3fc3099emr16603219wrs.550.1657539673173;
        Mon, 11 Jul 2022 04:41:13 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u20-20020adfa194000000b0021da61caa10sm2434566wru.56.2022.07.11.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:41:12 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Gregory Erwin <gregerwin256@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v8] ath9k: let sleep be interrupted when unregistering
 hwrng
In-Reply-To: <87v8s8ubws.fsf@kernel.org>
References: <Yrw5f8GN2fh2orid@zx2c4.com>
 <20220629114240.946411-1-Jason@zx2c4.com> <87v8s8ubws.fsf@kernel.org>
Date:   Mon, 11 Jul 2022 12:41:12 +0100
Message-ID: <xhsmho7xv512f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/22 19:26, Kalle Valo wrote:
> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
>
>> There are two deadlock scenarios that need addressing, which cause
>> problems when the computer goes to sleep, the interface is set down, and
>> hwrng_unregister() is called. When the deadlock is hit, sleep is delayed
>> for tens of seconds, causing it to fail. These scenarios are:
>>
>> 1) The hwrng kthread can't be stopped while it's sleeping, because it
>>    uses msleep_interruptible() instead of schedule_timeout_interruptible=
().
>>    The fix is a simple moving to the correct function. At the same time,
>>    we should cleanup a common and useless dmesg splat in the same area.
>>
>> 2) A normal user thread can't be interrupted by hwrng_unregister() while
>>    it's sleeping, because hwrng_unregister() is called from elsewhere.
>>    The solution here is to keep track of which thread is currently
>>    reading, and asleep, and signal that thread when it's time to
>>    unregister. There's a bit of book keeping required to prevent
>>    lifetime issues on current.
>>
>> Reported-by: Gregory Erwin <gregerwin256@gmail.com>
>> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: Rui Salvaterra <rsalvaterra@gmail.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: stable@vger.kernel.org
>> Fixes: fcd09c90c3c5 ("ath9k: use hw_random API instead of directly dumpi=
ng into random.c")
>> Link: https://lore.kernel.org/all/CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDs=
FGTEjs0c00giw@mail.gmail.com/
>> Link: https://lore.kernel.org/lkml/CAO+Okf5k+C+SE6pMVfPf-d8MfVPVq4PO7EY8=
Hys_DVXtent3HA@mail.gmail.com/
>> Link: https://bugs.archlinux.org/task/75138
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> ---
>> Changes v7->v8:
>> - Add a missing export_symbol.
>>
>>  drivers/char/hw_random/core.c        | 30 ++++++++++++++++++++++++----
>>  drivers/net/wireless/ath/ath9k/rng.c | 19 +++++++-----------
>>  kernel/sched/core.c                  |  1 +
>>  3 files changed, 34 insertions(+), 16 deletions(-)
>
> I don't see any acks for the hw_random and the scheduler change, adding m=
ore
> people to CC. Full patch here:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20220629114240.=
946411-1-Jason@zx2c4.com/
>
> Are everyone ok if I take this patch via wireless-next?
>

Thanks for the Cc.

I'm not hot on the export of wake_up_state(), IMO any wakeup with
!(state & TASK_NORMAL) should be reserved to kernel internals. Now, here
IIUC the problem is that the patch uses an inline invoking

  wake_up_state(p, TASK_INTERRUPTIBLE)

so this isn't playing with any 'exotic' task state, thus it shouldn't
actually need the export.

I've been trying to figure out if this could work with just a
wake_up_process(), but the sleeping pattern here is not very conforming
(cf. 'wait loop' pattern in sched/core.c), AFAICT the signal is used to
circumvent that :/

