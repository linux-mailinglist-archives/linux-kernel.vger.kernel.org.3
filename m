Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA955EB14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiF1RdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiF1RdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 516131EEE5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656437593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7VE0tuK7nWwEOYtUcFLI6mabEeaSx3vxPSmkSS0cDM=;
        b=cH0snIUcPURQ1eGOZtA8e7U5+giPGpTtd4RvkH5Xfks92ZcAnw/0agPayutmT5CzAWoGgG
        hNtvhW7DTrKzZ2n9W+IUu/REa0hWuCU3tQi+i+Fmtlzvarqn6vOJJLQvg560j2YTx4nuy1
        E2Ny7q2eyg1P1qZPf7Tf3E278Ammoa0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-werrFefKO1KPF_ttVH9tpw-1; Tue, 28 Jun 2022 13:33:12 -0400
X-MC-Unique: werrFefKO1KPF_ttVH9tpw-1
Received: by mail-wm1-f70.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so5371636wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a7VE0tuK7nWwEOYtUcFLI6mabEeaSx3vxPSmkSS0cDM=;
        b=z1xcRjnmzpcyvEZnyxinE8qh0JuDXE0flsyWCUqVINJJdbT3xKnbSs5zI4LRyXMmjx
         OO7QLOE6CnP/b1k0EmUU3nlZMj/BNHX1VevNaJEPcEzdB5+Vs5FSZoEsxO0umoVC9kFD
         rJ3/5TDl3XPLe5WKRr9RKadHMwQIFPgVgqqVD90Z8mU1LZwDlnfl8W6JS1XMbys7mgr7
         8B8KdYR7OYfyWO0N2CAPDDaovtJOMaQCza7ge1osfPVOs4D1YJ30lixiZeEDkAFoNDhl
         hD31byJHzqrk0/TR1QXY28I6tU2hpMy+U8YKR+zyQjMesSsxqj3DNxQe6ruovLBJCLMb
         /jvQ==
X-Gm-Message-State: AJIora+AxY7igLxf1aXpoZOFPMHbDFG5Z0TSU9Elw3dtbymG1ruxejlJ
        ZPdecoMcpUrnfU0fedf86W+3WrNDcdHzoBmW6XTNvZfzkjwTWQ0d57QlsPN1MDnAfvjgi5d2QSh
        CSCCobP8NH+UZ6ZP8GiXn6VfV
X-Received: by 2002:adf:e5cc:0:b0:21b:8bab:8e95 with SMTP id a12-20020adfe5cc000000b0021b8bab8e95mr19211064wrn.454.1656437590821;
        Tue, 28 Jun 2022 10:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uNa1HHSsL0XcWy6n2rjIDIIsOFT4WH5URrvmgY8hvsAi2gczAwVJVbvUfAU+CLisMd3Ks0BA==
X-Received: by 2002:adf:e5cc:0:b0:21b:8bab:8e95 with SMTP id a12-20020adfe5cc000000b0021b8bab8e95mr19211039wrn.454.1656437590549;
        Tue, 28 Jun 2022 10:33:10 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003a044fe7fe7sm156300wml.9.2022.06.28.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:33:09 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
 <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
Date:   Tue, 28 Jun 2022 18:33:08 +0100
Message-ID: <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/22 13:42, Valentin Schneider wrote:
> On 25/06/22 12:04, Eric W. Biederman wrote:
>> At this point I recommend going back to being ``unconventional'' with
>> the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
>> use a mutex for locking rather than xchg()").
>>
>> That would also mean that we don't have to worry about the lockdep code
>> doing something weird in the future and breaking kexec.
>>
>> Your change starting to is atomic_cmpxchng is most halfway to a revert
>> of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
>> xchg()").  So we might as well go the whole way and just document that
>> the kexec on panic code can not use conventional kernel locking
>> primitives and has to dig deep and build it's own.  At which point it
>> makes no sense for the rest of the kexec code to use anything different.
>>
>
> Hm, I'm a bit torn about that one, ideally I'd prefer to keep "homegrown"
> locking primitives to just where they are needed (loading & kexec'ing), but
> I'm also not immensely fond of the "hybrid" mutex+cmpxchg approach.
>

8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()") was
straightforward enough because it turned

        if (xchg(&lock, 1))
                return -EBUSY;

into

        if (!mutex_trylock(&lock))
                return -EBUSY;

Now, most of the kexec_mutex uses are trylocks, except for:
- crash_get_memory_size()
- crash_shrink_memory()

I really don't want to go down the route of turning those into cmpxchg
try-loops, would it be acceptable to make those use trylocks (i.e. return
-EBUSY if the cmpxchg fails)?

Otherwise, we keep the mutexes for functions like those which go nowhere
near an NMI.

