Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1329D48B78C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiAKTm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiAKTmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55390C061757
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:42:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d3so235515lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72nCaH0D5cVWOpCSRc18GR2eFwD5HF2lWhLZ438H8+E=;
        b=IbI2Ue6xwevdXzForB3sPC7JLpGCLW4aJaiaqGPQM519ZpN4Iw53D7dK6TEvItwJQM
         lU0w7yPNWbufVbo7aTy0WNF/06ot4HROv5RcW7EH+B/47POEIinAhzsJIzijm2pqH0rA
         32W/JrQJcTgkaHK2M1qJ6iERelYscbkX2JYhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72nCaH0D5cVWOpCSRc18GR2eFwD5HF2lWhLZ438H8+E=;
        b=k89HacVmx8Zs7Irg617LtsMGaK14Zgj9PxBU/4T1gwlm3aKDV7vkefcbPf76FUI41A
         Y3vq011ZBTJVbHgjZetsVxte+gPA5rL0NiYQ/sazm4mfG2I8rEZjIP2JPNXQng2zEaBd
         uLZ4JVOJ6XBxNg8eQM101WI/bxYSIJ30NQnVI8deE7bSHY8D3z+PFkiiyCagXL1Jyd/5
         iHVFuo1YHecoJsPBVez4KjrkwilngQfh5Xkir/1Kts9/qdudW7/DZ4OjWrUcSfwVEz0z
         LeAqgKMm1LDQkfIHODyS19VLfoo2lVrQpfXvW646OD11ilQowAC0Pia18MhOOw85nnuc
         3vlg==
X-Gm-Message-State: AOAM53112VdLo+QjtiqZbZIlBqPy9GtJg97JWq9Y2LS9HDXJyKxOzPeV
        QZed/xxNpKGXGZemEwtHgfLGJ3jnBJNpDpnf4F4=
X-Google-Smtp-Source: ABdhPJyt7ZWDy2BU1KOUXuvdKS18d9of2DSrHVNbd4lRasByDo9c5FT0NR3oNVPsKXza3k4RVVVtIg==
X-Received: by 2002:a19:f803:: with SMTP id a3mr4257242lff.95.1641930168539;
        Tue, 11 Jan 2022 11:42:48 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r4sm142927lfn.103.2022.01.11.11.42.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:42:48 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id br17so360773lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:42:48 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr5117431wrh.97.1641929709117;
 Tue, 11 Jan 2022 11:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20220111071212.1210124-1-surenb@google.com> <Yd3RClhoz24rrU04@sol.localdomain>
 <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com> <CAJuCfpE3feNU=36qRUdCJsk41rxQBv1gRYy5R1dB1djMd0NLjg@mail.gmail.com>
In-Reply-To: <CAJuCfpE3feNU=36qRUdCJsk41rxQBv1gRYy5R1dB1djMd0NLjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 11:34:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9-9mFcoaD3rdHd+HKYpyTXkkE2iJkPoTTCrp-+sD=ew@mail.gmail.com>
Message-ID: <CAHk-=wj9-9mFcoaD3rdHd+HKYpyTXkkE2iJkPoTTCrp-+sD=ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Jan 11, 2022 at 11:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Thanks for the explanation!
> So, it sounds like the best (semantically correct) option I have here
> is smp_store_release() to set the pointer, and then smp_load_acquire()
> to read it. Is my understanding correct?

Yeah, that's the clearest one from a memory ordering standpoint, and
is generally also cheap.

                Linus
