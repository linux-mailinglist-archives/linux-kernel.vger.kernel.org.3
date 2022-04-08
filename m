Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3484F8F56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiDHHTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiDHHTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:19:13 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC823B030
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:17:10 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e5e9025c20so86129877b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnXHR5gRI6b51YG8ylhL5jPW3yJr07fqNZU/XZSig0k=;
        b=AAcufFck/yBeQrNDVHVsf6MMXMwxY/5jmF3Dbk5qpkEevFCsvQ0Rnx1Na0EgbHbSUc
         JkF3Kuxtsyw7el5+5FmrRG8MRzoOQRIgXOkIX9wbfxwldbd5/fofZ3qJOtq5Bvf+rUcj
         pyA9S1Uwz8r+Xs2IrAbQTlRWIKm48N30FEYHDVr0Ffi1tAW6OCZI0VmKNV+kVIbltH+v
         N9jNUtwFkn5P+f9YbgUH6LAeJ9R+UqzccxI9r97GuomTEMkbEzUqODWr9IzqaoWRpShG
         JhLiSh9CLZ2lJAKWYhN+sBzvoQt+KqDIgBpNoh+qenG9R5TKfzfy/QB6LfyTjxrKTFIf
         OlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnXHR5gRI6b51YG8ylhL5jPW3yJr07fqNZU/XZSig0k=;
        b=pYr2jcqHEzY78NGit1VN0Qs3jlHMeGP8B986ch1GBnsB+7WNbY7MDVgw9xgT83RmYV
         xFkJ4Ijv7baWTvC2Ydy0JNvXNx9n2Jtw7F65xXfiVItcrc0zpupV61JnWhpTanjA6WDS
         xD7aDXsbw2RBp04VbZH5ESPrSxCycpbN3U04C3ecesaZA1p68hGjHZ+5LVB9fh41j4+Q
         eeHnms7O15qIcIk4JkUHRcN73Az5tcfUrqstcVQuhtJCeSk5OoEVH3i/b1U7gbyAYl/d
         0BdpKIIKrU2Hid/wVcLZpbb1GZfzWgTRtV7jrlDvpSTHFJouvUuEQgNHfrq/BFCuy2az
         wyiQ==
X-Gm-Message-State: AOAM531418ies+ldYhxVm1qNRsdbryc0DRdo+4VINlyGD325QTckzSS8
        jH6Bt4+BwNc4P4R8nLcgva5ZXvaZwau4bATq4MNn4A==
X-Google-Smtp-Source: ABdhPJzz9u/go6IjZ0evDmj7LCqhKD7NZ4HenDRPbw4CEb7Ac7TRuTiUprMq4ljNG0b2p23ib9BBLjHhTrrJ56L/X80=
X-Received: by 2002:a81:1985:0:b0:2eb:6021:12c4 with SMTP id
 127-20020a811985000000b002eb602112c4mr14872505ywz.248.1649402229982; Fri, 08
 Apr 2022 00:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220407021729.16655-1-zhouchengming@bytedance.com>
 <20220407021729.16655-2-zhouchengming@bytedance.com> <xm26pmlsvcah.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26pmlsvcah.fsf@bsegall-linux.svl.corp.google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Apr 2022 09:16:58 +0200
Message-ID: <CAKfTPtAYR-G2X2RnCJKLqS6J-Kn-tZTp9JyzxR3j9jsFbmwZwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Delete useless condition in tg_unthrottle_up()
To:     Benjamin Segall <bsegall@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 23:00, Benjamin Segall <bsegall@google.com> wrote:
>
> Chengming Zhou <zhouchengming@bytedance.com> writes:
>
> > Fully decayed cfs_rq is impossible to have queued entities,
> > the first condition "!cfs_rq_is_decayed(cfs_rq)" is enough
> > to cover.
>
> In particular, cfs_rq->load.weight is part of cfs_rq_is_decayed.

Testing cfs_rq->load.weight is the key point because nothing prevent
to add a task with null load

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Reviewed-by: Ben Segall <bsegall@google.com>
>
> >
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e6fa5d1141b4..17c13c38b1c2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4850,7 +4850,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
> >                                            cfs_rq->throttled_clock_task;
> >
> >               /* Add cfs_rq with load or one or more already running entities to the list */
> > -             if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
> > +             if (!cfs_rq_is_decayed(cfs_rq))
> >                       list_add_leaf_cfs_rq(cfs_rq);
> >       }
