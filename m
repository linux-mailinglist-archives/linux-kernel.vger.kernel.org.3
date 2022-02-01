Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D104C4A57C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiBAHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiBAHdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:33:22 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69195C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:33:22 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z7so13544299ilb.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIdNhi2/wGNy2B+fCo9w5bfywyakFJRFI4mxzMFaGNI=;
        b=gLyTG/GCZt1AfbBHRqQhlP90Gt1rlSLXTySgMzrQ0CHApygwv6J5YrLQTKz9p5jyk7
         lrrs0IG7jM2uvVhryW0VwU06UROgs9JmbHTWfs5uEzAwvSwCRbFx2c8aZrFoholr6D/w
         eK7nfmhw6eD6Zmhkc3wlXq7aOeYN33qCXywk5jkZuSZ9noYuFQ5VHgYudes6HpMv8S9n
         QfM0U+EFu3e+2upWnDOKh6HYOaetkbKigh00UWd4NKfH3UAkfOX066zGnRrx08A/c+9V
         PKQoBOIGaBix7qoJ1xRy9tJhVZMBqHHRrEgtkK3ORQBPuXjXPzRfuGuQnzrK4zlNZyKU
         X8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIdNhi2/wGNy2B+fCo9w5bfywyakFJRFI4mxzMFaGNI=;
        b=HUz4pYb+xIK7ZWSNjXLVoDDkpscCmW9QlE4yq6CaPd9+lzj+6i8Uzqt7wEe0f+Kk0y
         QKR/IkXI7eXqNtouTLV8uR/5qAsgYOSP2ys5Mui3D95ei0vbPhqPE0sEopbpAsZj86Ph
         DiPNAdFqtbsa7ONg1vagiyr8zNjwa4Ogei2CSvulCp6jPj/LY+y4c4mQrZbe+FsBFD3D
         IC+ajCd4RsHZi8MoI9mFs1msoACVJRWAXTfqj1DutELJzb8X7thNdwNZFlCjFdz7OjM1
         RrHpbGpEsb+ZpDlDm5wlD2B81CqZ49Ba9y9n39VKO3tN68UjysqKSTCGr9Y/RbRNawK6
         VUBg==
X-Gm-Message-State: AOAM533I1Z9Yase4C3P99Wf1lt/VklxT3cCDvfBzieb3vr0KhV8tm+MA
        54TD04GR112HJtcMKBh86udP7vdIUNZsSJ2zZtZNoQ==
X-Google-Smtp-Source: ABdhPJyTBfJZ+D9BniDzOWNhJfMNPqr6eDX92AwebnnPMqWvsVCMxWshk6ivXLtZwqM9pIDrkVI8yCduxjizop/oTrI=
X-Received: by 2002:a92:c5c8:: with SMTP id s8mr4153649ilt.295.1643700801640;
 Mon, 31 Jan 2022 23:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com> <20220126233454.3362047-9-eranian@google.com>
 <YfKY4k+ZO9of3Ipd@hirez.programming.kicks-ass.net>
In-Reply-To: <YfKY4k+ZO9of3Ipd@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 31 Jan 2022 23:33:10 -0800
Message-ID: <CABPqkBQoLh+v0ANLb=U-JTjT0yjBacVLTh6f=0q4J4XhVQeeuQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] ACPI: add perf low power callback
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 5:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 26, 2022 at 03:34:49PM -0800, Stephane Eranian wrote:
> > This patch add an optional callback needed by some PMU features, e.g., AMD
>
> "This patch" is a documented fail.
>
I understand this is not ideal. But the BRS feature must be disabled
before going low-power.
Do you have a better proposal? Been trying to find the simplest way to
support this with no
impact when not needed.

> > BRS, to give a chance to the perf_events code to change its state before
> > going to low power and after coming back.
> >
> > The callback is void when the PERF_NEEDS_LOPWR_CB flag is not set.
> > This flag must be set in arch specific perf_event.h header whenever needed.
> > When not set, there is no impact of the ACPI code.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  drivers/acpi/acpi_pad.c       | 6 ++++++
> >  drivers/acpi/processor_idle.c | 5 +++++
> >  include/linux/perf_event.h    | 6 ++++++
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> > index f45979aa2d64..a306a07a60b5 100644
> > --- a/drivers/acpi/acpi_pad.c
> > +++ b/drivers/acpi/acpi_pad.c
> > @@ -164,6 +164,9 @@ static int power_saving_thread(void *data)
> >                               tsc_marked_unstable = 1;
> >                       }
> >                       local_irq_disable();
> > +
> > +                     perf_lopwr_cb(true);
> > +
> >                       tick_broadcast_enable();
> >                       tick_broadcast_enter();
> >                       stop_critical_timings();
> > @@ -172,6 +175,9 @@ static int power_saving_thread(void *data)
> >
> >                       start_critical_timings();
> >                       tick_broadcast_exit();
> > +
> > +                     perf_lopwr_cb(false);
> > +
> >                       local_irq_enable();
> >
> >                       if (time_before(expire_time, jiffies)) {
>
> You forgot to Cc the maintainers of this stinking pile of poo. Can we
> please delete it instead?
