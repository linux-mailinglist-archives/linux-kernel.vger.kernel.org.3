Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65CB50BDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiDVQ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449914AbiDVQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:57:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A499A5FF0B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:54:50 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p21so9212827ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8KiB3k0qd5aGBnHBibLj4k3w/QF0UAZ/tRM/Axt2UE=;
        b=enp9BRHjyw5GkiP09bboYtyV2m3NiwJ5+1H2BxdsNHb/CN6IJpazQ2Uq4gTIBUN00H
         HP+bL7VZap6/1+DNCTBdmMWCC9JjrWTIRdn3Q3HT6/GvqvEYpJk7eJSMZnFXLCi4LyR0
         +2gXMbeJeSMtiiTuOlO1Ghq9qUxCexUXJRxazvFlr0RmzDMPwqML0cfCf1sAYbVxXhxp
         gtGmSfFMXj6zcMWeAdBPbW4EB3Ir80KXQ9t+WNiOm+D7i6VuEP/4IhVCOpBS0A6KVpiJ
         RwBqde7saG5FTGnSr07Ov7UedZk+UUVZ7D0q/l/2cE6EI4MkA2ShUJmiGeILPF5XcJUJ
         T/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8KiB3k0qd5aGBnHBibLj4k3w/QF0UAZ/tRM/Axt2UE=;
        b=F8hbWZwPh5Vg52InFlexw74H7VfMi2DQJgvbNgQ+7L8vLlhiXHlVQOemr3h9xBpcCB
         1dWP3utLZGraaJbBJ5pdLczGTjkKoESwB3XsY8+9r/0zjJgF/ERaoh89kNbyc6i73bGj
         ZISsjc2WzC8zm9RI8Bf7l6tCgYAGym6d0cc53saU0OkEyhqOt5JZFmRJR4ygp7MQLb5N
         Ix0N+vzATvDQPNyeXn+dEgdw14kNySYEsAHE/zgWQXd/mfkCV/crOWLAGd6f84zhq4Sp
         NsaZymH80i7NVNQjuK2NwEp+OqZ52y6YSRxgX5uNG6xL4R3L1i7pYurHVduJi52i7c1H
         D93g==
X-Gm-Message-State: AOAM530ygIZTXHenKYQactDfr5ErgUOrWwg39fZ6xYsyfuy3oL7BBtlD
        2GMn4wLWGG6Ak9C8eWK57+QvvoJ4yHkXZMYd0ffsfVrMJhY=
X-Google-Smtp-Source: ABdhPJzUAJpHWlGun68BFX5xSwYGsM4XUcVTIrs65mISg1PsnyRYcaz4u9X4l5p02NQn9CemAE6FTGjZlzrxxRp9Go4=
X-Received: by 2002:a05:6638:3393:b0:32a:93cd:7e48 with SMTP id
 h19-20020a056638339300b0032a93cd7e48mr2509483jav.93.1650646490086; Fri, 22
 Apr 2022 09:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com> <20220422110903.GW2731@worktop.programming.kicks-ass.net>
 <20220422115557.0dc5cd86@gandalf.local.home>
In-Reply-To: <20220422115557.0dc5cd86@gandalf.local.home>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Apr 2022 09:54:39 -0700
Message-ID: <CAEf4BzbnFBkdpHdwf3Uf_yQDt5Sn8NVkQNUts70EDVu8KmhsHw@mail.gmail.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Delyan Kratunov <delyank@fb.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 8:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 22 Apr 2022 13:09:03 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > If bpf wants to ride on them, it needs to suffer the pain of doing so.
>
> And I constantly hear that BPF is not an ABI, and is not guaranteed to work
> from one kernel version to the next.

Right, and that's true in terms of expectations of BPF users. But it's
also true that in pracitce people's tools have to keep working across
multiple kernel versions and we've developed multiple technologies
(e.g., BPF CO-RE) and techniques to allow people to adapt to kernel
changes. See [0] and [1] for some of the tricks people do in real
production tools to accommodate kernel changes. Some kernel changes
are easier to accommodate, some are harder. This particular one,
though, is pretty complicated as no function or symbol got renamed, so
it's much more involved to detect changes like this. But ultimately
people will do that anyway.

But the ask here is, given it's not too late and it's trivial to avoid
this breakage in the first place by reordering function arguments, we
(BPF users) kindly ask to consider doing that. Hopefully this trivial
change isn't hampering kernel development in any way.

  [0] https://github.com/iovisor/bcc/pull/3917
  [1] https://github.com/iovisor/bcc/pull/3747

>
> -- Steve
