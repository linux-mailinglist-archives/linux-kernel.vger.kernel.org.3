Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B36537AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiE3M1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiE3M1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D2B91C937
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653913636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dm0Y1acZu7H+lhgBwqH8XtSI5V6P9vk2Ea4OhIfvvWI=;
        b=IcrUvqZAkXpErPEGOVnjTaTEJ+MwvNELtNyabwMbCQbiqapFYrvgnJVPWIYMvq3HPQTi2P
        zDFS4eDdkS3h3FfKP2rD695jrilNP03zbJGd7RxO0ZJeF678gfbJvDrVyUMtWUrnS3zuUu
        jyqg+v+lbA1kUBBYEr0UEcMeBYMsQJA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-h-cCOY05Mve000uzmS4Iag-1; Mon, 30 May 2022 08:27:16 -0400
X-MC-Unique: h-cCOY05Mve000uzmS4Iag-1
Received: by mail-qv1-f70.google.com with SMTP id eb5-20020ad44e45000000b0046447caa7a0so2459547qvb.16
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Dm0Y1acZu7H+lhgBwqH8XtSI5V6P9vk2Ea4OhIfvvWI=;
        b=tKf6GuuFf6k6ytH0kCxH5tbqTHVcNGMgK5xATgNNzmvVzfyqLTaYQIYtdLtivhfMuP
         DCKVWSALb3Hegs/DBya6rTd1HeuV4UAjjjJdIPKurgXMeNrObo4geYkiaby1qMsx36Xk
         xcx1mE0UIc6gvG2AqGZ4W/tGkDGJpGLTOmN+Kc5Ygm1Wk+T+zzb/kIoMVi5yOyJ9Y25C
         cA+h5jKQQ9U5VujZ+7DWys0IY+y4mdZ59nURrceSHi9m2NiWs3qsqXtasohOufRB1G0V
         GCNqMFWyk4kdCD+r2yeU7/mP6vrIY315lnc72Rle/LSjLMvKk9ZjbWfUvsXXrycQHEg6
         8ZMA==
X-Gm-Message-State: AOAM531IsZLzcBMeK7kjjdyV303iMIB+49Y+7ohm2uJzJvPKHKkI7otR
        U46jqNHnYo4m6fXG3lBmNRH39ckv+p8zvgGpLItIqZP71zJRF8vWfGZjbQHu5XlDMz5g13t5kc+
        F/pRf5F0hCXxVSXHYRKSY8TR+
X-Received: by 2002:ac8:5c14:0:b0:2f9:38d7:b095 with SMTP id i20-20020ac85c14000000b002f938d7b095mr30524895qti.83.1653913633814;
        Mon, 30 May 2022 05:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPVFGd7qAu73vtmkyP8aOflOryg34S/7QdHj4WgB7g10Ek77A2LxfYhX8mQUoXD6X327EX8Q==
X-Received: by 2002:a05:622a:1a90:b0:2f9:38d8:fc48 with SMTP id s16-20020a05622a1a9000b002f938d8fc48mr29085796qtc.1.1653913623424;
        Mon, 30 May 2022 05:27:03 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id r16-20020a05620a299000b006a6442f99c3sm630035qkp.84.2022.05.30.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 05:27:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] cpuhp: make target_store() a nop when target ==
 state
In-Reply-To: <20220527132156.GB26124@pauld.bos.csb>
References: <20220526160615.7976-1-pauld@redhat.com>
 <20220526160615.7976-2-pauld@redhat.com>
 <xhsmhy1ynl3hr.mognet@vschneid.remote.csb>
 <20220527132156.GB26124@pauld.bos.csb>
Date:   Mon, 30 May 2022 13:27:00 +0100
Message-ID: <xhsmho7zf8auj.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/22 09:22, Phil Auld wrote:
> On Fri, May 27, 2022 at 10:38:24AM +0100 Valentin Schneider wrote:
>> On 26/05/22 12:06, Phil Auld wrote:
>> > writing the current state back in hotplug/target calls cpu_down()
>> > which will set cpu dying even when it isn't and then nothing will
>> > ever clear it. A stress test that reads values and writes them back
>> > for all cpu device files in sysfs will trigger the BUG() in
>> > select_fallback_rq once all cpus are marked as dying.
>> >
>> > kernel/cpu.c::target_store()
>> >    ...
>> >         if (st->state < target)
>> >                 ret = cpu_up(dev->id, target);
>> >         else
>> >                 ret = cpu_down(dev->id, target);
>> >
>> > cpu_down() -> cpu_set_state()
>> >     bool bringup = st->state < target;
>> >     ...
>> >     if (cpu_dying(cpu) != !bringup)
>> >            set_cpu_dying(cpu, !bringup);
>> >
>> > Fix this by letting state==target fall through in the target_store()
>> > conditional.
>> >
>>
>> To go back on my data race paranoia: writes to both cpu$x/online and
>> cpu$x/hotplug/target are serialized by device_hotplug_lock, and so are the
>> exported kernel hotplug functions ({add, remove}_cpu()).
>>
>> That's not cpu_add_remove_lock as I was looking for, but that's still all
>> under one lock, so I think we're good. Sorry for that!
>>
>
> Right. This catches it up higher so that we don't get into the code that
> starts actually changing things.  I wonder now in the state == target case
> if we should make sure st->target == target.  With the second patch it's
> less likely to be needed. Thoughts?
>

Yeah, you could append a simple:

        else
                WARN_ON(st->state != target);


> Maybe I'll include that if/when I have code to keep cpux/online in sync
> with st->state and cpu_online_mask.

