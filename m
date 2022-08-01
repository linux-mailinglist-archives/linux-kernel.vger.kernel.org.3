Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606E9586F45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiHARHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiHARHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:07:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634F62C9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:07:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s9so7034126ljs.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=M/VjqcNJHc+gRY3wXiZakq1QMHZ6f0h1tErzqGq4ciw=;
        b=O5KxE3ZAwD1QooSwoE5YL1eStigRy//uq+NqHkFRn1/n3WHSd0rD6slClmUZE/nZXj
         V2E4ussAL5zEBVfk63mmqY2Lcu8WuVqIv6omUi7KwC5BMbasyR/56ngg8oiQL84R0B81
         Utn2OiAIUGj8Cp/lm3kkji68h1+pVEgnyU2Rro5pWWuAWUifuZM4hFXZBRySWeaR9qty
         uYkXe2tiOfxyBN9pNmo23Oyyx6WhqU/XVfc4lFTj0MAcmMseUoxjvU980qU3se+qkhOR
         ZBeRv5zTGiGQF4FGQb9PCCdqiEOk7pFS+7Yz9udR6tFM60/tx9rBXdSkX3Q/kV0sm3ej
         oj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=M/VjqcNJHc+gRY3wXiZakq1QMHZ6f0h1tErzqGq4ciw=;
        b=Owl4XbLUgJ5E/9KqRUqXe/VOYj+jHNf6Zkjemw+uF4cNX9lbdWNg90vXB9oRMEwkQd
         ijqDwfAGVaOAgJcLyRdUeWLWq4uLByD7s6nebpvGuNYlYRwLXNYZ50jiAaBtWHX+wwoz
         X4HqY+wrJLYzHvI/4wsv+7bK83d1xURKApYtktpwxvgEKestevN3TqjGq+k93DgozUcn
         p13CKjF/osOuBGS5Coll5YYhKmSLWTymgbahivAN9A31U57HTVscSjznMcD/MmmGW7tV
         pO/Dc6jeFyvJF/hR+bm0Vor1o+Cc8hRCybW4A3WthD2d3d70qr8GmSSGZ7aWZHO4HRIg
         Rs9Q==
X-Gm-Message-State: AJIora/XPv+NXCoM85xVW6QqIrYRtJ+ZFwWM6zmpM1vn1VTjL+H+rd94
        kHWI3MP435Am/an7f6TmuPPba2dCuW/mgX7l7IFYOQ==
X-Google-Smtp-Source: AGRyM1swoEOC54y8dlt5wE189wVcgzfbMXw8yiwim4WUK8j9m3XBlYeTVTHWJijP9eiJ/kf3L/nl2oHK/6d2KZJPvtU=
X-Received: by 2002:a2e:b539:0:b0:25e:2f3e:bda0 with SMTP id
 z25-20020a2eb539000000b0025e2f3ebda0mr5194722ljm.227.1659373633411; Mon, 01
 Aug 2022 10:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 1 Aug 2022 10:07:09 -0700
Message-ID: <CAFTs51UAyc4Z5WUFdMXCTYR6zji6NwLeBxYsp9GQZvFdEtUm1w@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] RSEQ node id and virtual cpu id extensions
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:02 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.

Thanks a lot, Mathieu - it is really exciting to see this happening!

I'll share our experiences here, with the hope that it may be useful.
I've also cc-ed
Chris Kennelly, who worked on the userspace/tcmalloc side, as he can provide
more context/details if I miss or misrepresent something.

The problem:

tcmalloc maintains per-cpu freelists in the userspace to make userspace
memory allocations fast and efficient; it relies on rseq to do so, as
any manipulation
of the freelists has to be protected vs thread migrations.

However, as a typical userspace process at a Google datacenter is confined to
a relatively small number of CPUs (8-16) via cgroups, while the
servers typically
have a much larger number of physical CPUs, the per-cpu freelist model
is somewhat
wasteful: if a process has only at most 10 threads running, for
example, but these threads
can "wander" across 100 CPUs over the lifetime of the process, keeping 100
freelists instead of 10 noticeably wastes memory.

Note that although a typical process at Google has a limited CPU
quota, thus using
only a small number of CPUs at any given time, the process may often have many
hundreds or thousands of threads, so per-thread freelists are not a viable
solution to the problem just described.

Our current solution:

As you outlined in patch 9, tracking the number of currently running threads per
address space and exposing this information via a vcpu_id abstraction helps
tcmalloc to noticeably reduce its freelist overhead in the "narrow
process running
on a wide server" situation, which is typical at Google.

We have experimented with several approaches here. The one that we are
currently using is the "flat" model: we allocate vcpu IDs ignoring numa nodes.

We did try per-numa-node vcpus, but it did not show any material improvement
over the "flat" model, perhaps because on our most "wide" servers the CPU
topology is multi-level. Chris Kennelly may provide more details here.

On a more technical note, we do use atomic operations extensively in
the kernel to make sure
vcpu IDs are "tightly packed", i.e. if only N threads of a process are currently
running on physical CPUs, vcpu IDs will be in the range [0, N-1], i.e. no gaps,
no going to N and above; this does consume some extra CPU cycles, but the
RAM savings we gain far outweigh the extra CPU cost; it will be interesting to
see what you can do with the optimizations you propose in this patchset.

Again, thanks a lot for this effort!

Peter

[...]
