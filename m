Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B9448A5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiAKCzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKCza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:55:30 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477EC061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:55:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u21so38950292edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+Y28XxOTbwhPxzWhN6RbihwTYYfYJcoL9vjrnUr5zE=;
        b=dUok9tPThdjODcNE51pXamu5TwIzsdpaI5zTXGTRW4tg5ulv80Dh6+vkkiIFZ/PpyT
         FkFAgWhiQVPIXAOMWzUy1TGBrsE3Nu4l6kZFbOCJZ5CN61JWBAM6rkoXCl6at0rWQxhI
         PCR0gQqsIgknv2e3sVxB+FPFIdXxYloQtZRyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Y28XxOTbwhPxzWhN6RbihwTYYfYJcoL9vjrnUr5zE=;
        b=GVCH0kRDkO/eWecW7ot43nGcfnIlUaHcXxT+sbmyNH87yBCvCfl12kRG1rp/XRUIEA
         cDp+6OP3paOtKE2dDtNUGuGgLLdd9RCm13F6hhAOvz4BPjd7GrfVW5kD21t6SCD4vbMS
         yBspLSWAuh8u41sp39I8lqvxjNAvmAYr8rgLbVDaawTaVYsZ+MQcSehstFjdsduLiQo2
         jsS1+/PeTpeG/0Y9Pkjjbiky60txGv6VEv18DI0RUH3eqp2Y/GDBdVAcdnEvRfv7olle
         oUqhvMbGGWAPgINTTOrC0K0Uu7XmOTjEXLzMzxrDE5QKRQQiuMG9+J/NcNObW0+l7KNO
         zBZA==
X-Gm-Message-State: AOAM530Jg71Xa77RPEv1n0Ohf0X3qpMhTYGTtu+wZ1yN7XzrWEsUrT8T
        /kCEp1ynyxLxIH5R3UdZ7VLT0fuMbX1zesJWK+U=
X-Google-Smtp-Source: ABdhPJxf2geHXCw4NKlf4terobxodelO4Ho8q7TMnJ4dmH1mn6sCSJYJxK3z2rqcUK+iKYqLkpvsYw==
X-Received: by 2002:aa7:d5c7:: with SMTP id d7mr2402156eds.280.1641869727545;
        Mon, 10 Jan 2022 18:55:27 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id q21sm3016236ejn.107.2022.01.10.18.55.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 18:55:27 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso575325wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:55:26 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr548893wmj.144.1641869726504;
 Mon, 10 Jan 2022 18:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20220111025138.1071848-1-surenb@google.com>
In-Reply-To: <20220111025138.1071848-1-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 18:55:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxmsa7mnzwe-DV6m26teV32geB-n-aKbYHXNm1k4rVwg@mail.gmail.com>
Message-ID: <CAHk-=whxmsa7mnzwe-DV6m26teV32geB-n-aKbYHXNm1k4rVwg@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
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
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 6:51 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Fix this by disallowing to redefine an existing psi trigger. If a write
> operation is used on a file descriptor with an already existing psi
> trigger, the operation will fail with EBUSY error.

Looks fine to me. Eric?

I assume I'll get it through the usual channels unless there are issues,

                Linus
