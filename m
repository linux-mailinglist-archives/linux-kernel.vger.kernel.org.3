Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0614D8E44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiCNUgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiCNUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:36:15 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF0329B0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:35:03 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v130so33157389ybe.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEwC2oWm7E+TdYn9pjXIfdcT9lJnbB3JTmkCY2AgKHQ=;
        b=Q2+LiluU9906bLSTT9h7OPB+28HX9RJk5Fgi3kilfKrvbwjlosf57o8SIG6ZWFvzqQ
         tVFolIcruqmBocumtKnTmn4WMd8G/hQ79tHr9nt+/kouRiR+yYoAXB0vr9zZU8HtwBff
         YqFQqVQm95SK6Hc7+E7yFkuasGlFrhn8zOjLyQX+FNgupbJakVqrVyagedXH9lewlB7S
         9x/gXxulgTdQTzapN/u8sFp8z//hSXcJIeTQEMXiqjmqoIvJS6ziQOFHYr0oMWZHg0NR
         1uA1UCpXNAZQc4OsgyPSyF7EuPj/krnO3JxvDZq+d4HGyT4u9+qOYoZ01rb46QhYL8Ie
         afvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEwC2oWm7E+TdYn9pjXIfdcT9lJnbB3JTmkCY2AgKHQ=;
        b=Roynn/GJz2VaFOMqM5m1GQcEhJqBxuA5p34guLRKUvwnybBsqvUjWzH0TNiQ0m1yEB
         CpsSjixbBmsz37g866inI7BGBjjOhxrqz2rAG/WvDqLxobnbq/YF6EZfeBLSiHcw7ycx
         bISH9GE7hO95ZKUsXyRdJOtcSJrkpDWOU29fIadevP53cpVC0UOZh73kZ81vgtl06SSX
         0wkEpHAMYjRleDAGTl/dsK0q661ueQv1f+fE/mhYMUIZ1B4WQI39Prtq4VX3O6wpk/Ib
         mUVYGj+1PmRWz35kqj03/K5XEY9WTK6lHRCSmQA03o6UNktGEjt1BlC2FVkDWL9VPyoO
         Gg7A==
X-Gm-Message-State: AOAM530yNTPyeSqnXFCLGXK47q2i7qypdaLWKtk36JD1KcijXLCc8fSd
        yMKAI8Vo9RzM+iyLxTPJtFj9qDhwknCAqVpaLImU4aeesM0=
X-Google-Smtp-Source: ABdhPJzFxCOwbIwtBX8TR6abtHqC4NXg1xaPBpeedRiqRdOwsDIrT9iA/qqoJDHu/WTIhvwFdqYHiaek7j0a38LEKq0=
X-Received: by 2002:a25:d50c:0:b0:627:660c:1874 with SMTP id
 r12-20020a25d50c000000b00627660c1874mr19610951ybe.625.1647290102968; Mon, 14
 Mar 2022 13:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220314133738.269522-1-frederic@kernel.org> <20220314133738.269522-3-frederic@kernel.org>
 <CANpmjNPqY65ZYLFukgp779pHbiRH05yns+G7Z36QdWwrQp1WOQ@mail.gmail.com> <20220314200641.GV4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220314200641.GV4285@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Mar 2022 21:34:26 +0100
Message-ID: <CANpmjNMsyb9aOqcvUUMLbkyHiE9ZieBigU1XqBXgtYz_O00y3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] preempt/dynamic: Introduce preempt mode accessors
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 at 21:06, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Mar 14, 2022 at 03:44:39PM +0100, Marco Elver wrote:
> > On Mon, 14 Mar 2022 at 14:37, Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > From: Valentin Schneider <valentin.schneider@arm.com>
> > >
> > > CONFIG_PREEMPT{_NONE, _VOLUNTARY} designate either:
> > > o The build-time preemption model when !PREEMPT_DYNAMIC
> > > o The default boot-time preemption model when PREEMPT_DYNAMIC
> > >
> > > IOW, using those on PREEMPT_DYNAMIC kernels is meaningless - the actual
> > > model could have been set to something else by the "preempt=foo" cmdline
> > > parameter.
> > >
> > > Introduce a set of helpers to determine the actual preemption mode used by
> > > the live kernel.
> > >
> > > Suggested-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > ---
> > >  include/linux/sched.h | 16 ++++++++++++++++
> > >  kernel/sched/core.c   | 11 +++++++++++
> > >  2 files changed, 27 insertions(+)
> > >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 508b91d57470..d348e886e4d0 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -2096,6 +2096,22 @@ static inline void cond_resched_rcu(void)
> > >  #endif
> > >  }
> > >
> > > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > > +
> > > +extern bool preempt_mode_none(void);
> > > +extern bool preempt_mode_voluntary(void);
> > > +extern bool preempt_mode_full(void);
> > > +
> > > +#else
> > > +
> > > +#define preempt_mode_none() IS_ENABLED(CONFIG_PREEMPT_NONE)
> > > +#define preempt_mode_voluntary() IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)
> > > +#define preempt_mode_full() IS_ENABLED(CONFIG_PREEMPT)
> > > +
> >
> > Shame this was somehow forgotten.
> > There was a v3 of this patch that fixed a bunch of things (e.g. making
> > these proper functions so all builds error if accidentally used in
> > #if).
> >
> > https://lore.kernel.org/lkml/20211112185203.280040-3-valentin.schneider@arm.com/
> >
> > Is it also possible to take all the rest of that series (all 4
> > patches) from Valentin?
>
> Me, I am assuming that #2/3 is an experimental test so that I am able
> to easily whack this series over the head with rcutorture.  ;-)

I might be out of the loop here. All I can add is that any issues that
are a consequence of the preempt mode accessors are only testable if
the preemption model is actually changed at runtime and AFAIK
rcutorture doesn't do that. But as noted, this patch wasn't the latest
version and there were issues with it fixed by Valentin's latest v3
(from November, but had never been picked up anywhere).

Thanks,
-- Marco
