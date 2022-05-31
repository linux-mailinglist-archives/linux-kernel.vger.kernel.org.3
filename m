Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8439F539500
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbiEaQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346180AbiEaQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:32:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D072873F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:32:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ff90e0937aso145884317b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSRdjJ4GsSYX2sanC6V1p/5JQws5rxwYFyUpiG5r7ek=;
        b=qmiK67eVaFFgCtGDbvSmb/okOLbpaij9fPXhGHc0GhS2xwChEiWpm63Qoo/BLAIVen
         iIaoGHY24FWM51LkTSxGiOy16cWZpeFEvqINnPIUR1BuQFPKPzaCuWDA7hQvGUQ7M34G
         arvkAmKw5YWMjzrs7WMKgKs3/0Km1mC+2Q2iZPpUmE25JVEgJVBPfMXH35fUvMrpGuz+
         bJ9oPd+0M165s5ByTdI75lIq879K83aaJWE8t4eayniTtZU1Ox+tza7DvbubJHSVCaqC
         FG2TUEC//xfIUgwzDc3LOYGQXBiuKXuhWJ1YJDmUGVvqRbwsKbBBbMwM34G28Q3rzegL
         dYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSRdjJ4GsSYX2sanC6V1p/5JQws5rxwYFyUpiG5r7ek=;
        b=U+wxkUzfXAg7ZJxUI6pTZBOPQuUqohldJ//gclu6beKhX32jmpSBI0/10CQwAlw7k1
         bJ9eScER4EC9j0DicKItk73YIPDoZx86H2DQHHrMVcgGRDjUitcSpity2bpuRb11Mhq6
         yqWcUfexxNgqWoyYLi+tgqjuD4yXeIwrU7djDtuepGvWDZZR+CkXaLAOXI86ZG8Nabkt
         LZ5BPt3utp875VwzzkPrD/4aOkWBTA57ziWFpS/uwwxYMxcE4BE6h4wkfrDQb3UyvAQy
         96y84hjOJnX6zmoVThLFccmQvCtamUf2DBgJvl87QA13XHGfj2iurerAR9i8vzuL4RuL
         4tvw==
X-Gm-Message-State: AOAM532aKYE962j/+istj5ijU+zX76JXSazMnPpMIuv2KXCX6l2C1PH0
        H5V4ZmPp8hka2o7C+htSoFKxjm+rx4TiaOTGogulOQ==
X-Google-Smtp-Source: ABdhPJyRon53Pg9ZvPtzHQ3l2W0Sjq2m9Yxrl0Sct1vuKlc2EZbjfF4SGyFduyvALB+xBTJjM6Cqxa8SzIg1AaNqzsY=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr61808300ywb.319.1654014757465; Tue, 31
 May 2022 09:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220526103929.14976-1-zhouchengming@bytedance.com>
 <20220526103929.14976-3-zhouchengming@bytedance.com> <CAKfTPtADKqVSvUFmLRPCU_XGVvf3wme0EnnvPf1Q39HEs=VqRw@mail.gmail.com>
 <270c2315-7ba5-4bbb-ee5c-38cc8a57e628@bytedance.com>
In-Reply-To: <270c2315-7ba5-4bbb-ee5c-38cc8a57e628@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 May 2022 18:32:25 +0200
Message-ID: <CAKfTPtAL_N=grk7kaqB6bsZHh5JCvckTk9AtzFCJpanD=g_LOg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/2] sched/fair: optimize and simplify
 rq leaf_cfs_rq_list
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        odin@uged.al, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 at 15:55, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hi,
>
> On 2022/5/30 15:52, Vincent Guittot wrote:
> > On Thu, 26 May 2022 at 12:40, Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> [...]
> >> @@ -11257,9 +11218,10 @@ static inline bool vruntime_normalized(struct task_struct *p)
> >>   */
> >>  static void propagate_entity_cfs_rq(struct sched_entity *se)
> >>  {
> >> -       struct cfs_rq *cfs_rq;
> >> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >>
> >> -       list_add_leaf_cfs_rq(cfs_rq_of(se));
> >> +       if (!throttled_hierarchy(cfs_rq))
> >> +               list_add_leaf_cfs_rq(cfs_rq);
> >>
> >>         /* Start to propagate at parent */
> >>         se = se->parent;
> >> @@ -11268,7 +11230,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
> >>                 cfs_rq = cfs_rq_of(se);
> >>
> >
> >  you can break  if the cfs is throttled because it's sched_entity has
> > been dequeued. In this case we check if the cfs is throttled not if
> > the hierarchy is throttled
> >
> > +               if (cfs_rq_throttled(cfs_rq))
> > +                       break;
> >
>
> This propagate part still make me confused. :-)
>
> I wonder if you think we should change like this:
>
> static void propagate_entity_cfs_rq(struct sched_entity *se)
> {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
>         if (cfs_rq_throttled(cfs_rq))                   --> break if cfs is throttled
>                 return;
>
>         if (!throttled_hierarchy(cfs_rq))
>                 list_add_leaf_cfs_rq(cfs_rq);
>
>         /* Start to propagate at parent */
>         se = se->parent;
>
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
>                 if (cfs_rq_throttled(cfs_rq))           --> break if cfs is throttled
>                         break;
>
>                 update_load_avg(cfs_rq, se, UPDATE_TG); --> throttled cfs_rq->prop not updated
>                 if (!throttled_hierarchy(cfs_rq))
>                         list_add_leaf_cfs_rq(cfs_rq);
>         }
> }
>
>
>
> If I understand right, we should update_load_avg() until cfs_rq_throttled(),
> including that throttled cfs_rq? So we can go on propagating when unthrottle.
>
> Maybe like this?
>
> static void propagate_entity_cfs_rq(struct sched_entity *se)
> {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
>         if (cfs_rq_throttled(cfs_rq))                   --> break if cfs is throttled
>                 return;
>
>         if (!throttled_hierarchy(cfs_rq))
>                 list_add_leaf_cfs_rq(cfs_rq);
>
>         /* Start to propagate at parent */
>         se = se->parent;
>
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
>                 update_load_avg(cfs_rq, se, UPDATE_TG); --> update throttled cfs_rq->prop

Yes, that looks correct.
So we will ensure that the attach/detach is propagated down up to
thethrottle cfs

>
>                 if (cfs_rq_throttled(cfs_rq))           --> break if cfs is throttled
>                         break;
>
>                 if (!throttled_hierarchy(cfs_rq))
>                         list_add_leaf_cfs_rq(cfs_rq);
>         }
> }
>
>
> Thanks!
>
>
> >>                 update_load_avg(cfs_rq, se, UPDATE_TG);
> >> -               list_add_leaf_cfs_rq(cfs_rq);
> >> +               if (!throttled_hierarchy(cfs_rq))
> >> +                       list_add_leaf_cfs_rq(cfs_rq);
> >>         }
> >>  }
> >>  #else
> >> --
> >> 2.36.1
> >>
