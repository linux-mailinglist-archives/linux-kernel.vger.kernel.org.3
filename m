Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79054B2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiFNODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFNODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:03:12 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF16338BD;
        Tue, 14 Jun 2022 07:03:11 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v81so15410697ybe.0;
        Tue, 14 Jun 2022 07:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stigbHyDfR6uhTG6foFK4YFKLsIvOO9igz8IuzTE9PU=;
        b=UNtyK8oH+Bj/Q1FqUXs87b+uPRSF0dn+GLr0HrxZfcWwWy2Gxjt6fnjjpjEhhfbwvW
         YX21QGP4q/MSSd769grmLab/Pd+ZVkKs2UHJX9nwCPWD6AWN5rNZgwjm3Sv6ucNYq8wO
         nEhXFQSiuM70c02fH2tgErNj6oWNsollLrHgFudhGgI1iQyMG6YOe1v/LadJlNvZwDbn
         wJZswH4VdPBwwna+587+Ac72/niTmln2alXsxBKDMXp1z25eBbVZHMsSaRsFL3N+Uj/E
         AEZOWVoO79xXwzu4EbiioFV9apVKResA+gT0eMsllFp88h1Cx24cHTbC8BAcUgB5eTKD
         HHdg==
X-Gm-Message-State: AJIora8YyYhN/F/gJig1vSSGpMB8TLYY8hr6kGL2u+D/OGybXOKEAPKW
        kuveEvnrbW7un4cpWHCgbcDtwtq+WwMiwN1228a1kU+T
X-Google-Smtp-Source: AGRyM1s15Jz0q6FUl44PeSTS6IV+KBKBAkxOLxyHpkT5+GqaVFB1trtL0qcgWAxeTf56XxtM0TnkoCnL7qmu3lVk73k=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr5343474ybm.153.1655215391002; Tue, 14
 Jun 2022 07:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220527005345.189906-1-eiichi.tsukata@nutanix.com> <YpTgHeSJA4Ha3Gs4@fuller.cnet>
In-Reply-To: <YpTgHeSJA4Ha3Gs4@fuller.cnet>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 16:03:00 +0200
Message-ID: <CAJZ5v0g=i2G3PO1YzZibecLgMh7J-_K80hnOz=us0TXrL3Wxtg@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 7:37 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Fri, May 27, 2022 at 12:53:45AM +0000, Eiichi Tsukata wrote:
> > Add trace points as are implemented in KVM host halt polling.
> > This helps tune guest halt polling params.
> >
> > Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> > ---
> >  drivers/cpuidle/governors/haltpoll.c |  3 +++
> >  include/trace/events/power.h         | 29 ++++++++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
> > index cb2a96eafc02..1dff3a52917d 100644
> > --- a/drivers/cpuidle/governors/haltpoll.c
> > +++ b/drivers/cpuidle/governors/haltpoll.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/module.h>
> >  #include <linux/kvm_para.h>
> > +#include <trace/events/power.h>
> >
> >  static unsigned int guest_halt_poll_ns __read_mostly = 200000;
> >  module_param(guest_halt_poll_ns, uint, 0644);
> > @@ -90,6 +91,7 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
> >               if (val > guest_halt_poll_ns)
> >                       val = guest_halt_poll_ns;
> >
> > +             trace_guest_halt_poll_ns_grow(val, dev->poll_limit_ns);
> >               dev->poll_limit_ns = val;
> >       } else if (block_ns > guest_halt_poll_ns &&
> >                  guest_halt_poll_allow_shrink) {
> > @@ -100,6 +102,7 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
> >                       val = 0;
> >               else
> >                       val /= shrink;
> > +             trace_guest_halt_poll_ns_shrink(val, dev->poll_limit_ns);
> >               dev->poll_limit_ns = val;
> >       }
> >  }
> > diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> > index af5018aa9517..c708521e4ed5 100644
> > --- a/include/trace/events/power.h
> > +++ b/include/trace/events/power.h
> > @@ -500,6 +500,35 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
> >
> >       TP_ARGS(name, type, new_value)
> >  );
> > +
> > +TRACE_EVENT(guest_halt_poll_ns,
> > +
> > +     TP_PROTO(bool grow, unsigned int new, unsigned int old),
> > +
> > +     TP_ARGS(grow, new, old),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(bool, grow)
> > +             __field(unsigned int, new)
> > +             __field(unsigned int, old)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->grow   = grow;
> > +             __entry->new    = new;
> > +             __entry->old    = old;
> > +     ),
> > +
> > +     TP_printk("halt_poll_ns %u (%s %u)",
> > +             __entry->new,
> > +             __entry->grow ? "grow" : "shrink",
> > +             __entry->old)
> > +);
> > +
> > +#define trace_guest_halt_poll_ns_grow(new, old) \
> > +     trace_guest_halt_poll_ns(true, new, old)
> > +#define trace_guest_halt_poll_ns_shrink(new, old) \
> > +     trace_guest_halt_poll_ns(false, new, old)
> >  #endif /* _TRACE_POWER_H */
> >
> >  /* This part must be outside protection */
> > --
> > 2.36.1
> >
> >
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

I took this as an ACK and applied the patch as 5.20 material.

Thanks!
