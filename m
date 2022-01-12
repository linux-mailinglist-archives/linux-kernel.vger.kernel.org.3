Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F548CAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356063AbiALSKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356149AbiALSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:10:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:10:02 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w16so13202505edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhSCFec3TdzZgoMmjiOtfrqEeP0ETxz+5Dx8yofaKqk=;
        b=ACYcmQYX22hOF9eHsSpz63wI3cG/WXMRlzAlN2whKAaJhPR9GPIxx9qzxyuqNMjA+7
         rZivP0MyhKT2m5OXVlrJzc4KyBRcDy7L36J2mi7wYToYCPNHQweiy7y/QtQh9y37tYtS
         Q95EMM11LnVKXAhQsE7YRBQZnsA8tqq/mJJvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhSCFec3TdzZgoMmjiOtfrqEeP0ETxz+5Dx8yofaKqk=;
        b=BkRiUqCkEevT+/riBxFB+BP8NOePi1b7Q6B2HTHCbp0EkQVqqqCQAwXwkJGNznqNrH
         +eRQ7ZDH3gaxuVzefGfWOXAr2ddErC6Otu+oSz6EhDbDJsEd4ZU1whrf7wdEzQXfx863
         pn5q5l35kImWj4GB2eH7rV/KXrMU/SksUoJaT5psvx8knxGDKLJYTiy6LfAfqHVxIPhM
         EkZHWxdC/33MJTcxEzT5kt80kBsVoxronM3ACGXxtTj6Bc6jx5NvExKmx2cePFn+ws14
         Jbz9Puv8JboV85vIuE8x2AQHr2/i9MTVp+EWTzPNqF9iZsyKG8u6jDg1H5E52xdxcy0K
         Ae3Q==
X-Gm-Message-State: AOAM533Wn76/e+VlpTT9te2wzJJjTqBVRzFeOdeMd6eyshZlpUWPzaZ8
        +D0BAuJFRT+GKNWV39QHzBvgE2IkgtuCcTw/E04=
X-Google-Smtp-Source: ABdhPJzUhuuWz5FQbkicvkYDn2OyTGOlOesnLFF6UyivSP/XIX0wtq7pHjoOIlMeKbTUm/pd8ogvFQ==
X-Received: by 2002:a17:906:a893:: with SMTP id ha19mr723550ejb.144.1642011001090;
        Wed, 12 Jan 2022 10:10:01 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id oz31sm142905ejc.35.2022.01.12.10.10.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:10:00 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id l4so2188300wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:10:00 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr7775750wmq.152.1642010629913;
 Wed, 12 Jan 2022 10:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20220111232309.1786347-1-surenb@google.com> <Yd6niK1gzKc5lIJ8@hirez.programming.kicks-ass.net>
In-Reply-To: <Yd6niK1gzKc5lIJ8@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jan 2022 10:03:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNQD6o-REKoZv_5cHWrGmsT_KgduYCsLdLqbdHWUKcdw@mail.gmail.com>
Message-ID: <CAHk-=wiNQD6o-REKoZv_5cHWrGmsT_KgduYCsLdLqbdHWUKcdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 2:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Thanks, I'll go stick this in sched/urgent unless Linus picks it up
> himself.

I'll let it go through the proper channels, it's not like a few days
or whatever will make a difference.

               Linus
