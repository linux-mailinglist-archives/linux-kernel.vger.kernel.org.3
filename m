Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9984545518
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbiFITk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344881AbiFITkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:40:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DFC2BB05
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:40:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id l204so43469140ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIsenmbvX8zPgepE4b2x80VaH35pgU5I4dBAafr0Wdg=;
        b=EiAneKFx7dQ6UHpgwUSCPsCinqQ8+kRNHunXgahvbWb2xfnc7G+Veja9BcCkB55Bdp
         1sxt1RRjdz3e+3aXrcUsnoo/WL+HVe0gxHuJg/+VcuFznFWq68jfhAQ8bAwewhKtKtLV
         fxp2yjcVpnZQ/UQkSl4zsidwwLkg9Tfxy1w+YGGF2jci7Sx9Xv2SMHtSgzwjKxyk2Mnq
         xOzOUkdy/VB465plUgdJsQHvYcidt1ybKCQe80RC1kGrTYvlmRTN3a5tWcP3nVr3EFym
         HoyKTNB/EoKgBToBYIc7gfp339AU9VIjVixM14LtxIhZxCZQdJyWdUa+NIqOwVj4sYX7
         TkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIsenmbvX8zPgepE4b2x80VaH35pgU5I4dBAafr0Wdg=;
        b=pN6x90ei1KELKR4tmR51p3xzVw3gHPsYlhMlG84VK6Rp+7LMF7+/9XG0GJ3kK6WCWc
         Q8O4Kh0U3fPwSLsMr0Qwzwp4qR5N4+9VZcPkaFqBlwg62L42rnXo1egItFYmo/PKutE1
         W8AYfpPc5dZygf50t3SO4cGngg+YfAaue66LL3z1j8b4zXeUk2rWKMl8uwoLZaFSePrV
         LnHLE/DWJ/LoAI6cAkw1oqjjQlCyegTpztDmEdO3NiN05ZHs5eewTWicUdmI7guL/m2p
         N/gK/aLKc5wgJoXqXwjB6HMPbnk9nGwsVoRo1HTHzNya61ai283jpjrWNKd0Tq+dOggx
         0Fqg==
X-Gm-Message-State: AOAM530we0LUMAWXACmb0F6DG+wLTNYmGcPkH+YoxYkj7N8ZOyTOVvzq
        dIP+Ntkc/MrmDoGhm9bKQumyCrkyJt6PwXAK54qXfw==
X-Google-Smtp-Source: ABdhPJxurxfmMQVzOd4DmWf+6cz6lR2YHg//auWGZXvIk9b/uhLCwmVEkHtjn8uxxTPnDooIqhWMIFyfCKSm0IOW+l4=
X-Received: by 2002:a25:cb8a:0:b0:65c:a718:475c with SMTP id
 b132-20020a25cb8a000000b0065ca718475cmr42869165ybg.352.1654803619451; Thu, 09
 Jun 2022 12:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220609025515.2086253-1-joshdon@google.com> <CAKfTPtCc4NZ51qruKX1zROFHqg-_MQBadaJfVbYPxT=7c4So=Q@mail.gmail.com>
In-Reply-To: <CAKfTPtCc4NZ51qruKX1zROFHqg-_MQBadaJfVbYPxT=7c4So=Q@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 9 Jun 2022 12:40:08 -0700
Message-ID: <CABk29NtX7EZsAqrT8vXd6tgWe2HPRNPM=cWxFSSxBtW1MjFqOA@mail.gmail.com>
Subject: Re: [PATCH] sched: allow newidle balancing to bail out of load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Thanks Vincent,

On Thu, Jun 9, 2022 at 6:42 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 9 Jun 2022 at 04:55, Josh Don <joshdon@google.com> wrote:
> >
> > While doing newidle load balancing, it is possible for new tasks to
> > arrive, such as with pending wakeups. newidle_balance() already accounts
> > for this by exiting the sched_domain load_balance() iteration if it
> > detects these cases. This is very important for minimizing wakeup
> > latency.
> >
> > However, if we are already in load_balance(), we may stay there for a
> > while before returning back to newidle_balance(). This is most
> > exacerbated if we enter a 'goto redo' loop in the LBF_ALL_PINNED case. A
> > very straightforward workaround to this is to adjust should_we_balance()
> > to bail out if we're doing a CPU_NEWLY_IDLE balance and new tasks are
> > detected.
>
> This one is close to the other tests and I wonder if it should be
> better placed before taking the busiest rq lock and detaching some
> tasks.
>
> Beside your use case where all other threads can't move in local cpu
> and load_balance() loops and clears other cpus, most of the time is
> probably spent in fbg() and fbq() so there are more chance that a task
> woke in this meantime and I imagine that it becomes useless to take
> lock and move tasks from another cpu if the local cpu is no more newly
> idle.
>
> Have you tried other places in load_balance() and does this one
> provide the lowest wakeup latency ?
>
> That being said, the current patch makes sense.

I tested with another check after fbg/fbq and there wasn't any
noticeable improvement to observed wakeup latency (not totally
unexpected, since it only helps for wakeups that come during fbg/fbq).
However, I don't think there's any harm in having that extra check in
the CPU_NEWLY_IDLE case; might as well avoid bouncing the rq lock if
we can. fbq+fbg are together taking ~3-4us per iteration in my repro.

If there are no objections I can send a v2 with the added delta:

@@ -9906,6 +9906,16 @@ static int load_balance(int this_cpu, struct rq *this_rq,
                goto out_balanced;
        }

+       /*
+        * fbg/fbq can take a while. In the newly idle case, recheck whether
+        * we should continue with balancing, since it is possible that a
+        * task woke up in the interim.
+        */
+       if (env.idle == CPU_NEWLY_IDLE && !should_we_balance(&env)) {
+               *continue_balancing = 0;
+               goto out_balanced;
+       }
+
        BUG_ON(busiest == env.dst_rq);

        schedstat_add(sd->lb_imbalance[idle], env.imbalance);
